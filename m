Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263312AbVBDHyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbVBDHyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVBDHuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:50:51 -0500
Received: from gprs215-248.eurotel.cz ([160.218.215.248]:22675 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263484AbVBDHsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:48:16 -0500
Date: Fri, 4 Feb 2005 08:48:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI] Samsung P35, S3, black screen (radeon))
Message-ID: <20050204074802.GD1086@elf.ucw.cz>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net> <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net> <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz> <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4202DF7B.2000506@gmx.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'd love to see it too. Pavel, even if you don't want to merge it for a
> > while, we can always incorporate it in the Suspend2 patches so it gets
> > some testing. I know I'd try it on my i830 based Omnibook.
> 
> Can we use call_usermodehelper at this early resume stage (before any
> video access)? Calling vm86 directly is probably not going to fly
> because we want to be shielded from any misbehaviour in the bios code
> and it may be necessary to kill the process running the bios code.
> 
> Cases in point: My bios will cause the POSTing application to segfault.
> Others have reported the POSTing application just hangs, but the
> important things are done before the hang, so killing it after maybe
> 5 seconds would be ok.
> 
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
> - vesafb has to refrain from touching video until after POST
> - the vesaposter thread has to be the first unfrozen and
>   scheduled and completed thread. Only after that we can resume
>   vesafb and other threads
> - the locking will be tricky

- it is ugly

What about simply blocking all video accesses before disk (etc) is
resumed, so that "normal" (not locked in memory) application can be
used?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
