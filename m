Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVBPMBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVBPMBv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 07:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVBPMBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 07:01:51 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:10260 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262008AbVBPMBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 07:01:49 -0500
Date: Wed, 16 Feb 2005 12:00:55 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Mauricio Lin <mauriciolin@gmail.com>
cc: "Richard F. Rebel" <rrebel@whenu.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: /proc/*/statm, exactly what does "shared" mean?
In-Reply-To: <3f250c710502160241222dce47@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0502161142240.17264@goblin.wat.veritas.com>
References: <1108161173.32711.41.camel@rebel.corp.whenu.com> 
    <Pine.LNX.4.61.0502121158190.18829@goblin.wat.veritas.com> 
    <1108219160.12693.184.camel@blue.obulous.org> 
    <Pine.LNX.4.61.0502121509170.19562@goblin.wat.veritas.com> 
    <3f250c710502160241222dce47@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2005, Mauricio Lin wrote:
> Well, for each vma it is checked how many pages are mapped to rss. So
> I have to check per page if it is allocated in physical memory. I know
> that this is a heavy function, but do you have any suggestion to
> improve this?  What do you mean "needs refactoring into pgd_range,
> pud_range, pmd_range, pte_range levels like 2.4's statm"? Could you
> give more details, please?

Just look at, say, linux-2.4.29/fs/proc/array.c proc_pid_statm:
which calls statm_pgd_range which calls statm_pmd_range which
calls statm_pte_range which scans along the array of ptes doing
the pte examination you're doing.  There are plenty of examples
in 2.6.11-rc mm/memory.c of how to do it with pud level too.

Whereas your way starts at the top and descends the tree each time
for every leaf, repeatedly mapping and unmapping the page table if
that pagetable is in highmem.  You took follow_page as your starting
point, which is good for a single pte, but inefficient for many.

Your function(s) will still be heavyweight, but somewhat faster.

Hugh
