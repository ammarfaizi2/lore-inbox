Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUHXIVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUHXIVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 04:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUHXIVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 04:21:37 -0400
Received: from [203.178.140.15] ([203.178.140.15]:48396 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S266758AbUHXIVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 04:21:22 -0400
Date: Tue, 24 Aug 2004 17:22:07 +0900 (JST)
Message-Id: <20040824.172207.109934952.yoshfuji@linux-ipv6.org>
To: davem@redhat.com, jgarzik@pobox.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: IPv6 oops on ifup in latest BK
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040823235123.71f18c04.davem@redhat.com>
References: <412ADB20.5000901@pobox.com>
	<20040823235123.71f18c04.davem@redhat.com>
Organization: USAGI Project
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

In article <20040823235123.71f18c04.davem@redhat.com> (at Mon, 23 Aug 2004 23:51:23 -0700), "David S. Miller" <davem@redhat.com> says:

> > Attached minicom.cap.txt gives the ksymoops output and dmesg output. 
> > Appears to die in ipv6_get_hoplimit.
> 
> Yoshifuji-san, it is rt6i_dev changes.  The problem is that
> ipv6_get_hoplimit() gets called with NULL dev.
:
> It is this piece of code in ip6_route_add():
> 
> 		if (dev && dev != &loopback_dev) {
> 
> It does not handle the case where dev == NULL correctly.
> Original code did do the right thing:
> 
> 		if (dev)
> 			dev_put(dev);
> 		dev = &loopback_dev;
> 		dev_hold(dev);

Good catch and spotting.  Please try this patch.
Thank you.

===== net/ipv6/route.c 1.88 vs edited =====
--- 1.88/net/ipv6/route.c	2004-08-17 11:25:06 +09:00
+++ edited/net/ipv6/route.c	2004-08-24 17:09:10 +09:00
@@ -820,9 +820,12 @@
 	 */
 	if ((rtmsg->rtmsg_flags&RTF_REJECT) ||
 	    (dev && (dev->flags&IFF_LOOPBACK) && !(addr_type&IPV6_ADDR_LOOPBACK))) {
-		if (dev && dev != &loopback_dev) {
-			dev_put(dev);
-			in6_dev_put(idev);
+		/* hold loopback dev/idev if we haven't done so. */
+		if (dev != &loopback_dev) {
+			if (dev) {
+				dev_put(dev);
+				in6_dev_put(idev);
+			}
 			dev = &loopback_dev;
 			dev_hold(dev);
 			idev = in6_dev_get(dev);


-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
