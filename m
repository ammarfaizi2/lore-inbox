Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285618AbSBOA6h>; Thu, 14 Feb 2002 19:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285747AbSBOA62>; Thu, 14 Feb 2002 19:58:28 -0500
Received: from jalon.able.es ([212.97.163.2]:36312 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S285618AbSBOA6R>;
	Thu, 14 Feb 2002 19:58:17 -0500
Date: Fri, 15 Feb 2002 01:58:10 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: pid allocator bug ?
Message-ID: <20020215015810.C14226@werewolf.able.es>
In-Reply-To: <20020214172941.A14007@hendriks.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020214172941.A14007@hendriks.cx>; from erik@hendriks.cx on vie, feb 15, 2002 at 01:29:41 +0100
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20020215 Erik Arjan Hendriks wrote:
>BProc 3.1.7 is out and in the usual spot:
>
>http://sourceforge.net/project/showfiles.php?group_id=24453&release_id=75172
>
>Release notes and change log follow:
>
...
>
>        * Added patch for Linux PID allocator bug.
>

Patch is like this:

$Id: linux-2.4.17-fork-pid-alloc.patch,v 1.1 2002/02/14 17:21:35 hendriks Exp $

This patch fixes a bug in the Linux process ID allocator.  It isn't quite
SMP safe since it references "last_pid" after releasing the lock protecting
it.  This can result in two processes getting assigned the same process ID.

--- linux-2.4.17/kernel/fork.c.orig	Mon Feb  4 14:53:31 2002
+++ linux-2.4.17/kernel/fork.c	Mon Feb  4 14:53:53 2002
@@ -85,6 +85,7 @@
 {
 	static int next_safe = PID_MAX;
 	struct task_struct *p;
+	int pid;
 
 	if (flags & CLONE_PID)
 		return current->pid;
@@ -120,9 +121,10 @@
 		}
 		read_unlock(&tasklist_lock);
 	}
+	pid = last_pid;
 	spin_unlock(&lastpid_lock);
 
-	return last_pid;
+	return pid;
 }
 
 static inline int dup_mmap(struct mm_struct * mm)

????

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-rc1-slb1 #1 SMP Thu Feb 14 01:04:12 CET 2002 i686
