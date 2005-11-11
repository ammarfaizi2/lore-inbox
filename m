Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVKKXoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVKKXoE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVKKXoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:44:04 -0500
Received: from maggie.cs.pitt.edu ([130.49.220.148]:8329 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S1750794AbVKKXoB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:44:01 -0500
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] getrusage sucks
Date: Sat, 12 Nov 2005 00:43:51 +0100
User-Agent: KMail/1.8
Cc: Chris Wright <chrisw@osdl.org>, "Magnus Naeslund(f)" <mag@fbab.net>,
       "Hua Zhong (hzhong)" <hzhong@cisco.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org, David Wagner <daw@cs.berkeley.edu>
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com> <20051111230223.GB7991@shell0.pdx.osdl.net> <1131753496.3174.55.camel@localhost.localdomain>
In-Reply-To: <1131753496.3174.55.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511120043.52796.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> In which case the only comment I have is the one about accuracy - and
> that is true for procfs too so will only come up if someone gets the
> urge to use perfctr timers for precision resource management

According to your comments, this the final patch. 

Should it be committed ?

         Claudio



diff --git a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1746,9 +1746,26 @@ int getrusage(struct task_struct *p, int

 asmlinkage long sys_getrusage(int who, struct rusage __user *ru)
 {
-       if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN)
-               return -EINVAL;
-       return getrusage(current, who, ru);
+        if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN) {
+                struct task_struct* tsk;
+                struct rusage r;
+                read_lock(&tasklist_lock);
+                tsk = find_task_by_pid(who);
+                if (tsk == NULL) {
+                        read_unlock(&tasklist_lock);
+                        return -EINVAL;
+                }
+                if ((current->euid != tsk->euid) &&
+                (current->euid != tsk->uid) &&
+                (!capable(CAP_SYS_ADMIN))){
+                        read_unlock(&tasklist_lock);
+                        return -EPERM;
+                }
+                k_getrusage(tsk, RUSAGE_SELF, &r);
+                read_unlock(&tasklist_lock);
+                return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
+        } else
+                return getrusage(current, who, ru);
 }

 asmlinkage long sys_umask(int mask)
