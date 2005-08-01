Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVHAXQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVHAXQp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 19:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVHAXQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 19:16:44 -0400
Received: from graphe.net ([209.204.138.32]:28381 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261318AbVHAXQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 19:16:44 -0400
Date: Mon, 1 Aug 2005 16:16:41 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Richard Purdie <rpurdie@rpsys.net>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <1122937261.7648.151.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0508011609140.9237@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org> 
 <1122860603.7626.32.camel@localhost.localdomain>  <Pine.LNX.4.62.0508010908530.3546@graphe.net>
  <1122926537.7648.105.camel@localhost.localdomain> 
 <Pine.LNX.4.62.0508011335090.7011@graphe.net>  <1122930474.7648.119.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011414480.7574@graphe.net>  <1122931637.7648.125.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011438010.7888@graphe.net>  <1122933133.7648.141.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011517300.8498@graphe.net> <1122937261.7648.151.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2005, Richard Purdie wrote:

> > +	update_mmu_cache(vma, address, entry);
> > +	lazy_mmu_prot_update(entry);
> > +#endif
> 
> This locks the system up after the "INIT: version 2.86 booting" message.
> SysRq still responds but that's about it.

Hmmm. this should have returned the behavior to normal. Ah. Need to use 
new_entry instead of entry. Try this (is there any way that I could get 
access to the sytem? I am on IRC (freenode.net nick o-o) or on skype).

Index: linux-2.6.13-rc4-mm1/mm/memory.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/mm/memory.c	2005-08-01 16:11:45.000000000 -0700
+++ linux-2.6.13-rc4-mm1/mm/memory.c	2005-08-01 16:15:35.000000000 -0700
@@ -2094,6 +2094,7 @@
 		entry = pte_mkdirty(entry);
 	}
 
+#ifdef CONFIG_ATOMIC_TABLE_OPS
 	/*
 	 * If the cmpxchg fails then another processor may have done
 	 * the changes for us. If not then another fault will bring
@@ -2106,6 +2107,11 @@
 	} else {
 		inc_page_state(cmpxchg_fail_flag_update);
 	}
+#else
+	ptep_set_access_flags(vma, address, pte, new_entry, write_access);
+	update_mmu_cache(vma, address, new_entry);
+	lazy_mmu_prot_update(new_entry);
+#endif
 
 	pte_unmap(pte);
 	page_table_atomic_stop(mm);
