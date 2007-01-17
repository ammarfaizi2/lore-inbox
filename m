Return-Path: <linux-kernel-owner+w=401wt.eu-S1751539AbXAQG75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbXAQG75 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 01:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbXAQG72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 01:59:28 -0500
Received: from kandzendo.ru ([195.178.208.66]:42816 "EHLO tservice.net.ru"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751387AbXAQG7P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 01:59:15 -0500
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Jamal Hadi Salim <hadi@cyberus.ca>,
       Ingo Molnar <mingo@elte.hu>
Subject: [take33 9/10] kevent: Private userspace notifications.
In-Reply-To: <1169015435453@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Wed, 17 Jan 2007 09:30:35 +0300
Message-Id: <11690154353959@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Private userspace notifications.

Allows to register notifications of any private userspace
events over kevent. Events can be marked as readt using 
kevent_ctl(KEVENT_READY) command.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff --git a/kernel/kevent/kevent_unotify.c b/kernel/kevent/kevent_unotify.c
new file mode 100644
index 0000000..618c09c
--- /dev/null
+++ b/kernel/kevent/kevent_unotify.c
@@ -0,0 +1,62 @@
+/*
+ * 2006 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/kevent.h>
+
+static int kevent_unotify_callback(struct kevent *k)
+{
+	return 1;
+}
+
+int kevent_unotify_enqueue(struct kevent *k)
+{
+	int err;
+
+	err = kevent_storage_enqueue(&k->user->st, k);
+	if (err)
+		goto err_out_exit;
+
+	if (k->event.req_flags & KEVENT_REQ_ALWAYS_QUEUE)
+		kevent_requeue(k);
+
+	return 0;
+
+err_out_exit:
+	return err;
+}
+
+int kevent_unotify_dequeue(struct kevent *k)
+{
+	kevent_storage_dequeue(k->st, k);
+	return 0;
+}
+
+static int __init kevent_init_unotify(void)
+{
+	struct kevent_callbacks sc = {
+		.callback = &kevent_unotify_callback,
+		.enqueue = &kevent_unotify_enqueue,
+		.dequeue = &kevent_unotify_dequeue,
+		.flags = 0,
+	};
+
+	return kevent_add_callbacks(&sc, KEVENT_UNOTIFY);
+}
+module_init(kevent_init_unotify);

