Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVKSTa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVKSTa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 14:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVKSTa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 14:30:28 -0500
Received: from inet-tsb.toshiba.co.jp ([202.33.96.40]:60360 "EHLO
	inet-tsb.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S1750773AbVKSTa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 14:30:27 -0500
Date: Sun, 20 Nov 2005 04:30:18 +0900 (JST)
Message-Id: <200511191930.jAJJUJEv022269@toshiba.co.jp>
To: khc@pm.waw.pl
Cc: laforge@netfilter.org, netfilter-devel@lists.netfilter.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: build bug: ipt_CONNMARK.c: undefined reference to
 `need_ip_conntrack'
From: Yasuyuki KOZAKAI <yasuyuki.kozakai@toshiba.co.jp>
In-Reply-To: <m364qolfuv.fsf@defiant.localdomain>
References: <m364qolfuv.fsf@defiant.localdomain>
X-Mailer: Mew version 4.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Sun_Nov_20_04_30_18_2005_933)--"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Sun_Nov_20_04_30_18_2005_933)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 19 Nov 2005 18:14:32 +0100

>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> net/built-in.o(.init.text+0x1adb): In function `init':
> ipt_CONNMARK.c: undefined reference to `need_ip_conntrack'
> make[2]: *** [.tmp_vmlinux1] Error 1
> 
> Last merged Linus' git: b286e39207237e2f6929959372bf66d9a8d05a82
> (i.e., current 2.6.15rc1+).

Thanks for report. Could you check this patch ?

Signed-off-by: Yasuyuki Kozakai <yasuyuki.kozakai@toshiba.co.jp>

-- Yasuyuki Kozakai

----Next_Part(Sun_Nov_20_04_30_18_2005_933)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="kconfig.patch"

[NETFILTER] fixed dependencies between modules related with ip_conntrack

- IP_NF_CONNTRACK_MARK is bool and depends on only IP_NF_CONNTRACK which is
  tristate. If a variable depends on IP_NF_CONNTRACK_MARK and
  doesn't care about IP_NF_CONNTRACK, it can be y. This must be avoided.
- IP_NF_CT_ACCT has same problem.
- IP_NF_TARGET_CLUSTERIP also depends on IP_NF_MANGLE.

Signed-off-by: Yasuyuki Kozakai <yasuyuki.kozakai@toshiba.co.jp>

---
commit 99b60eb9f5dab5bc6e008e1ea0434cbcacb479e7
tree 14a745e19d569d6a122ba1464df55b03ba6b1f54
parent 777c88274354f764f9f0c42b403a63b1a1707ced
author Yasuyuki Kozakai <yasuyuki.kozakai@toshiba.co.jp> Sun, 20 Nov 2005 04:07:51 +0900
committer Yasuyuki Kozakai <yasuyuki.kozakai@toshiba.co.jp> Sun, 20 Nov 2005 04:07:51 +0900

 net/ipv4/netfilter/Kconfig |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
index 9d3c8b5..0bc0052 100644
--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -440,7 +440,7 @@ config IP_NF_MATCH_COMMENT
 config IP_NF_MATCH_CONNMARK
 	tristate  'Connection mark match support'
 	depends on IP_NF_IPTABLES
-	depends on IP_NF_CONNTRACK_MARK || (NF_CONNTRACK_MARK && NF_CONNTRACK_IPV4)
+	depends on (IP_NF_CONNTRACK && IP_NF_CONNTRACK_MARK) || (NF_CONNTRACK_MARK && NF_CONNTRACK_IPV4)
 	help
 	  This option adds a `connmark' match, which allows you to match the
 	  connection mark value previously set for the session by `CONNMARK'. 
@@ -452,7 +452,7 @@ config IP_NF_MATCH_CONNMARK
 config IP_NF_MATCH_CONNBYTES
 	tristate  'Connection byte/packet counter match support'
 	depends on IP_NF_IPTABLES
-	depends on IP_NF_CT_ACCT || (NF_CT_ACCT && NF_CONNTRACK_IPV4)
+	depends on (IP_NF_CONNTRACK && IP_NF_CT_ACCT) || (NF_CT_ACCT && NF_CONNTRACK_IPV4)
 	help
 	  This option adds a `connbytes' match, which allows you to match the
 	  number of bytes and/or packets for each direction within a connection.
@@ -767,7 +767,7 @@ config IP_NF_TARGET_TTL
 config IP_NF_TARGET_CONNMARK
 	tristate  'CONNMARK target support'
 	depends on IP_NF_MANGLE
-	depends on IP_NF_CONNTRACK_MARK || (NF_CONNTRACK_MARK && NF_CONNTRACK_IPV4)
+	depends on (IP_NF_CONNTRACK && IP_NF_CONNTRACK_MARK) || (NF_CONNTRACK_MARK && NF_CONNTRACK_IPV4)
 	help
 	  This option adds a `CONNMARK' target, which allows one to manipulate
 	  the connection mark value.  Similar to the MARK target, but
@@ -779,8 +779,8 @@ config IP_NF_TARGET_CONNMARK
 
 config IP_NF_TARGET_CLUSTERIP
 	tristate "CLUSTERIP target support (EXPERIMENTAL)"
-	depends on IP_NF_IPTABLES && EXPERIMENTAL
-	depends on IP_NF_CONNTRACK_MARK || (NF_CONNTRACK_MARK && NF_CONNTRACK_IPV4)
+	depends on IP_NF_MANGLE && EXPERIMENTAL
+	depends on (IP_NF_CONNTRACK && IP_NF_CONNTRACK_MARK) || (NF_CONNTRACK_MARK && NF_CONNTRACK_IPV4)
 	help
 	  The CLUSTERIP target allows you to build load-balancing clusters of
 	  network servers without having a dedicated load-balancing

----Next_Part(Sun_Nov_20_04_30_18_2005_933)----
