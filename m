Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVFJPil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVFJPil (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 11:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbVFJPik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 11:38:40 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:31494 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262582AbVFJPep
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 11:34:45 -0400
Message-Id: <200506101529.j5AFTVut008287@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/4] UML - slirp and slip driver cleanups and fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Jun 2005 11:29:31 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch merges a lot of duplicated code in the slip and slirp drivers,
abstracts out the slip protocol, and makes the slip driver work in 2.6.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/drivers/Makefile
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/Makefile	2005-06-08 12:21:17.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/Makefile	2005-06-08 12:54:43.000000000 -0400
@@ -22,8 +22,8 @@ obj-y := stdio_console.o fd.o chan_kern.
 obj-$(CONFIG_SSL) += ssl.o
 obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
 
-obj-$(CONFIG_UML_NET_SLIP) += slip.o
-obj-$(CONFIG_UML_NET_SLIRP) += slirp.o
+obj-$(CONFIG_UML_NET_SLIP) += slip.o slip_common.o
+obj-$(CONFIG_UML_NET_SLIRP) += slirp.o slip_common.o
 obj-$(CONFIG_UML_NET_DAEMON) += daemon.o 
 obj-$(CONFIG_UML_NET_MCAST) += mcast.o 
 #obj-$(CONFIG_UML_NET_PCAP) += pcap.o $(PCAP)
@@ -41,6 +41,6 @@ obj-$(CONFIG_UML_WATCHDOG) += harddog.o
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
 obj-$(CONFIG_UML_RANDOM) += random.o
 
-USER_OBJS := fd.o null.o pty.o tty.o xterm.o
+USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o
 
 include arch/um/scripts/Makefile.rules
Index: linux-2.6.12-rc/arch/um/drivers/slip.h
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/slip.h	2005-06-07 10:24:53.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/slip.h	2005-06-08 12:54:43.000000000 -0400
@@ -1,10 +1,7 @@
 #ifndef __UM_SLIP_H
 #define __UM_SLIP_H
 
-#define BUF_SIZE 1500
- /* two bytes each for a (pathological) max packet of escaped chars +  * 
-  * terminating END char + initial END char                            */
-#define ENC_BUF_SIZE (2 * BUF_SIZE + 2)
+#include "slip_common.h"
 
 struct slip_data {
 	void *dev;
@@ -12,28 +9,12 @@ struct slip_data {
 	char *addr;
 	char *gate_addr;
 	int slave;
-	unsigned char ibuf[ENC_BUF_SIZE];
-	unsigned char obuf[ENC_BUF_SIZE];
-	int more; /* more data: do not read fd until ibuf has been drained */
-	int pos;
-	int esc;
+	struct slip_proto slip;
 };
 
 extern struct net_user_info slip_user_info;
 
-extern int set_umn_addr(int fd, char *addr, char *ptp_addr);
 extern int slip_user_read(int fd, void *buf, int len, struct slip_data *pri);
 extern int slip_user_write(int fd, void *buf, int len, struct slip_data *pri);
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.12-rc/arch/um/drivers/slip_common.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/slip_common.c	2005-06-08 06:19:43.393768952 -0400
+++ linux-2.6.12-rc/arch/um/drivers/slip_common.c	2005-06-08 12:54:43.000000000 -0400
@@ -0,0 +1,54 @@
+#include <string.h>
+#include "slip_common.h"
+#include "net_user.h"
+
+int slip_proto_read(int fd, void *buf, int len, struct slip_proto *slip)
+{
+	int i, n, size, start;
+
+	if(slip->more > 0){
+		i = 0;
+		while(i < slip->more){
+			size = slip_unesc(slip->ibuf[i++], slip->ibuf, 
+					  &slip->pos, &slip->esc);
+			if(size){
+				memcpy(buf, slip->ibuf, size);
+				memmove(slip->ibuf, &slip->ibuf[i], 
+					slip->more - i);
+				slip->more = slip->more - i; 
+				return size;
+			}
+		}
+		slip->more = 0;
+	}
+
+	n = net_read(fd, &slip->ibuf[slip->pos], 
+		     sizeof(slip->ibuf) - slip->pos);
+	if(n <= 0) 
+		return n;
+
+	start = slip->pos;
+	for(i = 0; i < n; i++){
+		size = slip_unesc(slip->ibuf[start + i], slip->ibuf,&slip->pos,
+				  &slip->esc);
+		if(size){
+			memcpy(buf, slip->ibuf, size);
+			memmove(slip->ibuf, &slip->ibuf[start+i+1], 
+				n - (i + 1));
+			slip->more = n - (i + 1); 
+			return size;
+		}
+	}
+	return 0;
+}
+
+int slip_proto_write(int fd, void *buf, int len, struct slip_proto *slip)
+{
+	int actual, n;
+
+	actual = slip_esc(buf, slip->obuf, len);
+	n = net_write(fd, slip->obuf, actual);
+	if(n < 0) 
+		return n;
+	else return len;
+}
Index: linux-2.6.12-rc/arch/um/drivers/slip_common.h
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/slip_common.h	2005-06-08 06:19:43.393768952 -0400
+++ linux-2.6.12-rc/arch/um/drivers/slip_common.h	2005-06-08 12:54:43.000000000 -0400
@@ -0,0 +1,104 @@
+#ifndef __UM_SLIP_COMMON_H
+#define __UM_SLIP_COMMON_H
+
+#define BUF_SIZE 1500
+ /* two bytes each for a (pathological) max packet of escaped chars +  * 
+  * terminating END char + initial END char                            */
+#define ENC_BUF_SIZE (2 * BUF_SIZE + 2)
+
+/* SLIP protocol characters. */
+#define SLIP_END             0300	/* indicates end of frame	*/
+#define SLIP_ESC             0333	/* indicates byte stuffing	*/
+#define SLIP_ESC_END         0334	/* ESC ESC_END means END 'data'	*/
+#define SLIP_ESC_ESC         0335	/* ESC ESC_ESC means ESC 'data'	*/
+
+static inline int slip_unesc(unsigned char c, unsigned char *buf, int *pos,
+                             int *esc)
+{
+	int ret;
+
+	switch(c){
+	case SLIP_END:
+		*esc = 0;
+		ret=*pos;
+		*pos=0;
+		return(ret);
+	case SLIP_ESC:
+		*esc = 1;
+		return(0);
+	case SLIP_ESC_ESC:
+		if(*esc){
+			*esc = 0;
+			c = SLIP_ESC;
+		}
+		break;
+	case SLIP_ESC_END:
+		if(*esc){
+			*esc = 0;
+			c = SLIP_END;
+		}
+		break;
+	}
+	buf[(*pos)++] = c;
+	return(0);
+}
+
+static inline int slip_esc(unsigned char *s, unsigned char *d, int len)
+{
+	unsigned char *ptr = d;
+	unsigned char c;
+
+	/*
+	 * Send an initial END character to flush out any
+	 * data that may have accumulated in the receiver
+	 * due to line noise.
+	 */
+
+	*ptr++ = SLIP_END;
+
+	/*
+	 * For each byte in the packet, send the appropriate
+	 * character sequence, according to the SLIP protocol.
+	 */
+
+	while (len-- > 0) {
+		switch(c = *s++) {
+		case SLIP_END:
+			*ptr++ = SLIP_ESC;
+			*ptr++ = SLIP_ESC_END;
+			break;
+		case SLIP_ESC:
+			*ptr++ = SLIP_ESC;
+			*ptr++ = SLIP_ESC_ESC;
+			break;
+		default:
+			*ptr++ = c;
+			break;
+		}
+	}
+	*ptr++ = SLIP_END;
+	return (ptr - d);
+}
+
+struct slip_proto {
+	unsigned char ibuf[ENC_BUF_SIZE];
+	unsigned char obuf[ENC_BUF_SIZE];
+	int more; /* more data: do not read fd until ibuf has been drained */
+	int pos;
+	int esc;
+};
+
+#define SLIP_PROTO_INIT { \
+	.ibuf  	= { '\0' }, \
+	.obuf  	= { '\0' }, \
+        .more	= 0, \
+	.pos	= 0, \
+	.esc	= 0 \
+}
+
+extern int slip_proto_read(int fd, void *buf, int len, 
+			   struct slip_proto *slip);
+extern int slip_proto_write(int fd, void *buf, int len, 
+			    struct slip_proto *slip);
+
+#endif
Index: linux-2.6.12-rc/arch/um/drivers/slip_kern.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/slip_kern.c	2005-06-08 11:56:11.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/slip_kern.c	2005-06-08 14:18:59.000000000 -0400
@@ -26,16 +26,16 @@ void slip_init(struct net_device *dev, v
 		  .addr		= NULL,
 		  .gate_addr 	= init->gate_addr,
 		  .slave  	= -1,
-		  .ibuf  	= { '\0' },
-		  .obuf  	= { '\0' },
-		  .pos 		= 0,
-		  .esc 		= 0,
+		  .slip		= SLIP_PROTO_INIT,
 		  .dev 		= dev });
 
 	dev->init = NULL;
+	dev->header_cache_update = NULL;
+	dev->hard_header_cache = NULL;
+	dev->hard_header = NULL;
 	dev->hard_header_len = 0;
-	dev->addr_len = 4;
-	dev->type = ARPHRD_ETHER;
+	dev->addr_len = 0;
+	dev->type = ARPHRD_SLIP;
 	dev->tx_queue_len = 256;
 	dev->flags = IFF_NOARP;
 	printk("SLIP backend - SLIP IP = %s\n", spri->gate_addr);
Index: linux-2.6.12-rc/arch/um/drivers/slip_proto.h
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/slip_proto.h	2005-06-07 10:24:53.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/slip_proto.h	2005-06-08 06:19:43.393768952 -0400
@@ -1,94 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __UM_SLIP_PROTO_H__
-#define __UM_SLIP_PROTO_H__
-
-/* SLIP protocol characters. */
-#define SLIP_END             0300	/* indicates end of frame	*/
-#define SLIP_ESC             0333	/* indicates byte stuffing	*/
-#define SLIP_ESC_END         0334	/* ESC ESC_END means END 'data'	*/
-#define SLIP_ESC_ESC         0335	/* ESC ESC_ESC means ESC 'data'	*/
-
-static inline int slip_unesc(unsigned char c, unsigned char *buf, int *pos,
-                             int *esc)
-{
-	int ret;
-
-	switch(c){
-	case SLIP_END:
-		*esc = 0;
-		ret=*pos;
-		*pos=0;
-		return(ret);
-	case SLIP_ESC:
-		*esc = 1;
-		return(0);
-	case SLIP_ESC_ESC:
-		if(*esc){
-			*esc = 0;
-			c = SLIP_ESC;
-		}
-		break;
-	case SLIP_ESC_END:
-		if(*esc){
-			*esc = 0;
-			c = SLIP_END;
-		}
-		break;
-	}
-	buf[(*pos)++] = c;
-	return(0);
-}
-
-static inline int slip_esc(unsigned char *s, unsigned char *d, int len)
-{
-	unsigned char *ptr = d;
-	unsigned char c;
-
-	/*
-	 * Send an initial END character to flush out any
-	 * data that may have accumulated in the receiver
-	 * due to line noise.
-	 */
-
-	*ptr++ = SLIP_END;
-
-	/*
-	 * For each byte in the packet, send the appropriate
-	 * character sequence, according to the SLIP protocol.
-	 */
-
-	while (len-- > 0) {
-		switch(c = *s++) {
-		case SLIP_END:
-			*ptr++ = SLIP_ESC;
-			*ptr++ = SLIP_ESC_END;
-			break;
-		case SLIP_ESC:
-			*ptr++ = SLIP_ESC;
-			*ptr++ = SLIP_ESC_ESC;
-			break;
-		default:
-			*ptr++ = c;
-			break;
-		}
-	}
-	*ptr++ = SLIP_END;
-	return (ptr - d);
-}
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.12-rc/arch/um/drivers/slip_user.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/slip_user.c	2005-06-08 11:56:11.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/slip_user.c	2005-06-08 14:18:59.000000000 -0400
@@ -13,7 +13,7 @@
 #include "user.h"
 #include "net_user.h"
 #include "slip.h"
-#include "slip_proto.h"
+#include "slip_common.h"
 #include "helper.h"
 #include "os.h"
 
@@ -77,41 +77,51 @@ static int slip_tramp(char **argv, int f
 	err = os_pipe(fds, 1, 0);
 	if(err < 0){
 		printk("slip_tramp : pipe failed, err = %d\n", -err);
-		return(err);
+		goto out;
 	}
 
 	err = 0;
 	pe_data.stdin = fd;
 	pe_data.stdout = fds[1];
 	pe_data.close_me = fds[0];
-	pid = run_helper(slip_pre_exec, &pe_data, argv, NULL);
-
-	if(pid < 0) err = pid;
-	else {
-		output_len = page_size();
-		output = um_kmalloc(output_len);
-		if(output == NULL)
-			printk("slip_tramp : failed to allocate output "
-			       "buffer\n");
-
-		os_close_file(fds[1]);
-		read_output(fds[0], output, output_len);
-		if(output != NULL){
-			printk("%s", output);
-			kfree(output);
-		}
-		CATCH_EINTR(err = waitpid(pid, &status, 0));
-		if(err < 0)
-			err = errno;
-		else if(!WIFEXITED(status) || (WEXITSTATUS(status) != 0)){
-			printk("'%s' didn't exit with status 0\n", argv[0]);
-			err = -EINVAL;
-		}
+	err = run_helper(slip_pre_exec, &pe_data, argv, NULL);
+	if(err < 0) 
+		goto out_close;
+	pid = err;
+
+	output_len = page_size();
+	output = um_kmalloc(output_len);
+	if(output == NULL){
+		printk("slip_tramp : failed to allocate output buffer\n");
+		os_kill_process(pid, 1);
+		err = -ENOMEM;
+		goto out_free;
+	}
+
+	os_close_file(fds[1]);
+	read_output(fds[0], output, output_len);
+	printk("%s", output);
+
+	CATCH_EINTR(err = waitpid(pid, &status, 0));
+	if(err < 0)
+		err = errno;
+	else if(!WIFEXITED(status) || (WEXITSTATUS(status) != 0)){
+		printk("'%s' didn't exit with status 0\n", argv[0]);
+		err = -EINVAL;
 	}
+	else err = 0;
 
 	os_close_file(fds[0]);
 
-	return(err);
+out_free:
+	kfree(output);
+	return err;
+
+out_close:
+	os_close_file(fds[0]);
+	os_close_file(fds[1]);
+out:
+	return err;
 }
 
 static int slip_open(void *data)
@@ -123,21 +133,26 @@ static int slip_open(void *data)
 			 NULL };
 	int sfd, mfd, err;
 
-	mfd = get_pty();
-	if(mfd < 0){
-		printk("umn : Failed to open pty, err = %d\n", -mfd);
-		return(mfd);
+	err = get_pty();
+	if(err < 0){
+		printk("slip-open : Failed to open pty, err = %d\n", -err);
+		goto out;
 	}
-	sfd = os_open_file(ptsname(mfd), of_rdwr(OPENFLAGS()), 0);
-	if(sfd < 0){
-		printk("Couldn't open tty for slip line, err = %d\n", -sfd);
-		os_close_file(mfd);
-		return(sfd);
+	mfd = err;
+
+	err = os_open_file(ptsname(mfd), of_rdwr(OPENFLAGS()), 0);
+	if(err < 0){
+		printk("Couldn't open tty for slip line, err = %d\n", -err);
+		goto out_close;
 	}
-	if(set_up_tty(sfd)) return(-1);
+	sfd = err;
+
+	if(set_up_tty(sfd)) 
+		goto out_close2;
+
 	pri->slave = sfd;
-	pri->pos = 0;
-	pri->esc = 0;
+	pri->slip.pos = 0;
+	pri->slip.esc = 0;
 	if(pri->gate_addr != NULL){
 		sprintf(version_buf, "%d", UML_NET_VERSION);
 		strcpy(gate_buf, pri->gate_addr);
@@ -146,12 +161,12 @@ static int slip_open(void *data)
 
 		if(err < 0){
 			printk("slip_tramp failed - err = %d\n", -err);
-			return(err);
+			goto out_close2;
 		}
 		err = os_get_ifname(pri->slave, pri->name);
 		if(err < 0){
 			printk("get_ifname failed, err = %d\n", -err);
-			return(err);
+			goto out_close2;
 		}
 		iter_addresses(pri->dev, open_addr, pri->name);
 	}
@@ -160,10 +175,16 @@ static int slip_open(void *data)
 		if(err < 0){
 			printk("Failed to set slip discipline encapsulation - "
 			       "err = %d\n", -err);
-			return(err);
+			goto out_close2;
 		}
 	}
 	return(mfd);
+out_close2:
+	os_close_file(sfd);
+out_close:
+	os_close_file(mfd);
+out:
+	return err;
 }
 
 static void slip_close(int fd, void *data)
@@ -190,48 +211,12 @@ static void slip_close(int fd, void *dat
 
 int slip_user_read(int fd, void *buf, int len, struct slip_data *pri)
 {
-	int i, n, size, start;
-
-	if(pri->more>0) {
-		i = 0;
-		while(i < pri->more) {
-			size = slip_unesc(pri->ibuf[i++],
-					pri->ibuf, &pri->pos, &pri->esc);
-			if(size){
-				memcpy(buf, pri->ibuf, size);
-				memmove(pri->ibuf, &pri->ibuf[i], pri->more-i);
-				pri->more=pri->more-i; 
-				return(size);
-			}
-		}
-		pri->more=0;
-	}
-
-	n = net_read(fd, &pri->ibuf[pri->pos], sizeof(pri->ibuf) - pri->pos);
-	if(n <= 0) return(n);
-
-	start = pri->pos;
-	for(i = 0; i < n; i++){
-		size = slip_unesc(pri->ibuf[start + i],
-				pri->ibuf, &pri->pos, &pri->esc);
-		if(size){
-			memcpy(buf, pri->ibuf, size);
-			memmove(pri->ibuf, &pri->ibuf[start+i+1], n-(i+1));
-			pri->more=n-(i+1); 
-			return(size);
-		}
-	}
-	return(0);
+	return slip_proto_read(fd, buf, len, &pri->slip);
 }
 
 int slip_user_write(int fd, void *buf, int len, struct slip_data *pri)
 {
-	int actual, n;
-
-	actual = slip_esc(buf, pri->obuf, len);
-	n = net_write(fd, pri->obuf, actual);
-	if(n < 0) return(n);
-	else return(len);
+	return slip_proto_write(fd, buf, len, &pri->slip);
 }
 
 static int slip_set_mtu(int mtu, void *data)
@@ -267,14 +252,3 @@ struct net_user_info slip_user_info = {
 	.delete_address = slip_del_addr,
 	.max_packet	= BUF_SIZE
 };
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.12-rc/arch/um/drivers/slirp.h
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/slirp.h	2005-06-07 10:24:53.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/slirp.h	2005-06-08 12:54:43.000000000 -0400
@@ -1,10 +1,7 @@
 #ifndef __UM_SLIRP_H
 #define __UM_SLIRP_H
 
-#define BUF_SIZE 1500
- /* two bytes each for a (pathological) max packet of escaped chars +  * 
-  * terminating END char + initial END char                            */
-#define ENC_BUF_SIZE (2 * BUF_SIZE + 2)
+#include "slip_common.h"
 
 #define SLIRP_MAX_ARGS 100
 /*
@@ -24,28 +21,13 @@ struct slirp_data {
 	struct arg_list_dummy_wrapper argw;
 	int pid;
 	int slave;
-	unsigned char ibuf[ENC_BUF_SIZE];
-	unsigned char obuf[ENC_BUF_SIZE];
-	int more; /* more data: do not read fd until ibuf has been drained */
-	int pos;
-	int esc;
+	struct slip_proto slip;
 };
 
 extern struct net_user_info slirp_user_info;
 
-extern int set_umn_addr(int fd, char *addr, char *ptp_addr);
 extern int slirp_user_read(int fd, void *buf, int len, struct slirp_data *pri);
-extern int slirp_user_write(int fd, void *buf, int len, struct slirp_data *pri);
+extern int slirp_user_write(int fd, void *buf, int len, 
+			    struct slirp_data *pri);
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.12-rc/arch/um/drivers/slirp_kern.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/slirp_kern.c	2005-06-08 11:56:11.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/slirp_kern.c	2005-06-08 14:18:51.000000000 -0400
@@ -25,10 +25,7 @@ void slirp_init(struct net_device *dev, 
 		{ .argw 	= init->argw,
 		  .pid  	= -1,
 		  .slave  	= -1,
-		  .ibuf  	= { '\0' },
-		  .obuf  	= { '\0' },
-		  .pos 		= 0,
-		  .esc 		= 0,
+		  .slip		= SLIP_PROTO_INIT,
 		  .dev 		= dev });
 
 	dev->init = NULL;
Index: linux-2.6.12-rc/arch/um/drivers/slirp_user.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/slirp_user.c	2005-06-08 11:56:11.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/slirp_user.c	2005-06-08 12:54:43.000000000 -0400
@@ -12,7 +12,7 @@
 #include "user.h"
 #include "net_user.h"
 #include "slirp.h"
-#include "slip_proto.h"
+#include "slip_common.h"
 #include "helper.h"
 #include "os.h"
 
@@ -48,47 +48,32 @@ static int slirp_tramp(char **argv, int 
 	return(pid);
 }
 
-/* XXX This is just a trivial wrapper around os_pipe */
-static int slirp_datachan(int *mfd, int *sfd)
-{
-	int fds[2], err;
-
-	err = os_pipe(fds, 1, 1);
-	if(err < 0){
-		printk("slirp_datachan: Failed to open pipe, err = %d\n", -err);
-		return(err);
-	}
-
-	*mfd = fds[0];
-	*sfd = fds[1];
-	return(0);
-}
-
 static int slirp_open(void *data)
 {
 	struct slirp_data *pri = data;
-	int sfd, mfd, pid, err;
+	int fds[2], pid, err;
 
-	err = slirp_datachan(&mfd, &sfd);
+	err = os_pipe(fds, 1, 1);
 	if(err)
 		return(err);
 
-	pid = slirp_tramp(pri->argw.argv, sfd);
-
-	if(pid < 0){
-		printk("slirp_tramp failed - errno = %d\n", -pid);
-		os_close_file(sfd);	
-		os_close_file(mfd);	
-		return(pid);
+	err = slirp_tramp(pri->argw.argv, fds[1]);
+	if(err < 0){
+		printk("slirp_tramp failed - errno = %d\n", -err);
+		goto out;
 	}
+	pid = err;
 
-	pri->slave = sfd;
-	pri->pos = 0;
-	pri->esc = 0;
-
-	pri->pid = pid;
-
-	return(mfd);
+	pri->slave = fds[1];
+	pri->slip.pos = 0;
+	pri->slip.esc = 0;
+	pri->pid = err;
+
+	return(fds[0]);
+out:
+	os_close_file(fds[0]);
+	os_close_file(fds[1]);
+	return err;
 }
 
 static void slirp_close(int fd, void *data)
@@ -129,48 +114,12 @@ static void slirp_close(int fd, void *da
 
 int slirp_user_read(int fd, void *buf, int len, struct slirp_data *pri)
 {
-	int i, n, size, start;
-
-	if(pri->more>0) {
-		i = 0;
-		while(i < pri->more) {
-			size = slip_unesc(pri->ibuf[i++],
-					pri->ibuf,&pri->pos,&pri->esc);
-			if(size){
-				memcpy(buf, pri->ibuf, size);
-				memmove(pri->ibuf, &pri->ibuf[i], pri->more-i);
-				pri->more=pri->more-i; 
-				return(size);
-			}
-		}
-		pri->more=0;
-	}
-
-	n = net_read(fd, &pri->ibuf[pri->pos], sizeof(pri->ibuf) - pri->pos);
-	if(n <= 0) return(n);
-
-	start = pri->pos;
-	for(i = 0; i < n; i++){
-		size = slip_unesc(pri->ibuf[start + i],
-				pri->ibuf,&pri->pos,&pri->esc);
-		if(size){
-			memcpy(buf, pri->ibuf, size);
-			memmove(pri->ibuf, &pri->ibuf[start+i+1], n-(i+1));
-			pri->more=n-(i+1); 
-			return(size);
-		}
-	}
-	return(0);
+	return slip_proto_read(fd, buf, len, &pri->slip);
 }
 
 int slirp_user_write(int fd, void *buf, int len, struct slirp_data *pri)
 {
-	int actual, n;
-
-	actual = slip_esc(buf, pri->obuf, len);
-	n = net_write(fd, pri->obuf, actual);
-	if(n < 0) return(n);
-	else return(len);
+	return slip_proto_write(fd, buf, len, &pri->slip);
 }
 
 static int slirp_set_mtu(int mtu, void *data)
@@ -188,14 +137,3 @@ struct net_user_info slirp_user_info = {
 	.delete_address = NULL,
 	.max_packet	= BUF_SIZE
 };
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

