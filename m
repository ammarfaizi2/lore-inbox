Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267335AbTBPTJZ>; Sun, 16 Feb 2003 14:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267337AbTBPTJZ>; Sun, 16 Feb 2003 14:09:25 -0500
Received: from franka.aracnet.com ([216.99.193.44]:13289 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267335AbTBPTJX>; Sun, 16 Feb 2003 14:09:23 -0500
Date: Sun, 16 Feb 2003 11:19:03 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: more signal locking bugs?
Message-ID: <27100000.1045423143@[10.10.2.4]>
In-Reply-To: <26480000.1045422382@[10.10.2.4]>
References: <Pine.LNX.4.44.0302161017500.2619-100000@home.transmeta.com> <26480000.1045422382@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

task_lock nests *inside* tasklist_lock but ... :

__do_SAK:

	task_lock
	...
	send_sig (SIGKILL, ...)
		send_sig_info (SIGKILL, ...)
			if (T(sig, SIG_KERNEL_BROADCAST_MASK)))
				read_lock(&tasklist_lock);
				...
				read_unlock(&tasklist_lock);
	...
	task_unlock


#define SIG_KERNEL_BROADCAST_MASK (\
        M(SIGHUP)    |  M(SIGINT)    |  M(SIGQUIT)   |  M(SIGILL)    | \
        M(SIGTRAP)   |  M(SIGABRT)   |  M(SIGBUS)    |  M(SIGFPE)    | \
        M(SIGKILL)   |  M(SIGUSR1)   |  M(SIGSEGV)   |  M(SIGUSR2)   | \
        M(SIGPIPE)   |  M(SIGALRM)   |  M(SIGTERM)   |  M(SIGXCPU)   | \
        M(SIGXFSZ)   |  M(SIGVTALRM) |  M(SIGPROF)   |  M(SIGPOLL)   | \
        M(SIGSYS)    |  M_SIGSTKFLT  |  M(SIGPWR)    |  M(SIGCONT)   | \
        M(SIGSTOP)   |  M(SIGTSTP)   |  M(SIGTTIN)   |  M(SIGTTOU)   | \
        M_SIGEMT )

