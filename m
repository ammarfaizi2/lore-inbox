Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSHOV1m>; Thu, 15 Aug 2002 17:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317520AbSHOV1m>; Thu, 15 Aug 2002 17:27:42 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:47858 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317517AbSHOV1k>; Thu, 15 Aug 2002 17:27:40 -0400
Date: Thu, 15 Aug 2002 17:31:36 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, trond.myklebust@fys.uio.no
Subject: [patch] v2.5.31 nfsctl.c stack usage reduction
Message-ID: <20020815173136.D29874@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heyo,

The patch below (which depends on the copy_from_user_kmalloc addition) 
reduces the stack usage in nfsctl.c, which was allocating structures that 
were 2KB or more on the stack.

		-ben

:r ~/patches/v2.5/v2.5.31-stack-nfs.diff
diff -urN foo-v2.5.31/fs/nfsd/nfsctl.c bar-v2.5.31/fs/nfsd/nfsctl.c
--- foo-v2.5.31/fs/nfsd/nfsctl.c	Tue Jul 30 10:24:17 2002
+++ bar-v2.5.31/fs/nfsd/nfsctl.c	Thu Aug 15 17:26:09 2002
@@ -155,56 +155,47 @@
  * payload - write methods
  */
 
+/* Rather than duplicate this many times, just use a funky macro. */
+#define WRITE_METHOD(type, fn)		\
+	type *data;			\
+	ssize_t ret;			\
+	if (size < sizeof(*data))	\
+		return -EINVAL;		\
+	data = copy_from_user_kmalloc(buf, size);\
+	if (IS_ERR(data))		\
+		return PTR_ERR(data);	\
+	ret = fn;			\
+	kfree(data);			\
+	return ret;
+
 static ssize_t write_svc(struct file *file, const char *buf, size_t size)
 {
-	struct nfsctl_svc data;
-	if (size < sizeof(data))
-		return -EINVAL;
-	if (copy_from_user(&data, buf, size))
-		return -EFAULT;
-	return nfsd_svc(data.svc_port, data.svc_nthreads);
+	WRITE_METHOD(struct nfsctl_svc,
+		     nfsd_svc(data->svc_port, data->svc_nthreads));
 }
 
 static ssize_t write_add(struct file *file, const char *buf, size_t size)
 {
-	struct nfsctl_client data;
-	if (size < sizeof(data))
-		return -EINVAL;
-	if (copy_from_user(&data, buf, size))
-		return -EFAULT;
-	return exp_addclient(&data);
+	WRITE_METHOD(struct nfsctl_client, exp_addclient(data));
 }
 
 static ssize_t write_del(struct file *file, const char *buf, size_t size)
 {
-	struct nfsctl_client data;
-	if (size < sizeof(data))
-		return -EINVAL;
-	if (copy_from_user(&data, buf, size))
-		return -EFAULT;
-	return exp_delclient(&data);
+	WRITE_METHOD(struct nfsctl_client, exp_delclient(data));
 }
 
 static ssize_t write_export(struct file *file, const char *buf, size_t size)
 {
-	struct nfsctl_export data;
-	if (size < sizeof(data))
-		return -EINVAL;
-	if (copy_from_user(&data, buf, size))
-		return -EFAULT;
-	return exp_export(&data);
+	WRITE_METHOD(struct nfsctl_export, exp_export(data));
 }
 
 static ssize_t write_unexport(struct file *file, const char *buf, size_t size)
 {
-	struct nfsctl_export data;
-	if (size < sizeof(data))
-		return -EINVAL;
-	if (copy_from_user(&data, buf, size))
-		return -EFAULT;
-	return exp_unexport(&data);
+	WRITE_METHOD(struct nfsctl_export, exp_unexport(data));
 }
 
+#undef WRITE_METHOD
+
 static ssize_t write_getfs(struct file *file, const char *buf, size_t size)
 {
 	struct nfsctl_fsparm data;
