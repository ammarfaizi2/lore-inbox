Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267485AbTBJBRi>; Sun, 9 Feb 2003 20:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267493AbTBJBRi>; Sun, 9 Feb 2003 20:17:38 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:6730 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267485AbTBJBRh>; Sun, 9 Feb 2003 20:17:37 -0500
Date: Sun, 9 Feb 2003 17:27:09 -0800
Message-Id: <200302100127.h1A1R9Y06040@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
X-Fcc: ~/Mail/linus
Cc: Ingo Molnar <mingo@elte.hu>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>, Arjan van de Ven <arjanv@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: Linus Torvalds's message of  Sunday, 9 February 2003 17:07:01 -0800 <Pine.LNX.4.44.0302091703220.13648-100000@home.transmeta.com>
X-Fcc: ~/Mail/linus
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /home/roland/redhat/linux-2.5.59-1.1007/fs/exec.c.~1~	Fri Feb  7 20:04:27 2003
+++ /home/roland/redhat/linux-2.5.59-1.1007/fs/exec.c	Sun Feb  9 17:25:31 2003
@@ -601,9 +601,12 @@ static inline int de_thread(struct task_
 
 	if (thread_group_empty(current))
 		goto no_thread_group;
+
 	/*
-	 * Kill all other threads in the thread group:
+	 * Kill all other threads in the thread group.
+	 * We must hold tasklist_lock to call zap_other_threads.
 	 */
+	read_lock(&tasklist_lock);
 	spin_lock_irq(lock);
 	if (oldsig->group_exit) {
 		/*
@@ -611,6 +614,7 @@ static inline int de_thread(struct task_
 		 * return so that the signal is processed.
 		 */
 		spin_unlock_irq(lock);
+		read_unlock(&tasklist_lock);
 		kmem_cache_free(sighand_cachep, newsighand);
 		if (newsig)
 			kmem_cache_free(signal_cachep, newsig);
@@ -618,6 +622,7 @@ static inline int de_thread(struct task_
 	}
 	oldsig->group_exit = 1;
 	zap_other_threads(current);
+	read_unlock(&tasklist_lock);
 
 	/*
 	 * Account for the thread group leader hanging around:
