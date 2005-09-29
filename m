Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVI2GMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVI2GMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 02:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVI2GMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 02:12:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:17303 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751206AbVI2GMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 02:12:40 -0400
Date: Thu, 29 Sep 2005 07:12:39 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: linux-sh@m17n.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] breakage either in arch/sh/Kconfig or arch/sh/kernel/process.c?
Message-ID: <20050929061239.GS7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In process.c:
void flush_thread(void)
{
#if defined(CONFIG_SH_FPU)
        struct task_struct *tsk = current;
        struct pt_regs *regs = (struct pt_regs *)
                                ((unsigned long)tsk->thread_info
                                 + THREAD_SIZE - sizeof(struct pt_regs)
                                 - sizeof(unsigned long));
...
and
int dump_task_regs(struct task_struct *tsk, elf_gregset_t *regs)
{
        struct pt_regs ptregs;

        ptregs = *(struct pt_regs *)
                ((unsigned long)tsk->thread_info + THREAD_SIZE
                 - sizeof(struct pt_regs)
#ifdef CONFIG_SH_DSP
                 - sizeof(struct pt_dspregs)
#endif
                 - sizeof(unsigned long));

which is obviously inconsistent if we ever build with both SH_FPU and SH_DSP
set.  Now, in arch/sh/Kconfig we see that SH_FPU depends on !CPU_SH3 and SH_DSP
on !CPU_SH4.  Which leaves CPU_SH2 picking both options.

Comments?  Looks like either Kconfig or flush_thread() needs fixing...
