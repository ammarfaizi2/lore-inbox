Return-Path: <linux-kernel-owner+w=401wt.eu-S964941AbXADRW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbXADRW6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbXADRW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:22:58 -0500
Received: from smtp.osdl.org ([65.172.181.24]:37959 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964941AbXADRW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:22:57 -0500
Date: Thu, 4 Jan 2007 09:22:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/33] KVM: MMU: Cache shadow page tables
Message-Id: <20070104092226.91fa2dfe.akpm@osdl.org>
In-Reply-To: <459D21DD.5090506@qumranet.com>
References: <459D21DD.5090506@qumranet.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jan 2007 17:48:45 +0200
Avi Kivity <avi@qumranet.com> wrote:

> The current kvm shadow page table implementation does not cache shadow 
> page tables (except for global translations, used for kernel addresses) 
> across context switches.  This means that after a context switch, every 
> memory access will trap into the host.  After a while, the shadow page 
> tables will be rebuild, and the guest can proceed at native speed until 
> the next context switch.
> 
> The natural solution, then, is to cache shadow page tables across 
> context switches.  Unfortunately, this introduces a bucketload of problems:
> 
> - the guest does not notify the processor (and hence kvm) that it 
> modifies a page table entry if it has reason to believe that the 
> modification will be followed by a tlb flush.  It becomes necessary to 
> write-protect guest page tables so that we can use the page fault when 
> the access occurs as a notification.
> - write protecting the guest page tables means we need to keep track of 
> which ptes map those guest page table. We need to add reverse mapping 
> for all mapped writable guest pages.
> - when the guest does access the write-protected page, we need to allow 
> it to perform the write in some way.  We do that either by emulating the 
> write, or removing all shadow page tables for that page and allowing the 
> write to proceed, depending on circumstances.
> 
> This patchset implements the ideas above.  While a lot of tuning remains 
> to be done (for example, a sane page replacement algorithm), a guest 
> running with this patchset applied is much faster and more responsive 
> than with 2.6.20-rc3.  Some preliminary benchmarks are available in 
> http://article.gmane.org/gmane.comp.emulators.kvm.devel/661.
> 
> The patchset is bisectable compile-wise.

Is this intended for 2.6.20, or would you prefer that we release what we
have now and hold this off for 2.6.21?
