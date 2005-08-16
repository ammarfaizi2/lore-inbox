Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbVHPIq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbVHPIq5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 04:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbVHPIq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 04:46:57 -0400
Received: from koto.vergenet.net ([210.128.90.7]:44214 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S965148AbVHPIqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 04:46:54 -0400
Date: Tue, 16 Aug 2005 17:46:12 +0900
From: Horms <horms@debian.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alexander Pytlev <apytlev@tut.by>, linux-kernel@vger.kernel.org,
       debian-kernel@lists.debian.org,
       "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>,
       Willy Tarreau <willy@w.ods.org>
Subject: [PATCH] Bogus code in parsing of iocharset in isofs
Message-ID: <20050816084610.GB31717@debian.org>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Alexander Pytlev <apytlev@tut.by>, linux-kernel@vger.kernel.org,
	debian-kernel@lists.debian.org,
	"Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>,
	Willy Tarreau <willy@w.ods.org>
References: <1853917171.20050812104417@tut.by> <20050812082936.GB3302@verge.net.au> <20050816011121.GB7807@dmt.cnet> <20050816053121.GD11925@verge.net.au> <20050816083807.GA31717@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050816083807.GA31717@debian.org>
X-Cluestick: seven
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

this is a followup for the patch I sent earlier (like about 2 minutes
ago) regarding isofs options parsing. In the course of debuging this
Marcelo pointed out the following code

#ifdef CONFIG_JOLIET
                if (!strcmp(this_char,"iocharset") && value) {
                        popt->iocharset = value;
                        while (*value && *value != ',')
                                value++;
                        if (value == popt->iocharset)
                                return 0;
                        *value = 0;
                } else 
#endif              

On inspection it turns out that because of use of strtok(),
*value is already NULL terminated, and thus the code snippet
above is largely bogus. The following patch should remove the
bogus code without changing functionality.

Signed-off-by: Horms <horms@verge.net.au>

--- ../build-386/fs/isofs/inode.c	2005-08-03 14:46:33.000000000 +0900
+++ fs/isofs/inode.c	2005-08-16 17:23:04.000000000 +0900
@@ -324,12 +324,9 @@
 
 #ifdef CONFIG_JOLIET
 		if (!strcmp(this_char,"iocharset") && value) {
-			popt->iocharset = value;
-			while (*value && *value != ',')
-				value++;
-			if (value == popt->iocharset)
+			if (!value)
 				return 0;
-			*value = 0;
+			popt->iocharset = value;
 		} else
 #endif
 		if (!strcmp(this_char,"map") && value) {
