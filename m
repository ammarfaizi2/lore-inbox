Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVAMBCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVAMBCI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVAMBAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 20:00:47 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:39140 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261501AbVALVxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:53:32 -0500
Date: Thu, 13 Jan 2005 01:15:19 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: kobject_uevent.c moved to kernel connector.
Message-ID: <20050113011519.6e087fb4@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050112190615.GC10885@kroah.com>
References: <1101286481.18807.66.camel@uganda>
	<1101287606.18807.75.camel@uganda>
	<20041124222857.GG3584@kroah.com>
	<1102504677.3363.55.camel@uganda>
	<20041221204101.GA9831@kroah.com>
	<1103707272.3432.6.camel@uganda>
	<20041225180241.38ffb9d8@zanzibar.2ka.mipt.ru>
	<20050104060211.50c2bf47@zanzibar.2ka.mipt.ru>
	<20050112190615.GC10885@kroah.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__13_Jan_2005_01_15_19_+0300_y13IGb3fGm1y4jmB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Thu__13_Jan_2005_01_15_19_+0300_y13IGb3fGm1y4jmB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

kobject_uevent.c change which allows to use new kernel connector interface.
More details at http://marc.theaimsgroup.com/?l=linux-kernel&m=110370721906005&w=2
They require small change to kernel connector itself(needs it export 
initialization flag), also attached small programm to read kobject data.
Usage:

s0mbre@kuasar:~/aWork/connector$ sudo ./kobj
Password:
Thu Jan 13 00:36:58 2005 : [abcd.0] [seq=4294967295, ack=4294967295], add@/devices/pci0000:00/0000:00:1d.2/usb3/3-1.
Thu Jan 13 00:36:58 2005 : [abcd.0] [seq=1936024425, ack=1768124463], add@/devices/pci0000:00/0000:00:1d.2/usb3/3-1/3-1:1.0.
Thu Jan 13 00:36:58 2005 : [abcd.0] [seq=1936024425, ack=1768124463], add@/devices/pci0000:00/0000:00:1d.2/usb3/3-1/3-1:1.1.
Thu Jan 13 00:36:58 2005 : [abcd.0] [seq=1936024425, ack=1768124463], add@/devices/pci0000:00/0000:00:1d.2/usb3/3-1/3-1:1.2.
Thu Jan 13 00:36:58 2005 : [abcd.0] [seq=1936024425, ack=0], add@/module/hci_usb.
Thu Jan 13 00:36:58 2005 : [abcd.0] [seq=1936024425, ack=0], add@/module/hci_usb/sections.
Thu Jan 13 00:36:58 2005 : [abcd.0] [seq=1936024425, ack=0], add@/bus/usb/drivers/hci_usb.
Thu Jan 13 00:36:58 2005 : [abcd.0] [seq=1936024425, ack=0], add@/class/bluetooth/hci0.
Thu Jan 13 00:37:04 2005 : [abcd.0] [seq=1647276915, ack=1952806252], remove@/class/bluetooth/hci0.
Thu Jan 13 00:37:05 2005 : [abcd.0] [seq=1935764579, ack=1818374003], remove@/devices/pci0000:00/0000:00:1d.2/usb3/3-1/3-1:1.0.
Thu Jan 13 00:37:05 2005 : [abcd.0] [seq=1935764579, ack=1818374003], remove@/devices/pci0000:00/0000:00:1d.2/usb3/3-1/3-1:1.1.
Thu Jan 13 00:37:05 2005 : [abcd.0] [seq=1935764579, ack=1818374003], remove@/devices/pci0000:00/0000:00:1d.2/usb3/3-1/3-1:1.2.
Thu Jan 13 00:37:05 2005 : [abcd.0] [seq=1935764579, ack=1818374003], remove@/devices/pci0000:00/0000:00:1d.2/usb3/3-1.

P.S. I'm not subscribed to these mail lists, please CC me in your answers.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

--- include/linux/connector.h~	2005-01-13 00:21:55.000000000 +0300
+++ include/linux/connector.h	2005-01-13 00:53:21.000000000 +0300
@@ -24,6 +24,9 @@
 
 #include <asm/types.h>
 
+#define CONN_IDX_KOBJECT_UEVENT		0xabcd
+#define CONN_VAL_KOBJECT_UEVENT		0x0000
+
 #define CONNECTOR_MAX_MSG_SIZE 	1024
 
 struct cb_id
--- linux-2.6/drivers/connector/connector.c.orig	2005-01-13 00:21:23.000000000 +0300
+++ linux-2.6/drivers/connector/connector.c	2005-01-13 00:32:48.000000000 +0300
@@ -46,6 +46,8 @@
 
 static struct cn_dev cdev;
 
+int cn_already_initialized = 0;
+
 /*
  * msg->seq and msg->ack are used to determine message genealogy.
  * When someone sends message it puts there locally unique sequence 
@@ -456,6 +458,7 @@
 static int cn_init(void)
 {
 	struct cn_dev *dev = &cdev;
+	int err;
 
 	dev->input = cn_input;
 	dev->id.idx = cn_idx;
@@ -475,7 +478,17 @@
 		return -EINVAL;
 	}
 
-	return cn_add_callback(&dev->id, "connector", &cn_callback);
+	err = cn_add_callback(&dev->id, "connector", &cn_callback);
+	if (err) {
+		cn_queue_free_dev(dev->cbdev);
+		if (dev->nls->sk_socket)
+			sock_release(dev->nls->sk_socket);
+		return -EINVAL;
+	}
+
+	cn_already_initialized = 1;
+
+	return 0;
 }
 
 static void cn_fini(void)
--- linux-2.6/lib/kobject_uevent.c.orig	2005-01-13 00:45:55.000000000 +0300
+++ linux-2.6/lib/kobject_uevent.c	2005-01-13 00:34:05.000000000 +0300
@@ -12,6 +12,7 @@
  *	Kay Sievers		<kay.sievers@vrfy.org>
  *	Arjan van de Ven	<arjanv@redhat.com>
  *	Greg Kroah-Hartman	<greg@kroah.com>
+ *	Evgeniy Polyakov 	<johnpol@2ka.mipt.ru>
  */
 
 #include <linux/spinlock.h>
@@ -21,6 +22,7 @@
 #include <linux/string.h>
 #include <linux/kobject_uevent.h>
 #include <linux/kobject.h>
+#include <linux/connector.h>
 #include <net/sock.h>
 
 #define BUFFER_SIZE	1024	/* buffer for the hotplug env */
@@ -53,6 +55,68 @@
 #ifdef CONFIG_KOBJECT_UEVENT
 static struct sock *uevent_sock;
 
+#ifdef CONFIG_CONNECTOR
+static struct cb_id uid = {CONN_IDX_KOBJECT_UEVENT, CONN_VAL_KOBJECT_UEVENT};
+static void kobject_uevent_connector_callback(void *data)
+{
+}
+
+static void kobject_uevent_send_connector(const char *signal, const char *obj, char **envp, int gfp_mask)
+{
+	if (cn_already_initialized) {
+		int size;
+		struct cn_msg *msg;
+		static int uevent_connector_initialized;
+		
+		if (!uevent_connector_initialized) {
+			cn_add_callback(&uid, "kobject_uevent", kobject_uevent_connector_callback);
+			uevent_connector_initialized = 1;
+		}
+
+
+		size = strlen(signal) + strlen(obj) + 2 + BUFFER_SIZE + sizeof(*msg);
+		msg = kmalloc(size, gfp_mask);
+		if (msg) {
+			u8 *pos;
+			int len;
+
+			msg->len = size - sizeof(*msg);
+
+			memcpy(&msg->id, &uid, sizeof(msg->id));
+			
+			size -= sizeof(*msg);
+
+			pos = (u8 *)(msg + 1);
+			
+			len = snprintf(pos, size, "%s@%s", signal, obj);
+			len++;
+			size -= len;
+			pos += len;
+			
+			if (envp) {
+				int i;
+
+				for (i = 2; envp[i]; i++) {
+					len = strlen(envp[i]) + 1;
+					snprintf(pos, size, "%s", envp[i]);
+					size -= len;
+					pos += len;
+				}
+			}
+
+			cn_netlink_send(msg, 0);
+
+			kfree(msg);
+		}
+	}
+}
+#else
+static void kobject_uevent_send_connector(const char *signal, const char *obj, char **envp, int gfp_mask)
+{
+}
+#endif
+
+
 /**
  * send_uevent - notify userspace by sending event trough netlink socket
  *
@@ -93,6 +157,8 @@
 		}
 	}
 
+	kobject_uevent_send_connector(signal, obj, envp, gfp_mask);
+
 	return netlink_broadcast(uevent_sock, skb, 0, 1, gfp_mask);
 }
 



	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt

--Multipart=_Thu__13_Jan_2005_01_15_19_+0300_y13IGb3fGm1y4jmB
Content-Type: text/x-csrc;
 name="kobj.c"
Content-Disposition: attachment;
 filename="kobj.c"
Content-Transfer-Encoding: 7bit

/*
 * 	kobj.c
 *
 * Copyright (c) 2005 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
 * 
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#include <asm/types.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/poll.h>

#include <linux/netlink.h>
#include <linux/rtnetlink.h>

#include <arpa/inet.h>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <time.h>

#include "connector.h"
#include "../soekris/sc_conn.h"

static int need_exit;
__u32 seq;

int main(int argc, char *argv[])
{
	int s;
	char buf[1024];
	int len;
	struct nlmsghdr *reply;
	struct sockaddr_nl l_local;
	struct cn_msg *data;
	char *m;
	FILE *out;
	time_t tm;
	struct pollfd pfd;
	int pin_number = 0;

	if (argc < 2)
		out = stdout;
	else {
		out = fopen(argv[1], "a+");
		if (!out) {
			fprintf(stderr, "Unable to open %s for writing: %s\n",
				argv[1], strerror(errno));
			out = stdout;
		}
	}

	memset(buf, 0, sizeof(buf));

	s = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_NFLOG);
	if (s == -1) {
		perror("socket");
		return -1;
	}

	l_local.nl_family = AF_NETLINK;
	l_local.nl_groups = 0xabcd;
	l_local.nl_pid = getpid();

	if (bind(s, (struct sockaddr *)&l_local, sizeof(struct sockaddr_nl)) == -1) {
		perror("bind");
		close(s);
		return -1;
	}

	pfd.fd = s;

	while (!need_exit) {
		pfd.events = POLLIN;
		pfd.revents = 0;
		switch (poll(&pfd, 1, -1)) 
		{
			case 0:
				need_exit = 1;
				break;
			case -1:
				if (errno != EINTR) 
				{
					need_exit = 1;
					break;
				}
			continue;
		}
		if (need_exit)
			break;

		memset(buf, 0, sizeof(buf));
		len = recv(s, buf, sizeof(buf), 0);
		if (len == -1) {
			perror("recv buf");
			close(s);
			return -1;
		}
		reply = (struct nlmsghdr *)buf;

		switch (reply->nlmsg_type) {
		case NLMSG_ERROR:
			fprintf(out, "Error message received.\n");
			fflush(out);
			break;
		case NLMSG_DONE:
			data = (struct cn_msg *)NLMSG_DATA(reply);
			m = (char *)(data + 1);

			time(&tm);
			fprintf(out,
				"%.24s : [%x.%x] [seq=%u, ack=%u], %s.\n",
				ctime(&tm), data->id.idx, data->id.val,
				data->seq, data->ack, m);
			fflush(out);
			break;
		default:
			break;
		}

		//sleep(1);
	}

	close(s);
	return 0;
}

--Multipart=_Thu__13_Jan_2005_01_15_19_+0300_y13IGb3fGm1y4jmB--
