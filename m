Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTFITJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 15:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbTFITJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 15:09:57 -0400
Received: from 12-221-81-65.client.insightBB.com ([12.221.81.65]:36879 "HELO
	apathy.killer-robot.net") by vger.kernel.org with SMTP
	id S264252AbTFITJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 15:09:47 -0400
Date: Mon, 9 Jun 2003 14:23:25 -0500
From: Maciej Babinski <maciej@killer-robot.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] CIFS oops
Message-ID: <20030609192325.GA24583@apathy.black-flower>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a non-critical oops that occurs when the cifs module is
removed from the kernel. It uses the completion.h mechanism to
ensure that the cifsoplockd kernel thread exits before the module is
unloaded.

                                    -- Maciej Babinski


--- linux-2.5.70.old/fs/cifs/cifsfs.c	Mon May 26 20:00:40 2003
+++ linux-2.5.70/fs/cifs/cifsfs.c	Mon Jun  9 12:59:31 2003
@@ -62,6 +62,8 @@
 void cifs_proc_init(void);
 void cifs_proc_clean(void);
 
+static DECLARE_COMPLETION(cifsoplock_exited);
+
 static int
 cifs_read_super(struct super_block *sb, void *data,
 		const char *devname, int silent)
@@ -423,7 +425,8 @@
 		       "cifs_destroy_mids: error not all structures were freed\n");
 	if (kmem_cache_destroy(cifs_oplock_cachep))
 		printk(KERN_WARNING
-		       "error not all oplock structures were freed\n");}
+		       "error not all oplock structures were freed\n");
+}
 
 static int cifs_oplock_thread(void * dummyarg)
 {
@@ -435,10 +438,10 @@
 	int rc;
 
 	daemonize("cifsoplockd");
-	allow_signal(SIGKILL);
+	allow_signal(SIGTERM);
 
 	oplockThread = current;
-	while (1) {
+	do {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(100*HZ);
 		/* BB add missing code */
@@ -466,7 +469,9 @@
 		}
 		write_unlock(&GlobalMid_Lock);
 		cFYI(1,("next time through while loop")); /* BB remove */
-	}
+	} while (!signal_pending(current));
+
+	complete_and_exit (&cifsoplock_exited, 0);
 }
 
 static int __init
@@ -528,8 +533,10 @@
 	cifs_destroy_inodecache();
 	cifs_destroy_mids();
 	cifs_destroy_request_bufs();
-	if(oplockThread)
-		send_sig(SIGKILL, oplockThread, 1);
+	if(oplockThread) {
+		send_sig(SIGTERM, oplockThread, 1);
+		wait_for_completion(&cifsoplock_exited);
+	}
 }
 
 MODULE_AUTHOR("Steve French <sfrench@us.ibm.com>");
