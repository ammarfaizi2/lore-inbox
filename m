Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271521AbRHPIQd>; Thu, 16 Aug 2001 04:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271522AbRHPIQX>; Thu, 16 Aug 2001 04:16:23 -0400
Received: from dialup290.canberra.net.au ([203.33.188.162]:22020 "EHLO
	didi.local.net") by vger.kernel.org with ESMTP id <S271521AbRHPIQO>;
	Thu, 16 Aug 2001 04:16:14 -0400
Message-ID: <000f01c1262a$773ad1f0$0200a8c0@W2K>
From: "Nick Piggin" <s3293115@student.anu.edu.au>
To: "Linus Torvalds" <torvalds@transmeta.com>,
        "Linux-Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <200108151719.f7FHJbS02350@penguin.transmeta.com>
Subject: Re: kswapd using all cpu for long periods in 2.4.9-pre4
Date: Thu, 16 Aug 2001 18:07:16 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes you're right, my fault sorry. Leaving it as default does fix the
problem. The values were changed using sysctl(8). It writes straight to
/proc - my freepages is not readonly for some reason (source has been
changed)... anyway, no sysctl(2) backdoors found here.

On related topic - is /Documentation/sysctl/vm.txt up-to-date? Is there a
better document to use?

Nick

----- Original Message -----
From: "Linus Torvalds" <torvalds@transmeta.com>
Newsgroups: linux.dev.kernel
To: <s3293115@student.anu.edu.au>; <linux-kernel@vger.kernel.org>; "Marcelo
Tosatti" <marcelo@conectiva.com.br>; "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Sent: Thursday, August 16, 2001 3:19 AM
Subject: Re: kswapd using all cpu for long periods in 2.4.9-pre4


> I just noticed something..
>
> In article <000c01c12569$65581630$0200a8c0@W2K> you write:
> >
> >kswapd is using all cpu for long periods (100-200 seconds then 100-200
> >seconds break....) there is very little disk activity (heres a vmstat
while
> >its happening)
> >
> >mem info during:
> >SysRq: Show Memory
> >Mem-info:
> >Free pages: 3744kB ( 0kB HighMem)
> >( Active: 6946, inactive_dirty: 4296, inactive_clean: 895, free: 936 (256
> >512 2048) )
>
> This shows your freepages.min low and high: 256. 512 and 2048
> respectively.
>
> And that's WRONG. Your "freepages.high" is _way_ too high. You must have
> changed it through the /proc interface somehow, which should be
> impossible (the /proc/sys/vm/freepages file is read-only), but I suspect
> that maybe there's a sysctl backdoor.
>
> How do I know that "freepages.high" is too big? Because it should always
> be 3*freepages.min. Yours is 8*min.
>
> And why does this matter? Because what has apparently happened is:
>  - your setup somehow modifies the global free target
>  - but the per-zone targets are still the old ones
>
> The end result: we always think that we are under a global shortage, but
> the actual page freeing routines refuse to free pages because all the
> _zones_ think that they are fine.
>
> Which gives you _exactly_ the behaviour you're describing. "kswapd" will
> run forever, and never make any progress at all.
>
> I wonder if this is more common? Does any of the distributions maybe
> have some "system tuning" script that modifies the freepages values
> through sysctl? That would certainly explain why some people see the
> problem and others do not..
>
> How DID you change that value?
>
> Linus
>

