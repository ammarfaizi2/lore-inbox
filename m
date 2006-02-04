Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWBDTVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWBDTVj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 14:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWBDTVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 14:21:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20696 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932213AbWBDTVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 14:21:38 -0500
Date: Sat, 4 Feb 2006 20:21:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: chroot in swsusp userland interface (was: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060204192123.GB3909@elf.ucw.cz>
References: <200602030918.07006.nigel@suspend2.net> <20060204010833.GD4845@dspnet.fr.eu.org> <20060204012312.GH3291@elf.ucw.cz> <200602041451.45232.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602041451.45232.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > No, I do not want to deal with multiple processes. Chrome code is not
> > *as* evil as you paint it... But yes, chroot is a nice idea. Doing
> > chroot into nowhere after freezing system will prevent most stupid
> > mistakes. Rest of userland is frozen, so it can not do anything really
> > wrong (at most you deadlock), if you kill someone -- well, that's only
> > as dangerous as any other code running as root.
> 
> I like the chroot idea too.
> 
> Are we going to chroot from the kernel level (eg. the atomic snapshot
> ioctl()) or from within the suspending utility?
> 
> I think the kernel level would protect some people from bugs in their own
> suspending utilities, but then we'd have to mount the tmpfs from the kernel
> level as well.

What about this (untested)?

BTW we do some playing with consoles after freeze. Would it be
possible to do it *before* freeze? Opening tty might change its
access time...?
							Pavel

Index: resume.c
===================================================================
RCS file: /cvsroot/suspend/suspend/resume.c,v
retrieving revision 1.4
diff -u -u -r1.4 resume.c
--- resume.c	3 Feb 2006 22:39:24 -0000	1.4
+++ resume.c	4 Feb 2006 19:19:48 -0000
@@ -227,6 +227,12 @@
 		error = errno;
 		goto Close;
 	}
+	/*
+	 * From now on, system is frozen; any filesystem access may mean data corruption.
+	 * Prevent accidental filesystem accesses by chrooting somewhere where little
+	 * damage can be done.
+	 */
+	chroot("/sys/power");
 	atomic_restore(dev);
 	unfreeze(dev);
 Close:
Index: suspend.c
===================================================================
RCS file: /cvsroot/suspend/suspend/suspend.c,v
retrieving revision 1.5
diff -u -u -r1.5 suspend.c
--- suspend.c	3 Feb 2006 22:39:24 -0000	1.5
+++ suspend.c	4 Feb 2006 19:19:51 -0000
@@ -360,6 +360,12 @@
 		goto Close;
 	}
 	go_to_console();
+	/*
+	 * From now on, system is frozen; any filesystem access may mean data corruption.
+	 * Prevent accidental filesystem accesses by chrooting somewhere where little
+	 * damage can be done.
+	 */
+	chroot("/sys/power");
 	attempts = 2;
 	do {
 		if (set_image_size(dev, image_size)) {


-- 
Thanks, Sharp!
