Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935370AbWK1PY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935370AbWK1PY6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 10:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758686AbWK1PY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 10:24:58 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:19158 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1757395AbWK1PY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 10:24:57 -0500
Date: Tue, 28 Nov 2006 17:24:52 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: kdb@oss.sgi.com
Subject: [RFC&PATCH] KDB over the network using netconsole
Message-ID: <20061128152451.GA31626@localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-PopBeforeSMTPSenders: da-x@monatomic.org
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Today I had to debug a kernel of a remote machine that has no IPMI 
or serial console attached to it. So I sat for two hours and cooked
a support for interacting with KDB purely over the network, by 
extending netconsole.

The result is very adhoc-ish in nature, but it works nicely. Your 
comments regarding how to go further with this will be appreciated. 
Should I'm too busy working on other things, perhaps someone else will 
find a way to work toward a cleaner, accpetable implementation.


The usage is quite simple:

at the client 
-------------
./netkdb [remote_ip]

at the server
-------------
insmod netconsole netconsole=[params]
enter KDB through crash or otherwise.


This client above works as a netconsole client, and in addition to that,
every keystroke will translate to a UDP packet sent back to the machine. 
The client assumes that the local UDP port is 9353 and the port at the 
machine running KDB is 6656.

I've attached the patch and the client util. The patch works for kdb 4.4 
and Linux 2.6.18 on x86_64.

        - Dan

--9amGYk9869ThD9tj
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="netkdb.c"

/*
 * A network client for interacting with KDB.
 *
 * Dan Aloni <dan@xiv.co.il>, 2006 (c)
 *
 * This is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 * 
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this software; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA 02111-1307 USA
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/poll.h>
#include <netinet/in.h>
#include <termios.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <signal.h>

struct termios orig_tty;

void sigint(int s)
{
	tcsetattr(STDIN_FILENO, TCSANOW, &orig_tty);
}

void disable_icanon(void)
{
	struct termios tty;

	tcgetattr(STDIN_FILENO, &tty);
	orig_tty = tty;

	tty.c_lflag &= ~ICANON;
	tty.c_lflag &= ~ECHO;

	tty.c_iflag &= ~ICRNL;

	tcsetattr(STDIN_FILENO, TCSANOW, &tty);

	signal(SIGINT, sigint);
}


int main(int argc, char *argv[])
{
	int sock_fd;
	int ret;
	int flag;
	int stdin_fd = STDIN_FILENO;
	char in_char;
	struct sockaddr_in listening_address = {
		.sin_family = AF_INET,
		.sin_addr.s_addr = INADDR_ANY,
		.sin_port = htons(9353),
	};
	struct sockaddr_in remote_address = {
		.sin_family = AF_INET,
		.sin_addr.s_addr = INADDR_ANY,
		.sin_port = htons(6665),
	};
	struct pollfd ufds[2];

	if (argc < 2)
		return -1;
	
	remote_address.sin_addr.s_addr = inet_addr(argv[1]);
	
	printf("netkdb to %s, SIGINT will exit\n", inet_ntoa(remote_address.sin_addr));

	sock_fd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
	if (sock_fd < 0) {
		printf("socket creation failed\n");
		return -1;
	}

	flag = 1;
	ret = setsockopt(sock_fd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
	if (ret <0) {
		return -1;
	}

	ret = bind(sock_fd, (struct sockaddr *)&listening_address, 
		   sizeof(listening_address));

	if (ret < 0) {
		printf("bind failed\n");
		return -1;
	}

	ufds[0].fd = sock_fd;
	ufds[0].events = POLLIN;
	ufds[1].fd = stdin_fd;
	ufds[1].events = POLLIN;

	disable_icanon();

	while (1) {
		ufds[0].revents = 0;
		ufds[1].revents = 0;

		ret = poll(ufds, 2, 1000);
		if (ret < 0)
			break;

		if (ufds[1].revents) {
			ret = read(stdin_fd, &in_char, 1);
			if (ret == 0)
				break;
			
			/* translate backspace to what kdb is expecting */
			if (in_char == 127) {
				in_char = 8;
			}

			ret = sendto(sock_fd, &in_char, 1, 0, (struct sockaddr *)&remote_address, 
				     sizeof(remote_address));

			if (ret < 0) {
				fprintf(stderr, "sendto() failed\n");
				break;
			}
		}

		if (ufds[0].revents) {
			struct sockaddr_in source;
			socklen_t socklen = sizeof(remote_address);
			char buf[0x1000];

			ret = recvfrom(sock_fd, buf, sizeof(buf), 0, (struct sockaddr *)&source, 
				       &socklen);

			if (ret < 0) {
				fprintf(stderr, "recvfrom() failed\n");
				break;
			}

			if (source.sin_addr.s_addr == remote_address.sin_addr.s_addr) {
				write(STDOUT_FILENO, buf, ret);
			}
		}
	}

	tcsetattr(STDIN_FILENO, TCSANOW, &orig_tty);
	
	return 0;
}

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="netkdb.diff"

diff --git a/arch/x86_64/kdb/kdba_io.c b/arch/x86_64/kdb/kdba_io.c
index 7170e97..3c7c269 100644
--- a/arch/x86_64/kdb/kdba_io.c
+++ b/arch/x86_64/kdb/kdba_io.c
@@ -444,6 +444,9 @@ #endif
 #ifdef	CONFIG_KDB_USB
 	get_usb_char,
 #endif
+#if defined(CONFIG_NETCONSOLE) || defined(CONFIG_NETCONSOLE_MODULE)
+	kdb_get_netpoll_char,
+#endif
 	NULL
 };
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index bf58db2..b1c91e7 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -46,6 +46,10 @@ #include <linux/sysrq.h>
 #include <linux/smp.h>
 #include <linux/netpoll.h>
 
+#ifdef CONFIG_KDB
+#include <linux/kdb.h>
+#endif
+
 MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
 MODULE_DESCRIPTION("Console driver for network interfaces");
 MODULE_LICENSE("GPL");
@@ -60,6 +64,9 @@ static struct netpoll np = {
 	.local_port = 6665,
 	.remote_port = 6666,
 	.remote_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+#ifdef CONFIG_KDB
+	.rx_hook = kdb_netconsole_rx_hook,
+#endif
 	.drop = netpoll_queue,
 };
 static int configured = 0;
@@ -115,11 +122,18 @@ static int init_netconsole(void)
 
 	register_console(&netconsole);
 	printk(KERN_INFO "netconsole: network logging started\n");
+
+#ifdef CONFIG_KDB
+	kdb_register_netconsole(&np);	
+#endif
 	return 0;
 }
 
 static void cleanup_netconsole(void)
 {
+#ifdef CONFIG_KDB
+	kdb_unregister_netconsole();
+#endif
 	unregister_console(&netconsole);
 	netpoll_cleanup(&np);
 }
diff --git a/include/linux/kdb.h b/include/linux/kdb.h
index 098145c..bd3c3f7 100644
--- a/include/linux/kdb.h
+++ b/include/linux/kdb.h
@@ -15,6 +15,7 @@ #define _KDB_H
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/netpoll.h>
 #include <asm/atomic.h>
 
 /* These are really private, but they must be defined before including
@@ -160,4 +161,8 @@ int kdb_process_cpu(const struct task_st
 
 extern const char kdb_serial_str[];
 
+extern void kdb_register_netconsole(struct netpoll *np);
+extern void kdb_unregister_netconsole(void);
+extern void kdb_netconsole_rx_hook(struct netpoll *, int source, char *buf, int size);
+
 #endif	/* !_KDB_H */
diff --git a/include/linux/kdbprivate.h b/include/linux/kdbprivate.h
index 78a939f..ff9a252 100644
--- a/include/linux/kdbprivate.h
+++ b/include/linux/kdbprivate.h
@@ -489,6 +489,10 @@ #ifndef KDB_RUNNING_PROCESS_ORIGINAL
 #define KDB_RUNNING_PROCESS_ORIGINAL kdb_running_process
 #endif
 
+#if defined(CONFIG_NETCONSOLE) || defined(CONFIG_NETCONSOLE_MODULE)
+extern int kdb_get_netpoll_char(void);
+#endif
+
 extern int kdb_wait_for_cpus_secs;
 extern void kdba_cpu_up(void);
 
diff --git a/kdb/kdb_io.c b/kdb/kdb_io.c
index d271366..6c1f046 100644
--- a/kdb/kdb_io.c
+++ b/kdb/kdb_io.c
@@ -604,6 +604,100 @@ #endif	/* kdba_setjmp */
 		;
 }
 
+#if defined(CONFIG_NETCONSOLE) || defined(CONFIG_NETCONSOLE_MODULE)
+
+#define RX_ACCUM_SIZE 0x10000
+
+static struct netpoll *netconsole_np;
+static int netconsole_context;
+
+static struct {
+	unsigned char buffer[RX_ACCUM_SIZE];
+	int filled;
+	int read_ptr;
+	int write_ptr;
+} rx_accum;
+
+void kdb_register_netconsole(struct netpoll *np)
+{
+	netconsole_np = np;
+}
+
+void kdb_unregister_netconsole(void)
+{
+	netconsole_np = NULL;
+}
+
+void kdb_netconsole_rx_hook(struct netpoll *np, int source, char *buf, int size)
+{
+	int partial;
+
+	if (!netconsole_np)
+		return;
+
+	if (!netconsole_context)
+		return;
+
+restart:
+	if (RX_ACCUM_SIZE - rx_accum.filled < size)
+		size = RX_ACCUM_SIZE - rx_accum.filled;
+
+	if (size <= 0)
+		return;
+
+	partial = RX_ACCUM_SIZE - rx_accum.write_ptr;
+	if (partial < size) {
+		memcpy(&rx_accum.buffer[rx_accum.write_ptr], buf, partial);
+
+		size -= partial;
+		rx_accum.filled += partial;
+		rx_accum.write_ptr = 0;
+		buf += partial;
+		goto restart;
+	}
+
+	memcpy(&rx_accum.buffer[rx_accum.write_ptr], buf, size);
+	rx_accum.filled += size;
+	rx_accum.write_ptr += size;
+}
+
+int kdb_get_netpoll_char(void)
+{
+	int polled = 0;
+
+	do {
+		if (rx_accum.filled > 0) {
+			int ret;
+
+			ret = rx_accum.buffer[rx_accum.read_ptr];
+			rx_accum.read_ptr += 1;
+			rx_accum.read_ptr %= RX_ACCUM_SIZE;
+			rx_accum.filled--;
+
+			return ret;
+		}
+
+		if (!netconsole_np)
+			return -1;
+
+		if (polled)
+			break;
+
+		netconsole_context = 1;
+		netpoll_poll(netconsole_np);
+		netconsole_context = 0;
+		polled++;
+	} while (1);
+
+	return -1;
+}
+
+EXPORT_SYMBOL(kdb_register_netconsole);
+EXPORT_SYMBOL(kdb_unregister_netconsole);
+EXPORT_SYMBOL(kdb_netconsole_rx_hook);
+
+#endif
+
 /*
  * kdb_io_init
  *

--9amGYk9869ThD9tj--
