Return-Path: <linux-kernel-owner+w=401wt.eu-S964937AbWLMFEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWLMFEZ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 00:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbWLMFEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 00:04:24 -0500
Received: from gate.crashing.org ([63.228.1.57]:46331 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964937AbWLMFEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 00:04:24 -0500
X-Greylist: delayed 1575 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 00:04:23 EST
Subject: VM_RESERVED vs vm_normal_page()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 15:37:57 +1100
Message-Id: <1165984677.11914.159.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks !

What is the logic regarding VM_RESERVED, and more specifically, why is
vm_normal_page() nor returning NULL for these ?

I have struct pages that are a bit special for things like SPE mappings
on Cell and I'd like to avoid a lot of the stuff the VM tries to do on
them, like rmap accounting, etc... In fact, for almost everything, the
semantics I want are vm_normal_page() to return NULL... I have struct
pages because for now I need do_no_page() to work, but I must absolutely
avoid things like getting swapped out etc...

Thus I looked at the logic in vm_normal_page() and it really sucks...
this is pretty much a "heuristic" to differenciate remap_page_range from
copy_on_write stuff ... gack.

What is VM_RESERVED for then ? Could I just use that ? I currently only
have VM_IO set on my SPE VMAs but I could add it. The current
implementation of vm_normal_page() doesn't test for it though, maybe it
should ?

I have still a problem though, in the case vm_normal_page() is made to
return NULL...

In that case, unmapping of pages will still cause them to be released
(tlb_* -> free_pages_and_swap_cache -> release_pages ->
put_page_testzero) but if you fork(), copy_one_pte() will not call an
additional get_page() when vm_normal_page() returns NULL... thus I fear
the page count will become bocus accross forks...

In the long run, I want to stop using struct page's for the SPU
registers and local store, once Nick's new stuff gets in, though I might
have a go at hacking something together before... but in the meantime,
I'd like to figure out what is the _safe_ way of having a VMA containing
PTEs mapping to struct pages that are _not_ normal memory and thus
aren't to be swapped out, freed, or anything like that.

Cheers,
Ben. 

