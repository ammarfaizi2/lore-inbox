Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVKMBev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVKMBev (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 20:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVKMBev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 20:34:51 -0500
Received: from maggie.cs.pitt.edu ([130.49.220.148]:28858 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S1750789AbVKMBeu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 20:34:50 -0500
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] getrusage sucks
Date: Sun, 13 Nov 2005 02:34:18 +0100
User-Agent: KMail/1.8
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Magnus Naeslund(f)" <mag@fbab.net>,
       "Hua Zhong (hzhong)" <hzhong@cisco.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org, David Wagner <daw@cs.berkeley.edu>,
       Lee Revell <rlrevell@joe-job.com>
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com> <Pine.LNX.4.63.0511111547310.18982@twinlark.arctic.org> <20051112011006.GD7991@shell0.pdx.osdl.net>
In-Reply-To: <20051112011006.GD7991@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511130234.19733.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 November 2005 02:10, Chris Wright wrote:
> * dean gaudet (dean-list-linux-kernel@arctic.org) wrote:
> > do you have a use case for this new code?
>
> I'm with Dean.  What problem are you trying to solve?

I just want to improve getrusage to account for the case in which a server 
process needs to have usage information about client processes at run-time.
In this case RUSAGE_SELF is more important than RUSAGE_CHILDREN.
I think it would be an useful feature for some user-level applications.

At the beginning, I didn't want to propose any different prototype for the 
function, even if I think that a more general (and correct) one would be

      int getrusage(int who, struct rusage *usage, pid_t pid);

which accounts for all the situations we discussed so far.

However, I've added a more restrictive check (as asked by David) and the goto 
proposed by Hua. Is now the patch right ? Do you think that it's useful ?

Many thanks,

            Claudio


diff --git a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1746,9 +1746,29 @@ int getrusage(struct task_struct *p, int
 
 asmlinkage long sys_getrusage(int who, struct rusage __user *ru)
 {
- if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN)
-  return -EINVAL;
- return getrusage(current, who, ru);
+        struct rusage r;
+        struct task_struct* tsk = current;
+        read_lock(&tasklist_lock);
+        if ((who != RUSAGE_SELF) && (who != RUSAGE_CHILDREN)) {
+                tsk = find_task_by_pid(who);
+                if ((tsk == NULL) || (who <=0)) 
+                        goto bad;
+                if (((current->uid != tsk->euid) ||
+                     (current->uid != tsk->suid) ||
+                     (current->uid != tsk->uid) ||
+                     (current->gid != tsk->egid) ||
+                     (current->gid != tsk->sgid) ||
+                     (current->gid != tsk->gid)) && !capable(CAP_SYS_PTRACE))
+                        goto bad;
+                who = RUSAGE_SELF;
+        }
+        k_getrusage(tsk, who, &r);
+        read_unlock(&tasklist_lock);
+        return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
+
+ bad:
+        read_unlock(&tasklist_lock);
+        return tsk ? -EPERM : -EINVAL;
 }
 
 asmlinkage long sys_umask(int mask)

