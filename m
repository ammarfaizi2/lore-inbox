Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVGDSjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVGDSjc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 14:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVGDSj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 14:39:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37061 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261532AbVGDSjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 14:39:14 -0400
Date: Mon, 4 Jul 2005 20:40:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Shawn Starr <shawn.starr@rogers.com>, Lenz Grimmer <lenz@grimmer.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up
Message-ID: <20050704184032.GT1444@suse.de>
References: <20050704061713.GA1444@suse.de> <20050704142723.2202.qmail@web88009.mail.re2.yahoo.com> <20050704144634.GQ1444@suse.de> <42C970D1.3090609@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C970D1.3090609@linuxwireless.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04 2005, Alejandro Bonilla wrote:
> Jens Axboe wrote:
> 
> >
> >That's madness, we can't add a kernel thread for every single little
> >silly thing. You don't need to stop any io, you just want to make sure
> >that your park request gets issued right after the current io has
> >finished.
> > 
> >
> HI,
> 
>    For me, the heads have to park so fast. That I would be afraid of a 
> kernel panil or something that could happen if you park the head so fast 
> that it won't even tell the kernel it did, or because ext3 couldn't 
> update or any crazy reason.
> 
>    I use a lot a project called laptop_mode, which suspend the hd until 
> you do a request to the kernel or the HD and it spins up the HD. I think 
> somehow, the kernel is not fast enough to do what we want, I mean, I 
> don't see it.
> 
>    Imagine you are in starbucks, your laptop is over a 1.2 M table, 
> Linus just said that a new kernel is out. So you simply download it, and 
> now you are compiling it. But, you invited your kid to Starbucks. And 
> while your CPU is at 100% and full throttle HD usage. Then your kid 
> trips on the cable or simply pushes the PC out.
> 
>    Do you think that the kernel will STOP, HOLD and park the head in 
> less than a second? OR on the time we need?
> 
>    I would say is a dammed good kernel if it would. (could RTOS, make 
> things faster)
> 
> Simply send the flames my way if you think I'm totally wrong. Which I 
> might be. I really don't know...

You have to wait for the current command to finish, that is the fastest
approach. Aborting it would likely take longer. So what I describe
above, is really as fast as you can issue that command. If you are busy
doing io (writes, from the sound of the above), a single command doesn't
take very long as it goes to cache. Lets just say 10ms as a nice
pessimistic number. On average, that means you have 5ms until that
command finishes and you can issue the park. Submitting the park command
doesn't take long, the time is dominated by the actual park time. Which
is hardware bound, there's not much we can improve there in software.

The actualy accel daemon would run at an appropriate scheduling
priority/class, to ensure good response there.

-- 
Jens Axboe

