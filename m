Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264287AbVBDDZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264287AbVBDDZp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 22:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263859AbVBDDUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 22:20:17 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:39067 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261606AbVBDCtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 21:49:41 -0500
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI]
	Samsung P35, S3, black screen (radeon))
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Pavel Machek <pavel@ucw.cz>, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4202DF7B.2000506@gmx.net>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net>
	 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>
	 <4202A972.1070003@gmx.net>  <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams>  <4202DF7B.2000506@gmx.net>
Content-Type: text/plain
Message-Id: <1107485504.5727.35.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 04 Feb 2005 13:51:55 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-02-04 at 13:35, Carl-Daniel Hailfinger wrote:
> Can we use call_usermodehelper at this early resume stage (before any
> video access)? Calling vm86 directly is probably not going to fly
> because we want to be shielded from any misbehaviour in the bios code
> and it may be necessary to kill the process running the bios code.
> 
> Cases in point: My bios will cause the POSTing application to segfault.
> Others have reported the POSTing application just hangs, but the
> important things are done before the hang, so killing it after maybe
> 5 seconds would be ok.

Yuckkkkk!

> Rough outline how to do that without adding tons of code:
> We need a call_usermodehelper_from_ram_with_timeout for that.
> 
> Kernel:                          Userspace:
> User wants to enter S3
> init_mutex_locked(s3_sem)
> call_usermodehelper("vesaposter")
>                                  vesaposter calls LRMI_init
>                                  vesaposter mlocks all its memory
>                                  vesaposter calls into kernel
>                                           and down(s3_sem)
> suspend vesafb
> 
> User has triggered resume
> run wakeup.S
> thaw essential threads
> set a timer of 5 seconds
> up(s3_sem)
> thaw and schedule vesaposter
> wait for timer or vesaposter termination
>                                  vesaposter returns from kernel
>                                  vesaposter posts video card
>                                  vesaposter terminates
> resume vesafb
> continue resume
> 
> Problems with that approach:
> - vesaposter has to be locked in memory to avoid disk accesses

That's no biggie.

> - vesafb has to refrain from touching video until after POST

Which is why I think we should do the post asap (as you have). What is
counted as an essential thread?

> - the vesaposter thread has to be the first unfrozen and
>   scheduled and completed thread. Only after that we can resume
>   vesafb and other threads

All other threads will be frozen, and we don't have scheduler hooks that
will hang up our new kiddie, so we should be right there.

> - the locking will be tricky

But also simplified by the fact that everything else is frozen.

> Advantages:
> - the problems all seem to be solvable easily
> - security and stability are similar to the current userspace code
> - we can use vesafb on such machines
> - the kernel code won't be much more than two dozen lines
> - the userspace POSTing code can be upgraded without the need
>   for kernel updates (no policy in the kernel)
> 
> What do you think?

Show us some code :>

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

