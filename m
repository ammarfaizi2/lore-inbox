Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274851AbRJAKTd>; Mon, 1 Oct 2001 06:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274859AbRJAKTY>; Mon, 1 Oct 2001 06:19:24 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:3602 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S274851AbRJAKTG>; Mon, 1 Oct 2001 06:19:06 -0400
Date: Mon, 1 Oct 2001 12:19:31 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linus Torvalds <Torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: devinet.c 4.4BSD compatibility patch to ioctl SIOCGIF* for 2.4.10
Message-ID: <20011001121931.B15943@emma1.emma.line.org>
Mail-Followup-To: Linus Torvalds <Torvalds@transmeta.com>,
	"David S. Miller" <davem@redhat.com>,
	"netdev@oss.sgi.com" <netdev@oss.sgi.com>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please apply this patch to 2.4.11-preX. It's been in -ac for
some revisions now, and no-one has screamed or claimed it broke
anything. It's unchanged from my 2.4.9 version, it applies cleanly
against 2.4.10, so I'm resubmitting.

The patch is also available from
http://home.pages.de/~mandree/linux/kernel/2.4/

Best regards,
Matthias Andree

------------------------------------------------------------------------------

This is the second edition of my SIOCGIF* compatibility patch, against
Linux 2.4.9. In contrast to the first edition, it only does the "search
passed-in address" logic for SIOCGIFADDR, DSTADDR, BRDADDR and NETMASK
ioctls as suggested by Alexey Kuznetsov. It keeps the "only do this if
we got AF_INET" property.

This patch allows the aforementioned ioctls to return the proper values
for an interface that has multiple addresses with the same label, as
configured by:

ip addr 192.168.0.1/24 dev eth0
ip addr 172.16.15.14/16 dev eth0

Note that SIOCGIFCONF returns all these IP aliases, which confuses
applications that feed the data obtained from SIOCGIFCONF back into
SIOCGIFNETMASK, but do not validate the address via SIOCGIFADDR.

4.4BSD applications pass in the interface address alongside the
interface name to select the alias.

Remember, this patch falls back to interface-only match (return the
"primary" address) if at least one of these conditions is true:

- the address family is not AF_INET
- no interface alias has the address passed in

--- linux-2.4.9-f/net/ipv4/devinet.c.orig	Wed May 16 19:21:45 2001
+++ linux-2.4.9-f/net/ipv4/devinet.c	Mon Sep 17 00:39:41 2001
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
@@ -463,6 +467,7 @@
 int devinet_ioctl(unsigned int cmd, void *arg)
 {
 	struct ifreq ifr;
+	struct sockaddr_in sin_orig;
 	struct sockaddr_in *sin = (struct sockaddr_in *)&ifr.ifr_addr;
 	struct in_device *in_dev;
 	struct in_ifaddr **ifap = NULL;
@@ -470,6 +475,7 @@
 	struct net_device *dev;
 	char *colon;
 	int ret = 0;
+	int tryaddrmatch = 0;
 
 	/*
 	 *	Fetch the caller's info block into kernel space
@@ -479,6 +485,9 @@
 		return -EFAULT;
 	ifr.ifr_name[IFNAMSIZ-1] = 0;
 
+	/* save original address for comparison */
+	memcpy(&sin_orig, sin, sizeof(*sin));
+
 	colon = strchr(ifr.ifr_name, ':');
 	if (colon)
 		*colon = 0;
@@ -496,6 +505,7 @@
 		   so that we do not impose a lock.
 		   One day we will be forced to put shlock here (I mean SMP)
 		 */
+		tryaddrmatch = (sin_orig.sin_family == AF_INET);
 		memset(sin, 0, sizeof(*sin));
 		sin->sin_family = AF_INET;
 		break;
@@ -529,9 +539,29 @@
 		*colon = ':';
 
 	if ((in_dev=__in_dev_get(dev)) != NULL) {
-		for (ifap=&in_dev->ifa_list; (ifa=*ifap) != NULL; ifap=&ifa->ifa_next)
-			if (strcmp(ifr.ifr_name, ifa->ifa_label) == 0)
-				break;
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
+		} else { /* tryaddrmatch */
+			ifa = NULL;
+		} /* if (tryaddrmatch) */
+		/* we didn't get a match, maybe the application is
+		   4.3BSD-style and passed in junk so we fall back to 
+		   comparing just the label */
+		if (ifa == NULL) {
+			for (ifap=&in_dev->ifa_list; (ifa=*ifap) != NULL; ifap=&ifa->ifa_next)
+				if (strcmp(ifr.ifr_name, ifa->ifa_label) == 0)
+					break;
+		}
 	}
 
 	if (ifa == NULL && cmd != SIOCSIFADDR && cmd != SIOCSIFFLAGS) {
