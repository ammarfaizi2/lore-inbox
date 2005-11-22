Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbVKVLJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbVKVLJR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 06:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVKVLJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 06:09:17 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:47886 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S964915AbVKVLJQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 06:09:16 -0500
Date: Tue, 22 Nov 2005 19:09:30 +0900 (JST)
Message-Id: <20051122.190930.02663054.yoshfuji@linux-ipv6.org>
To: hpplinuxml@0xdef.net, dccp@vger.kernel.org, acme@ghostprotocols.net
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] dccp sizeof correction
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20051122105130.GA25078@0xdef.net>
References: <20051122105130.GA25078@0xdef.net>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20051122105130.GA25078@0xdef.net> (at Tue, 22 Nov 2005 11:51:31 +0100), Hagen Paul Pfeifer <hpplinuxml@0xdef.net> says:

> Setsockopt in DCCP make the assumption that sizeof(int) is the same as
> sizeof(u32), that isn't correct at all. ;)

The patch is not correct.
I think we should use int for DCCP_SOCKOPT_SERVICE.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 8a6b2a9..f4299db 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -211,14 +211,21 @@ int dccp_ioctl(struct sock *sk, int cmd,
 	return -ENOIOCTLCMD;
 }
 
-static int dccp_setsockopt_service(struct sock *sk, const u32 service,
+static int dccp_setsockopt_service(struct sock *sk,
 				   char __user *optval, int optlen)
 {
+	u32 service;
 	struct dccp_sock *dp = dccp_sk(sk);
 	struct dccp_service_list *sl = NULL;
 
-	if (service == DCCP_SERVICE_INVALID_VALUE || 
-	    optlen > DCCP_SERVICE_LIST_MAX_LEN * sizeof(u32))
+	if (optlen < sizeof(u32) ||
+	    optlen > DCCP_SERCICE_LISR_MAX_LEN * sizeof(u32))
+		return -EINVAL;
+
+	if (get_user(service, (u32 __user *)optval))
+		return -EFAULT;
+
+	if (service == DCCP_SERVICE_INVALID_VALUE)
 		return -EINVAL;
 
 	if (optlen > sizeof(service)) {
@@ -256,14 +263,14 @@ int dccp_setsockopt(struct sock *sk, int
 	if (level != SOL_DCCP)
 		return ip_setsockopt(sk, level, optname, optval, optlen);
 
+	if (optname == DCCP_SOCKOPT_SERVICE)
+		return dccp_setsockopt_service(sk, optval, optlen);
+
 	if (optlen < sizeof(int))
 		return -EINVAL;
 
 	if (get_user(val, (int __user *)optval))
 		return -EFAULT;
-
-	if (optname == DCCP_SOCKOPT_SERVICE)
-		return dccp_setsockopt_service(sk, val, optval, optlen);
 
 	lock_sock(sk);
 	dp = dccp_sk(sk);

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
