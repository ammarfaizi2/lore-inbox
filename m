Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUIVARC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUIVARC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 20:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUIVARC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 20:17:02 -0400
Received: from [62.206.217.67] ([62.206.217.67]:16284 "EHLO gw.localnet")
	by vger.kernel.org with ESMTP id S266704AbUIVAQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 20:16:54 -0400
Message-ID: <4150C448.5040604@trash.net>
Date: Wed, 22 Sep 2004 02:16:08 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Ballarin <Ballarin.Marc@gmx.de>
CC: "David S. Miller" <davem@davemloft.net>, rusty@rustcorp.com.au,
       torvalds@osdl.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
References: <1095721742.5886.128.camel@bach> <20040921143613.2dc78e2f.Ballarin.Marc@gmx.de> <1095803902.1942.211.camel@bach> <20040922003646.3a84f4c5.Ballarin.Marc@gmx.de> <20040921153600.2e732ea6.davem@davemloft.net> <20040922013516.753044db.Ballarin.Marc@gmx.de>
In-Reply-To: <20040922013516.753044db.Ballarin.Marc@gmx.de>
Content-Type: multipart/mixed;
 boundary="------------040005030203070902060303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040005030203070902060303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marc Ballarin wrote:

>On Tue, 21 Sep 2004 15:36:00 -0700
>"David S. Miller" <davem@davemloft.net> wrote:
>
>  
>
>>You can't have ipchains and iptables loaded at the same time.
>>You must first manually unload iptables, then you can
>>successfully load the ipchains module.
>>    
>>
>
>Yes, I know, something seems strange here.
>  
>

Fixed by this patch. The conntrack protocols need ip_ct_log_invalid
which is defined in ip_conntrack_standalone, so ip_conntrack is
loaded automatically before ipchains. This patch moves it over to
ip_conntrack_core.

Dave, please apply on top of the other netfilter patches.

Regards
Patrick


--------------040005030203070902060303
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/22 02:04:02+02:00 kaber@coreworks.de 
#   {NETFILTER]: Move ip_ct_log_invalid to ip_conntrack_core.c
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
# net/ipv4/netfilter/ip_conntrack_standalone.c
#   2004/09/22 02:03:37+02:00 kaber@coreworks.de +0 -2
#   {NETFILTER]: Move ip_ct_log_invalid to ip_conntrack_core.c
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
# net/ipv4/netfilter/ip_conntrack_core.c
#   2004/09/22 02:03:37+02:00 kaber@coreworks.de +1 -0
#   {NETFILTER]: Move ip_ct_log_invalid to ip_conntrack_core.c
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
diff -Nru a/net/ipv4/netfilter/ip_conntrack_core.c b/net/ipv4/netfilter/ip_conntrack_core.c
--- a/net/ipv4/netfilter/ip_conntrack_core.c	2004-09-22 02:10:28 +02:00
+++ b/net/ipv4/netfilter/ip_conntrack_core.c	2004-09-22 02:10:28 +02:00
@@ -74,6 +74,7 @@
 static kmem_cache_t *ip_conntrack_cachep;
 static kmem_cache_t *ip_conntrack_expect_cachep;
 struct ip_conntrack ip_conntrack_untracked;
+unsigned int ip_ct_log_invalid;
 
 DEFINE_PER_CPU(struct ip_conntrack_stat, ip_conntrack_stat);
 
diff -Nru a/net/ipv4/netfilter/ip_conntrack_standalone.c b/net/ipv4/netfilter/ip_conntrack_standalone.c
--- a/net/ipv4/netfilter/ip_conntrack_standalone.c	2004-09-22 02:10:28 +02:00
+++ b/net/ipv4/netfilter/ip_conntrack_standalone.c	2004-09-22 02:10:28 +02:00
@@ -48,8 +48,6 @@
 extern atomic_t ip_conntrack_count;
 DECLARE_PER_CPU(struct ip_conntrack_stat, ip_conntrack_stat);
 
-unsigned int ip_ct_log_invalid = 0;
-
 static int kill_proto(const struct ip_conntrack *i, void *data)
 {
 	return (i->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.protonum == 

--------------040005030203070902060303--
