Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318460AbSHPPTC>; Fri, 16 Aug 2002 11:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318464AbSHPPTC>; Fri, 16 Aug 2002 11:19:02 -0400
Received: from mnh-1-13.mv.com ([207.22.10.45]:54020 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S318460AbSHPPTB>;
	Fri, 16 Aug 2002 11:19:01 -0400
Message-Id: <200208161625.LAA02494@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: James Morris <jmorris@intercode.com.au>
cc: Alan Cox <alan@redhat.com>, "David S. Miller" <davem@redhat.com>,
       kuznet@ms2.inr.ac.ru, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org, Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH][RFC] sigurg/sigio cleanup for 2.5.31 
In-Reply-To: Your message of "Fri, 16 Aug 2002 03:16:57 +1000."
             <Mutt.LNX.4.44.0208160302100.28909-100000@blackbird.intercode.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Aug 2002 11:25:54 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmorris@intercode.com.au said:
>   o Fixed fowner race (lockless technique suggested by Alan Cox). 

This looks broken to me.  

+static void f_modown(struct file *filp, unsigned long pid,
+                     uid_t uid, uid_t euid)
+{
+	filp->f_owner.pid = PID_INVALID;
+	wmb();
+	filp->f_owner.uid = uid;
+	filp->f_owner.euid = euid;
+	wmb();
+	filp->f_owner.pid = pid;
+}

@@ -469,6 +491,9 @@
 	struct task_struct * p;
 	int   pid	= fown->pid;
 	
+	if (!pid || pid == PID_INVALID)
+		return;
+	

This introduces a window within which SIGIO will be dropped.  As it stands,
this will break UML.  Lost SIGIOs will cause UML hangs.

If you're determined to avoid spinlocks, why not do something like this:

+	if (!pid)
+		return;
+	while(fown->pid == PID_INVALID) ;

maybe with a cpu_relax() in the loop.

But that starts looking a lot like a spinlock.

Also, shouldn't there be a capable(CAP_KILL) in here rather than a check
for uid == 0?

+static inline int sigio_perm(struct task_struct *p,
+                             struct fown_struct *fown)
+{
+	return ((fown->euid == 0) ||
+ 	        (fown->euid == p->suid) || (fown->euid == p->uid) ||
+ 	        (fown->uid == p->suid) || (fown->uid == p->uid));
+}
+

				Jeff

