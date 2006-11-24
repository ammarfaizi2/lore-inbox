Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966246AbWKXWDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966246AbWKXWDi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 17:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966248AbWKXWDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 17:03:37 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:38849 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S966246AbWKXWDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 17:03:36 -0500
Date: Fri, 24 Nov 2006 17:03:33 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: [PATCH 14/16] LTTng 0.6.36 for 2.6.18 : Netlink control
Message-ID: <20061124220333.GO25048@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 17:02:30 up 93 days, 19:10,  3 users,  load average: 0.55, 0.63, 0.47
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tracing control through netlink socket.

patch14-2.6.18-lttng-core-0.6.36-netlink-control.diff

Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--BEGIN--
--- /dev/null
+++ b/ltt/ltt-control.c
@@ -0,0 +1,121 @@
+/* ltt-control.c
+ *
+ * LTT control module over a netlink socket.
+ *
+ * Inspired from Relay Apps, by Tom Zanussi and iptables
+ *
+ * Copyright 2005 -
+ * 	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <ltt/ltt-tracer.h>
+#include <linux/netlink.h>
+#include <linux/inet.h>
+#include <linux/ip.h>
+#include <linux/security.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+#include <net/sock.h>
+#include "ltt-control.h"
+
+#define LTTCTLM_BASE	0x10
+#define LTTCTLM_CONTROL	(LTTCTLM_BASE + 1)	/* LTT control message */
+
+static struct sock *socket;
+
+void ltt_control_input(struct sock *sk, int len)
+{
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh = NULL;
+	u8 *payload = NULL;
+	lttctl_peer_msg_t *msg;
+	int err;
+
+	printk(KERN_DEBUG "ltt-control ltt_control_input\n");
+
+	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
+
+		nlh = (struct nlmsghdr *)skb->data;
+		if (security_netlink_recv(skb, CAP_SYS_PTRACE)) {
+			netlink_ack(skb, nlh, EPERM);
+			kfree_skb(skb);
+			continue;
+		}
+		/* process netlink message pointed by skb->data */
+		err = EINVAL;
+		payload = NLMSG_DATA(nlh);
+		/* process netlink message with header pointed by 
+		 * nlh and payload pointed by payload
+		 */
+		if (nlh->nlmsg_len !=
+				sizeof(lttctl_peer_msg_t) +
+				sizeof(struct nlmsghdr)) {
+			printk(KERN_ALERT "ltt-control bad message length %d vs. %zu\n",
+				nlh->nlmsg_len, sizeof(lttctl_peer_msg_t) +
+				sizeof(struct nlmsghdr));
+			netlink_ack(skb, nlh, EINVAL);
+			kfree_skb(skb);
+			continue;
+		}
+		msg = (lttctl_peer_msg_t*)payload;
+
+		switch (msg->op) {
+			case OP_CREATE:
+				err = ltt_control(LTT_CONTROL_CREATE_TRACE,
+						msg->trace_name,
+						msg->trace_type, msg->args);
+				break;
+			case OP_DESTROY:
+				err = ltt_control(LTT_CONTROL_DESTROY_TRACE,
+						msg->trace_name,
+						msg->trace_type, msg->args);
+				break;
+			case OP_START:
+				err = ltt_control(LTT_CONTROL_START,
+						msg->trace_name,
+						msg->trace_type, msg->args);
+				break;
+			case OP_STOP:
+				err = ltt_control(LTT_CONTROL_STOP,
+						msg->trace_name,
+						msg->trace_type, msg->args);
+				break;
+			default:
+				err = EBADRQC;
+				printk(KERN_INFO 
+					"ltt-control invalid operation\n");
+		}
+		netlink_ack(skb, nlh, err);
+		kfree_skb(skb);
+	}
+}
+
+
+static int ltt_control_init(void)
+{
+	printk(KERN_INFO "ltt-control init\n");
+
+	socket = netlink_kernel_create(NETLINK_LTT, 1,
+			ltt_control_input, THIS_MODULE);
+	if (socket == NULL)
+		return -EPERM;
+	else
+		return 0;
+}
+
+static void ltt_control_exit(void)
+{
+	printk(KERN_INFO "ltt-control exit\n");
+	sock_release(socket->sk_socket);
+}
+
+
+module_init(ltt_control_init)
+module_exit(ltt_control_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Controller");
+
--- /dev/null
+++ b/ltt/ltt-control.h
@@ -0,0 +1,31 @@
+/* ltt-control.h
+ *
+ * LTT control module over a netlink socket.
+ *
+ * Inspired from Relay Apps, by Tom Zanussi and iptables
+ *
+ * Copyright 2005 -
+ * 	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
+ */
+
+#ifndef _LTT_CONTROL_H
+#define _LTT_CONTROL_H
+
+enum trace_op {
+	OP_CREATE,
+	OP_DESTROY,
+	OP_START,
+	OP_STOP,
+	OP_ALIGN,
+	OP_NONE
+};
+
+typedef struct lttctl_peer_msg {
+	char trace_name[NAME_MAX];
+	char trace_type[NAME_MAX];
+	enum trace_op op;
+	union ltt_control_args args;
+} lttctl_peer_msg_t;
+
+#endif //_LTT_CONTROL_H
+
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -21,6 +21,7 @@ #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
 #define NETLINK_KOBJECT_UEVENT	15	/* Kernel messages to userspace */
 #define NETLINK_GENERIC		16
+#define NETLINK_LTT		31 	/* Linux Trace Toolkit FIXME */
 
 #define MAX_LINKS 32		
 
--END--

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
