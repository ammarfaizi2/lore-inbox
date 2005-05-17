Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVEQQpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVEQQpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVEQQpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:45:44 -0400
Received: from solarneutrino.net ([66.199.224.43]:53770 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S261812AbVEQQph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 12:45:37 -0400
Date: Tue, 17 May 2005 12:45:27 -0400
To: Dave Airlie <airlied@linux.ie>
Cc: Andreas Stenglein <a.stenglein@gmx.net>, khaqq <khaqq@free.fr>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: DRI lockup on R200, 2.6.11.7
Message-ID: <20050517164527.GA23375@tau.solarneutrino.net>
References: <20050426202916.GA2635@xarello> <21d7e99705042801227ed5438e@mail.gmail.com> <20050511162159.GA19046@tau.solarneutrino.net> <20050514105051.GC8956@buche.local> <20050514165705.GA20921@tau.solarneutrino.net> <20050514210047.2fff483f.khaqq@free.fr> <20050514191707.GB20921@tau.solarneutrino.net> <20050515115239.GA5773@buche.local> <Pine.LNX.4.58.0505151136310.24826@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505151136310.24826@skynet>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I just got around to testing this today.  Using NO_TCL locks the
machine immediately:

[drm:drm_lock_take] *ERROR* 4 holds heavyweight lock

X isn't spinning the CPU, but the overall effect is the same.  When I
move the mouse it's doing:

ioctl(5, 0x4008642a, 0x7ffffffff448)    = ? ERESTARTSYS (To be restarted)
--- SIGIO (I/O possible) @ 0 (0) ---
select(7, [5 6], NULL, NULL, {0, 0})    = 1 (in [6], left {0, 0})
rt_sigprocmask(SIG_BLOCK, [IO], [IO], 8) = 0
read(6, "\10\3\4\0", 64)                = 4
rt_sigprocmask(SIG_BLOCK, [], [IO], 8)  = 0
select(1024, [6], NULL, NULL, {0, 0})   = 0 (Timeout)
rt_sigreturn(0x1)                       = -1 EINTR (Interrupted system call)
ioctl(5, 0x4008642a, 0x7ffffffff448)    = ? ERESTARTSYS (To be restarted)


Also, I tried to kill X using a sysrq-k and got:

SysRq : SAK
Badness in set_palette at drivers/char/vt.c:2918

Call Trace:<ffffffff8022391c>{set_palette+60} <ffffffff802244db>{__handle_sysrq+107} 
       <ffffffff80195bd5>{write_sysrq_trigger+53} <ffffffff80166510>{vfs_write+192} 
       <ffffffff80166663>{sys_write+83} <ffffffff8010d13a>{system_call+126} 

-ryan
