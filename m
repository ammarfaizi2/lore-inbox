Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbUJ3PBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUJ3PBM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbUJ3Oyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:54:35 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:61902 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261218AbUJ3Ol3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:41:29 -0400
Message-ID: <4183A80D.3090705@kolivas.org>
Date: Sun, 31 Oct 2004 00:41:17 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 25/28] Make public parts of schedstats
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC5F624FDB5B99B039994671D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC5F624FDB5B99B039994671D
Content-Type: multipart/mixed;
 boundary="------------030202030201080206080304"

This is a multi-part message in MIME format.
--------------030202030201080206080304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make public parts of schedstats


--------------030202030201080206080304
Content-Type: text/x-patch;
 name="publicise_schedstats.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="publicise_schedstats.diff"

Take the common functions of schedstats out, and privatise those that are
scheduler design dependant.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/sched.h	2004-10-30 00:20:11.034827926 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h	2004-10-30 00:20:12.649569607 +1000
@@ -32,6 +32,7 @@
 #include <linux/pid.h>
 #include <linux/percpu.h>
 #include <linux/topology.h>
+#include <linux/seq_file.h>
 
 struct exec_domain;
 
Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/scheduler.h	2004-10-30 00:19:31.771109110 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h	2004-10-30 00:20:12.649569607 +1000
@@ -46,6 +46,9 @@ struct sched_drv
 	void (*wait_task_inactive)(task_t *);
 	void (*cpu_attach_domain)(struct sched_domain *, int);
 #endif
+#ifdef CONFIG_SCHEDSTATS
+	int (*show_schedstat)(struct seq_file *, void *);
+#endif
 };
 
 /*
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-30 00:20:11.036827607 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-30 00:20:12.651569288 +1000
@@ -348,7 +348,7 @@ static inline void task_rq_unlock(runque
  */
 #define SCHEDSTAT_VERSION 10
 
-static int show_schedstat(struct seq_file *seq, void *v)
+static int ingo_show_schedstat(struct seq_file *seq, void *v)
 {
 	int cpu;
 	enum idle_type itype;
@@ -407,32 +407,6 @@ static int show_schedstat(struct seq_fil
 	return 0;
 }
 
-static int schedstat_open(struct inode *inode, struct file *file)
-{
-	unsigned int size = PAGE_SIZE * (1 + num_online_cpus() / 32);
-	char *buf = kmalloc(size, GFP_KERNEL);
-	struct seq_file *m;
-	int res;
-
-	if (!buf)
-		return -ENOMEM;
-	res = single_open(file, show_schedstat, NULL);
-	if (!res) {
-		m = file->private_data;
-		m->buf = buf;
-		m->size = size;
-	} else
-		kfree(buf);
-	return res;
-}
-
-struct file_operations proc_schedstat_operations = {
-	.open    = schedstat_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-};
-
 # define schedstat_inc(rq, field)	rq->field++;
 # define schedstat_add(rq, field, amt)	rq->field += amt;
 #else /* !CONFIG_SCHEDSTATS */
@@ -4149,4 +4123,7 @@ struct sched_drv ingo_sched_drv = {
 	.sched_idle_next	= ingo_sched_idle_next,
 #endif	
 #endif
+#ifdef CONFIG_SCHEDSTATS
+	.show_schedstat		= ingo_show_schedstat,
+#endif
 };
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-30 00:20:11.037827447 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-30 00:20:12.652569128 +1000
@@ -928,6 +928,36 @@ void __devinit init_sched_build_groups(s
 }
 #endif
 
+#ifdef CONFIG_SCHEDSTATS
+int show_schedstat(struct seq_file *seq, void *v);
+
+static int schedstat_open(struct inode *inode, struct file *file)
+{
+	unsigned int size = PAGE_SIZE * (1 + num_online_cpus() / 32);
+	char *buf = kmalloc(size, GFP_KERNEL);
+	struct seq_file *m;
+	int res;
+
+	if (!buf)
+		return -ENOMEM;
+	res = single_open(file, show_schedstat, NULL);
+	if (!res) {
+		m = file->private_data;
+		m->buf = buf;
+		m->size = size;
+	} else
+		kfree(buf);
+	return res;
+}
+
+struct file_operations proc_schedstat_operations = {
+	.open    = schedstat_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = single_release,
+};
+#endif
+
 extern struct sched_drv ingo_sched_drv;
 
 struct sched_drv *scheduler =
@@ -1136,3 +1166,10 @@ asmlinkage void schedule_tail(task_t *ta
 {
 	scheduler->tail(task);
 }
+
+#ifdef CONFIG_SCHEDSTATS
+int show_schedstat(struct seq_file *seq, void *v)
+{
+	return scheduler->show_schedstat(seq, v);
+}
+#endif


--------------030202030201080206080304--

--------------enigC5F624FDB5B99B039994671D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6gNZUg7+tp6mRURAhCSAKCD7iPqkloy2XAgMJg87L4iMQN8tQCfUbO1
ml4+qHb/lvOfwckaEiwvIj0=
=5ijH
-----END PGP SIGNATURE-----

--------------enigC5F624FDB5B99B039994671D--
