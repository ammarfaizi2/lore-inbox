Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbVCXLj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbVCXLj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 06:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263097AbVCXLjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 06:39:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52378 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262779AbVCXLi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 06:38:59 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <29204.1111608899@redhat.com> 
References: <29204.1111608899@redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, Michael A Halcrow <mahalcro@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Keys: Pass session keyring to call_usermodehelper() [try #2]
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Thu, 24 Mar 2005 11:38:28 +0000
Message-ID: <23939.1111664308@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes it possible to pass a session keyring through to the
process spawned by call_usermodehelper(). This allows patch 3/3 to pass an
authorisation key through to /sbin/request-key, thus permitting better access
controls when doing just-in-time key creation.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-umhelper-2612rc1mm1-2.diff 
 include/linux/key.h         |   10 +++++++++-
 include/linux/kmod.h        |   12 +++++++++++-
 kernel/kmod.c               |   15 ++++++++++++---
 security/keys/request_key.c |    2 +-
 4 files changed, 33 insertions(+), 6 deletions(-)

diff -uNrp linux-2.6.12-rc1-mm1/include/linux/key.h linux-2.6.12-rc1-mm1-keys-umhelper/include/linux/key.h
--- linux-2.6.12-rc1-mm1/include/linux/key.h	2005-03-23 17:22:44.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-umhelper/include/linux/key.h	2005-03-24 11:26:24.684060442 +0000
@@ -273,14 +273,22 @@ extern void key_fsuid_changed(struct tas
 extern void key_fsgid_changed(struct task_struct *tsk);
 extern void key_init(void);
 
+#define __install_session_keyring(tsk, keyring)			\
+({								\
+	struct key *old_session = tsk->signal->session_keyring;	\
+	tsk->signal->session_keyring = keyring;			\
+	old_session;						\
+})
+
 #else /* CONFIG_KEYS */
 
 #define key_validate(k)			0
 #define key_serial(k)			0
-#define key_get(k) 			NULL
+#define key_get(k) 			({ NULL; })
 #define key_put(k)			do { } while(0)
 #define alloc_uid_keyring(u)		0
 #define switch_uid_keyring(u)		do { } while(0)
+#define __install_session_keyring(t, k)	({ NULL; })
 #define copy_keys(f,t)			0
 #define copy_thread_group_keys(t)	0
 #define exit_keys(t)			do { } while(0)
diff -uNrp linux-2.6.12-rc1-mm1/include/linux/kmod.h linux-2.6.12-rc1-mm1-keys-umhelper/include/linux/kmod.h
--- linux-2.6.12-rc1-mm1/include/linux/kmod.h	2005-01-04 11:13:54.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-umhelper/include/linux/kmod.h	2005-03-24 11:12:14.903253166 +0000
@@ -34,7 +34,17 @@ static inline int request_module(const c
 #endif
 
 #define try_then_request_module(x, mod...) ((x) ?: (request_module(mod), (x)))
-extern int call_usermodehelper(char *path, char *argv[], char *envp[], int wait);
+
+struct key;
+extern int call_usermodehelper_keys(char *path, char *argv[], char *envp[],
+				    struct key *session_keyring, int wait);
+
+static inline int
+call_usermodehelper(char *path, char **argv, char **envp, int wait)
+{
+	return call_usermodehelper_keys(path, argv, envp, NULL, wait);
+}
+
 extern void usermodehelper_init(void);
 
 #endif /* __LINUX_KMOD_H__ */
diff -uNrp linux-2.6.12-rc1-mm1/kernel/kmod.c linux-2.6.12-rc1-mm1-keys-umhelper/kernel/kmod.c
--- linux-2.6.12-rc1-mm1/kernel/kmod.c	2005-01-04 11:13:56.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-umhelper/kernel/kmod.c	2005-03-24 11:15:25.610527168 +0000
@@ -120,6 +120,7 @@ struct subprocess_info {
 	char *path;
 	char **argv;
 	char **envp;
+	struct key *ring;
 	int wait;
 	int retval;
 };
@@ -130,16 +131,21 @@ struct subprocess_info {
 static int ____call_usermodehelper(void *data)
 {
 	struct subprocess_info *sub_info = data;
+	struct key *old_session;
 	int retval;
 
-	/* Unblock all signals. */
+	/* Unblock all signals and set the session keyring. */
+	key_get(sub_info->ring);
 	flush_signals(current);
 	spin_lock_irq(&current->sighand->siglock);
+	old_session = __install_session_keyring(current, sub_info->ring);
 	flush_signal_handlers(current, 1);
 	sigemptyset(&current->blocked);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
+	key_put(old_session);
+
 	/* We can run anywhere, unlike our parent keventd(). */
 	set_cpus_allowed(current, CPU_MASK_ALL);
 
@@ -211,10 +217,11 @@ static void __call_usermodehelper(void *
 }
 
 /**
- * call_usermodehelper - start a usermode application
+ * call_usermodehelper_keys - start a usermode application
  * @path: pathname for the application
  * @argv: null-terminated argument list
  * @envp: null-terminated environment list
+ * @session_keyring: session keyring for process (NULL for an empty keyring)
  * @wait: wait for the application to finish and return status.
  *
  * Runs a user-space application.  The application is started
@@ -224,7 +231,8 @@ static void __call_usermodehelper(void *
  * Must be called from process context.  Returns a negative error code
  * if program was not execed successfully, or 0.
  */
-int call_usermodehelper(char *path, char **argv, char **envp, int wait)
+int call_usermodehelper_keys(char *path, char **argv, char **envp,
+			     struct key *session_keyring, int wait)
 {
 	DECLARE_COMPLETION(done);
 	struct subprocess_info sub_info = {
@@ -232,6 +240,7 @@ int call_usermodehelper(char *path, char
 		.path		= path,
 		.argv		= argv,
 		.envp		= envp,
+		.ring		= session_keyring,
 		.wait		= wait,
 		.retval		= 0,
 	};
diff -uNrp linux-2.6.12-rc1-mm1/security/keys/request_key.c linux-2.6.12-rc1-mm1-keys-umhelper/security/keys/request_key.c
--- linux-2.6.12-rc1-mm1/security/keys/request_key.c	2005-03-23 17:22:46.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-umhelper/security/keys/request_key.c	2005-03-24 11:12:46.125678832 +0000
@@ -88,7 +88,7 @@ static int call_request_key(struct key *
 	argv[i] = NULL;
 
 	/* do it */
-	return call_usermodehelper(argv[0], argv, envp, 1);
+	return call_usermodehelper_keys(argv[0], argv, envp, NULL, 1);
 
 } /* end call_request_key() */
 
