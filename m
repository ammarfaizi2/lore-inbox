Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262878AbVCPXi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbVCPXi0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbVCPXh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:37:26 -0500
Received: from mail.dif.dk ([193.138.115.101]:24451 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262866AbVCPXfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:35:11 -0500
Date: Thu, 17 Mar 2005 00:36:35 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Pekka Savola <pekkas@netcore.fi>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] net, ipv6: remove redundant NULL checks before kfree in
 ip6_flowlabel.c
Message-ID: <Pine.LNX.4.62.0503170027390.2558@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kfree() has no problems dealing with NULL pointers, so wrapping checks for 
null round calls to it is redundant. This patch gets rid of two such 
checks in net/ipv6/ip6_flowlabel.c

I considered also rewriting the 
        if (fl)
                fl_free(fl);
bit as simply fl_free(fl) as well, but that if() potentially saves two 
calls to kfree() inside fl_free as well as the call to fl_free itself, so 
I guess that's worth the if().

Please consider applying.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.11-mm4-orig/net/ipv6/ip6_flowlabel.c linux-2.6.11-mm4/net/ipv6/ip6_flowlabel.c
--- linux-2.6.11-mm4-orig/net/ipv6/ip6_flowlabel.c	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.11-mm4/net/ipv6/ip6_flowlabel.c	2005-03-17 00:23:30.000000000 +0100
@@ -87,8 +87,7 @@ static struct ip6_flowlabel * fl_lookup(
 
 static void fl_free(struct ip6_flowlabel *fl)
 {
-	if (fl->opt)
-		kfree(fl->opt);
+	kfree(fl->opt);
 	kfree(fl);
 }
 
@@ -553,8 +552,7 @@ release:
 done:
 	if (fl)
 		fl_free(fl);
-	if (sfl1)
-		kfree(sfl1);
+	kfree(sfl1);
 	return err;
 }
 



-- 
Jesper Juhl

PS. Please CC me on replies from lists other than linux-kernel


