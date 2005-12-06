Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbVLFWBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbVLFWBo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbVLFWBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:01:44 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:60458 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030269AbVLFWBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:01:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=USd9kZUfAzO/imrnr/iBHruuJOXYQDsIovuQoG1pKxyNhSiaYL1QqKJuUo2P/qPR793pUdaq8XLFrlHpf12pqbswoap8Go9WdUz1eHclvYZSTrgPOdj+nLTGUA7V9VupSUeVr9ypGZXhyMlcWbls1tzRQc+eLoqbwM2bj0gunAw=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] Reduce number of pointer derefs in various files (kernel/exit.c used as example)
Date: Tue, 6 Dec 2005 23:02:06 +0100
User-Agent: KMail/1.9
Cc: Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512062302.06933.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are a lot of places in the kernel where we dereference several pointers
in a row several times.
As far as I can tell it should be more efficient to just deref those pointers
once, store the result in a variable, and then use that (unless the use is very
limited of course). 

To "test the waters" before I do a lot of work that won't be accepted, I picked
a random file with generic kernel code that has this issue and made a patch.

What I'd like to know is if anyone sees any problems with this and if patches
such as this one would be considered a good thing.

If patches like the one below are wanted I'll have a bunch of similar ones
ready to go pretty soon.

I've compile tested this patch and I'm currently running a 2.6.15-rc5-git1
kernel with it applied without problems.

Ohh, and before I forget, besides the fact that this should speed things up a
little bit it also has the added benefit of reducing the size of the generated
code.
The original kernel/exit.o file was 19604 bytes in size, the patched one is
19508 bytes in size.

Comments very welcome.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 kernel/exit.c |   37 +++++++++++++++++++++----------------
 1 files changed, 21 insertions(+), 16 deletions(-)

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
 




-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html


