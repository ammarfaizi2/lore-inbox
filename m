Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVCKUyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVCKUyd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVCKUvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:51:37 -0500
Received: from [62.206.217.67] ([62.206.217.67]:59355 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261626AbVCKUt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 15:49:58 -0500
Message-ID: <4232044E.8030001@trash.net>
Date: Fri, 11 Mar 2005 21:49:18 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050106 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: dtor_core@ameritech.net, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org
Subject: Re: Last night Linus bk - netfilter busted?
References: <200503110223.34461.dtor_core@ameritech.net>	<4231A498.4020101@trash.net> <20050311105136.2a5e4ddc.davem@davemloft.net>
In-Reply-To: <20050311105136.2a5e4ddc.davem@davemloft.net>
Content-Type: multipart/mixed;
 boundary="------------000409040102040404030604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000409040102040404030604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
> Damn, wait, Patrick, I think I know what's happening.  The iptables
> IPT_* verdicts are dependant upon the NF_* values, and they don't
> cope with Bart's changes I bet.  Can you figure out what the exact
> error would be?  This kind of issue would explain the looping inside
> of ipt_do_table(), wouldn't it?

You're right, good catch. IPT_RETURN is interpreted internally by
ip_tables, but since the value changed it isn't recognized by ip_tables
anymore and returned to nf_iterate() as NF_REPEAT. This patch restores
the old value.


--------------000409040102040404030604
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/11 21:41:01+01:00 kaber@coreworks.de 
#   [NETFILTER]: Fix iptables userspace compatibility breakage
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
# include/linux/netfilter_ipv6/ip6_tables.h
#   2005/03/11 21:40:52+01:00 kaber@coreworks.de +1 -1
#   [NETFILTER]: Fix iptables userspace compatibility breakage
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
# include/linux/netfilter_ipv4/ip_tables.h
#   2005/03/11 21:40:52+01:00 kaber@coreworks.de +1 -1
#   [NETFILTER]: Fix iptables userspace compatibility breakage
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
diff -Nru a/include/linux/netfilter_ipv4/ip_tables.h b/include/linux/netfilter_ipv4/ip_tables.h
--- a/include/linux/netfilter_ipv4/ip_tables.h	2005-03-11 21:41:32 +01:00
+++ b/include/linux/netfilter_ipv4/ip_tables.h	2005-03-11 21:41:32 +01:00
@@ -166,7 +166,7 @@
 #define IPT_CONTINUE 0xFFFFFFFF
 
 /* For standard target */
-#define IPT_RETURN (-NF_MAX_VERDICT - 1)
+#define IPT_RETURN (-NF_REPEAT - 1)
 
 /* TCP matching stuff */
 struct ipt_tcp
diff -Nru a/include/linux/netfilter_ipv6/ip6_tables.h b/include/linux/netfilter_ipv6/ip6_tables.h
--- a/include/linux/netfilter_ipv6/ip6_tables.h	2005-03-11 21:41:32 +01:00
+++ b/include/linux/netfilter_ipv6/ip6_tables.h	2005-03-11 21:41:32 +01:00
@@ -166,7 +166,7 @@
 #define IP6T_CONTINUE 0xFFFFFFFF
 
 /* For standard target */
-#define IP6T_RETURN (-NF_MAX_VERDICT - 1)
+#define IP6T_RETURN (-NF_REPEAT - 1)
 
 /* TCP matching stuff */
 struct ip6t_tcp

--------------000409040102040404030604--
