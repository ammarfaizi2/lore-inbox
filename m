Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262773AbTCVN7G>; Sat, 22 Mar 2003 08:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262777AbTCVN7G>; Sat, 22 Mar 2003 08:59:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53510 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262773AbTCVN7E>; Sat, 22 Mar 2003 08:59:04 -0500
Date: Sat, 22 Mar 2003 14:10:06 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4+ptrace exploit fix breaks root's ability to strace
Message-ID: <20030322141006.A8159@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030322103121.A16994@flint.arm.linux.org.uk> <1048345130.8912.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1048345130.8912.9.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sat, Mar 22, 2003 at 02:58:51PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 02:58:51PM +0000, Alan Cox wrote:
> On Sat, 2003-03-22 at 10:31, Russell King wrote:
> > Are the authors of the ptrace patch aware that, in addition to closing the
> > hole, the "fix" also prevents a ptrace-capable task (eg, strace started by
> > root) from ptracing user threads?
> > 
> > For example, you can't strace vsftpd processes started from xinetd.
> > 
> > Is this intended behaviour?
> 
> Its an unintended side effect, nobody has sent a patch to fix it yet.

How about this fix?  PT_PTRACE_CAP is set when we attach to a process
and the process doing the attaching has the ptrace capability.

Note that this patch is against the 2.4.19 version of ptrace.c with the
2.4.20 ptrace patch applied.

--- orig/kernel/ptrace.c	Wed Mar 19 15:54:45 2003
+++ linux/kernel/ptrace.c	Sat Mar 22 10:14:01 2003
@@ -22,7 +22,7 @@
 int ptrace_check_attach(struct task_struct *child, int kill)
 {
 	mb();
-	if (!is_dumpable(child))
+	if (!is_dumpable(child) && !(child->ptrace & PT_PTRACE_CAP))
 		return -EPERM;
 
 	if (!(child->ptrace & PT_PTRACED))
@@ -140,7 +140,7 @@
 	/* Worry about races with exit() */
 	task_lock(tsk);
 	mm = tsk->mm;
-	if (!is_dumpable(tsk) || (&init_mm == mm))
+	if ((!is_dumpable(tsk) || (&init_mm == mm)) && !(tsk->ptrace & PT_PTRACE_CAP))
 		mm = NULL;
 	if (mm)
 		atomic_inc(&mm->mm_users);


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

