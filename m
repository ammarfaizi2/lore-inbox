Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965336AbWJ2TVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965336AbWJ2TVT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965339AbWJ2TUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:20:55 -0500
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:32702 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965341AbWJ2TUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:20:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=qep7wmS4k21O3PClXUNAOgZCCvYCTNMv41IgxeY8AWBr/eRi71y9waz4iAqj3dqlKlaDbJEd+XID3pL+5EyHIBP2/WNm65KXJu4+Rni0c8CdWer2XkMeR1cK9rl9x/uOmqOo9cv9rX2bJ3mJCfZRilRt4v2ZgmwB0BBc1MPy/ss=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 11/11] uml ubd driver: various little changes
Date: Sun, 29 Oct 2006 20:20:52 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20061029192052.12292.3146.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix a small memory leak in ubd_config, and clearify the confusion which lead to
it.

Then, some little changes not affecting operations -
* move init functions together,
* add a comment about a potential problem in case of some evolution in the block layer,
* mark all initcalls as static __init functions
* mark an used once little function as inline
* document that mconsole methods are all called in process context (was
  triggered when checking ubd mconsole methods).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c      |   44 ++++++++++++++++++++++-----------------
 arch/um/include/mconsole_kern.h |    1 +
 arch/um/kernel/tt/tracer.c      |    1 -
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 641782e..8323af0 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -202,17 +202,6 @@ #define DEFAULT_UBD { \
 
 struct ubd ubd_devs[MAX_DEV] = { [ 0 ... MAX_DEV - 1 ] = DEFAULT_UBD };
 
-static int ubd0_init(void)
-{
-	struct ubd *ubd_dev = &ubd_devs[0];
-
-	if(ubd_dev->file == NULL)
-		ubd_dev->file = "root_fs";
-	return(0);
-}
-
-__initcall(ubd0_init);
-
 /* Only changed by fake_ide_setup which is a setup */
 static int fake_ide = 0;
 static struct proc_dir_entry *proc_ide_root = NULL;
@@ -293,6 +282,10 @@ static int parse_unit(char **ptr)
 	return(n);
 }
 
+/* If *index_out == -1 at exit, the passed option was a general one;
+ * otherwise, the str pointer is used (and owned) inside ubd_devs array, so it
+ * should not be freed on exit.
+ */
 static int ubd_setup_common(char *str, int *index_out)
 {
 	struct ubd *ubd_dev;
@@ -480,8 +473,9 @@ int thread_fd = -1;
 
 /* Changed by ubd_handler, which is serialized because interrupts only
  * happen on CPU 0.
+ * XXX: currently unused.
  */
-int intr_count = 0;
+static int intr_count = 0;
 
 /* call ubd_finish if you need to serialize */
 static void __ubd_finish(struct request *req, int error)
@@ -554,7 +548,7 @@ void kill_io_thread(void)
 
 __uml_exitcall(kill_io_thread);
 
-static int ubd_file_size(struct ubd *ubd_dev, __u64 *size_out)
+static inline int ubd_file_size(struct ubd *ubd_dev, __u64 *size_out)
 {
 	char *file;
 
@@ -730,7 +724,7 @@ static int ubd_config(char *str)
 	}
 	if (n == -1) {
 		ret = 0;
-		goto out;
+		goto err_free;
 	}
 
  	mutex_lock(&ubd_lock);
@@ -827,6 +821,7 @@ out:
 	return err;
 }
 
+/* All these are called by mconsole in process context and without ubd-specific locks. */
 static struct mc_device ubd_mc = {
 	.name		= "ubd",
 	.config		= ubd_config,
@@ -835,7 +830,7 @@ static struct mc_device ubd_mc = {
 	.remove		= ubd_remove,
 };
 
-static int ubd_mc_init(void)
+static int __init ubd_mc_init(void)
 {
 	mconsole_register_dev(&ubd_mc);
 	return 0;
@@ -843,13 +838,24 @@ static int ubd_mc_init(void)
 
 __initcall(ubd_mc_init);
 
+static int __init ubd0_init(void)
+{
+	struct ubd *ubd_dev = &ubd_devs[0];
+
+	if(ubd_dev->file == NULL)
+		ubd_dev->file = "root_fs";
+	return(0);
+}
+
+__initcall(ubd0_init);
+
 static struct platform_driver ubd_driver = {
 	.driver = {
 		.name  = DRIVER_NAME,
 	},
 };
 
-int ubd_init(void)
+static int __init ubd_init(void)
 {
         int i;
 
@@ -877,7 +883,7 @@ int ubd_init(void)
 
 late_initcall(ubd_init);
 
-int ubd_driver_init(void){
+static int __init ubd_driver_init(void){
 	unsigned long stack;
 	int err;
 
@@ -1384,8 +1390,8 @@ void do_io(struct io_thread_req *req)
  */
 int kernel_fd = -1;
 
-/* Only changed by the io thread */
-int io_count = 0;
+/* Only changed by the io thread. XXX: currently unused. */
+static int io_count = 0;
 
 int io_thread(void *arg)
 {
diff --git a/arch/um/include/mconsole_kern.h b/arch/um/include/mconsole_kern.h
index d0b6901..1ea6d92 100644
--- a/arch/um/include/mconsole_kern.h
+++ b/arch/um/include/mconsole_kern.h
@@ -14,6 +14,7 @@ struct mconsole_entry {
 	struct mc_request request;
 };
 
+/* All these methods are called in process context. */
 struct mc_device {
 	struct list_head list;
 	char *name;
diff --git a/arch/um/kernel/tt/tracer.c b/arch/um/kernel/tt/tracer.c
index 9882342..b919535 100644
--- a/arch/um/kernel/tt/tracer.c
+++ b/arch/um/kernel/tt/tracer.c
@@ -176,7 +176,6 @@ struct {
 int signal_index[32];
 int nsignals = 0;
 int debug_trace = 0;
-extern int io_nsignals, io_count, intr_count;
 
 extern void signal_usr1(int sig);
 
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
