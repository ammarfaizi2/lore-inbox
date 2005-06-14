Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVFNFOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVFNFOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 01:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbVFNFOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 01:14:11 -0400
Received: from web33307.mail.mud.yahoo.com ([68.142.206.122]:65126 "HELO
	web33307.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261160AbVFNFOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 01:14:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Q8iNE4WxxCXZBfl+0Q6O5ea31wVOt5GLRLwtNf1S8wyTs2HPXT98EIVSgSQ/nzStf2ddIclGh/H9mtNyypXDIHnGewWdC+szYxHnh2zTk5Yfm2d8CeMJ8MmaEMWW8S47P7rCaER+sisAc4DsEWI54i3qbfEONtDlv9SBcyp5A3E=  ;
Message-ID: <20050614051405.42342.qmail@web33307.mail.mud.yahoo.com>
Date: Mon, 13 Jun 2005 22:14:05 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: rmap.c: try_to_unmap_file(): VM_LOCKED not respected
To: linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My application is using remap_file_pages and mlocks
those pages.
So in the code of  try_to_unmap_file (see below),
I should never reach the call to try_to_unmap_cluster,
because for those pages VM_LOCKED is always set.
But, under heavy load I am seeing try_to_unmap_cluster
is getting called. Stack:
try_to_unmap_cluster
try_to_unmap_file
try_to_unmap
shrink_list
__pagevec_release
shrink_cache
shrink_zone
balance_pgdat
prepare_to_wait
kswapd


Any idea why VM_LOCKED is not being respected ?

   do {
 list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
                                                
shared.vm_set.list) {
     if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
              continue;
    cursor = (unsigned long) vma->vm_private_data;
while (vma->vm_mm->rss &&
cursor < max_nl_cursor &&                             
   cursor < vma->vm_end - vma->vm_start) {
                                
try_to_unmap_cluster(cursor, &mapcount, vma);
        cursor += CLUSTER_SIZE;
}
.....<snip>
   } while (max_nl_cursor <= max_nl_size);

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
