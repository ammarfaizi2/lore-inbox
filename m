Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVIEMU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVIEMU3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 08:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVIEMU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 08:20:29 -0400
Received: from odin2.bull.net ([192.90.70.84]:31643 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1751102AbVIEMU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 08:20:28 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: george@mvista.com
Subject: Re: [patch] KGDB for Real-Time Preemption systems
Date: Mon, 5 Sep 2005 14:23:46 +0200
User-Agent: KMail/1.7.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
References: <20050811110051.GA20872@elte.hu> <43028A94.1050603@mvista.com>
In-Reply-To: <43028A94.1050603@mvista.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TjDHDJu2AMwUQ7i"
Message-Id: <200509051423.47380.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_TjDHDJu2AMwUQ7i
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

mercredi 17 Ao=FBt 2005 02:53, George Anzinger wrote/a =E9crit=A0:
> I have put a version of KGDB for x86 RT kernels here:
> http://source.mvista.com/~ganzinger/
>
> The common_kgdb_cfi_.... stuff creates debug records for entry.S and
> friends so that you can "bt" through them.  Apply in this order:
> Ingo's patch
> kgdb-ga-rt.patch
> common_kgdb_cfi_annotations.patch
>
> This is, more or less, the same kgdb that is in Andrew's mm tree changed
> to fix the RT issues.

Hi, everybody

I found two bugs in kgdb-ga-rt patch.

The first one : if CONFIG_SMP is not set, we have a compile error
The second one : if CONFIG_KGDB is not set, we have a link error=20
I send you a diff patch to correct this. I am not sure the last patch is=20
correct, but it works.

--Boundary-00=_TjDHDJu2AMwUQ7i
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff.kgdb-ga-rt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff.kgdb-ga-rt"

--- kgdb-ga-rt.patch.org	2005-09-05 12:00:17.103019648 +0200
+++ kgdb-ga-rt.patch	2005-09-05 12:08:04.561955088 +0200
@@ -1861,11 +1861,11 @@
 +	gdb_i386errcode = err_code;
 +	kgdb_info.called_from = __builtin_return_address(0);
 +	kgdb_info.why = str;
++#ifdef CONFIG_SMP
 +	kgdb_info.cpus_waiting[trap_cpu].regs = linux_regs;
 +	kgdb_info.cpus_waiting[trap_cpu].task = current;
 +	kgdb_info.cpus_waiting[trap_cpu].pid = 
 +		(current->pid) ? : (PID_MAX + trap_cpu);
-+#ifdef CONFIG_SMP
 +	/*
 +	 * OK, we can now communicate, lets tell gdb about the sync.
 +	 * but only if we had a problem.
@@ -5078,7 +5078,7 @@
 ===================================================================
 --- /dev/null
 +++ linux-2.6.13-rc/include/asm-i386/kgdb_local.h
-@@ -0,0 +1,174 @@
+@@ -0,0 +1,178 @@
 +#ifndef __KGDB_LOCAL
 +#define ___KGDB_LOCAL
 +#include <linux/config.h>
@@ -5248,7 +5248,11 @@
 +#endif
 +#define INIT_KDEBUG putDebugChar("+");
 +extern struct  notifier_block kgdb_notify_struct;
++#ifdef CONFIG_KGDB 
 +#define KGDB_NOTIFY {&kgdb_notify_struct}
++#else				/* CONFIG_KGDB */
++#define KGDB_NOTIFY {NULL}
++#endif				/* CONFIG_KGDB */
 +#else
 +#define KGDB_NOTIFY {NULL}
 +#endif                          /* __ASSEMBLY__ */

--Boundary-00=_TjDHDJu2AMwUQ7i--
