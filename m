Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbULSWlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbULSWlG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 17:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbULSWlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 17:41:06 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:62107 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261346AbULSWlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 17:41:00 -0500
Message-ID: <14514245.1103496059334.JavaMail.tomcat@pne-ps4-sn2>
Date: Sun, 19 Dec 2004 23:40:59 +0100 (MET)
From: Voluspa <lista4@comhem.se>
Reply-To: lista4@comhem.se
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, mr@ramendik.ru, kernel@kolivas.org
Mime-Version: 1.0
Content-Type: text/plain;charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: CP Presentation Server
X-clientstamp: [213.64.150.229]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Found the first kernel version with the regression. It's linux-2.6.9-rc1

Perusing lkml from august there was a short thread about the oopses and loss 
of keyboard in X. Applying that information in a crude hack I was able to 
test the effected 2.6.9-rc1 and three -bk forward:

http://marc.theaimsgroup.com/?t=109357291300002&r=1&w=2

diff -Naur linux-2.6.9-rc1/net/sunrpc/svcauth_unix.c linux-2.6.9-rc1-debug/net/sunrpc/svcauth_unix.c
--- linux-2.6.9-rc1/net/sunrpc/svcauth_unix.c   2004-12-15 18:39:28.000000000 
+0100
+++ linux-2.6.9-rc1-debug/net/sunrpc/svcauth_unix.c     2004-12-19 19:01:
53.000000000 +0100
@@ -104,7 +104,6 @@
                if (test_bit(CACHE_VALID, &item->flags) &&
                    !test_bit(CACHE_NEGATIVE, &item->flags))
                        auth_domain_put(&im->m_client->h);
-               kfree(im->m_class);
                kfree(im);
        }
 }

I've since tested and retested for several hours on the different kernels. At one 
point I thought the usage of lapic=lapic made a difference, but it turned 
out to be a red herring.

2.6.8.1-bk2 is without doubt the last kernel to handle my testcase "properly". There 
are no freezes whatsoever and the swapping is finished within 1 minute and 
some seconds.

2.6.9-rc1 and forward all have the freezes. Swapping and readback takes from 
3 to 6 minutes. I can't find a pattern in the time differences.

What's left now is to find some repository which has the gargantuan 2.6.9-rc1 
broken out in its pieces (and I guess 2.6.8.1-bk1 and 2 must be subtracted 
from that). Then reverting patches. A process where I'd need some handholding 
as to what would be likely candidates.

An innocent one is Ingo's "context-switching overhead in X, ioport()" patch. 
I added it to 2.6.8.1-bk2 and it didn't break my testcase.

Ah, well. It's that time of the year, so I won't be able to do any testing until 
the madness is over.

Mvh
Mats Johannesson

