Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267356AbUI0Us1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267356AbUI0Us1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267358AbUI0Urp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:47:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:17561 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267356AbUI0UoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:44:20 -0400
Date: Mon, 27 Sep 2004 13:37:58 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch for comment: setuid core dumps
Message-Id: <20040927133758.2be9dc5a.rddunlap@osdl.org>
In-Reply-To: <20040927202616.GA22228@devserv.devel.redhat.com>
References: <20040927202616.GA22228@devserv.devel.redhat.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


| Opinions, bugs, reviews, fan mail ?
| 
| 
| @@ -1383,6 +1389,17 @@
|  		up_write(&mm->mmap_sem);
|  		goto fail;
|  	}
| +	
| +	/*
| +	 *	We cannot trust fsuid as being the "true" uid of the
| +	 *	process nor do we know its entire history. We only know it
| +	 *	was tainted so we dump it as root in mode 2.
| +	 */
| +	if (mm->dumpable == 2)		/* Setuid core dump mode */

Use something other than hard-coded '2'.

| +	{
| +		flag = O_EXCL;		/* Stop rewrite attacks */
| +		current->fsuid = 0;	/* Dump root private */
| +	}
|  	mm->dumpable = 0;
|  	init_completion(&mm->core_done);
|  	current->signal->group_exit = 1;

| diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/include/linux/sysctl.h linux-2.6.9rc2/include/linux/sysctl.h
| --- linux.vanilla-2.6.9rc2/include/linux/sysctl.h	2004-09-14 14:22:57.000000000 +0100
| +++ linux-2.6.9rc2/include/linux/sysctl.h	2004-09-27 16:05:39.889981776 +0100
| @@ -134,6 +134,7 @@
|  	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
|  	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
|  	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
| +	KERN_SETUID_DUMPABLE=67, /* int: unknown nmi panic flag */

Fix comment.

| @@ -1681,7 +1681,7 @@
|  				error = 1;
|  			break;
|  		case PR_SET_DUMPABLE:
| -			if (arg2 != 0 && arg2 != 1) {
| +			if (arg2 < 0 || arg2 > 2) {
|  				error = -EINVAL;
|  				break;
|  			}

The suid_dumpable possible values deserve an enum or #defines
instead of hard-coded values.


Otherwise makes sense to me & looks good on a quick look.

--
~Randy
MOTD:  Always include version info.
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
