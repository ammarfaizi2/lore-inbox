Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422802AbWJLHqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422802AbWJLHqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWJLHp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:45:57 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:50621 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1422802AbWJLHpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:45:06 -0400
X-Originating-Ip: 72.57.81.197
Date: Thu, 12 Oct 2006 03:44:05 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Redefine instances of sema_init() to use standard form.
Message-ID: <Pine.LNX.4.64.0610120330540.5013@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since there seems to be no compelling reason *not* to do this, rewrite
all implementations of sema_init() in all instances of semaphore.h to
use the __SEMAPHORE_INITIALIZER macro.  (And, while we're there,
rename a couple instances of __SEMAPHORE_INIT just to be consistent
with everyone else.)

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
---

 asm-alpha/semaphore.h   |    9 +--------
 asm-arm/semaphore.h     |    8 +++-----
 asm-arm26/semaphore.h   |    8 +++-----
 asm-avr32/semaphore.h   |    4 +---
 asm-i386/semaphore.h    |   10 +---------
 asm-ia64/semaphore.h    |    2 +-
 asm-m32r/semaphore.h    |   10 +---------
 asm-mips/semaphore.h    |    3 +--
 asm-powerpc/semaphore.h |    3 +--
 asm-s390/semaphore.h    |    3 +--
 asm-sh/semaphore.h      |   10 +---------
 asm-sh64/semaphore.h    |   10 +---------
 asm-sparc/semaphore.h   |    4 +---
 asm-sparc64/semaphore.h |    3 +--
 asm-x86_64/semaphore.h  |   10 +---------
 asm-xtensa/semaphore.h  |    4 +---
 16 files changed, 20 insertions(+), 81 deletions(-)

diff --git a/include/asm-alpha/semaphore.h b/include/asm-alpha/semaphore.h
index 1a6295f..8c3c6dd 100644
--- a/include/asm-alpha/semaphore.h
+++ b/include/asm-alpha/semaphore.h
@@ -34,14 +34,7 @@ #define DECLARE_MUTEX_LOCKED(name)	__DEC

 static inline void sema_init(struct semaphore *sem, int val)
 {
-	/*
-	 * Logically,
-	 *   *sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
-	 * except that gcc produces better initializing by parts yet.
-	 */
-
-	atomic_set(&sem->count, val);
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-arm/semaphore.h b/include/asm-arm/semaphore.h
index d5dc624..ae1044b 100644
--- a/include/asm-arm/semaphore.h
+++ b/include/asm-arm/semaphore.h
@@ -18,23 +18,21 @@ struct semaphore {
 	wait_queue_head_t wait;
 };

-#define __SEMAPHORE_INIT(name, cnt)				\
+#define __SEMAPHORE_INITIALIZER(name, cnt)			\
 {								\
 	.count	= ATOMIC_INIT(cnt),				\
 	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
 }

 #define __DECLARE_SEMAPHORE_GENERIC(name,count)	\
-	struct semaphore name = __SEMAPHORE_INIT(name,count)
+	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)

 #define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name,0)

 static inline void sema_init(struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX(struct semaphore *sem)
diff --git a/include/asm-arm26/semaphore.h b/include/asm-arm26/semaphore.h
index 1fda543..ef51941 100644
--- a/include/asm-arm26/semaphore.h
+++ b/include/asm-arm26/semaphore.h
@@ -18,7 +18,7 @@ struct semaphore {
 	wait_queue_head_t wait;
 };

-#define __SEMAPHORE_INIT(name, n)					\
+#define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
 	.count		= ATOMIC_INIT(n),				\
 	.sleepers	= 0,						\
@@ -26,16 +26,14 @@ #define __SEMAPHORE_INIT(name, n)					\
 }

 #define __DECLARE_SEMAPHORE_GENERIC(name,count)	\
-	struct semaphore name = __SEMAPHORE_INIT(name,count)
+	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)

 #define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name,0)

 static inline void sema_init(struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX(struct semaphore *sem)
diff --git a/include/asm-avr32/semaphore.h b/include/asm-avr32/semaphore.h
index ef99ddc..7391408 100644
--- a/include/asm-avr32/semaphore.h
+++ b/include/asm-avr32/semaphore.h
@@ -40,9 +40,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-i386/semaphore.h b/include/asm-i386/semaphore.h
index 4e34a46..0945d0f 100644
--- a/include/asm-i386/semaphore.h
+++ b/include/asm-i386/semaphore.h
@@ -63,15 +63,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-/*
- *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
- *
- * i'd rather use the more flexible initialization above, but sadly
- * GCC 2.7.2.3 emits a bogus warning. EGCS doesn't. Oh well.
- */
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-ia64/semaphore.h b/include/asm-ia64/semaphore.h
index f483eeb..4e8eda1 100644
--- a/include/asm-ia64/semaphore.h
+++ b/include/asm-ia64/semaphore.h
@@ -24,7 +24,7 @@ #define __SEMAPHORE_INITIALIZER(name, n)
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }

-#define __DECLARE_SEMAPHORE_GENERIC(name,count)					\
+#define __DECLARE_SEMAPHORE_GENERIC(name,count)				\
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name, count)

 #define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
diff --git a/include/asm-m32r/semaphore.h b/include/asm-m32r/semaphore.h
index 41e45d7..d114364 100644
--- a/include/asm-m32r/semaphore.h
+++ b/include/asm-m32r/semaphore.h
@@ -39,15 +39,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-/*
- *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
- *
- * i'd rather use the more flexible initialization above, but sadly
- * GCC 2.7.2.3 emits a bogus warning. EGCS doesnt. Oh well.
- */
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-mips/semaphore.h b/include/asm-mips/semaphore.h
index 3d6aa7c..cba043a 100644
--- a/include/asm-mips/semaphore.h
+++ b/include/asm-mips/semaphore.h
@@ -53,8 +53,7 @@ #define DECLARE_MUTEX_LOCKED(name)	__DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-powerpc/semaphore.h b/include/asm-powerpc/semaphore.h
index 57369d2..ca3ea7d 100644
--- a/include/asm-powerpc/semaphore.h
+++ b/include/asm-powerpc/semaphore.h
@@ -39,8 +39,7 @@ #define DECLARE_MUTEX_LOCKED(name)	__DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-s390/semaphore.h b/include/asm-s390/semaphore.h
index dbce058..ad8c949 100644
--- a/include/asm-s390/semaphore.h
+++ b/include/asm-s390/semaphore.h
@@ -37,8 +37,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-sh/semaphore.h b/include/asm-sh/semaphore.h
index 489f784..209103d 100644
--- a/include/asm-sh/semaphore.h
+++ b/include/asm-sh/semaphore.h
@@ -41,15 +41,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-/*
- *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
- *
- * i'd rather use the more flexible initialization above, but sadly
- * GCC 2.7.2.3 emits a bogus warning. EGCS doesn't. Oh well.
- */
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-sh64/semaphore.h b/include/asm-sh64/semaphore.h
index 4695264..b2f3f57 100644
--- a/include/asm-sh64/semaphore.h
+++ b/include/asm-sh64/semaphore.h
@@ -48,15 +48,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-/*
- *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
- *
- * i'd rather use the more flexible initialization above, but sadly
- * GCC 2.7.2.3 emits a bogus warning. EGCS doesnt. Oh well.
- */
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-sparc/semaphore.h b/include/asm-sparc/semaphore.h
index f74ba31..79d4121 100644
--- a/include/asm-sparc/semaphore.h
+++ b/include/asm-sparc/semaphore.h
@@ -30,9 +30,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic24_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-sparc64/semaphore.h b/include/asm-sparc64/semaphore.h
index 093dcc6..8a7c201 100644
--- a/include/asm-sparc64/semaphore.h
+++ b/include/asm-sparc64/semaphore.h
@@ -30,8 +30,7 @@ #define DECLARE_MUTEX_LOCKED(name)	__DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-x86_64/semaphore.h b/include/asm-x86_64/semaphore.h
index 1194888..504a3ac 100644
--- a/include/asm-x86_64/semaphore.h
+++ b/include/asm-x86_64/semaphore.h
@@ -64,15 +64,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-/*
- *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
- *
- * i'd rather use the more flexible initialization above, but sadly
- * GCC 2.7.2.3 emits a bogus warning. EGCS doesn't. Oh well.
- */
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)
diff --git a/include/asm-xtensa/semaphore.h b/include/asm-xtensa/semaphore.h
index f10c348..017d892 100644
--- a/include/asm-xtensa/semaphore.h
+++ b/include/asm-xtensa/semaphore.h
@@ -37,9 +37,7 @@ #define DECLARE_MUTEX_LOCKED(name) __DEC

 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
-	sem->sleepers = 0;
-	init_waitqueue_head(&sem->wait);
+	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 }

 static inline void init_MUTEX (struct semaphore *sem)


--

  while i digest all of steven's observations, i figure i'd get at
least this much into the pipeline.  i'll take my victories where i can
get them.

rday
