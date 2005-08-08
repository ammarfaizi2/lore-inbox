Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVHHWMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVHHWMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVHHWMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:12:44 -0400
Received: from tim.rpsys.net ([194.106.48.114]:54960 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932263AbVHHWMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:12:43 -0400
Subject: Re: 2.6.13-rc3-mm3
From: Richard Purdie <rpurdie@rpsys.net>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0508080945100.19665@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	 <1122860603.7626.32.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508010908530.3546@graphe.net>
	 <1122926537.7648.105.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011335090.7011@graphe.net>
	 <1122930474.7648.119.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011414480.7574@graphe.net>
	 <1122931637.7648.125.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011438010.7888@graphe.net>
	 <1122933133.7648.141.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011517300.8498@graphe.net>
	 <1122937261.7648.151.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508031716001.24733@graphe.net>
	 <1123154825.8987.33.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508040703300.3277@graphe.net>
	 <1123166252.8987.50.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508050817060.28659@graphe.net>
	 <1123422275.7800.24.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508080945100.19665@graphe.net>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 23:12:31 +0100
Message-Id: <1123539152.7716.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've done a bit of analysis:

cmpxchg fail fault mm=c3945b20 vma=c304ad84 addr=402cb000 write=2048
ptep=c2af5b2c pmd=c2bc5008 entry=886c0f7 new=886c077 current=886c077

Note the Dirty bit is set on entry and not new where it probably should
be...

  ptep_cmpxchg(mm, address, pte, entry, new_entry)

This will compare "current"(886c077) with "entry"(886c0f7) which are not
equal and the whole thing therefore correctly fails leading to the loop.

The following patch (against -mm) cleared the problem up but I'm not
sure how correct it is:

Index: linux-2.6.12/mm/memory.c
===================================================================
--- linux-2.6.12.orig/mm/memory.c	2005-08-08 23:03:45.000000000 +0100
+++ linux-2.6.12/mm/memory.c	2005-08-08 23:04:02.000000000 +0100
@@ -2046,7 +2046,7 @@
 			return do_wp_page(mm, vma, address, pte, pmd, entry);
 #endif
 		}
-		entry = pte_mkdirty(entry);
+		new_entry = pte_mkdirty(entry);
 	}
 
 	/*


