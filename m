Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbUEOLir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUEOLir (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 07:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUEOLir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 07:38:47 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:19600 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262051AbUEOLii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 07:38:38 -0400
From: tglx@linutronix.de (Thomas Gleixner)
Reply-To: tglx@linutronix.de
Organization: linutronix
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.26] kernel/sysctl.c fix compiler warnings
Date: Sat, 15 May 2004 13:27:44 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405151327.44430.tglx@linutronix.de>
X-Seen: false
X-ID: TttjkmZVreGjsuy7rfNc8btRm-LRtCAkPx9Lv6TsTzipqc49rXsIUh@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch fixes the following warnings, produced by gcc3.3.3:

sysctl.c: In function `do_proc_dointvec':
sysctl.c:879: warning: use of cast expressions as lvalues is deprecated
sysctl.c: In function `proc_dointvec_minmax':
sysctl.c:1032: warning: use of cast expressions as lvalues is deprecated
sysctl.c: In function `do_proc_doulongvec_minmax':
sysctl.c:1133: warning: use of cast expressions as lvalues is deprecated

-- 
Thomas
________________________________________________________________________
"Free software" is a matter of liberty, not price. To understand the concept,
you should think of "free" as in "free speech,'' not as in "free beer".
My 0.02$: Keep in mind that "free beer" can have a price too: "an hangover".
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de

--- linux-2.4.26.org/kernel/sysctl.c	2003-11-28 19:26:21.000000000 +0100
+++ linux-2.4.26/kernel/sysctl.c	2004-05-15 13:12:54.000000000 +0200
@@ -854,6 +854,7 @@
 	int *i, vleft, first=1, neg, val;
 	size_t left, len;
 	
+	char *pbuffer = (char *) buffer;
 	#define TMPBUFLEN 20
 	char buf[TMPBUFLEN], *p;
 	
@@ -871,12 +872,12 @@
 		if (write) {
 			while (left) {
 				char c;
-				if (get_user(c, (char *) buffer))
+				if (get_user(c, pbuffer))
 					return -EFAULT;
 				if (!isspace(c))
 					break;
 				left--;
-				((char *) buffer)++;
+				pbuffer++;
 			}
 			if (!left)
 				break;
@@ -884,7 +885,7 @@
 			len = left;
 			if (len > TMPBUFLEN-1)
 				len = TMPBUFLEN-1;
-			if(copy_from_user(buf, buffer, len))
+			if(copy_from_user(buf, pbuffer, len))
 				return -EFAULT;
 			buf[len] = 0;
 			p = buf;
@@ -900,7 +901,7 @@
 				break;
 			if (neg)
 				val = -val;
-			buffer += len;
+			pbuffer += len;
 			left -= len;
 			switch(op) {
 			case OP_SET:	*i = val; break;
@@ -921,23 +922,22 @@
 			len = strlen(buf);
 			if (len > left)
 				len = left;
-			if(copy_to_user(buffer, buf, len))
+			if(copy_to_user(pbuffer, buf, len))
 				return -EFAULT;
 			left -= len;
-			buffer += len;
+			pbuffer += len;
 		}
 	}
 
 	if (!write && !first && left) {
-		if(put_user('\n', (char *) buffer))
+		if(put_user('\n', pbuffer))
 			return -EFAULT;
-		left--, buffer++;
+		left--, pbuffer++;
 	}
 	if (write) {
-		p = (char *) buffer;
 		while (left) {
 			char c;
-			if (get_user(c, p++))
+			if (get_user(c, pbuffer++))
 				return -EFAULT;
 			if (!isspace(c))
 				break;
@@ -1007,6 +1007,7 @@
 	size_t len, left;
 	#define TMPBUFLEN 20
 	char buf[TMPBUFLEN], *p;
+	char *pbuffer = (char *) buffer;
 	
 	if (!table->data || !table->maxlen || !*lenp ||
 	    (filp->f_pos && !write)) {
@@ -1024,12 +1025,12 @@
 		if (write) {
 			while (left) {
 				char c;
-				if (get_user(c, (char *) buffer))
+				if (get_user(c, pbuffer))
 					return -EFAULT;
 				if (!isspace(c))
 					break;
 				left--;
-				((char *) buffer)++;
+				pbuffer++;
 			}
 			if (!left)
 				break;
@@ -1037,7 +1038,7 @@
 			len = left;
 			if (len > TMPBUFLEN-1)
 				len = TMPBUFLEN-1;
-			if(copy_from_user(buf, buffer, len))
+			if(copy_from_user(buf, pbuffer, len))
 				return -EFAULT;
 			buf[len] = 0;
 			p = buf;
@@ -1053,7 +1054,7 @@
 				break;
 			if (neg)
 				val = -val;
-			buffer += len;
+			pbuffer += len;
 			left -= len;
 
 			if ((min && val < *min) || (max && val > *max))
@@ -1067,23 +1068,22 @@
 			len = strlen(buf);
 			if (len > left)
 				len = left;
-			if(copy_to_user(buffer, buf, len))
+			if(copy_to_user(pbuffer, buf, len))
 				return -EFAULT;
 			left -= len;
-			buffer += len;
+			pbuffer += len;
 		}
 	}
 
 	if (!write && !first && left) {
-		if(put_user('\n', (char *) buffer))
+		if(put_user('\n', (char *) pbuffer))
 			return -EFAULT;
-		left--, buffer++;
+		left--, pbuffer++;
 	}
 	if (write) {
-		p = (char *) buffer;
 		while (left) {
 			char c;
-			if (get_user(c, p++))
+			if (get_user(c, pbuffer++))
 				return -EFAULT;
 			if (!isspace(c))
 				break;
@@ -1108,6 +1108,7 @@
 	int vleft, first=1, neg;
 	size_t len, left;
 	char buf[TMPBUFLEN], *p;
+	char *pbuffer = (char *) buffer;
 	
 	if (!table->data || !table->maxlen || !*lenp ||
 	    (filp->f_pos && !write)) {
@@ -1125,12 +1126,12 @@
 		if (write) {
 			while (left) {
 				char c;
-				if (get_user(c, (char *) buffer))
+				if (get_user(c, pbuffer))
 					return -EFAULT;
 				if (!isspace(c))
 					break;
 				left--;
-				((char *) buffer)++;
+				pbuffer++;
 			}
 			if (!left)
 				break;
@@ -1138,7 +1139,7 @@
 			len = left;
 			if (len > TMPBUFLEN-1)
 				len = TMPBUFLEN-1;
-			if(copy_from_user(buf, buffer, len))
+			if(copy_from_user(buf, pbuffer, len))
 				return -EFAULT;
 			buf[len] = 0;
 			p = buf;
@@ -1154,7 +1155,7 @@
 				break;
 			if (neg)
 				val = -val;
-			buffer += len;
+			pbuffer += len;
 			left -= len;
 
 			if(neg)
@@ -1172,23 +1173,22 @@
 			len = strlen(buf);
 			if (len > left)
 				len = left;
-			if(copy_to_user(buffer, buf, len))
+			if(copy_to_user(pbuffer, buf, len))
 				return -EFAULT;
 			left -= len;
-			buffer += len;
+			pbuffer += len;
 		}
 	}
 
 	if (!write && !first && left) {
-		if(put_user('\n', (char *) buffer))
+		if(put_user('\n', pbuffer))
 			return -EFAULT;
-		left--, buffer++;
+		left--, pbuffer++;
 	}
 	if (write) {
-		p = (char *) buffer;
 		while (left) {
 			char c;
-			if (get_user(c, p++))
+			if (get_user(c, pbuffer++))
 				return -EFAULT;
 			if (!isspace(c))
 				break;

