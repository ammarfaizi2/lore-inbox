Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVC1Ihr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVC1Ihr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 03:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVC1Ihr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 03:37:47 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:10502 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261354AbVC1Ihk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 03:37:40 -0500
Date: Mon, 28 Mar 2005 17:39:38 +0900 (JST)
Message-Id: <20050328.173938.26746686.yoshfuji@linux-ipv6.org>
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       from-linux-kernel@I-love.sakura.ne.jp, yoshfuji@linux-ipv6.org
Subject: Re: Off-by-one bug at unix_mkname ?
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20050328.172108.30349253.yoshfuji@linux-ipv6.org>
References: <200503281700.HHE91205.FtVLOStGOSPMYJFMN@I-love.sakura.ne.jp>
	<20050328.172108.30349253.yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050328.172108.30349253.yoshfuji@linux-ipv6.org> (at Mon, 28 Mar 2005 17:21:08 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:

> > It seems to me that the following code is off-by-one bug.
:
> Well, 2.2 has some comment on this:

So, I'd suggest to put the comment back to 2.4/2.6 instead.
(Note: net/socket.c refers this around MAX_SOCK_ADDR definition.)

Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

===== net/unix/af_unix.c 1.73 vs edited =====
--- 1.73/net/unix/af_unix.c	2005-03-10 13:42:53 +09:00
+++ edited/net/unix/af_unix.c	2005-03-28 17:31:33 +09:00
@@ -188,6 +188,15 @@
 	if (!sunaddr || sunaddr->sun_family != AF_UNIX)
 		return -EINVAL;
 	if (sunaddr->sun_path[0]) {
+		/*
+		 *	This may look like an off by one error but it is
+		 *	a bit more subtle. 108 is the longest valid AF_UNIX
+		 *	path for a binding. sun_path[108] doesnt as such
+		 *	exist. However in kernel space we are guaranteed that
+		 *	it is a valid memory location in our kernel
+		 *	address buffer.
+		 */
+		if (len > sizeof(*sunaddr))
 		((char *)sunaddr)[len]=0;
 		len = strlen(sunaddr->sun_path)+1+sizeof(short);
 		return len;

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
