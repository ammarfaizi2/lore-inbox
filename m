Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTKTOhJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 09:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTKTOhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 09:37:09 -0500
Received: from users.ccur.com ([208.248.32.211]:18144 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S261885AbTKTOgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 09:36:51 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200311201436.OAA05368@rudolph.ccur.com>
Subject: [PATCH resend] to mqueues-4.00, dynamic shared library support
To: wrona@mat.uni.torun.pl, golbi@mat.uni.torun.pl
Date: Thu, 20 Nov 2003 09:36:38 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ resend as the previous didn't appear on the list ]

Hi Michal & Krzyztof,

Patches the message queue library source file so that:

  o it can be built as a dynamic shared library.
  o apps can link against the pthreads version without -lpthread
    | In that case they get a non-pthread subset out of -lmqueue.
  o fixed warnings using -W options appropriate for library builds.

The compile-time error checks used for the warning fixups:

    -W -Wall -Wshadow -Wcast-align -Wredundant-decls \
    -Wbad-function-cast -Wcast-qual -Wwrite-strings \
    -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes

This patch applies against mqueues-4.00.  Tested against i386 and
against Opteron in both native and ia32 modes.

Regards,
Joe



diff -ura 4.00/library/src/mqueue.c new/library/src/mqueue.c
--- 4.00/library/src/mqueue.c	2003-11-08 09:20:56.000000000 -0500
+++ new/library/src/mqueue.c	2003-11-19 17:52:53.000000000 -0500
@@ -32,10 +32,7 @@
 #include "../include/mqueue.h"
 #include "config.h"
 
-#ifdef SIGEVTHREAD_SUPPORT
-#include <pthread.h>
-#endif
-
+#ifndef __NR_mq_open
 #define __NR_mq_open		274
 #define __NR_mq_unlink		(__NR_mq_open+1)
 #define __NR_mq_timedsend	(__NR_mq_open+2)
@@ -43,32 +40,39 @@
 #define __NR_mq_notify		(__NR_mq_open+4)
 #define __NR_mq_getattr		(__NR_mq_open+5)
 #define __NR_mq_setattr		(__NR_mq_open+6)
-
-#define ERRNO_OK_SIGNAL		0
-#define ERRNO_OK_THREAD		1
-#define ERRNO_REMOVE_THREAD	2
+#endif
 
 #ifdef SIGEVTHREAD_SUPPORT
+#include <pthread.h>
+
+/*
+ * Force any references in this file to the following externs to
+ * define to NULL if global definitions cannot be found at link
+ * edit time.
+ */
+#pragma weak pthread_create
+#pragma weak pthread_sigmask
+#pragma weak pthread_barrier_init
+#pragma weak pthread_barrier_wait
+#pragma weak pthread_attr_init
+#pragma weak pthread_attr_setdetachstate
+
 struct thread_communication_data
 {
-	struct sigevent notification;	/* first field must be copied as it can */
-	mqd_t mqdes;			/* be used after mq_notify exits        */
-	int *result;			/* and it can use its internal data     */
+	struct sigevent notification;	/* must be a copy of, not a ptr to */
+	mqd_t mqdes;
+	int *result;
 	pthread_barrier_t *barrier;
 };
-#endif
 
+#endif /* SIGEVTHREAD_SUPPORT */
 
-_syscall5(int, mq_timedsend, mqd_t, mqdes, const char*, msg_ptr, 
-	size_t, msg_len, unsigned int, msg_prio, const struct timespec*, abs_timeout);
-_syscall5(ssize_t, mq_timedreceive, mqd_t, mqdes, char*, msg_ptr, 
-	size_t, msg_len, unsigned int*, msg_prio, const struct timespec*, abs_timeout);
-_syscall2(int, mq_getattr, mqd_t, mqdes, struct mq_attr*, mqstat);
-_syscall3(int, mq_setattr, mqd_t, mqdes, const struct mq_attr*, mqstat,
-	struct mq_attr*, omqstat);
+#define ERRNO_OK_SIGNAL		0
+#define ERRNO_OK_THREAD		1
+#define ERRNO_REMOVE_THREAD	2
 
 /* check if name is a valid path */
-inline int is_valid_path(const char *name)
+static inline int is_valid_path(const char *name)
 {
 	int len;
 	
@@ -83,7 +87,7 @@
 		goto err_einval;
 		
 	return 0;
-	
+
 err_einval:
 	errno = EINVAL;
 	return -1;
@@ -92,12 +96,63 @@
 	return -1;
 }
 
-mqd_t mq_open(const char *name, int oflag, /* mode_t mode,
-	    struct mq_attr *attr */ ...)
+/*
+ * kernel interfaces.  We use glibc's syscall(3) instead of the macros
+ * _syscall1, _syscall2, etc, as the macros generate compilation errors
+ * when mqueue.c is built as a dynamic shared library.
+ */
+static inline mqd_t __mq_open(const char  *name,
+				int oflag, mode_t mode, struct mq_attr* attr)
+{
+	return syscall(__NR_mq_open, name, oflag, mode, attr);
+}
+
+static inline int __mq_unlink(const char *name)
+{
+	return syscall(__NR_mq_unlink, name);
+}
+
+static inline int __mq_notify(mqd_t mqdes, const struct sigevent *notification)
+{
+	return syscall(__NR_mq_notify, mqdes, notification);
+}
+
+static inline int __mq_getattr(mqd_t mqdes, struct mq_attr *mqstat)
 {
-unsigned long 	mode;
-struct mq_attr 	*attr;
-va_list 	ap;
+	return syscall(__NR_mq_getattr, mqdes, mqstat);
+}
+
+static inline int __mq_setattr( mqd_t mqdes, const struct mq_attr *mqstat,
+				struct mq_attr *omqstat)
+{
+	return syscall(__NR_mq_setattr,  mqdes, mqstat, omqstat);
+}
+
+static inline int __mq_timedsend(mqd_t mqdes, const char *msg_ptr,
+				size_t msg_len, unsigned int msg_prio,
+				const struct timespec *abs_timeout)
+{
+	return syscall(__NR_mq_timedsend, mqdes, msg_ptr, msg_len,
+		msg_prio, abs_timeout);
+}
+
+static inline ssize_t __mq_timedreceive(mqd_t mqdes, char *msg_ptr,
+				size_t msg_len, unsigned int *msg_prio,
+				const struct timespec *abs_timeout)
+{
+	return syscall(__NR_mq_timedreceive, mqdes, msg_ptr, msg_len,
+		msg_prio, abs_timeout);
+}
+
+/*
+ * application-visible wrappers around the kernel interfaces
+ */
+
+mqd_t mq_open(const char *name, int oflag, ...)
+{
+	unsigned long 	mode;
+	struct mq_attr 	*attr;
+	va_list 	ap;
 
 	va_start(ap, oflag);
 	mode = va_arg(ap, unsigned long);
@@ -107,10 +162,8 @@
 	if (is_valid_path(name) < 0)
 		return (mqd_t)-1;
 
-	static inline _syscall4(mqd_t, mq_open, const char *, name, int, oflag, mode_t, mode, struct mq_attr*, attr);
-    
 	/* omit leading slash */
-	return mq_open(name + 1, oflag, mode, attr);
+	return __mq_open(name + 1, oflag, mode, attr);
 }
 
 int mq_close(mqd_t mqdes)
@@ -123,51 +176,77 @@
 	if (is_valid_path(name) < 0)
 		return -1;
 	
-	static inline _syscall1(int, mq_unlink, const char*, name);
-       
-	return mq_unlink(name+1);
+	return __mq_unlink(name+1);
 }
 
-int mq_send(mqd_t mqdes, const char *msg_ptr, size_t msg_len, unsigned int msg_prio)
+int mq_send(mqd_t mqdes, const char *msg_ptr, size_t msg_len,
+					unsigned int msg_prio)
 {
-	return mq_timedsend(mqdes, msg_ptr, msg_len, msg_prio, NULL);
+	return __mq_timedsend(mqdes, msg_ptr, msg_len, msg_prio, NULL);
 }
 
-ssize_t mq_receive(mqd_t mqdes, char *msg_ptr, size_t msg_len, unsigned int *msg_prio)
+ssize_t mq_receive(mqd_t mqdes, char *msg_ptr, size_t msg_len,
+					unsigned int *msg_prio)
 {
-	return mq_timedreceive(mqdes, msg_ptr, msg_len, msg_prio, NULL);
+	return __mq_timedreceive(mqdes, msg_ptr, msg_len, msg_prio, NULL);
+}
+
+int mq_timedsend(mqd_t mqdes, const char *msg_ptr, size_t msg_len,
+					unsigned int msg_prio,
+					const struct timespec *abs_timeout)
+{
+	return __mq_timedsend(mqdes, msg_ptr, msg_len, msg_prio, abs_timeout);
+}
+
+ssize_t mq_timedreceive(mqd_t mqdes, char *msg_ptr, size_t msg_len,
+					unsigned int *msg_prio,
+					const struct timespec *abs_timeout)
+{
+	return __mq_timedreceive(mqdes, msg_ptr, msg_len, msg_prio,
+		abs_timeout);
+}
+
+int mq_getattr(mqd_t mqdes, struct mq_attr *mqstat)
+{
+	return __mq_getattr(mqdes, mqstat);
+}
+
+int mq_setattr( mqd_t mqdes, const struct mq_attr *mqstat,
+					struct mq_attr *omqstat)
+{
+	return __mq_setattr(mqdes, mqstat, omqstat);
 }
 
 #ifdef SIGEVTHREAD_SUPPORT
 static void *notification_handler(void * raw_arg)
 {
-	struct thread_communication_data arg = *(struct thread_communication_data *)raw_arg;
+	struct thread_communication_data arg =
+		*(struct thread_communication_data *)raw_arg;
 	siginfo_t info;
-	sigset_t sigset;
+	sigset_t signalset;
 	
 	arg.notification.sigev_signo = SIGUSR1;
 	
-	sigfillset(&sigset);
-	pthread_sigmask(SIG_BLOCK, &sigset, NULL);
+	sigfillset(&signalset);
+	pthread_sigmask(SIG_BLOCK, &signalset, NULL);
 	
 	/* set up kernel notification */
-	static inline _syscall2(int, mq_notify, mqd_t, _mqdes, const struct sigevent*, notification);
 	if (mq_notify(arg.mqdes, &(arg.notification))) {
 		*(arg.result) = errno;
 		pthread_barrier_wait(arg.barrier);
-		return;
+		return NULL;
 	}
 
 	/* allow parent to continue */
 	*(arg.result) = 0;
 	pthread_barrier_wait(arg.barrier);
 
-	sigemptyset(&sigset);
-	sigaddset(&sigset, arg.notification.sigev_signo);
+	sigemptyset(&signalset);
+	sigaddset(&signalset, arg.notification.sigev_signo);
 
 	/* wait for kernel signal */
 	do {
-		sigwaitinfo(&sigset, &info);
+		sigwaitinfo(&signalset, &info);
 		/* if si_errno == ERRNO_OK_SIGNAL then this signal was sent 
 		 * from kernel to whole process as an effect of SIGEV_SIGNAL 
 		 * notification
@@ -180,19 +259,20 @@
 	
 	if (info.si_errno == ERRNO_OK_THREAD)
 		(arg.notification.sigev_notify_function)(info._sifields._rt.si_sigval);
+	return NULL;
 }
 #endif
 
 int mq_notify(mqd_t mqdes, const struct sigevent *notification)
 {
-	struct sigevent n, *ptr;
+	struct sigevent n;
+	const struct sigevent *ptr;
 #ifdef SIGEVTHREAD_SUPPORT
 	pthread_t handler_thread;
 	pthread_attr_t thread_attr;
 	pthread_barrier_t barrier;
 	struct thread_communication_data thread_data;
 #endif
-	int result;
 
 	ptr = &n;
 
@@ -200,15 +280,21 @@
 		n.sigev_notify = SIGEV_NONE;
 		n.sigev_notify_attributes = NULL;
 	} else
-		ptr = (struct sigevent *) notification;
+		ptr = (const struct sigevent *) notification;
 
 	if (ptr->sigev_notify == SIGEV_THREAD) {
 #ifdef SIGEVTHREAD_SUPPORT
+		int result;
+		if (&pthread_create == NULL) {
+			errno = ENOSYS;
+			return -1;
+		}
 		pthread_barrier_init(&barrier, NULL, 2);
 
 		if (ptr->sigev_notify_attributes == NULL) {
 			pthread_attr_init(&thread_attr);
-			pthread_attr_setdetachstate(&thread_attr, PTHREAD_CREATE_DETACHED);
+			pthread_attr_setdetachstate(&thread_attr,
+						PTHREAD_CREATE_DETACHED);
 			n.sigev_notify_attributes = &thread_attr;
 		}
 
@@ -217,8 +303,9 @@
 		thread_data.mqdes = mqdes;
 		thread_data.result = &result;
 
-		if (pthread_create(&handler_thread, ptr->sigev_notify_attributes, 
-				   notification_handler, &thread_data)) {
+		if (pthread_create(&handler_thread,
+					ptr->sigev_notify_attributes, 
+					notification_handler, &thread_data)) {
 			errno = EAGAIN;
 			return -1;
 		}
@@ -228,13 +315,11 @@
 			return -1;
 		}
 #else
-		fprintf(stderr, "SIGEV_THREAD not supported!\n");
 		errno = ENOSYS;
 		return -1;
 #endif		
 	} else {
-		static inline _syscall2(int, mq_notify, mqd_t, mqdes, const struct sigevent*, notification);
-		return mq_notify(mqdes, ptr);
+		return __mq_notify(mqdes, ptr);
 	}
 
 	return 0;
