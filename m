Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289783AbSBEUVH>; Tue, 5 Feb 2002 15:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289794AbSBEUU6>; Tue, 5 Feb 2002 15:20:58 -0500
Received: from acl.lanl.gov ([128.165.147.1]:63093 "HELO acl.lanl.gov")
	by vger.kernel.org with SMTP id <S289783AbSBEUUs>;
	Tue, 5 Feb 2002 15:20:48 -0500
Date: Tue, 5 Feb 2002 13:20:46 -0700
From: "Erik A. Hendriks" <hendriks@lanl.gov>
To: marcelo@conectiva.com.br, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Linux 2.4.17,2.5.3 process ID allocator isn't quite SMP safe.
Message-ID: <20020205132046.D5217@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The get_pid function in kernel/fork.c returns the value of last_pid
after releasing the lock protecting it.  On SMPs, I have observed two
processes occasionally being assigned the same process ID as a result.

I'm pretty sure the sequence of events looks like this: The first
process releases the lock after coming up with a suitable pid (stored
in last_pid).  Then after it releases the lock but before it does the
return (IRQ or something happens here to create delay?) another
processor comes a long and updates it.  Then get_pid returns the value
of last_pid which is now the pid chosen by the other process.

Attached below is a little patch to fix it.

- Erik

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


