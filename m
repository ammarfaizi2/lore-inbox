Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVCPLBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVCPLBl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 06:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVCPLBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 06:01:41 -0500
Received: from dd3624.kasserver.com ([81.209.188.85]:44725 "EHLO
	dd3624.kasserver.com") by vger.kernel.org with ESMTP
	id S262367AbVCPLBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 06:01:39 -0500
From: <shenkel@gmail.com>
Message-ID: <16952.4619.28663.456755@gargle.gargle.HOWL>
Date: Wed, 16 Mar 2005 12:01:31 +0100
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix unaligned accesses in tcp_input_parse
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
X-Spam-Flag: NO
X-Spam-score: -1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

TCP options are not guaranteed to be aligned at all, so we should use
get_unaligned when accessing u16- or u32-values in the TCP
options header to avoid alignment errors on some platforms. The patch
applies to vanilla 2.6.11.

Ciao,
Sven

Signed-off-by: Sven Henkel <shenkel@gmail.com>

--- linux-2.6.11/net/ipv4/tcp_input.c.orig	2005-03-02 14:43:31.000000000 +0100
+++ linux-2.6.11/net/ipv4/tcp_input.c	2005-03-02 14:43:33.000000000 +0100
@@ -71,6 +71,7 @@
 #include <net/tcp.h>
 #include <net/inet_common.h>
 #include <linux/ipsec.h>
+#include <asm/unaligned.h>
 
 int sysctl_tcp_timestamps = 1;
 int sysctl_tcp_window_scaling = 1;
@@ -3007,7 +3008,7 @@ void tcp_parse_options(struct sk_buff *s
 	  			switch(opcode) {
 				case TCPOPT_MSS:
 					if(opsize==TCPOLEN_MSS && th->syn && !estab) {
-						u16 in_mss = ntohs(*(__u16 *)ptr);
+						u16 in_mss = ntohs(get_unaligned((__u16 *)ptr));
 						if (in_mss) {
 							if (opt_rx->user_mss && opt_rx->user_mss < in_mss)
 								in_mss = opt_rx->user_mss;
@@ -3034,8 +3035,8 @@ void tcp_parse_options(struct sk_buff *s
 						if ((estab && opt_rx->tstamp_ok) ||
 						    (!estab && sysctl_tcp_timestamps)) {
 							opt_rx->saw_tstamp = 1;
-							opt_rx->rcv_tsval = ntohl(*(__u32 *)ptr);
-							opt_rx->rcv_tsecr = ntohl(*(__u32 *)(ptr+4));
+							opt_rx->rcv_tsval = ntohl(get_unaligned((__u32 *)ptr));
+							opt_rx->rcv_tsecr = ntohl(get_unaligned((__u32 *)(ptr+4)));
 						}
 					}
 					break;

