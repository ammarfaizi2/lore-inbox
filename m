Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTFXVVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 17:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbTFXVVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 17:21:06 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:24979 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261960AbTFXVVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 17:21:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16120.50188.29.739261@gargle.gargle.HOWL>
Date: Tue, 24 Jun 2003 23:35:07 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: akpm@digeo.com (Andrew Morton),
       linux-kernel@vger.kernel.org (linux-kernel)
Subject: Re: 2.5.73 -- Uninitialised timer! (i386)
In-Reply-To: <200306242033.QAA27440@clem.clem-digital.net>
References: <20030624124800.72bfb98d.akpm@digeo.com>
	<200306242033.QAA27440@clem.clem-digital.net>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Clements writes:
 > Quoting Andrew Morton
 >   > 
 >   > Well it beats me.  That timer is clearly initialised OK.
 >   > 
 >   > What compiler version are you using?  Can you try
 >   > a different one>?
 > 
 > Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
 > gcc version 2.95.4 20011002 (Debian prerelease)
 > 
 > Only compiler currently installed.  Have four systems (3 single
 > processor, 1 dual) all running Debian--woody with same versions.
 > On the UP systems, will see several of these traces during boot.
 > After that, it is very seldom (0 to 3 in 12 hours). Have seen none
 > on the SMP system.  Recompiled one of the UP systems with SMP
 > enabled and no longer saw the trace during boot and post. Have
 > not seen this prior to 2.5.73.

Apply the patch below (which I posted to LKML yesterday btw).
2.5.73 incorrectly removed the workaround needed to prevent
gcc-2.95.x from miscompiling spinlocks on UP (they become
empty structs, and gcc-2.95.x has problems with those).

/Mikael

--- linux-2.5.73/include/linux/spinlock.h.~1~	2003-06-23 13:07:39.000000000 +0200
+++ linux-2.5.73/include/linux/spinlock.h	2003-06-23 22:58:29.000000000 +0200
@@ -146,8 +146,13 @@
 /*
  * gcc versions before ~2.95 have a nasty bug with empty initializers.
  */
-typedef struct { } spinlock_t;
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { }
+#if (__GNUC__ > 2)
+  typedef struct { } spinlock_t;
+  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
+#else
+  typedef struct { int gcc_is_buggy; } spinlock_t;
+  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+#endif
 
 /*
  * If CONFIG_SMP is unset, declare the _raw_* definitions as nops
