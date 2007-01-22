Return-Path: <linux-kernel-owner+w=401wt.eu-S1751821AbXAVOB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbXAVOB1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 09:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbXAVOB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 09:01:27 -0500
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:49259 "EHLO
	aa014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbXAVOB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 09:01:26 -0500
Date: Mon, 22 Jan 2007 14:59:56 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.com, torvalds@osdl.com,
       nhorman@tuxdriver.com
Subject: Re: [PATCH] select: fix sys_select to not leak ERESTARTNOHAND to
 userspace
Message-ID: <20070122145956.4a68762d@localhost>
In-Reply-To: <20070116201332.GA28523@hmsreliant.homelinux.net>
References: <20070116201332.GA28523@hmsreliant.homelinux.net>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2007 15:13:32 -0500
Neil Horman <nhorman@tuxdriver.com> wrote:

> As it is currently written, sys_select checks its return code to convert
> ERESTARTNOHAND to EINTR.  However, the check is within an if (tvp) clause, and
> so if select is called from userspace with a NULL timeval, then it is possible
> for the ERESTARTNOHAND errno to leak into userspace, which is incorrect.  This
> patch moves that check outside of the conditional, and prevents the errno leak.

the ERESTARTNOHAND thing is handled in arch specific signal code,
syscalls can return -ERESTARTNOHAND as much as they want (and your
change breaks the current behaviour of select()).

For example:

arch/x86_64/kernel/signal.c

        /* Are we from a system call? */
        if ((long)regs->orig_rax >= 0) {
                /* If so, check system call restarting.. */
                switch (regs->rax) {
                        case -ERESTART_RESTARTBLOCK:
                        case -ERESTARTNOHAND:
                                regs->rax = -EINTR;
                                break;

-- 
	Paolo Ornati
	Linux 2.6.20-rc5 on x86_64
