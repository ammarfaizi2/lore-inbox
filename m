Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVCITrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVCITrS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVCITrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:47:07 -0500
Received: from [62.206.217.67] ([62.206.217.67]:45031 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262301AbVCITpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:45:49 -0500
Message-ID: <422F525F.90404@trash.net>
Date: Wed, 09 Mar 2005 20:45:35 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050106 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Tomt <andre@tomt.net>
CC: Michal Vanco <vanco@satro.sk>, linux-kernel@vger.kernel.org,
       Netdev <netdev@oss.sgi.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.11 on AMD64 traps
References: <200503081900.18686.vanco@satro.sk> <422DF07D.7010908@tomt.net>
In-Reply-To: <422DF07D.7010908@tomt.net>
Content-Type: multipart/mixed;
 boundary="------------050304030002040403080208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050304030002040403080208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> Michal Vanco wrote:
>>
>> I see this problem running 2.6.11 on dual AMD64:
>>
>> Running quagga routing daemon (ospf+bgp) and issuing "netstat -rn |wc 
>> -l" command
>> while quagga tries to load more than 154000 routes from its bgp 
>> neighbours causes this trap:

This patch should fix it. The crash is caused by stale pointers,
the pointers in fib_iter_state are not reloaded after seq->stop()
followed by seq->start(pos > 0).


--------------050304030002040403080208
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/09 20:41:46+01:00 kaber@coreworks.de 
#   [IPV4]: Fix crash while reading /proc/net/route caused by stale pointers
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
# net/ipv4/fib_hash.c
#   2005/03/09 20:41:37+01:00 kaber@coreworks.de +11 -1
#   [IPV4]: Fix crash while reading /proc/net/route caused by stale pointers
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
diff -Nru a/net/ipv4/fib_hash.c b/net/ipv4/fib_hash.c
--- a/net/ipv4/fib_hash.c	2005-03-09 20:43:55 +01:00
+++ b/net/ipv4/fib_hash.c	2005-03-09 20:43:55 +01:00
@@ -919,13 +919,23 @@
 	return fa;
 }
 
+static struct fib_alias *fib_get_idx(struct seq_file *seq, loff_t pos)
+{
+	struct fib_alias *fa = fib_get_first(seq);
+
+	if (fa)
+		while (pos && (fa = fib_get_next(seq)))
+			--pos;
+	return pos ? NULL : fa;
+}
+
 static void *fib_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	void *v = NULL;
 
 	read_lock(&fib_hash_lock);
 	if (ip_fib_main_table)
-		v = *pos ? fib_get_next(seq) : SEQ_START_TOKEN;
+		v = *pos ? fib_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 	return v;
 }
 

--------------050304030002040403080208--
