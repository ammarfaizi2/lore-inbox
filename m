Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbWBYTJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbWBYTJD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 14:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWBYTHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 14:07:47 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:3471 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1161068AbWBYTHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 14:07:32 -0500
Date: Sat, 25 Feb 2006 16:08:04 -0300
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: davem <davem@davemloft.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       robert.olsson@its.uu.se
Subject: [PATCH 3/6] pktgen: Fix kernel_thread() fail leak.
Message-ID: <20060225160804.4f7dd91c@home.brethil>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Free all the alocated resources if kernel_thread() call fails.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

---

 net/core/pktgen.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

c3fd9c4bbddab18349563c0c5d90c4bf0002de99
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 2d6b147..1c565fe 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3082,6 +3082,7 @@ static struct pktgen_thread *__init pktg
 
 static int __init pktgen_create_thread(const char *name, int cpu)
 {
+	int err;
 	struct pktgen_thread *t = NULL;
 	struct proc_dir_entry *pe;
 
@@ -3120,9 +3121,15 @@ static int __init pktgen_create_thread(c
 
 	t->removed = 0;
 
-	if (kernel_thread((void *)pktgen_thread_worker, (void *)t,
-			  CLONE_FS | CLONE_FILES | CLONE_SIGHAND) < 0)
+	err = kernel_thread((void *)pktgen_thread_worker, (void *)t,
+			  CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
+	if (err < 0) {
 		printk("pktgen: kernel_thread() failed for cpu %d\n", t->cpu);
+		remove_proc_entry(t->name, pg_proc_dir);
+		list_del(&t->th_list);
+		kfree(t);
+		return err;
+	}
 
 	return 0;
 }
-- 
1.2.1.g3397f9


-- 
Luiz Fernando N. Capitulino
