Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUHCUsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUHCUsw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266835AbUHCUsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:48:51 -0400
Received: from fmr05.intel.com ([134.134.136.6]:62872 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S266833AbUHCUs1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:48:27 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: [SIMPLE PATCH] aio.c: rename 'struct timeout' to 'struct aio_timeout'
Date: Tue, 3 Aug 2004 13:47:33 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A6EC05C@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [SIMPLE PATCH] aio.c: rename 'struct timeout' to 'struct aio_timeout'
Thread-Index: AcR5X4UDRolwn3LZS0+KvAhWaHbt5QAOppKA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Suparna Bhattacharya" <suparna@in.ibm.com>, <linux-aio@kvack.org>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Aug 2004 20:48:05.0539 (UTC) FILETIME=[2D04AF30:01C4799B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch renames fs/aio.c:'struct timeout' to 'struct aio_timeout'.
The rationale behind this decision is this type is used only inside
the aforementioned aio.c file and being the type name very generic,
it is likely to cause namespace conflicts in the future.

I actually found it while working on an extended schedule_timeout()-
like API used by robust mutexes but usable by anyone. There I declared
a 'struct timeout' and aio.c complained about it. I could have also
renamed the struct for the schedule_timeout() like API, but being the
aio.c one specific to the file, I thought it might make more sense
to rename the later.

Signed-off-by: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

diff -u fs/aio.c:1.1.1.7 fs/aio.c:1.1.1.1.2.5
--- fs/aio.c:1.1.1.7 Tue Apr 6 00:22:44 2004
+++ fs/aio.c Fri Jun 4 01:34:19 2004
@@ -750,7 +750,7 @@
 	return ret;
 }
 
-struct timeout {
+struct aio_timeout {
 	struct timer_list	timer;
 	int			timed_out;
 	struct task_struct	*p;
@@ -758,13 +758,13 @@
 
 static void timeout_func(unsigned long data)
 {
-	struct timeout *to = (struct timeout *)data;
+	struct aio_timeout *to = (struct aio_timeout *)data;
 
 	to->timed_out = 1;
 	wake_up_process(to->p);
 }
 
-static inline void init_timeout(struct timeout *to)
+static inline void init_timeout(struct aio_timeout *to)
 {
 	init_timer(&to->timer);
 	to->timer.data = (unsigned long)to;
@@ -773,7 +773,7 @@
 	to->p = current;
 }
 
-static inline void set_timeout(long start_jiffies, struct timeout *to,
+static inline void set_timeout(long start_jiffies, struct aio_timeout *to,
 			       const struct timespec *ts)
 {
 	unsigned long how_long;
@@ -791,7 +791,7 @@
 	add_timer(&to->timer);
 }
 
-static inline void clear_timeout(struct timeout *to)
+static inline void clear_timeout(struct aio_timeout *to)
 {
 	del_timer_sync(&to->timer);
 }
@@ -807,7 +807,7 @@
 	int			ret;
 	int			i = 0;
 	struct io_event		ent;
-	struct timeout		to;
+	struct aio_timeout	to;
 
 	/* needed to zero any padding within an entry (there shouldn't be 
 	 * any, but C is fun!


Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
