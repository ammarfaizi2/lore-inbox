Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbUCIMcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 07:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbUCIMcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 07:32:19 -0500
Received: from holomorphy.com ([207.189.100.168]:50952 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261898AbUCIMcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 07:32:17 -0500
Date: Tue, 9 Mar 2004 04:32:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309123206.GN655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	andrea@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20040308202433.GA12612@dualathlon.random> <20040309105226.GA2863@elte.hu> <20040309110233.GA3819@elte.hu> <20040309030907.71a53a7c.akpm@osdl.org> <20040309114924.GA4581@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309114924.GA4581@elte.hu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org> wrote:
>> Do these tests actually make any forward progress at all, or is it
>> some bug which has sent the kernel into a loop?

On Tue, Mar 09, 2004 at 12:49:24PM +0100, Ingo Molnar wrote:
> i think they make a forward progress so it's more of a DoS - but a very
> effective one, especially considering that i didnt even try hard ...
> what worries me is that there are apps that generate such vma patterns
> (for various reasons).
> I do believe that scanning ->i_mmap & ->i_mmap_shared is fundamentally
> flawed.

Whatever's going on, this looks like objrmap will turn into a quagmire.
I was vaguely holding out for anobjrmap to come in and get rid of the
dependency of the pte_chain -based ptov resolution on struct page. So,
any ideas on how to kick pte_chains of the habit of shoving information
in pagetable nodes' struct pages or am I (worst case) stuck eating
grossly oversized pagetable nodes and horrific internal fragmentation
(<= 20% pagetable utilization with 4K already) no matter what?

I guess I could allocate an array of the things pte_chains want in
struct pages and attach it to ->private at allocation-time, but that's
even worse wrt. cache and space footprint than the current state of
affairs, worse still on 32-bit, and scales poorly to small PAGE_MMUCOUNT.
I guess ->lru and ->list may handle it up to 4, but that smells bad.

My second guess is that with PAGE_MMUCOUNT >= 2 and only using one
pte_chain entry per PAGE_MMUCOUNT aligned and contiguous ptes, it's
still a net space win to just put information directly beside the
(potentially physical) pte pointers in the pte_chains.

Do either of these sound desirable? Any other ideas?


-- wli
