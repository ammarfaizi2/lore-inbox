Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbTBQAQu>; Sun, 16 Feb 2003 19:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbTBQAQu>; Sun, 16 Feb 2003 19:16:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46598 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266069AbTBQAQr>; Sun, 16 Feb 2003 19:16:47 -0500
Date: Sun, 16 Feb 2003 16:23:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: more signal locking bugs?
In-Reply-To: <Pine.LNX.4.44.0302162100140.24528-100000@dbl.q-ag.de>
Message-ID: <Pine.LNX.4.44.0302161620020.1609-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Feb 2003, Manfred Spraul wrote:
> 
> What about this minimal patch? The performance critical operation is 
> signal delivery - we should fix the synchronization between signal 
> delivery and exec first.

Ok, I committed this alternative change, which isn't quite as minimal, but 
looks a lot cleaner to me.

Also, looking at execve() and other paths, we do seem to have sufficient 
protection from the tasklist_lock that signal delivery should be fine. So 
despite a long and confused thread, I think in the end the only real bug 
was the one Martin found which should be thus fixed..

		Linus

---
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1054  -> 1.1055 
#	include/linux/signal.h	1.8     -> 1.9    
#	     fs/proc/array.c	1.42    -> 1.43   
#	      kernel/sched.c	1.158   -> 1.159  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/16	torvalds@home.transmeta.com	1.1055
# Clean up and fix locking around signal rendering
# --------------------------------------------
#
diff -Nru a/fs/proc/array.c b/fs/proc/array.c
--- a/fs/proc/array.c	Sun Feb 16 16:22:45 2003
+++ b/fs/proc/array.c	Sun Feb 16 16:22:45 2003
@@ -180,51 +180,74 @@
 	return buffer;
 }
 
+static char * render_sigset_t(const char *header, sigset_t *set, char *buffer)
+{
+	int i, len;
+
+	len = strlen(header);
+	memcpy(buffer, header, len);
+	buffer += len;
+
+	i = _NSIG;
+	do {
+		int x = 0;
+
+		i -= 4;
+		if (sigismember(set, i+1)) x |= 1;
+		if (sigismember(set, i+2)) x |= 2;
+		if (sigismember(set, i+3)) x |= 4;
+		if (sigismember(set, i+4)) x |= 8;
+		*buffer++ = (x < 10 ? '0' : 'a' - 10) + x;
+	} while (i >= 4);
+
+	*buffer++ = '\n';
+	*buffer = 0;
+	return buffer;
+}
+
 static void collect_sigign_sigcatch(struct task_struct *p, sigset_t *ign,
 				    sigset_t *catch)
 {
 	struct k_sigaction *k;
 	int i;
 
-	sigemptyset(ign);
-	sigemptyset(catch);
+	k = p->sighand->action;
+	for (i = 1; i <= _NSIG; ++i, ++k) {
+		if (k->sa.sa_handler == SIG_IGN)
+			sigaddset(ign, i);
+		else if (k->sa.sa_handler != SIG_DFL)
+			sigaddset(catch, i);
+	}
+}
+
+static inline char * task_sig(struct task_struct *p, char *buffer)
+{
+	sigset_t pending, shpending, blocked, ignored, caught;
+
+	sigemptyset(&pending);
+	sigemptyset(&shpending);
+	sigemptyset(&blocked);
+	sigemptyset(&ignored);
+	sigemptyset(&caught);
 
+	/* Gather all the data with the appropriate locks held */
 	read_lock(&tasklist_lock);
 	if (p->sighand) {
 		spin_lock_irq(&p->sighand->siglock);
-		k = p->sighand->action;
-		for (i = 1; i <= _NSIG; ++i, ++k) {
-			if (k->sa.sa_handler == SIG_IGN)
-				sigaddset(ign, i);
-			else if (k->sa.sa_handler != SIG_DFL)
-				sigaddset(catch, i);
-		}
+		pending = p->pending.signal;
+		shpending = p->signal->shared_pending.signal;
+		blocked = p->blocked;
+		collect_sigign_sigcatch(p, &ignored, &caught);
 		spin_unlock_irq(&p->sighand->siglock);
 	}
 	read_unlock(&tasklist_lock);
-}
-
-static inline char * task_sig(struct task_struct *p, char *buffer)
-{
-	sigset_t ign, catch;
 
-	buffer += sprintf(buffer, "SigPnd:\t");
-	buffer = render_sigset_t(&p->pending.signal, buffer);
-	*buffer++ = '\n';
-	buffer += sprintf(buffer, "ShdPnd:\t");
-	buffer = render_sigset_t(&p->signal->shared_pending.signal, buffer);
-	*buffer++ = '\n';
-	buffer += sprintf(buffer, "SigBlk:\t");
-	buffer = render_sigset_t(&p->blocked, buffer);
-	*buffer++ = '\n';
-
-	collect_sigign_sigcatch(p, &ign, &catch);
-	buffer += sprintf(buffer, "SigIgn:\t");
-	buffer = render_sigset_t(&ign, buffer);
-	*buffer++ = '\n';
-	buffer += sprintf(buffer, "SigCgt:\t"); /* Linux 2.0 uses "SigCgt" */
-	buffer = render_sigset_t(&catch, buffer);
-	*buffer++ = '\n';
+	/* render them all */
+	buffer = render_sigset_t("SigPnd:\t", &pending, buffer);
+	buffer = render_sigset_t("ShdPnd:\t", &shpending, buffer);
+	buffer = render_sigset_t("SigBlk:\t", &blocked, buffer);
+	buffer = render_sigset_t("SigIgn:\t", &ignored, buffer);
+	buffer = render_sigset_t("SigCgt:\t", &caught, buffer);
 
 	return buffer;
 }
diff -Nru a/include/linux/signal.h b/include/linux/signal.h
--- a/include/linux/signal.h	Sun Feb 16 16:22:45 2003
+++ b/include/linux/signal.h	Sun Feb 16 16:22:45 2003
@@ -151,8 +151,6 @@
 	}
 }
 
-extern char * render_sigset_t(sigset_t *set, char *buffer);
-
 /* Some extensions for manipulating the low 32 signals in particular.  */
 
 static inline void sigaddsetmask(sigset_t *set, unsigned long mask)
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Sun Feb 16 16:22:45 2003
+++ b/kernel/sched.c	Sun Feb 16 16:22:45 2003
@@ -2095,21 +2095,6 @@
 	}
 }
 
-char * render_sigset_t(sigset_t *set, char *buffer)
-{
-	int i = _NSIG, x;
-	do {
-		i -= 4, x = 0;
-		if (sigismember(set, i+1)) x |= 1;
-		if (sigismember(set, i+2)) x |= 2;
-		if (sigismember(set, i+3)) x |= 4;
-		if (sigismember(set, i+4)) x |= 8;
-		*buffer++ = (x < 10 ? '0' : 'a' - 10) + x;
-	} while (i >= 4);
-	*buffer = 0;
-	return buffer;
-}
-
 void show_state(void)
 {
 	task_t *g, *p;

