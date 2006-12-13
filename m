Return-Path: <linux-kernel-owner+w=401wt.eu-S932600AbWLMHaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbWLMHaj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 02:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbWLMHaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 02:30:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52752 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932600AbWLMHai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 02:30:38 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Yinghai Lu" <yinghai.lu@amd.com>
Cc: "Greg KH" <gregkh@suse.de>, "Peter Stuge" <stuge-linuxbios@cdy.org>,
       linux-usb-devel@lists.sourceforge.net,
       "Stefan Reinauer" <stepan@coresystems.de>, linux-kernel@vger.kernel.org,
       linuxbios@linuxbios.org, "Andi Kleen" <ak@suse.de>,
       "David Brownell" <david-b@pacbell.net>
Subject: Re: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port support.
References: <5986589C150B2F49A46483AC44C7BCA49072A5@ssvlexmb2.amd.com>
	<m17ix24ywj.fsf@ebiederm.dsl.xmission.com>
	<86802c440612080053s13e5318eq7ae83aff4c7eb21c@mail.gmail.com>
	<m1zm9y3gd2.fsf@ebiederm.dsl.xmission.com>
	<86802c440612122300k36e84f96x85ef25ebbf27077d@mail.gmail.com>
Date: Wed, 13 Dec 2006 00:29:49 -0700
In-Reply-To: <86802c440612122300k36e84f96x85ef25ebbf27077d@mail.gmail.com>
	(Yinghai Lu's message of "Tue, 12 Dec 2006 23:00:25 -0800")
Message-ID: <m164cgqmmq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yinghai Lu" <yinghai.lu@amd.com> writes:

> On 12/8/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Your or I missed a bug fix/enhancement in there somewhere.
>>
>
> I found the problem. the __set_fixmap need to __va, so the entries
> will be referred from PAGE_OFFSET.
>
> solution will be
> 1. move enable_dbgp_console from setup_early_printk, and call it from
> setup_arch after init_memory_mapping.
> 2. or make __set_fixmap can use __pa or pa()+__START_KERNEL_map in
> addtion to _va.

3.  Make __va always work.  I had this in my tree and I guess it didn't get
   into my big rollup patch.

Eric


x86_64: Fix the memory mapping in the early page table

diff --git a/arch/x86_64/kernel/head.S b/arch/x86_64/kernel/head.S
index 1e6f808..2f65469 100644
--- a/arch/x86_64/kernel/head.S
+++ b/arch/x86_64/kernel/head.S
@@ -328,9 +328,9 @@ ENTRY(wakeup_level4_pgt)
        .align PAGE_SIZE
 ENTRY(boot_level4_pgt)
        .quad   phys_level3_ident_pgt | 0x007
-       .fill   255,8,0
+       .fill   257,8,0
        .quad   phys_level3_physmem_pgt | 0x007
-       .fill   254,8,0
+       .fill   252,8,0
        /* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
        .quad   phys_level3_kernel_pgt | 0x007
 


