Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263155AbTJUPNO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbTJUPMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:12:50 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:54174 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263155AbTJUPKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:10:33 -0400
Date: Tue, 21 Oct 2003 17:10:53 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (8/8): console driver fixes.
Message-ID: <20031021151053.GF1690@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move copy_from_user out of locked code in the 3215 and sclp driver.

diffstat:
 drivers/s390/char/con3215.c  |   88 ++++++++++++++++++-------------------------
 drivers/s390/char/sclp_con.c |    4 -
 drivers/s390/char/sclp_rw.c  |   16 +------
 drivers/s390/char/sclp_rw.h  |    2 
 drivers/s390/char/sclp_tty.c |   38 ++++++++++++++----
 5 files changed, 73 insertions(+), 75 deletions(-)

diff -urN linux-2.6/drivers/s390/char/con3215.c linux-2.6-s390/drivers/s390/char/con3215.c
--- linux-2.6/drivers/s390/char/con3215.c	Fri Oct 17 23:43:20 2003
+++ linux-2.6-s390/drivers/s390/char/con3215.c	Tue Oct 21 16:37:39 2003
@@ -96,6 +96,7 @@
 	int msg_dstat;		      /* dstat for pending message */
 	int msg_cstat;		      /* cstat for pending message */
 	int line_pos;		      /* position on the line (for tabs) */
+	char ubuffer[80];	      /* copy_from_user buffer */
 };
 
 /* array of 3215 devices structures */
@@ -532,15 +533,12 @@
 /*
  * String write routine for 3215 devices
  */
-static int
-raw3215_write(struct raw3215_info *raw, const char *str,
-	      int from_user, unsigned int length)
+static void
+raw3215_write(struct raw3215_info *raw, const char *str, unsigned int length)
 {
 	unsigned long flags;
-	int ret, c;
-	int count;
+	int c, count;
 
-	ret = 0;
 	while (length > 0) {
 		spin_lock_irqsave(raw->lock, flags);
 		count = (length > RAW3215_BUFFER_SIZE) ?
@@ -550,46 +548,19 @@
 		raw3215_make_room(raw, count);
 
 		/* copy string to output buffer and convert it to EBCDIC */
-		if (from_user) {
-			while (1) {
-				c = min_t(int, count,
-					min(RAW3215_BUFFER_SIZE - raw->count,
-					    RAW3215_BUFFER_SIZE - raw->head));
-				if (c <= 0)
-					break;
-				c -= copy_from_user(raw->buffer + raw->head,
-						    str, c);
-				if (c == 0) {
-					if (!ret)
-						ret = -EFAULT;
-					break;
-				}
-				ASCEBC(raw->buffer + raw->head, c);
-				raw->head = (raw->head + c) &
-					    (RAW3215_BUFFER_SIZE - 1);
-				raw->count += c;
-				raw->line_pos += c;
-				str += c;
-				count -= c;
-				ret += c;
-			}
-		} else {
-			while (1) {
-				c = min_t(int, count,
-					min(RAW3215_BUFFER_SIZE - raw->count,
-					    RAW3215_BUFFER_SIZE - raw->head));
-				if (c <= 0)
-					break;
-				memcpy(raw->buffer + raw->head, str, c);
-				ASCEBC(raw->buffer + raw->head, c);
-				raw->head = (raw->head + c) &
-					    (RAW3215_BUFFER_SIZE - 1);
-				raw->count += c;
-				raw->line_pos += c;
-				str += c;
-				count -= c;
-				ret += c;
-			}
+		while (1) {
+			c = min_t(int, count,
+				  min(RAW3215_BUFFER_SIZE - raw->count,
+				      RAW3215_BUFFER_SIZE - raw->head));
+			if (c <= 0)
+				break;
+			memcpy(raw->buffer + raw->head, str, c);
+			ASCEBC(raw->buffer + raw->head, c);
+			raw->head = (raw->head + c) & (RAW3215_BUFFER_SIZE - 1);
+			raw->count += c;
+			raw->line_pos += c;
+			str += c;
+			count -= c;
 		}
 		if (!(raw->flags & RAW3215_WORKING)) {
 			raw3215_mk_write_req(raw);
@@ -598,8 +569,6 @@
 		}
 		spin_unlock_irqrestore(raw->lock, flags);
 	}
-
-	return ret;
 }
 
 /*
@@ -825,7 +794,7 @@
 		for (i = 0; i < count; i++)
 			if (str[i] == '\t' || str[i] == '\n')
 				break;
-		raw3215_write(raw, str, 0, i);
+		raw3215_write(raw, str, i);
 		count -= i;
 		str += i;
 		if (count > 0) {
@@ -1021,12 +990,29 @@
 	      const unsigned char *buf, int count)
 {
 	struct raw3215_info *raw;
-	int ret = 0;
+	int length, ret;
 
 	if (!tty)
 		return 0;
 	raw = (struct raw3215_info *) tty->driver_data;
-	ret = raw3215_write(raw, buf, from_user, count);
+	if (!from_user) {
+		raw3215_write(raw, buf, count);
+		return count;
+	}
+	ret = 0;
+	while (count > 0) {
+		length = count < 80 ? count : 80;
+		length -= copy_from_user(raw->ubuffer, buf, length);
+		if (length == 0) {
+			if (!ret)
+				ret = -EFAULT;
+			break;
+		}
+		raw3215_write(raw, raw->ubuffer, count);
+		buf += length;
+		count -= length;
+		ret += length;
+	}
 	return ret;
 }
 
diff -urN linux-2.6/drivers/s390/char/sclp_con.c linux-2.6-s390/drivers/s390/char/sclp_con.c
--- linux-2.6/drivers/s390/char/sclp_con.c	Fri Oct 17 23:43:12 2003
+++ linux-2.6-s390/drivers/s390/char/sclp_con.c	Tue Oct 21 16:37:39 2003
@@ -134,8 +134,8 @@
 		}
 		/* try to write the string to the current output buffer */
 		written = sclp_write(sclp_conbuf, (const unsigned char *)
-				     message, count, 0);
-		if (written == -EFAULT || written == count)
+				     message, count);
+		if (written == count)
 			break;
 		/*
 		 * Not all characters could be written to the current
diff -urN linux-2.6/drivers/s390/char/sclp_rw.c linux-2.6-s390/drivers/s390/char/sclp_rw.c
--- linux-2.6/drivers/s390/char/sclp_rw.c	Fri Oct 17 23:43:10 2003
+++ linux-2.6-s390/drivers/s390/char/sclp_rw.c	Tue Oct 21 16:37:39 2003
@@ -175,11 +175,9 @@
  *  is not busy)
  */
 int
-sclp_write(struct sclp_buffer *buffer,
-	   const unsigned char *msg, int count, int from_user)
+sclp_write(struct sclp_buffer *buffer, const unsigned char *msg, int count)
 {
 	int spaces, i_msg;
-	char ch;
 	int rc;
 
 	/*
@@ -206,13 +204,7 @@
 	 * This is in order to a slim and quick implementation.
 	 */
 	for (i_msg = 0; i_msg < count; i_msg++) {
-		if (from_user) {
-			if (get_user(ch, msg + i_msg) != 0)
-				return -EFAULT;
-		} else
-			ch = msg[i_msg];
-
-		switch (ch) {
+		switch (msg[i_msg]) {
 		case '\n':	/* new line, line feed (ASCII)	*/
 			/* check if new mto needs to be created */
 			if (buffer->current_line == NULL) {
@@ -286,7 +278,7 @@
 			break;
 		default:	/* no escape character	*/
 			/* do not output unprintable characters */
-			if (!isprint(ch))
+			if (!isprint(msg[i_msg]))
 				break;
 			/* check if new mto needs to be created */
 			if (buffer->current_line == NULL) {
@@ -295,7 +287,7 @@
 				if (rc)
 					return i_msg;
 			}
-			*buffer->current_line++ = sclp_ascebc(ch);
+			*buffer->current_line++ = sclp_ascebc(msg[i_msg]);
 			buffer->current_length++;
 			break;
 		}
diff -urN linux-2.6/drivers/s390/char/sclp_rw.h linux-2.6-s390/drivers/s390/char/sclp_rw.h
--- linux-2.6/drivers/s390/char/sclp_rw.h	Fri Oct 17 23:43:16 2003
+++ linux-2.6-s390/drivers/s390/char/sclp_rw.h	Tue Oct 21 16:37:39 2003
@@ -89,7 +89,7 @@
 struct sclp_buffer *sclp_make_buffer(void *, unsigned short, unsigned short);
 void *sclp_unmake_buffer(struct sclp_buffer *);
 int sclp_buffer_space(struct sclp_buffer *);
-int sclp_write(struct sclp_buffer *buffer, const unsigned char *, int, int);
+int sclp_write(struct sclp_buffer *buffer, const unsigned char *, int);
 void sclp_emit_buffer(struct sclp_buffer *,void (*)(struct sclp_buffer *,int));
 void sclp_set_columns(struct sclp_buffer *, unsigned short);
 void sclp_set_htab(struct sclp_buffer *, unsigned short);
diff -urN linux-2.6/drivers/s390/char/sclp_tty.c linux-2.6-s390/drivers/s390/char/sclp_tty.c
--- linux-2.6/drivers/s390/char/sclp_tty.c	Fri Oct 17 23:42:55 2003
+++ linux-2.6-s390/drivers/s390/char/sclp_tty.c	Tue Oct 21 16:37:39 2003
@@ -322,7 +322,7 @@
  * Write a string to the sclp tty.
  */
 static void
-sclp_tty_write_string(const unsigned char *str, int count, int from_user)
+sclp_tty_write_string(const unsigned char *str, int count)
 {
 	unsigned long flags;
 	void *page;
@@ -348,8 +348,8 @@
 						       sclp_ioctls.htab);
 		}
 		/* try to write the string to the current output buffer */
-		written = sclp_write(sclp_ttybuf, str, count, from_user);
-		if (written == -EFAULT || written == count)
+		written = sclp_write(sclp_ttybuf, str, count);
+		if (written == count)
 			break;
 		/*
 		 * Not all characters could be written to the current
@@ -389,12 +389,32 @@
 sclp_tty_write(struct tty_struct *tty, int from_user,
 	       const unsigned char *buf, int count)
 {
+	int length, ret;
+
 	if (sclp_tty_chars_count > 0) {
-		sclp_tty_write_string(sclp_tty_chars, sclp_tty_chars_count, 0);
+		sclp_tty_write_string(sclp_tty_chars, sclp_tty_chars_count);
 		sclp_tty_chars_count = 0;
 	}
-	sclp_tty_write_string(buf, count, from_user);
-	return count;
+	if (!from_user) {
+		sclp_tty_write_string(buf, count);
+		return count;
+	}
+	ret = 0;
+	while (count > 0) {
+		length = count < SCLP_TTY_BUF_SIZE ?
+			count : SCLP_TTY_BUF_SIZE;
+		length -= copy_from_user(sclp_tty_chars, buf, length);
+		if (length == 0) {
+			if (!ret)
+				ret = -EFAULT;
+			break;
+		}
+		sclp_tty_write_string(sclp_tty_chars, length);
+		buf += length;
+		count -= length;
+		ret += length;
+	}
+	return ret;
 }
 
 /*
@@ -412,7 +432,7 @@
 {
 	sclp_tty_chars[sclp_tty_chars_count++] = ch;
 	if (ch == '\n' || sclp_tty_chars_count >= SCLP_TTY_BUF_SIZE) {
-		sclp_tty_write_string(sclp_tty_chars, sclp_tty_chars_count, 0);
+		sclp_tty_write_string(sclp_tty_chars, sclp_tty_chars_count);
 		sclp_tty_chars_count = 0;
 	}
 }
@@ -425,7 +445,7 @@
 sclp_tty_flush_chars(struct tty_struct *tty)
 {
 	if (sclp_tty_chars_count > 0) {
-		sclp_tty_write_string(sclp_tty_chars, sclp_tty_chars_count, 0);
+		sclp_tty_write_string(sclp_tty_chars, sclp_tty_chars_count);
 		sclp_tty_chars_count = 0;
 	}
 }
@@ -464,7 +484,7 @@
 sclp_tty_flush_buffer(struct tty_struct *tty)
 {
 	if (sclp_tty_chars_count > 0) {
-		sclp_tty_write_string(sclp_tty_chars, sclp_tty_chars_count, 0);
+		sclp_tty_write_string(sclp_tty_chars, sclp_tty_chars_count);
 		sclp_tty_chars_count = 0;
 	}
 }
