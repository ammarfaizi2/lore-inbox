Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262971AbVCQCxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbVCQCxL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 21:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262970AbVCQCxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 21:53:11 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:53521 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S262969AbVCQCxA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 21:53:00 -0500
Date: Thu, 17 Mar 2005 11:54:44 +0900 (JST)
Message-Id: <20050317.115444.31670680.yoshfuji@linux-ipv6.org>
To: davem@davemloft.net, juhl-lkml@dif.dk
Cc: kuznet@ms2.inr.ac.ru, davem@davemloft.net, pekkas@netcore.fi,
       netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] net, ipv6: remove redundant NULL checks before kfree
 in ip6_flowlabel.c
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.62.0503170027390.2558@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503170027390.2558@dragon.hyggekrogen.localhost>
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

In article <Pine.LNX.4.62.0503170027390.2558@dragon.hyggekrogen.localhost> (at Thu, 17 Mar 2005 00:36:35 +0100 (CET)), Jesper Juhl <juhl-lkml@dif.dk> says:

> I considered also rewriting the 
>         if (fl)
>                 fl_free(fl);
> bit as simply fl_free(fl) as well, but that if() potentially saves two 
> calls to kfree() inside fl_free as well as the call to fl_free itself, so 
> I guess that's worth the if().

I don't mind calling kfree twice itself (because that function is not
so performance critical), but fl_free(NULL) is out because
if fl is NULL, kfree(fl->opt) is out.

So, what do you think of checking fl inside fl_free like this?

We can even make fl_free inline and check as following:
  if (fl) {
    kfree(fl->opt);
    kfree(fl);
  }

Based on patch from Jesper Juhl <juhl-lkml@dif.dk>.

David?

Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

===== net/ipv6/ip6_flowlabel.c 1.18 vs edited =====
--- 1.18/net/ipv6/ip6_flowlabel.c	2005-01-14 13:41:06 +09:00
+++ edited/net/ipv6/ip6_flowlabel.c	2005-03-17 11:23:32 +09:00
@@ -87,7 +87,7 @@
 
 static void fl_free(struct ip6_flowlabel *fl)
 {
-	if (fl->opt)
+	if (fl)
 		kfree(fl->opt);
 	kfree(fl);
 }
@@ -351,8 +351,7 @@
 	return fl;
 
 done:
-	if (fl)
-		fl_free(fl);
+	fl_free(fl);
 	*err_p = err;
 	return NULL;
 }
@@ -551,10 +550,8 @@
 	}
 
 done:
-	if (fl)
-		fl_free(fl);
-	if (sfl1)
-		kfree(sfl1);
+	fl_free(fl);
+	kfree(sfl1);
 	return err;
 }
 

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
