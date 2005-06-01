Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVFAUJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVFAUJO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 16:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVFAUJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:09:13 -0400
Received: from holomorphy.com ([66.93.40.71]:34769 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261163AbVFAUI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:08:57 -0400
Date: Wed, 1 Jun 2005 13:08:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap maximum size documented ?
Message-ID: <20050601200855.GQ20782@holomorphy.com>
References: <200506011225.j51CPDV23243@lastovo.hermes.si> <20050601124025.GZ422@unthought.net> <1117630718.6271.31.camel@laptopd505.fenrus.org> <loom.20050601T150142-941@post.gmane.org> <20050601134022.GM20782@holomorphy.com> <429E0843.5060505@tmr.com> <20050601192934.GP20782@holomorphy.com> <429E10B9.601@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429E10B9.601@tmr.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 03:47:05PM -0400, Bill Davidsen wrote:
>> mmap() is limited only by file offsets, which are fully 32-bit on
>> 32-bit systems. remap_file_pages() is limited by PTE_FILE_MAX_BITS,
>> which is fully 32-bit with CONFIG_HIGHMEM64G=y on i386 but only 29 bit
>> without it on i386. In general checking for PTE_FILE_MAX_BITS on the
>> relevant architecture should answer your question for remap_file_pages(),
>> and BITS_PER_LONG for mmap(). The swap limits for other architectures
>> will also differ and you generally have to look at the swp_entry/pte
>> encoding/decoding macros to decipher what the precise limits are
>> (though a quick hacky C program can help discover them for you).
>> Generally you get the filesizes by PAGE_SIZE << X_FILE_OFFSET_BITS.

The hacky C program. Note that some fiddling with compiler flags is
needed to get it to compile at all, and you probably need to have
done make oldconfig or similar to prep the kernel tree too. The answer
necessarily varies with your .config and it won't work cross-arch
except in the 32/64 -bit variant case (in which case it must be
compiled as the same kind of app [32/64] the kernel is expected to be).

The expressions for the swap limits were taken from sys_swapon().

This should remove all doubt, if any remain.


#include <linux/config.h>
#include <linux/swap.h>
#include <asm/pgtable.h>
#include <linux/swapops.h>

int printf(const char *, ...);

int main(void)
{
	unsigned long long type, offset;

	type = swp_type(pte_to_swp_entry(swp_entry_to_pte(swp_entry(~0UL,0))));
	offset = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0,~0UL)))) - 1;
	offset = (offset << PAGE_SHIFT) + ~PAGE_MASK;

	printf("max swapfiles = %Lu files\n", type);
	printf("max swapsize = %Lu B\n", offset);
	return 0;
}
