Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbTDQMTi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 08:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTDQMTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 08:19:38 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:17889 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261320AbTDQMTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 08:19:33 -0400
Date: Thu, 17 Apr 2003 14:31:11 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paul Larson <plars@linuxtestproject.org>
Cc: ltp-coverage@lists.sourceforge.net,
       lse-tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Ltp-coverage] 2.5.67-gcov and 2.4.20-gcov
Message-ID: <20030417123111.GA29390@wohnheim.fh-wedel.de>
References: <1050502803.8637.1094.camel@plars> <20030416164440.GB2305@wohnheim.fh-wedel.de> <1050511870.10732.1277.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1050511870.10732.1277.camel@plars>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 April 2003 11:51:09 -0500, Paul Larson wrote:
> On Wed, 2003-04-16 at 11:44, Jörn Engel wrote:
> > Excuse me for being lazy. Does this already cover ppc? I submitted a
> > patch over some other channels some time ago.
> No, not yet.  And I havn't seen that patch, could you send it to me, or
> to the ltp-coverage mailing list?

Attached.

Most of it is trivial - identical to arch/*.

The bit in arch/ppc/kernel/entry.S was necessary for me to compile
this for a ppc 405gp based system, gcov would grow the kernel beyond
the relative jump distance for "bnel syscall_trace".

Paulus, Ben, is the relative jump a wanted optimization or unclean
code that went unnoticed so far? IOW should this go into mainline or
remain part of the gcov patch?

Jörn

-- 
Optimizations always bust things, because all optimizations are, in
the long haul, a form of cheating, and cheaters eventually get caught.
-- Larry Wall 

Index: arch/ppc/config.in
===================================================================
RCS file: /home/linux/arch/ppc/config.in,v
retrieving revision 1.11
diff -u -r1.11 config.in
--- arch/ppc/config.in	19 Feb 2003 21:41:13 -0000	1.11
+++ arch/ppc/config.in	28 Mar 2003 12:37:57 -0000
@@ -714,3 +714,13 @@
   bool 'Support for early boot texts over serial port' CONFIG_SERIAL_TEXT_DEBUG
 fi
 endmenu
+
+mainmenu_option next_comment
+comment 'GCOV coverage profiling'
+
+bool 'GCOV kernel' CONFIG_GCOV_PROFILE
+if [ "$CONFIG_GCOV_PROFILE" != "n" ]; then
+   bool '  GCOV kernel profiler' CONFIG_GCOV_ALL
+fi
+
+endmenu
Index: arch/ppc/kernel/entry.S
===================================================================
RCS file: /home/linux/arch/ppc/kernel/entry.S,v
retrieving revision 1.2
diff -u -r1.2 entry.S
--- entry.S	14 Feb 2003 21:40:50 -0000	1.2
+++ entry.S	28 Mar 2003 12:59:06 -0000
@@ -314,9 +314,19 @@
 	.globl	ret_from_fork
 ret_from_fork:
 	bl	schedule_tail
+#ifdef CONFIG_GCOV_ALL
+	lis	r0,syscall_trace@ha
+	addi	r0,r0,syscall_trace@l
+	mtlr	r0
+#endif
 	lwz	r0,TASK_PTRACE(r2)
 	andi.	r0,r0,PT_TRACESYS
+#ifdef CONFIG_GCOV_ALL
+	beq	ret_from_except
+	blrl
+#else
 	bnel-	syscall_trace
+#endif
 	b	ret_from_except
 
 	.globl	ret_from_intercept
Index: arch/ppc/kernel/head.S
===================================================================
RCS file: /home/linux/arch/ppc/kernel/head.S,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 head.S
--- arch/ppc/kernel/head.S	5 Nov 2002 16:24:13 -0000	1.1.1.1
+++ arch/ppc/kernel/head.S	28 Mar 2003 12:37:57 -0000
@@ -1755,3 +1755,24 @@
  */
 abatron_pteptrs:
 	.space	8
+ 
+#ifdef CONFIG_GCOV_PROFILE
+/*
+ * The .ctors-section contains a list of pointers to constructor
+ * functions which are used to initialize gcov structures.
+ *
+ * Because there is no NULL at the end of the constructor list
+ * in the kernel we need the addresses of both the constructor
+ * as well as the destructor list which are supposed to be
+ * adjacent.
+ */
+
+.section ".ctors","aw"
+.globl  __CTOR_LIST__
+.type   __CTOR_LIST__,@object
+__CTOR_LIST__:
+.section ".dtors","aw"
+.globl  __DTOR_LIST__
+.type   __DTOR_LIST__,@object
+__DTOR_LIST__:
+#endif
Index: arch/ppc/kernel/head_4xx.S
===================================================================
RCS file: /home/linux/arch/ppc/kernel/head_4xx.S,v
retrieving revision 1.8
diff -u -r1.8 head_4xx.S
--- arch/ppc/kernel/head_4xx.S	17 Feb 2003 20:06:16 -0000	1.8
+++ arch/ppc/kernel/head_4xx.S	28 Mar 2003 12:37:57 -0000
@@ -1271,3 +1271,24 @@
 	mtdcr 0x022, r3
 	blr
 #endif
+ 
+#ifdef CONFIG_GCOV_PROFILE
+/*
+ * The .ctors-section contains a list of pointers to constructor
+ * functions which are used to initialize gcov structures.
+ *
+ * Because there is no NULL at the end of the constructor list
+ * in the kernel we need the addresses of both the constructor
+ * as well as the destructor list which are supposed to be
+ * adjacent.
+ */
+
+.section ".ctors","aw"
+.globl  __CTOR_LIST__
+.type   __CTOR_LIST__,@object
+__CTOR_LIST__:
+.section ".dtors","aw"
+.globl  __DTOR_LIST__
+.type   __DTOR_LIST__,@object
+__DTOR_LIST__:
+#endif
Index: arch/ppc/kernel/head_8xx.S
===================================================================
RCS file: /home/linux/arch/ppc/kernel/head_8xx.S,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 head_8xx.S
--- arch/ppc/kernel/head_8xx.S	5 Nov 2002 16:24:13 -0000	1.1.1.1
+++ arch/ppc/kernel/head_8xx.S	28 Mar 2003 12:37:58 -0000
@@ -997,3 +997,23 @@
 	.space	16
 #endif
 
+#ifdef CONFIG_GCOV_PROFILE
+/*
+ * The .ctors-section contains a list of pointers to constructor
+ * functions which are used to initialize gcov structures.
+ *
+ * Because there is no NULL at the end of the constructor list
+ * in the kernel we need the addresses of both the constructor
+ * as well as the destructor list which are supposed to be
+ * adjacent.
+ */
+
+.section ".ctors","aw"
+.globl  __CTOR_LIST__
+.type   __CTOR_LIST__,@object
+__CTOR_LIST__:
+.section ".dtors","aw"
+.globl  __DTOR_LIST__
+.type   __DTOR_LIST__,@object
+__DTOR_LIST__:
+#endif
