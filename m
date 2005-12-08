Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932675AbVLHWfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbVLHWfX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVLHWfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:35:23 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:20082 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932675AbVLHWfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:35:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=m4Cl6qHmkgKXOxBANCWLlseoOgS9WhLVZSXfbVRXAAP/EqdDkfcQ/Y6LE4pirccQF5OeQFs/kt9WGMqqrXN4r0AdoT9sPSUxjvv2mY3RDjb4zfgXg1rEZGVRHUB0FdsLHD+2YT08ToTGPYgON4/hVu0l5I9PNs48vam+ZrhWu9E=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Decrease number of pointer derefs in exit.c
Date: Thu, 8 Dec 2005 23:35:42 +0100
User-Agent: KMail/1.9
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512082335.42811.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a small patch to decrease the number of pointer derefs in
kernel/exit.c

Benefits of the patch:
 - Fewer pointer dereferences should make the code slightly faster.
 - Size of generated code is smaller
 - improved readability

Please consider applying.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
---

 kernel/exit.c |   37 +++++++++++++++++++++----------------
 1 files changed, 21 insertions(+), 16 deletions(-)

   text    data     bss     dec     hex filename
 11077       0       0   11077    2b45 exit.o.orig
 10997       0       0   10997    2af5 exit.o

--- linux-2.6.15-rc5-git1-orig/kernel/exit.c	2005-12-04 18:48:53.000000000 +0100
+++ linux-2.6.15-rc5-git1/kernel/exit.c	2005-12-06 22:11:17.000000000 +0100
@@ -1068,6 +1068,9 @@ static int wait_task_zombie(task_t *p, i
 	}
 
 	if (likely(p->real_parent == p->parent) && likely(p->signal)) {
+		struct signal_struct *psig;
+		struct signal_struct *sig;
+		
 		/*
 		 * The resource counters for the group leader are in its
 		 * own task_struct.  Those for dead threads in the group
@@ -1084,24 +1087,26 @@ static int wait_task_zombie(task_t *p, i
 		 * here reaping other children at the same time.
 		 */
 		spin_lock_irq(&p->parent->sighand->siglock);
-		p->parent->signal->cutime =
-			cputime_add(p->parent->signal->cutime,
+		psig = p->parent->signal;
+		sig = p->signal;
+		psig->cutime =
+			cputime_add(psig->cutime,
 			cputime_add(p->utime,
-			cputime_add(p->signal->utime,
-				    p->signal->cutime)));
-		p->parent->signal->cstime =
-			cputime_add(p->parent->signal->cstime,
+			cputime_add(sig->utime,
+				    sig->cutime)));
+		psig->cstime =
+			cputime_add(psig->cstime,
 			cputime_add(p->stime,
-			cputime_add(p->signal->stime,
-				    p->signal->cstime)));
-		p->parent->signal->cmin_flt +=
-			p->min_flt + p->signal->min_flt + p->signal->cmin_flt;
-		p->parent->signal->cmaj_flt +=
-			p->maj_flt + p->signal->maj_flt + p->signal->cmaj_flt;
-		p->parent->signal->cnvcsw +=
-			p->nvcsw + p->signal->nvcsw + p->signal->cnvcsw;
-		p->parent->signal->cnivcsw +=
-			p->nivcsw + p->signal->nivcsw + p->signal->cnivcsw;
+			cputime_add(sig->stime,
+				    sig->cstime)));
+		psig->cmin_flt +=
+			p->min_flt + sig->min_flt + sig->cmin_flt;
+		psig->cmaj_flt +=
+			p->maj_flt + sig->maj_flt + sig->cmaj_flt;
+		psig->cnvcsw +=
+			p->nvcsw + sig->nvcsw + sig->cnvcsw;
+		psig->cnivcsw +=
+			p->nivcsw + sig->nivcsw + sig->cnivcsw;
 		spin_unlock_irq(&p->parent->sighand->siglock);
 	}
 



