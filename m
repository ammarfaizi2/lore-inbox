Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVG0ChP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVG0ChP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 22:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVG0ChP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 22:37:15 -0400
Received: from waste.org ([216.27.176.166]:32491 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262001AbVG0ChJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 22:37:09 -0400
Date: Tue, 26 Jul 2005 19:36:37 -0700
From: Matt Mackall <mpm@selenic.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: bunk@stusta.de, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [2.6 patch] NETCONSOLE must depend on INET
Message-ID: <20050727023636.GP12006@waste.org>
References: <20050726232043.GB7425@waste.org> <20050726.163202.119887768.davem@davemloft.net> <20050726235824.GN12006@waste.org> <20050726.170349.10935659.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726.170349.10935659.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sch added to cc: as I think he's the effective pktgen maintainer]

On Tue, Jul 26, 2005 at 05:03:49PM -0700, David S. Miller wrote:
> From: Matt Mackall <mpm@selenic.com>
> Date: Tue, 26 Jul 2005 16:58:24 -0700
> 
> > On Tue, Jul 26, 2005 at 04:32:02PM -0700, David S. Miller wrote:
> > > More seriously, please submit a version of whatever you
> > > believe to be the more correct fix so it can be reviewed
> > > and integrated.
> > 
> > Do you have a preferred location to put this function or
> > shall I invent one?
> 
> I actually can't wait to see where you're going to
> to put a function that transforms "IPV4 addresses"
> from ascii other than some place protected by CONFIG_INET.
> :-)

# HG changeset patch
# User mpm@selenic.com
# Node ID 6cdd6f36d53678a016cfbf5ce667cbd91504d538
# Parent  75716ae25f9d87ee2a5ef7c4df2d8f86e0f3f762
Move in_aton from net/ipv4/utils.c to net/core/utils.c

Move in_aton to allow netpoll and pktgen to work without the rest of
the IPv4 stack. Fix whitespace and add comment for the odd placement.

Delete now-empty net/ipv4/utils.c

Re-enable netpoll/netconsole without CONFIG_INET

Signed-off-by: Matt Mackall <mpm@selenic.com>

diff -r 75716ae25f9d -r 6cdd6f36d536 drivers/net/Kconfig
--- a/drivers/net/Kconfig	Tue Jul 26 23:21:24 2005
+++ b/drivers/net/Kconfig	Wed Jul 27 02:31:24 2005
@@ -2544,7 +2544,7 @@
 
 config NETCONSOLE
 	tristate "Network console logging support (EXPERIMENTAL)"
-	depends on NETDEVICES && INET && EXPERIMENTAL
+	depends on NETDEVICES && EXPERIMENTAL
 	---help---
 	If you want to log kernel messages over the network, enable this.
 	See <file:Documentation/networking/netconsole.txt> for details.
diff -r 75716ae25f9d -r 6cdd6f36d536 net/core/utils.c
--- a/net/core/utils.c	Tue Jul 26 23:21:24 2005
+++ b/net/core/utils.c	Wed Jul 27 02:31:24 2005
@@ -23,9 +23,9 @@
 #include <linux/percpu.h>
 #include <linux/init.h>
 
+#include <asm/byteorder.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
-
 
 /*
   This is a maximally equidistributed combined Tausworthe generator
@@ -153,3 +153,38 @@
 EXPORT_SYMBOL(net_random);
 EXPORT_SYMBOL(net_ratelimit);
 EXPORT_SYMBOL(net_srandom);
+
+/*
+ * Convert an ASCII string to binary IP.
+ * This is outside of net/ipv4/ because various code that uses IP addresses
+ * is otherwise not dependent on the TCP/IP stack.
+ */
+
+__u32 in_aton(const char *str)
+{
+	unsigned long l;
+	unsigned int val;
+	int i;
+
+	l = 0;
+	for (i = 0; i < 4; i++)
+	{
+		l <<= 8;
+		if (*str != '\0')
+		{
+			val = 0;
+			while (*str != '\0' && *str != '.')
+			{
+				val *= 10;
+				val += *str - '0';
+				str++;
+			}
+			l |= val;
+			if (*str != '\0')
+				str++;
+		}
+	}
+	return(htonl(l));
+}
+
+EXPORT_SYMBOL(in_aton);
diff -r 75716ae25f9d -r 6cdd6f36d536 net/ipv4/Makefile
--- a/net/ipv4/Makefile	Tue Jul 26 23:21:24 2005
+++ b/net/ipv4/Makefile	Wed Jul 27 02:31:24 2005
@@ -2,7 +2,7 @@
 # Makefile for the Linux TCP/IP (INET) layer.
 #
 
-obj-y     := utils.o route.o inetpeer.o protocol.o \
+obj-y     := route.o inetpeer.o protocol.o \
 	     ip_input.o ip_fragment.o ip_forward.o ip_options.o \
 	     ip_output.o ip_sockglue.o \
 	     tcp.o tcp_input.o tcp_output.o tcp_timer.o tcp_ipv4.o \
diff -r 75716ae25f9d -r 6cdd6f36d536 net/ipv4/utils.c
--- a/net/ipv4/utils.c	Tue Jul 26 23:21:24 2005
+++ /dev/null	Wed Jul 27 02:31:24 2005
@@ -1,59 +0,0 @@
-/*
- * INET		An implementation of the TCP/IP protocol suite for the LINUX
- *		operating system.  INET is implemented using the  BSD Socket
- *		interface as the means of communication with the user level.
- *
- *		Various kernel-resident INET utility functions; mainly
- *		for format conversion and debugging output.
- *
- * Version:	$Id: utils.c,v 1.8 2000/10/03 07:29:01 anton Exp $
- *
- * Author:	Fred N. van Kempen, <waltje@uWalt.NL.Mugnet.ORG>
- *
- * Fixes:
- *		Alan Cox	:	verify_area check.
- *		Alan Cox	:	removed old debugging.
- *		Andi Kleen	:	add net_ratelimit()  
- *
- *		This program is free software; you can redistribute it and/or
- *		modify it under the terms of the GNU General Public License
- *		as published by the Free Software Foundation; either version
- *		2 of the License, or (at your option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <asm/byteorder.h>
-
-/*
- *	Convert an ASCII string to binary IP. 
- */
- 
-__u32 in_aton(const char *str)
-{
-	unsigned long l;
-	unsigned int val;
-	int i;
-
-	l = 0;
-	for (i = 0; i < 4; i++) 
-	{
-		l <<= 8;
-		if (*str != '\0') 
-		{
-			val = 0;
-			while (*str != '\0' && *str != '.') 
-			{
-				val *= 10;
-				val += *str - '0';
-				str++;
-			}
-			l |= val;
-			if (*str != '\0') 
-				str++;
-		}
-	}
-	return(htonl(l));
-}
-
-EXPORT_SYMBOL(in_aton);


-- 
Mathematics is the supreme nostalgia of our time.
