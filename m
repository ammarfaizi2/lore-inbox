Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262889AbVCWUQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbVCWUQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVCWUQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:16:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14213 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262889AbVCWUPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:15:11 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, Michael A Halcrow <mahalcro@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Keys: Pass session keyring to call_usermodehelper()
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 23 Mar 2005 20:14:59 +0000
Message-ID: <29204.1111608899@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes it possible to pass a session keyring through to the
process spawned by call_usermodehelper(). This allows patch 3/3 to pass an
authorisation key through to /sbin/request-key, thus permitting better access
controls when doing just-in-time key creation.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-umhelper-2612rc1mm1.diff 
 arch/i386/mach-voyager/voyager_thread.c |    2 +-
 drivers/acpi/thermal.c                  |    2 +-
 drivers/input/input.c                   |    2 +-
 drivers/macintosh/therm_pm72.c          |    2 +-
 drivers/net/hamradio/baycom_epp.c       |    2 +-
 drivers/pnp/pnpbios/core.c              |    2 +-
 drivers/s390/crypto/z90main.c           |    2 +-
 include/linux/key.h                     |    8 ++++++++
 include/linux/kmod.h                    |    5 ++++-
 kernel/cpuset.c                         |    2 +-
 kernel/kmod.c                           |   15 ++++++++++++---
 lib/kobject_uevent.c                    |    2 +-
 security/keys/request_key.c             |    2 +-
 13 files changed, 34 insertions(+), 14 deletions(-)

diff -uNrp linux-2.6.12-rc1-mm1/arch/i386/mach-voyager/voyager_thread.c linux-2.6.12-rc1-mm1-keys-umhelper/arch/i386/mach-voyager/voyager_thread.c
--- linux-2.6.12-rc1-mm1/arch/i386/mach-voyager/voyager_thread.c	2004-09-16 12:05:45.000000000 +0100
+++ linux-2.6.12-rc1-mm1-keys-umhelper/arch/i386/mach-voyager/voyager_thread.c	2005-03-23 17:35:16.000000000 +0000
@@ -73,7 +73,7 @@ execute(const char *string)
 		NULL,
 	};
 
-	if ((ret = call_usermodehelper(argv[0], argv, envp, 1)) != 0) {
+	if ((ret = call_usermodehelper(argv[0], argv, envp, NULL, 1)) != 0) {
 		printk(KERN_ERR "Voyager failed to run \"%s\": %i\n",
 		       string, ret);
 	}
diff -uNrp linux-2.6.12-rc1-mm1/drivers/acpi/thermal.c linux-2.6.12-rc1-mm1-keys-umhelper/drivers/acpi/thermal.c
--- linux-2.6.12-rc1-mm1/drivers/acpi/thermal.c	2005-03-23 17:22:24.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-umhelper/drivers/acpi/thermal.c	2005-03-23 17:35:16.000000000 +0000
@@ -441,7 +441,7 @@ acpi_thermal_call_usermode (
 	envp[0] = "HOME=/";
 	envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
 	
-	call_usermodehelper(argv[0], argv, envp, 0);
+	call_usermodehelper(argv[0], argv, envp, NULL, 0);
 
 	return_VALUE(0);
 }
diff -uNrp linux-2.6.12-rc1-mm1/drivers/input/input.c linux-2.6.12-rc1-mm1-keys-umhelper/drivers/input/input.c
--- linux-2.6.12-rc1-mm1/drivers/input/input.c	2005-03-23 17:22:27.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-umhelper/drivers/input/input.c	2005-03-23 17:35:16.000000000 +0000
@@ -415,7 +415,7 @@ static void input_call_hotplug(char *ver
 		argv[0], argv[1], envp[0], envp[1], envp[2], envp[3], envp[4]);
 #endif
 
-	value = call_usermodehelper(argv [0], argv, envp, 0);
+	value = call_usermodehelper(argv [0], argv, envp, NULL, 0);
 
 	kfree(buf);
 	kfree(envp);
diff -uNrp linux-2.6.12-rc1-mm1/drivers/macintosh/therm_pm72.c linux-2.6.12-rc1-mm1-keys-umhelper/drivers/macintosh/therm_pm72.c
--- linux-2.6.12-rc1-mm1/drivers/macintosh/therm_pm72.c	2005-03-23 17:22:28.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-umhelper/drivers/macintosh/therm_pm72.c	2005-03-23 17:35:16.000000000 +0000
@@ -1598,7 +1598,7 @@ static int call_critical_overtemp(void)
 				"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
 				NULL };
 
-	return call_usermodehelper(critical_overtemp_path, argv, envp, 0);
+	return call_usermodehelper(critical_overtemp_path, argv, envp, NULL, 0);
 }
 
 
diff -uNrp linux-2.6.12-rc1-mm1/drivers/net/hamradio/baycom_epp.c linux-2.6.12-rc1-mm1-keys-umhelper/drivers/net/hamradio/baycom_epp.c
--- linux-2.6.12-rc1-mm1/drivers/net/hamradio/baycom_epp.c	2005-03-23 17:08:58.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-umhelper/drivers/net/hamradio/baycom_epp.c	2005-03-23 17:35:16.000000000 +0000
@@ -323,7 +323,7 @@ static int eppconfig(struct baycom_state
 	sprintf(portarg, "%ld", bc->pdev->port->base);
 	printk(KERN_DEBUG "%s: %s -s -p %s -m %s\n", bc_drvname, eppconfig_path, portarg, modearg);
 
-	return call_usermodehelper(eppconfig_path, argv, envp, 1);
+	return call_usermodehelper(eppconfig_path, argv, envp, NULL, 1);
 }
 
 /* ---------------------------------------------------------------------- */
diff -uNrp linux-2.6.12-rc1-mm1/drivers/pnp/pnpbios/core.c linux-2.6.12-rc1-mm1-keys-umhelper/drivers/pnp/pnpbios/core.c
--- linux-2.6.12-rc1-mm1/drivers/pnp/pnpbios/core.c	2005-03-23 17:22:32.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-umhelper/drivers/pnp/pnpbios/core.c	2005-03-23 17:35:16.000000000 +0000
@@ -157,7 +157,7 @@ static int pnp_dock_event(int dock, stru
 		info->location_id, info->serial, info->capabilities);
 	envp[i] = NULL;
 	
-	value = call_usermodehelper (argv [0], argv, envp, 0);
+	value = call_usermodehelper (argv [0], argv, envp, NULL, 0);
 	kfree (buf);
 	kfree (envp);
 	return 0;
diff -uNrp linux-2.6.12-rc1-mm1/drivers/s390/crypto/z90main.c linux-2.6.12-rc1-mm1-keys-umhelper/drivers/s390/crypto/z90main.c
--- linux-2.6.12-rc1-mm1/drivers/s390/crypto/z90main.c	2005-03-23 17:09:03.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-umhelper/drivers/s390/crypto/z90main.c	2005-03-23 17:35:16.000000000 +0000
@@ -3554,7 +3554,7 @@ z90crypt_hotplug_event(int dev_major, in
 	envp[4] = minor;
 	envp[5] = 0;
 
-	call_usermodehelper(argv[0], argv, envp, 0);
+	call_usermodehelper(argv[0], argv, envp, NULL, 0);
 #endif
 }
 #endif
diff -uNrp linux-2.6.12-rc1-mm1/include/linux/key.h linux-2.6.12-rc1-mm1-keys-umhelper/include/linux/key.h
--- linux-2.6.12-rc1-mm1/include/linux/key.h	2005-03-23 17:22:44.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-umhelper/include/linux/key.h	2005-03-23 17:35:16.000000000 +0000
@@ -273,6 +273,13 @@ extern void key_fsuid_changed(struct tas
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
@@ -281,6 +288,7 @@ extern void key_init(void);
 #define key_put(k)			do { } while(0)
 #define alloc_uid_keyring(u)		0
 #define switch_uid_keyring(u)		do { } while(0)
+#define __install_session_keyring(t, k)	NULL
 #define copy_keys(f,t)			0
 #define copy_thread_group_keys(t)	0
 #define exit_keys(t)			do { } while(0)
diff -uNrp linux-2.6.12-rc1-mm1/include/linux/kmod.h linux-2.6.12-rc1-mm1-keys-umhelper/include/linux/kmod.h
--- linux-2.6.12-rc1-mm1/include/linux/kmod.h	2005-01-04 11:13:54.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-umhelper/include/linux/kmod.h	2005-03-23 17:35:16.000000000 +0000
@@ -34,7 +34,10 @@ static inline int request_module(const c
 #endif
 
 #define try_then_request_module(x, mod...) ((x) ?: (request_module(mod), (x)))
-extern int call_usermodehelper(char *path, char *argv[], char *envp[], int wait);
+
+struct key;
+extern int call_usermodehelper(char *path, char *argv[], char *envp[],
+			       struct key *session_keyring, int wait);
 extern void usermodehelper_init(void);
 
 #endif /* __LINUX_KMOD_H__ */
diff -uNrp linux-2.6.12-rc1-mm1/kernel/cpuset.c linux-2.6.12-rc1-mm1-keys-umhelper/kernel/cpuset.c
--- linux-2.6.12-rc1-mm1/kernel/cpuset.c	2005-03-23 17:22:44.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-umhelper/kernel/cpuset.c	2005-03-23 17:41:40.229194131 +0000
@@ -428,7 +428,7 @@ static int cpuset_release_agent(char *cp
 	envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
 	envp[i] = NULL;
 
-	return call_usermodehelper(argv[0], argv, envp, 0);
+	return call_usermodehelper(argv[0], argv, envp, NULL, 0);
 }
 
 /*
diff -uNrp linux-2.6.12-rc1-mm1/kernel/kmod.c linux-2.6.12-rc1-mm1-keys-umhelper/kernel/kmod.c
--- linux-2.6.12-rc1-mm1/kernel/kmod.c	2005-01-04 11:13:56.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-umhelper/kernel/kmod.c	2005-03-23 17:35:16.000000000 +0000
@@ -108,7 +108,7 @@ int request_module(const char *fmt, ...)
 		return -ENOMEM;
 	}
 
-	ret = call_usermodehelper(modprobe_path, argv, envp, 1);
+	ret = call_usermodehelper(modprobe_path, argv, envp, NULL, 1);
 	atomic_dec(&kmod_concurrent);
 	return ret;
 }
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
 
@@ -215,6 +221,7 @@ static void __call_usermodehelper(void *
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
+int call_usermodehelper(char *path, char **argv, char **envp,
+			struct key *session_keyring, int wait)
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
diff -uNrp linux-2.6.12-rc1-mm1/lib/kobject_uevent.c linux-2.6.12-rc1-mm1-keys-umhelper/lib/kobject_uevent.c
--- linux-2.6.12-rc1-mm1/lib/kobject_uevent.c	2005-03-23 17:22:45.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-umhelper/lib/kobject_uevent.c	2005-03-23 17:35:16.000000000 +0000
@@ -370,7 +370,7 @@ void kobject_hotplug(struct kobject *kob
 	if (!hotplug_path[0])
 		goto exit;
 
-	retval = call_usermodehelper (argv[0], argv, envp, 0);
+	retval = call_usermodehelper (argv[0], argv, envp, NULL, 0);
 	if (retval)
 		pr_debug ("%s - call_usermodehelper returned %d\n",
 			  __FUNCTION__, retval);
diff -uNrp linux-2.6.12-rc1-mm1/security/keys/request_key.c linux-2.6.12-rc1-mm1-keys-umhelper/security/keys/request_key.c
--- linux-2.6.12-rc1-mm1/security/keys/request_key.c	2005-03-23 17:22:46.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-umhelper/security/keys/request_key.c	2005-03-23 17:35:16.000000000 +0000
@@ -88,7 +88,7 @@ static int call_request_key(struct key *
 	argv[i] = NULL;
 
 	/* do it */
-	return call_usermodehelper(argv[0], argv, envp, 1);
+	return call_usermodehelper(argv[0], argv, envp, NULL, 1);
 
 } /* end call_request_key() */
 
