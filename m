Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318031AbSHLNI7>; Mon, 12 Aug 2002 09:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318033AbSHLNI7>; Mon, 12 Aug 2002 09:08:59 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:39850 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S318031AbSHLNI4> convert rfc822-to-8bit; Mon, 12 Aug 2002 09:08:56 -0400
Date: Mon, 12 Aug 2002 15:12:40 +0200
Message-Id: <200208121312.g7CDCeX23523@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: Josef Siemes <jsiemes@web.de>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: jsiemes@web.de
Subject: PATCH: Multiple Nameservers with IP autoconfig
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I needed more than one nameserver with IP autoconfig from /proc/net/pnp, 
so I wrote this patch. I'm using this patch quite a while with 2.4.17 & 2.4.18, 
it also applies clean to 2.4.19. Please have a look at it, and if my copy&paste
didn't completely break it this should be ready for the main kernel tree.

Regards,

Josef Siemes

--- linux-2.4.19/net/ipv4/ipconfig.c    Sat Aug  3 02:39:46 2002
+++ linux-2.4.19-multidns/net/ipv4/ipconfig.c   Mon Aug 12 13:57:41 2002
@@ -26,6 +26,9 @@
  *
  *  Merged changes from 2.2.19 into 2.4.3
  *              -- Eric Biederman <ebiederman@lnxi.com>, 22 April Aug 2001
+ *
+ *  Multipe Nameservers in /proc/net/pnp
+ *              --  Josef Siemes <jsiemes@web.de>, Aug 2002
  */
 
 #include <linux/config.h>
@@ -90,6 +93,8 @@
 #define CONF_TIMEOUT_RANDOM    (HZ)    /* Maximum amount of randomization */
 #define CONF_TIMEOUT_MULT      *7/4    /* Rate of timeout growth */
 #define CONF_TIMEOUT_MAX       (HZ*30) /* Maximum allowed timeout */
+#define CONF_NAMESERVERS_MAX   3       /* Maximum number of nameservers  
+                                           - '3' from resolv.h */
 
 
 /*
@@ -131,7 +136,7 @@
 /* Persistent data: */
 
 int ic_proto_used;                     /* Protocol used, if any */
-u32 ic_nameserver = INADDR_NONE;       /* DNS Server IP address */
+u32 ic_nameservers[CONF_NAMESERVERS_MAX]; /* DNS Server IP addresses */
 u8 ic_domain[64];              /* DNS (not NIS) domain name */
 
 /*
@@ -624,6 +629,12 @@
  */
 static inline void ic_bootp_init(void)
 {
+       int i;
+
+       for (i=0;i<CONF_NAMESERVERS_MAX;i++)
+       {
+               ic_nameservers[i] = INADDR_NONE;
+       }       /* initialize DNS Server IP addresses */
        dev_add_pack(&bootp_packet_type);
 }
 
@@ -728,6 +739,9 @@
  */
 static void __init ic_do_bootp_ext(u8 *ext)
 {
+       u8 servers;
+       int i;
+
 #ifdef IPCONFIG_DEBUG
        u8 *c;
 
@@ -747,8 +761,14 @@
                                memcpy(&ic_gateway, ext+1, 4);
                        break;
                case 6:         /* DNS server */
-                       if (ic_nameserver == INADDR_NONE)
-                               memcpy(&ic_nameserver, ext+1, 4);
+                       servers= *ext/4;
+                       if (servers > CONF_NAMESERVERS_MAX)
+                               servers=CONF_NAMESERVERS_MAX;
+                       for (i=0;i<servers;i++)
+                       {
+                               if (ic_nameservers[i] == INADDR_NONE)
+                                       memcpy(&ic_nameservers[i], ext+1+4*i, 4);
+                       }
                        break;
                case 12:        /* Host name */
                        ic_bootp_string(system_utsname.nodename, ext+1, *ext, __NEW_UTS_LEN);
@@ -913,8 +933,8 @@
        ic_servaddr = b->server_ip;
        if (ic_gateway == INADDR_NONE && b->relay_ip)
                ic_gateway = b->relay_ip;
-       if (ic_nameserver == INADDR_NONE)
-               ic_nameserver = ic_servaddr;
+       if (ic_nameservers[0] == INADDR_NONE)
+               ic_nameservers[0] = ic_servaddr;
        ic_got_reply = IC_BOOTP;
 
 drop:
@@ -1077,6 +1097,7 @@
                        off_t offset, int length)
 {
        int len;
+       int i;
 
        if (ic_proto_used & IC_PROTO)
            sprintf(buffer, "#PROTO: %s\n",
@@ -1089,9 +1110,12 @@
        if (ic_domain[0])
                len += sprintf(buffer + len,
                               "domain %s\n", ic_domain);
-       if (ic_nameserver != INADDR_NONE)
-               len += sprintf(buffer + len,
-                              "nameserver %u.%u.%u.%u\n", NIPQUAD(ic_nameserver));
+       for (i=0;i<CONF_NAMESERVERS_MAX;i++)
+       {                          
+               if (ic_nameservers[i] != INADDR_NONE)
+                       len += sprintf(buffer + len,
+                                      "nameserver %s\n", in_ntoa(ic_nameservers[i]));
+       }
 
        if (offset > len)
                offset = len;

______________________________________________________________________________
WEB.DE Club - jetzt testen für 1 Euro! Nutzen Sie Ihre Chance 
unter https://digitaledienste.web.de/Club/formular/?mc=021105

