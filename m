Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262635AbSITNkd>; Fri, 20 Sep 2002 09:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262644AbSITNkd>; Fri, 20 Sep 2002 09:40:33 -0400
Received: from cpe-66-1-217-65.fl.sprintbbd.net ([66.1.217.65]:31251 "EHLO
	chef.linux-wlan.com") by vger.kernel.org with ESMTP
	id <S262635AbSITNk3>; Fri, 20 Sep 2002 09:40:29 -0400
Date: Fri, 20 Sep 2002 09:45:34 -0400
From: Solomon Peachy <solomon@linux-wlan.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.4] add wait_event_interruptible_timeout
Message-ID: <20020920134534.GA19306@linux-wlan.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The sleep_on* series of calls is unsafe, and prone to race conditions.
They've been unofficially deprecated for a while.  Instead, we're
supposed to use the wait_event* series of calls.

There's only one problem with this.  There's no equivalent of
sleep_on_timeout/interruptible_sleep_on_timeout.

So, the attached patch adds 'wait_event_timeout' and
'wait_event_interruptible_timeout'  The diff is generated against
2.4.20-pre7, but should apply cleanly to just about any 2.4/2.2 release,
and maybe even 2.5 as well.

Back to the bit mines..

 - Pizza
--=20
Solomon Peachy                        solomon@linux-wlan.com
AbsoluteValue Systems                 http://www.linux-wlan.com
715-D North Drive                     +1 (321) 259-0737  (office)
Melbourne, FL 32934                   +1 (321) 259-0286  (fax)

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sched.diff"
Content-Transfer-Encoding: quoted-printable

--- sched.h.old	Fri Sep 20 09:31:02 2002
+++ sched.h	Fri Sep 20 09:47:10 2002
@@ -855,6 +855,87 @@
 	__ret;								\
 })
=20
+#define __wait_event_timeout(wq, condition, timeout, ret)   \
+do {                                                                      \
+        int __ret =3D 0;                                                  =
  \
+        if (!(condition)) {                                               \
+          wait_queue_t __wait;                                            \
+          unsigned long expire;                                           \
+          init_waitqueue_entry(&__wait, current);                         \
+	                                                                  \
+          expire =3D timeout + jiffies;                                   =
  \
+          add_wait_queue(&wq, &__wait);                                   \
+          for (;;) {                                                      \
+                  set_current_state(TASK_UNINTERRUPTIBLE);                \
+                  if (condition)                                          \
+                          break;                                          \
+                  if (jiffies > expire) {                                 \
+                          ret =3D jiffies - expire;                       =
  \
+                          break;                                          \
+                  }                                                       \
+                  schedule_timeout(timeout);                              \
+          }                                                               \
+          current->state =3D TASK_RUNNING;                                =
  \
+          remove_wait_queue(&wq, &__wait);                                \
+	}                                                                 \
+} while (0)
+/*
+   retval =3D=3D 0; condition met; we're good.
+   retval > 0; timed out.
+*/
+#define wait_event_timeout(wq, condition, timeout)    	                \
+({									\
+	int __ret =3D 0;							\
+	if (!(condition))						\
+		__wait_event_timeout(wq, condition,                     \
+						timeout, __ret);	\
+	__ret;								\
+})
+
+#define __wait_event_interruptible_timeout(wq, condition, timeout, ret)   \
+do {                                                                      \
+        int __ret =3D 0;                                                  =
  \
+        if (!(condition)) {                                               \
+          wait_queue_t __wait;                                            \
+          unsigned long expire;                                           \
+          init_waitqueue_entry(&__wait, current);                         \
+	                                                                  \
+          expire =3D timeout + jiffies;                                   =
  \
+          add_wait_queue(&wq, &__wait);                                   \
+          for (;;) {                                                      \
+                  set_current_state(TASK_INTERRUPTIBLE);                  \
+                  if (condition)                                          \
+                          break;                                          \
+                  if (jiffies > expire) {                                 \
+                          ret =3D jiffies - expire;                       =
  \
+                          break;                                          \
+                  }                                                       \
+                  if (!signal_pending(current)) {                         \
+                          schedule_timeout(timeout);                      \
+                          continue;                                       \
+                  }                                                       \
+                  ret =3D -ERESTARTSYS;                                   =
  \
+                  break;                                                  \
+          }                                                               \
+          current->state =3D TASK_RUNNING;                                =
  \
+          remove_wait_queue(&wq, &__wait);                                \
+	}                                                                 \
+} while (0)
+
+/*
+   retval =3D=3D 0; condition met; we're good.
+   retval < 0; interrupted by signal.
+   retval > 0; timed out.
+*/
+#define wait_event_interruptible_timeout(wq, condition, timeout)	\
+({									\
+	int __ret =3D 0;							\
+	if (!(condition))						\
+		__wait_event_interruptible_timeout(wq, condition,	\
+						timeout, __ret);	\
+	__ret;								\
+})
+
 #define REMOVE_LINKS(p) do { \
 	(p)->next_task->prev_task =3D (p)->prev_task; \
 	(p)->prev_task->next_task =3D (p)->next_task; \

--Q68bSM7Ycu6FN28Q--

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9iyZ+gW9b/nAvdc4RAh4YAJ9y8LZ4p4fVJrlKdif4XN0A/oKBuQCfd6/5
RMkiaMQfvHlia+98XdGCFBU=
=+ptv
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
