Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270464AbRJBKT3>; Tue, 2 Oct 2001 06:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270619AbRJBKTU>; Tue, 2 Oct 2001 06:19:20 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:10765 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S270464AbRJBKTN>; Tue, 2 Oct 2001 06:19:13 -0400
Date: Tue, 2 Oct 2001 05:06:52 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, ak@muc.de
Subject: 2.2.19 backport of devinet.c 4.4BSD compatibility patch to ioctl SIOCGIF*
Message-ID: <20011002050652.A30832@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"David S. Miller" <davem@redhat.com>,
	"netdev@oss.sgi.com" <netdev@oss.sgi.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, ak@muc.de
In-Reply-To: <20011001121931.B15943@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20011001121931.B15943@emma1.emma.line.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's that 2.4.9 patch to devinet.c backported to 2.2.19. Same
functionality, but caters for CONFIG_IP_ALIAS:

The patch is also available at
http://mandree.home.pages.de/linux/kernel/2.2/

Alan, please consider this for inclusion into your current 2.2.20pre*
series.

--- devinet.c.orig	Fri Dec 22 12:36:33 2000
+++ devinet.c	Tue Oct  2 04:29:03 2001
@@ -20,6 +20,10 @@
  *	Changes:
  *	        Alexey Kuznetsov:	pa_* fields are replaced with ifaddr lists.
  *		Cyrus Durgin:		updated for kmod
+ *		Matthias Andree:	in devinet_ioctl, compare label and 
+ *					address (4.4BSD alias style support),
+ *					fall back to comparing just the label
+ *					if no match found.
  */
 
 #include <linux/config.h>
@@ -405,6 +409,8 @@
 	struct device *dev;
 #ifdef CONFIG_IP_ALIAS
 	char *colon;
+	struct sockaddr_in sin_orig;
+	int tryaddrmatch = 0;
 #endif
 	int exclusive = 0;
 	int ret = 0;
@@ -418,6 +424,9 @@
 	ifr.ifr_name[IFNAMSIZ-1] = 0;
 
 #ifdef CONFIG_IP_ALIAS
+        /* save original address for comparison */
+ 	memcpy(&sin_orig, sin, sizeof(*sin));
+	
 	colon = strchr(ifr.ifr_name, ':');
 	if (colon)
 		*colon = 0;
@@ -436,6 +445,9 @@
 		   so that we do not impose a lock.
 		   One day we will be forced to put shlock here (I mean SMP)
 		 */
+#ifdef CONFIG_IP_ALIAS
+		tryaddrmatch = (sin_orig.sin_family == AF_INET);
+#endif
 		memset(sin, 0, sizeof(*sin));
 		sin->sin_family = AF_INET;
 		break;
@@ -473,6 +485,25 @@
 #endif
 
 	if ((in_dev=dev->ip_ptr) != NULL) {
+#ifdef CONFIG_IP_ALIAS
+		if (tryaddrmatch) {
+			/* Matthias Andree */
+			/* compare label and address (4.4BSD style) */
+			/* note: we only do this for a limited set of ioctls
+			   and only if the original address family was AF_INET.
+			   This is checked above. */
+			for (ifap=&in_dev->ifa_list; (ifa=*ifap) != NULL; ifap=&ifa->ifa_next) {
+				if ((strcmp(ifr.ifr_name, ifa->ifa_label) == 0)
+				    && (sin_orig.sin_addr.s_addr == ifa->ifa_address)) {
+					break; /* found */
+				} /* if */
+			} /* for */
+		}
+		/* we didn't get a match, maybe the application is
+		   4.3BSD-style and passed in junk so we fall back to 
+		   comparing just the label */
+		if (ifa == NULL) 
+#endif
 		for (ifap=&in_dev->ifa_list; (ifa=*ifap) != NULL; ifap=&ifa->ifa_next)
 			if (strcmp(ifr.ifr_name, ifa->ifa_label) == 0)
 				break;

-- 
Matthias Andree
