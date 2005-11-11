Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbVKKWip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbVKKWip (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 17:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVKKWim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 17:38:42 -0500
Received: from maggie.cs.pitt.edu ([130.49.220.148]:60397 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S1751280AbVKKWi2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 17:38:28 -0500
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] getrusage sucks
Date: Fri, 11 Nov 2005 23:38:19 +0100
User-Agent: KMail/1.8
Cc: "Magnus Naeslund(f)" <mag@fbab.net>,
       "Hua Zhong (hzhong)" <hzhong@cisco.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org, David Wagner <daw@cs.berkeley.edu>
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com> <200511110211.05642.cloud.of.andor@gmail.com> <1131715816.3174.15.camel@localhost.localdomain>
In-Reply-To: <1131715816.3174.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511112338.20684.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > You need to wrap this with a read_lock(&tasklist_lock) to be safe, I
> > > think.
> >
>
> It will depend on the data accuracy. If the information on cpu usage is
> very accurate then it becomes a way to analyse what is happening to
> tasks you don't own - such as say cryptographic functions in the web
> server...
>
> Otherwise, or with an owner check I see no real problem with the concept


So, is the following patch right ? I've added both the lock and the owner 
check...

Do you think it may be an interesting feature to be inserted in the kernel ?

Many thanks,

                 Claudio



diff --git a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1746,9 +1746,25 @@ int getrusage(struct task_struct *p, int

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
+                (current->euid != tsk->uid)) {
+                        read_unlock(&tasklist_lock);
+                        return -EINVAL;
+                }
+                k_getrusage(tsk, RUSAGE_SELF, &r);
+                read_unlock(&tasklist_lock);
+                return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
+        } else
+                return getrusage(current, who, ru);
 }

 asmlinkage long sys_umask(int mask)
