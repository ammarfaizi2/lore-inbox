Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVAOOjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVAOOjZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 09:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbVAOOjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 09:39:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59104 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262285AbVAOOjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 09:39:12 -0500
Date: Sat, 15 Jan 2005 09:43:09 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.29-rc2
Message-ID: <20050115114309.GA7397@logos.cnet>
References: <20050112151334.GC32024@logos.cnet> <20050114225555.GA17714@steffen-moser.de> <20050115052050.GF4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050115052050.GF4274@stusta.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Adrian!

On Sat, Jan 15, 2005 at 06:20:50AM +0100, Adrian Bunk wrote:
> On Fri, Jan 14, 2005 at 11:55:55PM +0100, Steffen Moser wrote:
> 
> >...
> >  - fsa01 (problem occurs):
> >...
> >  | modutils               2.4.5
> >...
> >  - gateway (no problem):
> >...
> >  | modutils               2.4.12
> >....
> 
> OK, this seems to be the problem:
> modutils before 2.4.10 don't know about EXPORT_SYMBOL_GPL.
> 
> Please upgrade modutils on fsa01 and report whether it fixes the 
> problem.

Yes, thats the right solution - however I think it might be worth to have 
the non-GPL versions. Several old distros ship modutils older than 2.4.10
- eg SuSE Linux 7.1 (Oct 2001).

> If this was the problem, the patch below should be sufficient
> (modutils 2.4.10 isn't a very strong dependency - even Debian stable 
> ships 2.4.15).
> 
> 
> <--  snip  -->
> 
> 
> For support of EXPORT_SYMBOL_GPL, at least modutils 2.4.10 is required.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.4.29-rc2-full/Documentation/Changes.old	2005-01-15 06:17:46.000000000 +0100
> +++ linux-2.4.29-rc2-full/Documentation/Changes	2005-01-15 06:18:26.000000000 +0100
> @@ -52,7 +52,7 @@
>  o  Gnu make               3.77                    # make --version
>  o  binutils               2.9.1.0.25              # ld -v
>  o  util-linux             2.10o                   # fdformat --version
> -o  modutils               2.4.2                   # insmod -V
> +o  modutils               2.4.10                  # insmod -V
>  o  e2fsprogs              1.25                    # tune2fs
>  o  jfsutils               1.0.12                  # fsck.jfs -V
>  o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs
> @@ -156,11 +156,8 @@
>  Modutils
>  --------
>  
> -Upgrade to recent modutils to fix various outstanding bugs which are
> -seen more frequently under 2.4.x, and to enable auto-loading of USB
> -modules.  In addition, the layout of modules under
> -/lib/modules/`uname -r`/ has been made more sane.  This change also
> -requires that you upgrade to a recent modutils.
> +Upgrade to recent modutils is required for support of
> +EXPORT_SYMBOL_GPL.
>  
>  Mkinitrd
>  --------

Yes, this is change is interesting. I propose the following, with Arjan's comment
suggestion and yours 2.4.2/2.4.10 change.

--- drivers/char/tty_io.c.orig	2005-01-15 11:28:49.116993816 -0200
+++ drivers/char/tty_io.c	2005-01-15 11:33:45.063003184 -0200
@@ -718,7 +718,12 @@
 	wake_up_interruptible(&tty->write_wait);
 }
 
-EXPORT_SYMBOL_GPL(tty_wakeup);
+/*
+ * tty_wakeup/tty_ldisc_flush are actually _GPL exports but we can't do 
+ * that in 2.4 for modutils compat reasons.
+ */
+EXPORT_SYMBOL(tty_wakeup);
+
 
 void tty_ldisc_flush(struct tty_struct *tty)
 {
@@ -730,7 +735,12 @@
 	}
 }
 
-EXPORT_SYMBOL_GPL(tty_ldisc_flush);
+
+/*
+ * tty_wakeup/tty_ldisc_flush are actually _GPL exports but we can't do 
+ * that in 2.4 for modutils compat reasons.
+ */
+EXPORT_SYMBOL(tty_ldisc_flush);
 
 void do_tty_hangup(void *data)
 {
--- Documentation/Changes.orig	2005-01-15 11:26:42.221284896 -0200
+++ Documentation/Changes	2005-01-15 11:27:50.330930656 -0200
@@ -52,7 +52,7 @@
 o  Gnu make               3.77                    # make --version
 o  binutils               2.9.1.0.25              # ld -v
 o  util-linux             2.10o                   # fdformat --version
-o  modutils               2.4.2                   # insmod -V
+o  modutils               2.4.10                   # insmod -V
 o  e2fsprogs              1.25                    # tune2fs
 o  jfsutils               1.0.12                  # fsck.jfs -V
 o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs
@@ -159,8 +159,8 @@
 Upgrade to recent modutils to fix various outstanding bugs which are
 seen more frequently under 2.4.x, and to enable auto-loading of USB
 modules.  In addition, the layout of modules under
-/lib/modules/`uname -r`/ has been made more sane.  This change also
-requires that you upgrade to a recent modutils.
+/lib/modules/`uname -r`/ has been made more sane, and EXPORT_SYMBOL_GPL 
+also requires that you upgrade to a recent modutils.
 
 Mkinitrd
 --------



