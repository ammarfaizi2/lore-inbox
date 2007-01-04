Return-Path: <linux-kernel-owner+w=401wt.eu-S932309AbXADPsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbXADPsr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbXADPsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:48:47 -0500
Received: from il.qumranet.com ([62.219.232.206]:34432 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932309AbXADPsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:48:47 -0500
Message-ID: <459D21DD.5090506@qumranet.com>
Date: Thu, 04 Jan 2007 17:48:45 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: kvm-devel <kvm-devel@lists.sourceforge.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 0/33] KVM: MMU: Cache shadow page tables
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current kvm shadow page table implementation does not cache shadow 
page tables (except for global translations, used for kernel addresses) 
across context switches.  This means that after a context switch, every 
memory access will trap into the host.  After a while, the shadow page 
tables will be rebuild, and the guest can proceed at native speed until 
the next context switch.

The natural solution, then, is to cache shadow page tables across 
context switches.  Unfortunately, this introduces a bucketload of problems:

- the guest does not notify the processor (and hence kvm) that it 
modifies a page table entry if it has reason to believe that the 
modification will be followed by a tlb flush.  It becomes necessary to 
write-protect guest page tables so that we can use the page fault when 
the access occurs as a notification.
- write protecting the guest page tables means we need to keep track of 
which ptes map those guest page table. We need to add reverse mapping 
for all mapped writable guest pages.
- when the guest does access the write-protected page, we need to allow 
it to perform the write in some way.  We do that either by emulating the 
write, or removing all shadow page tables for that page and allowing the 
write to proceed, depending on circumstances.

This patchset implements the ideas above.  While a lot of tuning remains 
to be done (for example, a sane page replacement algorithm), a guest 
running with this patchset applied is much faster and more responsive 
than with 2.6.20-rc3.  Some preliminary benchmarks are available in 
http://article.gmane.org/gmane.comp.emulators.kvm.devel/661.

The patchset is bisectable compile-wise.

-- 
error compiling committee.c: too many arguments to function

