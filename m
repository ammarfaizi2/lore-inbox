Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbTC0Uad>; Thu, 27 Mar 2003 15:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261331AbTC0Uad>; Thu, 27 Mar 2003 15:30:33 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44774 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261327AbTC0Ua3>; Thu, 27 Mar 2003 15:30:29 -0500
Date: Thu, 27 Mar 2003 21:41:37 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "David S. Miller" <davem@redhat.com>, laforge@netfilter.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [2.4 patch] fix multiple definitions of ipv6_ext_hdr
Message-ID: <20030327204136.GY24744@fs.tum.de>
References: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 09:08:42PM -0300, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.21-pre5 to v2.4.21-pre6
> ============================================
>...
> <laforge@netfilter.org>:
>...
>   o [NETFILTER]: Add new ip6tables matches
>...


#include <deja-vu.h>


<--  snip  -->

...
ld -m elf_i386  -r -o netfilter.o ip6_tables.o ip6t_limit.o ip6t_mark.o 
ip6t_length.o ip6t_mac.o ip6t_rt.o ip6t_hbh.o ip6t_dst.o ip6t_ipv6header.o 
ip6t_frag.o ip6t_esp.o ip6t_ah.o ip6t_eui64.o ip6t_multiport.o ip6t_owner.o 
ip6table_filter.o ip6table_mangle.o ip6t_MARK.o ip6_queue.o ip6t_LOG.o
ip6t_hbh.o(.text+0x0): In function `ipv6_ext_hdr':
: multiple definition of `ipv6_ext_hdr'
ip6t_rt.o(.text+0x0): first defined here
...
make[3]: *** [netfilter.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.21-pre6-full-nohotplug/net/ipv6/netfilter'

<--  snip  -->

My fix for this issue that went into 2.5.66 is below (it applies 
and compiles against 2.4.21-pre6, too).

Please apply
Adrian



--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_ah.c.old	2003-03-05 23:30:00.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_ah.c	2003-03-05 23:30:43.000000000 +0100
@@ -26,17 +26,6 @@
        __u32   spi;
 };
 
-int ipv6_ext_hdr(u8 nexthdr)
-{
-        return ( (nexthdr == NEXTHDR_HOP)       ||
-                 (nexthdr == NEXTHDR_ROUTING)   ||
-                 (nexthdr == NEXTHDR_FRAGMENT)  ||
-                 (nexthdr == NEXTHDR_AUTH)      ||
-                 (nexthdr == NEXTHDR_ESP)       ||
-                 (nexthdr == NEXTHDR_NONE)      ||
-                 (nexthdr == NEXTHDR_DEST) );
-}
-
 /* Returns 1 if the spi is matched by the range, 0 otherwise */
 static inline int
 spi_match(u_int32_t min, u_int32_t max, u_int32_t spi, int invert)
@@ -79,7 +68,7 @@
        len = skb->len - ptr;
        temp = 0;
 
-        while (ipv6_ext_hdr(nexthdr)) {
+        while (ip6t_ext_hdr(nexthdr)) {
                struct ipv6_opt_hdr *hdr;
 
               DEBUGP("ipv6_ah header iteration \n");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_dst.c.old	2003-03-05 23:30:44.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_dst.c	2003-03-05 23:31:01.000000000 +0100
@@ -29,17 +29,6 @@
 #define DEBUGP(format, args...)
 #endif
 
-int ipv6_ext_hdr(u8 nexthdr)
-{
-        return ( (nexthdr == NEXTHDR_HOP)       ||
-                 (nexthdr == NEXTHDR_ROUTING)   ||
-                 (nexthdr == NEXTHDR_FRAGMENT)  ||
-                 (nexthdr == NEXTHDR_AUTH)      ||
-                 (nexthdr == NEXTHDR_ESP)       ||
-                 (nexthdr == NEXTHDR_NONE)      ||
-                 (nexthdr == NEXTHDR_DEST) );
-}
-
 /*
  * (Type & 0xC0) >> 6
  * 	0	-> ignorable
@@ -84,7 +73,7 @@
        len = skb->len - ptr;
        temp = 0;
 
-        while (ipv6_ext_hdr(nexthdr)) {
+        while (ip6t_ext_hdr(nexthdr)) {
                struct ipv6_opt_hdr *hdr;
 
               DEBUGP("ipv6_opts header iteration \n");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_esp.c.old	2003-03-05 23:31:02.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_esp.c	2003-03-05 23:31:22.000000000 +0100
@@ -23,17 +23,6 @@
 	__u32   spi;
 };
 
-int ipv6_ext_hdr(u8 nexthdr)
-{
-        return ( (nexthdr == NEXTHDR_HOP)       ||
-                 (nexthdr == NEXTHDR_ROUTING)   ||
-                 (nexthdr == NEXTHDR_FRAGMENT)  ||
-                 (nexthdr == NEXTHDR_AUTH)      ||
-                 (nexthdr == NEXTHDR_ESP)       ||
-                 (nexthdr == NEXTHDR_NONE)      ||
-                 (nexthdr == NEXTHDR_DEST) );
-}
-
 /* Returns 1 if the spi is matched by the range, 0 otherwise */
 static inline int
 spi_match(u_int32_t min, u_int32_t max, u_int32_t spi, int invert)
@@ -74,7 +63,7 @@
 	len = skb->len - ptr;
 	temp = 0;
 
-        while (ipv6_ext_hdr(nexthdr)) {
+        while (ip6t_ext_hdr(nexthdr)) {
         	struct ipv6_opt_hdr *hdr;
         	int hdrlen;
 
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_frag.c.old	2003-03-05 23:31:23.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_frag.c	2003-03-05 23:31:45.000000000 +0100
@@ -44,17 +44,6 @@
        __u32   id;
 };
 
-int ipv6_ext_hdr(u8 nexthdr)
-{
-        return ( (nexthdr == NEXTHDR_HOP)       ||
-                 (nexthdr == NEXTHDR_ROUTING)   ||
-                 (nexthdr == NEXTHDR_FRAGMENT)  ||
-                 (nexthdr == NEXTHDR_AUTH)      ||
-                 (nexthdr == NEXTHDR_ESP)       ||
-                 (nexthdr == NEXTHDR_NONE)      ||
-                 (nexthdr == NEXTHDR_DEST) );
-}
-
 /* Returns 1 if the id is matched by the range, 0 otherwise */
 static inline int
 id_match(u_int32_t min, u_int32_t max, u_int32_t id, int invert)
@@ -93,7 +82,7 @@
        len = skb->len - ptr;
        temp = 0;
 
-        while (ipv6_ext_hdr(nexthdr)) {
+        while (ip6t_ext_hdr(nexthdr)) {
                struct ipv6_opt_hdr *hdr;
 
               DEBUGP("ipv6_frag header iteration \n");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_hbh.c.old	2003-03-05 23:31:45.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_hbh.c	2003-03-05 23:32:01.000000000 +0100
@@ -29,17 +29,6 @@
 #define DEBUGP(format, args...)
 #endif
 
-int ipv6_ext_hdr(u8 nexthdr)
-{
-        return ( (nexthdr == NEXTHDR_HOP)       ||
-                 (nexthdr == NEXTHDR_ROUTING)   ||
-                 (nexthdr == NEXTHDR_FRAGMENT)  ||
-                 (nexthdr == NEXTHDR_AUTH)      ||
-                 (nexthdr == NEXTHDR_ESP)       ||
-                 (nexthdr == NEXTHDR_NONE)      ||
-                 (nexthdr == NEXTHDR_DEST) );
-}
-
 /*
  * (Type & 0xC0) >> 6
  * 	0	-> ignorable
@@ -84,7 +73,7 @@
        len = skb->len - ptr;
        temp = 0;
 
-        while (ipv6_ext_hdr(nexthdr)) {
+        while (ip6t_ext_hdr(nexthdr)) {
                struct ipv6_opt_hdr *hdr;
 
               DEBUGP("ipv6_opts header iteration \n");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_ipv6header.c.old	2003-03-05 23:32:02.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_ipv6header.c	2003-03-05 23:32:26.000000000 +0100
@@ -24,17 +24,6 @@
 #define DEBUGP(format, args...)
 #endif
 
-int ipv6_ext_hdr(u8 nexthdr)
-{
-        return ( (nexthdr == NEXTHDR_HOP)       ||
-                 (nexthdr == NEXTHDR_ROUTING)   ||
-                 (nexthdr == NEXTHDR_FRAGMENT)  ||
-                 (nexthdr == NEXTHDR_AUTH)      ||
-                 (nexthdr == NEXTHDR_ESP)       ||
-                 (nexthdr == NEXTHDR_NONE)      ||
-                 (nexthdr == NEXTHDR_DEST) );
-}
-
 static int
 ipv6header_match(const struct sk_buff *skb,
 		 const struct net_device *in,
@@ -95,7 +84,7 @@
 
 	temp = 0;
 
-        while (ipv6_ext_hdr(nexthdr)) {
+        while (ip6t_ext_hdr(nexthdr)) {
         	struct ipv6_opt_hdr *hdr;
         	int hdrlen;
 
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_rt.c.old	2003-03-05 23:32:26.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_rt.c	2003-03-05 23:32:40.000000000 +0100
@@ -21,17 +21,6 @@
 #define DEBUGP(format, args...)
 #endif
 
-int ipv6_ext_hdr(u8 nexthdr)
-{
-        return ( (nexthdr == NEXTHDR_HOP)       ||
-                 (nexthdr == NEXTHDR_ROUTING)   ||
-                 (nexthdr == NEXTHDR_FRAGMENT)  ||
-                 (nexthdr == NEXTHDR_AUTH)      ||
-                 (nexthdr == NEXTHDR_ESP)       ||
-                 (nexthdr == NEXTHDR_NONE)      ||
-                 (nexthdr == NEXTHDR_DEST) );
-}
-
 /* Returns 1 if the id is matched by the range, 0 otherwise */
 static inline int
 segsleft_match(u_int32_t min, u_int32_t max, u_int32_t id, int invert)
@@ -71,7 +60,7 @@
        len = skb->len - ptr;
        temp = 0;
 
-        while (ipv6_ext_hdr(nexthdr)) {
+        while (ip6t_ext_hdr(nexthdr)) {
                struct ipv6_opt_hdr *hdr;
 
               DEBUGP("ipv6_rt header iteration \n");
--- linux-2.5.64-notfull/include/linux/netfilter_ipv6/ip6_tables.h.old	2003-03-05 23:36:49.000000000 +0100
+++ linux-2.5.64-notfull/include/linux/netfilter_ipv6/ip6_tables.h	2003-03-05 23:49:51.000000000 +0100
@@ -449,6 +449,9 @@
 				  struct ip6t_table *table,
 				  void *userdata);
 
+/* Check for an extension */
+extern int ip6t_ext_hdr(u8 nexthdr);
+
 #define IP6T_ALIGN(s) (((s) + (__alignof__(struct ip6t_entry)-1)) & ~(__alignof__(struct ip6t_entry)-1))
 
 #endif /*__KERNEL__*/

