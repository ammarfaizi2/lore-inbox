Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVHIA55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVHIA55 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 20:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVHIA55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 20:57:57 -0400
Received: from graphe.net ([209.204.138.32]:2993 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S932397AbVHIA55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 20:57:57 -0400
Date: Mon, 8 Aug 2005 17:57:48 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Richard Purdie <rpurdie@rpsys.net>
cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <1123539152.7716.25.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0508081753520.31697@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org> 
 <1122860603.7626.32.camel@localhost.localdomain>  <Pine.LNX.4.62.0508010908530.3546@graphe.net>
  <1122926537.7648.105.camel@localhost.localdomain> 
 <Pine.LNX.4.62.0508011335090.7011@graphe.net>  <1122930474.7648.119.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011414480.7574@graphe.net>  <1122931637.7648.125.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011438010.7888@graphe.net>  <1122933133.7648.141.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011517300.8498@graphe.net>  <1122937261.7648.151.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508031716001.24733@graphe.net>  <1123154825.8987.33.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508040703300.3277@graphe.net>  <1123166252.8987.50.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508050817060.28659@graphe.net>  <1123422275.7800.24.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508080945100.19665@graphe.net> <1123539152.7716.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, Richard Purdie wrote:

> The following patch (against -mm) cleared the problem up but I'm not
> sure how correct it is:

Almost. The new entry needs to be made dirty. new_entry is already made 
young. entry is not.

---

Set dirty bit correctly in handle_pte_fault

new_entry is used for the new pte entry. handle_mm_fault must dirty
new_entry and not "entry". entry is only used for comparison. The current
version does not set the dirty bit.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.13-rc4/mm/memory.c
===================================================================
--- linux-2.6.13-rc4.orig/mm/memory.c	2005-08-03 17:15:22.000000000 -0700
+++ linux-2.6.13-rc4/mm/memory.c	2005-08-08 17:54:53.000000000 -0700
@@ -2091,7 +2091,7 @@
 			return do_wp_page(mm, vma, address, pte, pmd, entry);
 #endif
 		}
-		entry = pte_mkdirty(entry);
+		new_entry = pte_mkdirty(new_entry);
 	}
 
 	/*
