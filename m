Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272247AbRIFRs5>; Thu, 6 Sep 2001 13:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272080AbRIFRsu>; Thu, 6 Sep 2001 13:48:50 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:54027 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S271582AbRIFRs3>; Thu, 6 Sep 2001 13:48:29 -0400
Date: Thu, 6 Sep 2001 19:48:46 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: kuznet@ms2.inr.ac.ru
Cc: Matthias Andree <matthias.andree@gmx.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernel.org, netdev@oss.sgi.com,
        Wietse Venema <wietse@porcupine.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010906194846.A743@maggie.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: kuznet@ms2.inr.ac.ru,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org, netdev@oss.sgi.com,
	Wietse Venema <wietse@porcupine.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20010906155920.B29583@maggie.dt.e-technik.uni-dortmund.de> <200109061554.TAA11031@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109061554.TAA11031@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Thu, Sep 06, 2001 at 19:54:43 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Sep 2001, kuznet@ms2.inr.ac.ru wrote:

> > What 4.3BSD do you refer to?
> 
> The most wide spread example is Linux. Is this not enough? :-)

Nah, if you argue with BSD, show real BSD. :-)

> > I "must"? Who says so? The ip reference says to use label for 2.0
> > compatibility, but other systems
> 
> You read manual and however did this. Cool. Do you not flout on me
> occasionally? :-)

No, the issue is being serious. I can do what I did, and I (personally)
don't get the idea that SIOCGIFNETMASK compatibility is properly
described  with "2.0 compatibility". 2.0 compatibility can mean anything
from "choke on SMP" to "does not compile with 2.95.2", "runs on Windows
2.0" but does not state anything about the ioctl SIOCGIFNETMASK API
whatsoever.

> > I don't get the compatibility reasons. An eth0 interface that has two
> 
> If you are going to continue to use legacy interface,
> each interface/alias must have ONE address. Period.

No. See below.

> The easiest way to prevent such problems is not to use "ip",
> but use ifconfig.

...or use the "label" option of ip. Linux has no "home" as SysV or BSD,
it pulls its behaviour from anywhere the maintainers like it, and turns
arbitrarily incompatible (from a portability point of view) this way.

> > How can one seriously expect a portable software to use SIOCGIFNETMASK
> 
> Using "ip" you have prepared configuration which is not portable by definition.
> Each portable application will fail on it.

Sure, because the interface is broken.

> > names for the subsequent addresses)? "Not at all"?
> 
> Not "at all". F.e. if you fill ifr_data with random bits
> and run the test on Solaris (which is also <4.4BSD, something grown
> of 4.2BSD) and SIOCGIFNETMASK _fails_ there, I can agree
> that adding this 4.4BSDism will not be disasterous.

Solaris 8 does not fail, and it does not care for passing in 85.85.85.85
as address (patch to inet_addr_local.c that I used to test below).
Solaris has "logical interfaces" with distinct (hme0:1) names. Linux has
not -> 4.4BSD behaviour.

We can have both worlds in the same API:
1. if the address family given in ifa_address is AF_INET, assume we have
a 4.4BSD (FreeBSD 4.x) application and search for name AND address.
2. if (1.) does not turn up an address, or the address family was not
AF_INET, fall back to 4.2BSD/Solaris behaviour and search for just the
name.

That way, applications that expect the 4.4BSD API can send in the alias
they want the netmask for, and if an application uses a 4.2BSD API and
passes junk in, it will get the proper information from the fallback.

To stop all that nonsense discussion and give a proof of concept (as
best evidence): this is my patch against 2.4.9, it fixes the issue while
retaining 4.3BSD compatibility, if you pass it junk, it will happily
return the netmask of the first address of that interface as it did
until now.

I did not invent a pointer to store in the inside loop so as to keep the
loop bodies quick and keep loop invariant code (AF_INET comparison) out,
before someone asks.

Constructive comments are welcome.  Flames are not.

--- net/ipv4/devinet.c.orig	Thu Sep  6 18:57:25 2001
+++ net/ipv4/devinet.c	Thu Sep  6 19:33:38 2001
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
@@ -479,6 +484,9 @@
 		return -EFAULT;
 	ifr.ifr_name[IFNAMSIZ-1] = 0;
 
+	/* save original address for comparison */
+	memcpy(&sin_orig, sin, sizeof(*sin));
+
 	colon = strchr(ifr.ifr_name, ':');
 	if (colon)
 		*colon = 0;
@@ -529,9 +537,24 @@
 		*colon = ':';
 
 	if ((in_dev=__in_dev_get(dev)) != NULL) {
-		for (ifap=&in_dev->ifa_list; (ifa=*ifap) != NULL; ifap=&ifa->ifa_next)
-			if (strcmp(ifr.ifr_name, ifa->ifa_label) == 0)
-				break;
+		/* compare label and address (4.4BSD style) first if we
+		   have an AF_INET address family in the request */
+		if (sin_orig.sin_family == AF_INET) {
+			for (ifap=&in_dev->ifa_list; (ifa=*ifap) != NULL; ifap=&ifa->ifa_next)
+				if ((strcmp(ifr.ifr_name, ifa->ifa_label) == 0)
+				    && sin_orig.sin_addr.s_addr == ifa->ifa_address)
+					break;
+		} else {
+			ifa = NULL;
+		}
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



This patch to Postfix' inet_addr_local.c showed that Solaris doesn't
care about junk passed, and to verify Linux still returns a mask if you
pass it junk.

*** inet_addr_local.c.orig      Thu Sep  6 18:06:20 2001
--- inet_addr_local.c   Thu Sep  6 18:12:26 2001
***************
*** 133,138 ****
--- 133,139 ----
                if (mask_list) {
                    ifr_mask = (struct ifreq *) mymalloc(IFREQ_SIZE(ifr));
                    memcpy((char *) ifr_mask, (char *) ifr, IFREQ_SIZE(ifr));
+                   memset((char *)&(((struct sockaddr_in *)&ifr_mask->ifr_addr)->sin_addr), 0x55, 4);
                    if (ioctl(sock, SIOCGIFNETMASK, ifr_mask) < 0)
                        msg_fatal("%s: ioctl SIOCGIFNETMASK: %m", myname);
                    addr = ((struct sockaddr_in *) & ifr_mask->ifr_addr)->sin_addr;



-- 
Matthias Andree
