Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVCWMQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVCWMQc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 07:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVCWMQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 07:16:32 -0500
Received: from alog0307.analogic.com ([208.224.222.83]:41381 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261552AbVCWMOZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 07:14:25 -0500
Date: Wed, 23 Mar 2005 07:11:53 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: lseek on /proc/kmsg
In-Reply-To: <Pine.LNX.4.61.0503230811020.21578@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0503230705110.11131@chaos.analogic.com>
References: <Pine.LNX.4.61.0503221320090.5551@chaos.analogic.com>
 <Pine.LNX.4.61.0503222020470.32461@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0503221423560.6369@chaos.analogic.com>
 <Pine.LNX.4.61.0503222215310.19826@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0503221633230.7421@chaos.analogic.com>
 <Pine.LNX.4.61.0503230811020.21578@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005, Jan Engelhardt wrote:

>
> 1> Sure, read() needs to be modified to respect the file-position
> 1> set by kmsg_seek(). I don't think you can get away with the
> 1> call back into do_syslog.
>
> 2>I'm not sure that seek makes any sense on that, since it is more like a
> 2>pipe than a normal file..
>
> Well, seek(fd, 0, SEEK_END) could be used to flush a pipe's buffers.
>

Yep. That's what I tried to do. Just returns 0 and continues to
contain all the cached data.


> 0>> +static loff_t kmsg_seek(struct file *filp, loff_t offset, int origin) {
> 0>> +    if(origin != 2 /* SEEK_END */ || offset < 0) { return -ESPIPE; }
> 3> "Allow" seeking past the end of the buffer?
>
> Well, what does lseek(fd, >0, SEEK_END) do on normal files?
>

Goes to the end plus offset. A subsequent read returns EOF
or 0 depending upon your read mechanism. This is what I wanted
to do but with no offset.

Currently, I do this crap:

     for(;;)
     {
         pfd.fd      = ifd;
         pfd.events  = POLLIN;
         pfd.revents = 0;
         if(poll(&pfd, 1, 0) <= 0)
             break;
         (void)read(ifd, ibuf, BUF_LEN);
     }

I should be able to just lseek(ifd, 0 SEEK_END);

> -- 
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
