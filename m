Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWF0Lxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWF0Lxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWF0Lxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:53:49 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:32418 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932285AbWF0Lxs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:53:48 -0400
Subject: [RFC][PATCH 2/3] Process events biarch bug: Process events 
	timestamp bug
From: Matt Helsley <matthltc@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
References: <20060627112644.804066367@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 04:48:46 -0700
Message-Id: <1151408926.21787.1812.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The event sent by Process Events from a 64-bit kernel is not compatible with
what a 32-bit userspace program would expect to recieve because the timespec
struct (used to send a timestamp) is not the same. This means that fields stored
after the timestamp are offset and programs that don't take this into account
break under these circumstances.

This is a problem on ppc64, s390, x86-64.. any "biarch" system where it's
possible for a 64-bit kernel to run 32-bit userspace programs.

This patch adds a comment highlighting the problem and a Documentation file
showing a userspace workaround.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
---
 Documentation/connector/process_events.txt |   75 +++++++++++++++++++++++++++++
 drivers/connector/Kconfig                  |    3 +
 include/linux/cn_proc.h                    |    7 ++
 3 files changed, 85 insertions(+)

Index: linux-2.6.17-mm3-biarch/include/linux/cn_proc.h
===================================================================
--- linux-2.6.17-mm3-biarch.orig/include/linux/cn_proc.h
+++ linux-2.6.17-mm3-biarch/include/linux/cn_proc.h
@@ -55,11 +55,18 @@ struct proc_event {
 		/* "next" should be 0x00000400 */
 		/* "last" is the last process event: exit */
 		PROC_EVENT_EXIT = 0x80000000
 	} what;
 	__u32 cpu;
+
+ 	/*
+ 	 * UGH! timespec is biarch incompatible. See
+ 	 * Documentation/connector/process_events.txt if you're going to listen
+ 	 * for process events in userspace.
+ 	 */
 	struct timespec timestamp;
+
 	union process_event_data { /* must be last field of proc_event struct */
 		struct {
 			__u32 err;
 		} ack;
 
Index: linux-2.6.17-mm3-biarch/Documentation/connector/process_events.txt
===================================================================
--- /dev/null
+++ linux-2.6.17-mm3-biarch/Documentation/connector/process_events.txt
@@ -0,0 +1,75 @@
+NOTES:
+
+To safely use process events on biarch systems it's necessary to account for
+the difference in size of the events returned by 64-bit kernels to 32-bit
+applications. This size difference is caused by use of a struct timespec for
+the timestamp field.
+
+There are multiple ways of doing this. However, few of them account for the
+fact that the size of the process event structure may change in the future.
+
+#include "linux/cn_proc.h"
+
+{
+	...
+	struct process_event *ev;
+	union process_event_data *evdata;
+	struct timespec ts;
+
+	ev = cn_msg->data;
+	if ((cn_msg->len - sizeof(struct process_event)) == sizeof(__u64)) {
+		__u64 *v;
+
+		/* kernel is sending 64-bit timestamps to 32-bit userspace */
+
+		v = (*__u64)&ev->timestamp;
+		ts.tv_sec = *v;
+		v++;
+		ts.tv_nsec = *v;
+		v++;
+		evdata = (union process_event_data*)v;
+	} else {
+		evdata = &ev->event_data;
+		ts = ev->timestamp;
+	}
+
+	switch(ev->what) {
+	case PROCESS_EVENT_EXIT:
+		... evdata->exit.exit_code ...
+		break;
+	}
+}
+
+Alternately, you can compare the size of the message length to the known
+size of the two structure variations and thus determine which structure to
+use to access the data:
+
+struct pev32 {
+	enum what what;
+	__u32 cpu;
+	__u32 timestamp[2];
+	union process_event_data event_data;
+};
+
+struct pev64 {
+	enum what what;
+	__u32 cpu;
+	__u64 timestamp[2];
+	union process_event_data event_data;
+};
+
+...
+if (cn_msg->len == sizeof(struct pev64)) {
+	...
+} else if (cn_msg->len == sizeof(struct pev32)) {
+	...
+}
+
+Both approaches assume that the process events structure will never change
+size.
+
+To limit the number of times you need to test which format is being sent use
+the acknowledgement message returned by the kernel after sending
+PROC_CN_MCAST_LISTEN. Use any of the techniques described above on the
+acknowledgement message and then set function pointers, flags, etc. to avoid
+the test in the future.
Index: linux-2.6.17-mm3-biarch/drivers/connector/Kconfig
===================================================================
--- linux-2.6.17-mm3-biarch.orig/drivers/connector/Kconfig
+++ linux-2.6.17-mm3-biarch/drivers/connector/Kconfig
@@ -16,6 +16,9 @@ config PROC_EVENTS
 	depends on CONNECTOR
 	help
 	  Provide a connector that reports process events to userspace. Send
 	  events such as fork, exec, id change (uid, gid, suid, etc), and exit.
 
+	  See Documentation/connector/process_events.txt if you're going to
+	  listen for process events in userspace.
+
 endmenu

--

