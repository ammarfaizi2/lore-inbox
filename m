Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSDIO2M>; Tue, 9 Apr 2002 10:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290797AbSDIO2L>; Tue, 9 Apr 2002 10:28:11 -0400
Received: from brule.borg.umn.edu ([160.94.232.10]:29460 "EHLO
	brule.borg.umn.edu") by vger.kernel.org with ESMTP
	id <S289484AbSDIO2K>; Tue, 9 Apr 2002 10:28:10 -0400
From: Peter Bergner <bergner@brule.borg.umn.edu>
Date: Tue, 9 Apr 2002 09:28:03 -0500
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /arch/ppc64/kernel/setup.c
Message-ID: <20020409092803.A416306@brule.borg.umn.edu>
In-Reply-To: <Pine.GSO.4.05.10204051725280.19854-100000@mausmaki.cosy.sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas 'Dent' Mirlacher wrote:
: can someone please explain to me who calibrate_delay works in
: arch/ppc64/kernel/setup.c?
: 
: as i can see it calibrate.c is a global function defined in init/main.h.
: arch/ppc64/kernel/setup.c sets a pointer to the address of this function
: extern void (*calibrate_delay)(void); and assigns its own routine to that
: pointer. - hmm, every time i tried to do similar things (by mistake :),
: the program segfaulted on me.
: 
: - can someone please explain how this should work?

What's you're not seeing is the additional patch to the "offical"
sources which is required to get a working ppc64 kernel.  It's not
in the offical sources due to it touching non-arch specific files.
I've included the relevent part of the patch you're not seeing below.  
You can find the full patch at www.penguinppc64.org.

Peter



diff -uNr --exclude=CVS /kernels/64/linux-2.4.18-rc3/init/main.c linuxppc64_2_4/init/main.c
--- /kernels/64/linux-2.4.18-rc3/init/main.c	Thu Feb 21 17:04:28 2002
+++ linuxppc64_2_4/init/main.c	Thu Feb 21 21:02:01 2002
@@ -129,7 +129,6 @@
 char *execute_command;
 char root_device_name[64];
 
-
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 static char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
 
@@ -336,7 +335,7 @@
    better than 1% */
 #define LPS_PREC 8
 
-void __init calibrate_delay(void)
+void __init do_calibrate_delay(void)
 {
 	unsigned long ticks, loopbit;
 	int lps_precision = LPS_PREC;
@@ -376,6 +375,8 @@
 		loops_per_jiffy/(500000/HZ),
 		(loops_per_jiffy/(5000/HZ)) % 100);
 }
+
+void (*calibrate_delay)(void) = do_calibrate_delay;
 
 static int __init readonly(char *str)
 {
