Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbVKOQ4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbVKOQ4d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVKOQ4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:56:33 -0500
Received: from maggie.cs.pitt.edu ([130.49.220.148]:211 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S964942AbVKOQ4c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:56:32 -0500
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: [PATCH] getrusage sucks
User-Agent: KMail/1.8
Cc: Chris Wright <chrisw@osdl.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Magnus Naeslund(f)" <mag@fbab.net>,
       "Hua Zhong (hzhong)" <hzhong@cisco.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org, David Wagner <daw@cs.berkeley.edu>,
       Lee Revell <rlrevell@joe-job.com>
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com> <Pine.LNX.4.63.0511111547310.18982@twinlark.arctic.org> <20051112011006.GD7991@shell0.pdx.osdl.net>
In-Reply-To: <20051112011006.GD7991@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Date: Tue, 15 Nov 2005 17:56:07 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200511151756.09397.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 November 2005 02:08, Peter Chubb wrote:
> >> You need to wrap this with a read_lock(&tasklist_lock) to be safe,
> >> I think.
>
> Claudio> Right. Probably this was the meaning also of Hua's
> Claudio> mail. Sorry, but I didn't get it immediately.
>
> Claudio> So, what if I do as follows ? Do you see any problem with
> Claudio> this solution ?
>
> You should probably restrict the ability to read a process's usage to
> a suitably privileged user -- i.e., effective uid same as the task's,
> or capable(CAP_SYS_RESOURCE) or maybe capable(CAP_SYS_ADMIN)

So, is CAP_SYS_PTRACE (as done in the patch below) not enough ?

Honestly, I don't see any problem in allowing any user to know usage 
information about _his_ processes...

Many thanks,

            Claudio

Signed-off-by: Claudio Scordino <cloud.of.andor@gmail.com>

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

