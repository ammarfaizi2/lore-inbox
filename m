Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbTARNWI>; Sat, 18 Jan 2003 08:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbTARNWI>; Sat, 18 Jan 2003 08:22:08 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:23485 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S264724AbTARNWF>; Sat, 18 Jan 2003 08:22:05 -0500
From: Erich Focht <efocht@ess.nec.de>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>
Subject: [patch] tunable rebalance rates for sched-2.5.59-B0
Date: Sat, 18 Jan 2003 14:31:21 +0100
User-Agent: KMail/1.4.3
Cc: Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <Pine.LNX.4.44.0301170921430.3723-100000@localhost.localdomain> <148970000.1042831603@flay> <1042848809.24867.483.camel@dyn9-47-17-164.beaverton.ibm.com>
In-Reply-To: <1042848809.24867.483.camel@dyn9-47-17-164.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_98WW86ZNRLCFVPI8Z61H"
Message-Id: <200301181431.21942.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_98WW86ZNRLCFVPI8Z61H
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm currently scanning the parameter space of IDLE_NODE_REBALANCE_TICK
and BUSY_NODE_REBALANCE_TICK with the help of tunable rebalance
rates. The patch basically does:

-#define IDLE_NODE_REBALANCE_TICK (IDLE_REBALANCE_TICK * 2)
-#define BUSY_NODE_REBALANCE_TICK (BUSY_REBALANCE_TICK * 2)
+int idle_nodebalance_rate =3D 10;
+int busy_nodebalance_rate =3D 10;
+#define IDLE_NODE_REBALANCE_TICK (IDLE_REBALANCE_TICK * idle_nodebalance=
_rate)
+#define BUSY_NODE_REBALANCE_TICK (BUSY_REBALANCE_TICK * busy_nodebalance=
_rate)

and makes the variables accessible in /proc/sys/kernel

We might want to leave these tunable in case it turns out that
different platforms need significantly different values. Right now
it's just a tool for tuning.

Regards,
Erich


--------------Boundary-00=_98WW86ZNRLCFVPI8Z61H
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="tunable-balance-rate-2.5.59"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="tunable-balance-rate-2.5.59"

diff -urNp 2.5.59-B0/include/linux/sysctl.h 2.5.59-B0-tune/include/linux/sysctl.h
--- 2.5.59-B0/include/linux/sysctl.h	2003-01-17 03:22:16.000000000 +0100
+++ 2.5.59-B0-tune/include/linux/sysctl.h	2003-01-18 12:49:17.000000000 +0100
@@ -129,6 +129,8 @@ enum
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
+  	KERN_NODBALI=57,	/* int: idle cross-node balance rate */
+  	KERN_NODBALB=58,	/* int: busy cross-node balance rate */
 };
 
 
diff -urNp 2.5.59-B0/kernel/sched.c 2.5.59-B0-tune/kernel/sched.c
--- 2.5.59-B0/kernel/sched.c	2003-01-18 11:50:23.000000000 +0100
+++ 2.5.59-B0-tune/kernel/sched.c	2003-01-18 12:01:03.000000000 +0100
@@ -984,12 +984,14 @@ out:
  * busy-rebalance every 200 msecs. idle-rebalance every 1 msec. (or on
  * systems with HZ=100, every 10 msecs.)
  *
- * On NUMA, do a node-rebalance every 400 msecs.
+ * On NUMA, do a node-rebalance every 10ms (idle) or 2 secs (busy).
  */
 #define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
 #define BUSY_REBALANCE_TICK (HZ/5 ?: 1)
-#define IDLE_NODE_REBALANCE_TICK (IDLE_REBALANCE_TICK * 2)
-#define BUSY_NODE_REBALANCE_TICK (BUSY_REBALANCE_TICK * 2)
+int idle_nodebalance_rate = 10;
+int busy_nodebalance_rate = 10;
+#define IDLE_NODE_REBALANCE_TICK (IDLE_REBALANCE_TICK * idle_nodebalance_rate)
+#define BUSY_NODE_REBALANCE_TICK (BUSY_REBALANCE_TICK * busy_nodebalance_rate)
 
 #if CONFIG_NUMA
 static void balance_node(runqueue_t *this_rq, int idle, int this_cpu)
diff -urNp 2.5.59-B0/kernel/sysctl.c 2.5.59-B0-tune/kernel/sysctl.c
--- 2.5.59-B0/kernel/sysctl.c	2003-01-17 03:21:39.000000000 +0100
+++ 2.5.59-B0-tune/kernel/sysctl.c	2003-01-18 11:59:53.000000000 +0100
@@ -55,6 +55,8 @@ extern char core_pattern[];
 extern int cad_pid;
 extern int pid_max;
 extern int sysctl_lower_zone_protection;
+extern int idle_nodebalance_rate;
+extern int busy_nodebalance_rate;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -261,6 +263,10 @@ static ctl_table kern_table[] = {
 #endif
 	{KERN_PIDMAX, "pid_max", &pid_max, sizeof (int),
 	 0600, NULL, &proc_dointvec},
+	{KERN_NODBALI, "idle_nodebalance_rate", &idle_nodebalance_rate,
+	 sizeof (int), 0600, NULL, &proc_dointvec},
+	{KERN_NODBALB, "busy_nodebalance_rate", &busy_nodebalance_rate,
+	 sizeof (int), 0600, NULL, &proc_dointvec},
 	{0}
 };
 

--------------Boundary-00=_98WW86ZNRLCFVPI8Z61H--

