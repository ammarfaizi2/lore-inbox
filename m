Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbWIEUVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbWIEUVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 16:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWIEUVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 16:21:38 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:55323 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030253AbWIEUVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 16:21:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=djZrIS6p/EDMVmi3IsFZQNQGkyg82VKCOqawA1xzZI9fLowdNVLJZTrbOe2gldHt/j0djOxVu/j9LPWnwIF9sMXwFaDtkaRT4C+M6KvzjpOuuDnhS5cAaxv0RJwiFDOtOH5rWrruAJCUuIP+NrTu0EiyBVXBULJF/Ln4lK0jvH0=
Message-ID: <86b122f40609051321p4be05683x9261b5142ed2ea4f@mail.gmail.com>
Date: Tue, 5 Sep 2006 22:21:35 +0200
From: "Tiemen Schut" <tschut@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel drops ethernet packets during disk writes
In-Reply-To: <44FDCEB2.6070500@degler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <86b122f40609050815v664ff217kcfc82a5c9f2772ad@mail.gmail.com>
	 <86b122f40609050906u7aafe808h5002c9f15369a744@mail.gmail.com>
	 <44FDCEB2.6070500@degler.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now this is something constructive!

I can indeed maintain 350Mbit/s to disk (about 55MB/s to disk
actually), and I can receive all the packets, as long as I don't try
to do both things simultaniously.

I'll try to increase the buffers tomorrow, will let you know how it
worked out. I doubt though that the tcp buffers have any impact, we're
talking raw ethernet frames here.

Thanks,

Tiemen

On 9/5/06, Stephen Degler <stephen@degler.net > wrote:
>  Tiemen Schut wrote:
> > Summary: The linux kernel appears to drop raw ethernet packets if
> > another process is writing to disk.
> >
> > Test environment: Used a p4 1.7 GHz with gigabit interface
> > point-to-point connection to another p4 (windows pc). This windows PC
> > generates raw ethernet frames holding a counter and sends 'm on to the
> > linux PC, at a transfer rate of 350 Mbit/s. When not writing to disk,
> > everything goes quite fine. I can check the counters at the linux
> > side, and will notice a minimal packet loss (<  0.001 % or so).
> >
> > However, for my application I want to write each and every frame to
> > disk. So, I created a second app, and through a fifo the receiver app
> > and the disk writer app communicate. Now I'm losing like 80% of my
> > packets :o Reducing the throughput on the network doesn't really help
> > (though it does help a little).
> >
> > Note: I tried everything in the same app first, but my guess was that
> > the write operation delayed the app, so I decided to put everything in
> > two apps to give the scheduler some work ;) Didn't work though.
> >
> > My guess would be that the kernel drops the packets because the write
> > operation takes to long (how long can it take, it's just a stupid 1512
> > bytes frame). Anyway, I tried to enlarge
> > .sys.net.core.netdev_max_backlog, but that didn't do the trick.
> >
> > This problem occures on both  2.6.13 and 2.4.idontremember.
> >
> > It kinda sucks, what's the use of receiving traffic if you can't write
> > it to disk?
> >
> > I'm sending the packets using the winpcap library, and I'm receiving
> > the packets using the pcap library.
> >
> > Any help would be _greatly_ appreciated, and if neccessary, please ask
> > for additional information/used software/test results/etc.
> >
> > Tiemen Schut
> Hi your packets are being dropped perhaps because there is no room to
> store them while the disk is busy, not that you don't receive them.
>
> Can you sustain 35M/second to disk?  If you can't do that with dd
>  if=/dev/zero of="foo" bs=1024k, then you can not expect to do it with
> the network plus your writer.  Writing
> sequentially to a large modern disk you should be able to do this (large
> capacity SATA or SCSI disks, or hardware raid controllers).
>
> You can improve matters greatly by increasing the kernel network buffers
> available.  This will give you more buffer room while the disk subsystem
> is busy.  Look at the following tuneables: you should be able to greatly
> reduce packet loss by increasing them from the default values.
>
> net.core.rmem_max = 2500000
> net.core.wmem_max = 2500000
> net.ipv4.tcp_rmem = 4096 5000000 5000000
> net.ipv4.tcp_wmem = 4096 65536 5000000
>
> I can assure you that with the proper system configuration, high network
> to disk throughput is indeed possible.
>
> Hope this helps,
> skd
>
>
