Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbVCQAQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbVCQAQq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbVCQAOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:14:46 -0500
Received: from [62.206.217.67] ([62.206.217.67]:9360 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262893AbVCQANf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:13:35 -0500
Message-ID: <4238CBA8.1050807@trash.net>
Date: Thu, 17 Mar 2005 01:13:28 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050106 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: linux-kernel@vger.kernel.org, stable@kernel.org, shemminger@osdl.org,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       jmforbes@linuxtx.org, zwane@arm.linux.org.uk, cliffw@osdl.org,
       tytso@mit.edu, rddunlap@osdl.org
Subject: Re: [5/9] [TUN] Fix check for underflow
References: <20050316235502.GD5389@shell0.pdx.osdl.net>
In-Reply-To: <20050316235502.GD5389@shell0.pdx.osdl.net>
Content-Type: multipart/mixed;
 boundary="------------090302080202040206020001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090302080202040206020001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> 

I agree to both patches and additionally propose this one.
It fixes a crash when reading /proc/net/route (netstat -rn)
while routes are changed. I've seen two bugreports of users
beeing hit by this bug, one for 2.6.10, one for 2.6.11.

Regards
Patrick

--------------090302080202040206020001
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/10 18:20:44-08:00 kaber@trash.net 
#   [IPV4]: Fix crash while reading /proc/net/route caused by stale pointers
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# net/ipv4/fib_hash.c
#   2005/03/10 18:20:30-08:00 kaber@trash.net +11 -1
#   [IPV4]: Fix crash while reading /proc/net/route caused by stale pointers
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
diff -Nru a/net/ipv4/fib_hash.c b/net/ipv4/fib_hash.c
--- a/net/ipv4/fib_hash.c	2005-03-17 00:58:42 +01:00
+++ b/net/ipv4/fib_hash.c	2005-03-17 00:58:42 +01:00
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
 

--------------090302080202040206020001--
