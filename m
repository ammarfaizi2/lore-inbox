Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbVIURjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVIURjl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVIURjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:39:41 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:50333 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751297AbVIURjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:39:40 -0400
Message-ID: <43319AB5.8030103@engr.sgi.com>
Date: Wed, 21 Sep 2005 10:39:01 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, zh-tw, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Hugh Dickins <hugh@veritas.com>,
       Frank van Maarseveen <frankvm@frankvm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com> <43319111.1050803@engr.sgi.com> <Pine.LNX.4.62.0509211000470.10480@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0509211000470.10480@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 21 Sep 2005, Jay Lan wrote:
> 
> 
>>>5. Please add appropriate CONFIG, dummy macros etc., so that no time
>>>   is wasted on these updates in all the vanilla systems which have no
>>>   interest in them - but maybe Christoph already has that well in hand.
>>
>>It is used in enhanced system accounting. An obvious CONFIG would be
>>CONFIG_BSD_PROCESS_ACCT.
> 
> 
> Right. Make all the data fields and code dependent on an appropriate 
> CONFIG_XXX macro. We talked about that a couple of weeks ago as AFAIK.
> 
> I had a look at Frank's patch and it does not seem to touch the critical 
> paths. Jay: Can you verify that the changes do not affect critical paths 
> and that accounting is still working in the right way?

Frank's patch looks fine to me except one place:
diff -ru a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c	2005-09-21 11:07:40.000000000 +0200
+++ b/mm/mmap.c	2005-09-21 11:17:06.755572000 +0200
@@ -854,6 +854,7 @@
  		mm->stack_vm += pages;
  	if (flags & (VM_RESERVED|VM_IO))
  		mm->reserved_vm += pages;
+	update_mem_hiwater(mm);
  }
  #endif /* CONFIG_PROC_FS */

I have a question of adding this call here. 'update_mem_hiwater'
does nothing unless mm->total_vm or rss gets updated.
I do not see total_vm get updates in __vm_stat_account()?

- jay

