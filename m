Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVKKBLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVKKBLU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 20:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVKKBLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 20:11:20 -0500
Received: from maggie.cs.pitt.edu ([130.49.220.148]:8630 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S932328AbVKKBLT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 20:11:19 -0500
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: "Magnus Naeslund(f)" <mag@fbab.net>
Subject: Re: [PATCH] getrusage sucks
Date: Fri, 11 Nov 2005 02:11:04 +0100
User-Agent: KMail/1.8
Cc: "Hua Zhong (hzhong)" <hzhong@cisco.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com> <200511110123.29664.cloud.of.andor@gmail.com> <4373E69B.6040206@fbab.net>
In-Reply-To: <4373E69B.6040206@fbab.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511110211.05642.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You need to wrap this with a read_lock(&tasklist_lock) to be safe, I think.

Right. Probably this was the meaning also of Hua's mail. Sorry, but I didn't 
get it immediately.

So, what if I do as follows ? Do you see any problem with this solution ?

Many thanks,

              Claudio



diff --git a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1746,9 +1746,22 @@ int getrusage(struct task_struct *p, int

 asmlinkage long sys_getrusage(int who, struct rusage __user *ru)
 {
-       if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN)
-               return -EINVAL;
-       return getrusage(current, who, ru);
+        int res;
+        if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN) {
+                struct task_struct* tsk;
+                read_lock(&tasklist_lock);
+                tsk = find_task_by_pid(who);
+                if (tsk == NULL) {
+                        read_unlock(&tasklist_lock);
+                        return -EINVAL;
+                }
+                res = getrusage(tsk, RUSAGE_SELF, ru);
+                read_unlock(&tasklist_lock);
+                return res;
+        } else {
+                res = getrusage(current, who, ru);
+                return res;
+        }
 }

 asmlinkage long sys_umask(int mask)
