Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbVJ0GhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbVJ0GhJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 02:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbVJ0GhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 02:37:09 -0400
Received: from koto.vergenet.net ([210.128.90.7]:35506 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S932576AbVJ0GhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 02:37:08 -0400
Date: Thu, 27 Oct 2005 15:36:39 +0900
From: Horms <horms@verge.net.au>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [SECURITY,2.4,IPV6]: Fix infinite loop in udp_v6_get_port().
Message-ID: <20051027063637.GA5321@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cluestick: seven
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    [IPV6]: Fix infinite loop in udp_v6_get_port()
    
    This is CVE-2005-2973, and
    87bf9c97b4b3af8dec7b2b79cdfe7bfc0a0a03b2 in Linus' 2.6 Git Tree.
    It seems to be relevant to 2.4
    
    [IPV6]: Fix infinite loop in udp_v6_get_port()
    
    Original sign-off
    
    Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>
    
    Mine, indicating that I think it is relevant to 2.4
    
    Signed-off-by: Horms <horms@verge.net.au>

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 471180b..4395aa4 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -89,7 +89,7 @@ static int udp_v6_get_port(struct sock *
 		next:;
 		}
 		result = best;
-		for(;; result += UDP_HTABLE_SIZE) {
+		for(i = 0; i < (1 << 16) / UDP_HTABLE_SIZE; i++, result += UDP_HTABLE_SIZE) {
 			if (result > sysctl_local_port_range[1])
 				result = sysctl_local_port_range[0]
 					+ ((result - sysctl_local_port_range[0]) &
@@ -97,6 +97,8 @@ static int udp_v6_get_port(struct sock *
 			if (!udp_lport_inuse(result))
 				break;
 		}
+		if (i >= (1 << 16) / UDP_HTABLE_SIZE)
+			goto fail;
 gotit:
 		udp_port_rover = snum = result;
 	} else {
