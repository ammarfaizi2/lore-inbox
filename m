Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264314AbVBEGL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbVBEGL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 01:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264636AbVBEGLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 01:11:25 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:25754 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S264314AbVBEGLM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 01:11:12 -0500
Subject: [XFRM]: Probe selected algorithm only - 2.6.11-rc3 IPSEC problem
From: Andy <andy@globalnetit.com>
Reply-To: andy@globalnetit.com
To: herbert@gondor.apana.org.au
Cc: jmorris@redhat.com, davem@davemloft.net, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 05 Feb 2005 01:11:04 -0500
Message-Id: <1107583865.9597.357.camel@dell.tranquilitynj.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [70.21.154.229] at Sat, 5 Feb 2005 00:11:08 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.6.11-rc3 with Openswan, no IPSEC SA can be established. Kernel
logs "kernel: ESP: md5 digestsize 16 != 0" and netlink returns an error.

The changes to XFRM in 2.6.11-rc3 have an error in xfrm_algo.c such that
xfrm_aalg_get_byname() always returns digest_null (which would indeed
have a zero length digest...)

The problem is here:

$ diff -Naur net/xfrm/xfrm_algo.c*
--- net/xfrm/xfrm_algo.c        2005-02-04 18:05:53.000000000 -0500
+++ net/xfrm/xfrm_algo.c~       2005-02-04 08:08:16.000000000 -0500
@@ -357,7 +357,7 @@
                return NULL;
 
        for (i = 0; i < entries; i++) {
-               if (strcmp(name, list[i].name) != 0)
+               if (!strcmp(name, list[i].name))
                        continue;
 
                if (list[i].available)


where the sense of (!strcmp()) is reversed. It's easier to read by
explicitly comparing to zero, IMHO, as I did in this patch.



-- 
Andy <andy@globalnetit.com>

