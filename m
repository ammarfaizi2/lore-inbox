Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWEJTQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWEJTQj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 15:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWEJTQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 15:16:39 -0400
Received: from gold.veritas.com ([143.127.12.110]:11318 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750821AbWEJTQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 15:16:39 -0400
X-IronPort-AV: i="4.05,110,1146466800"; 
   d="scan'208"; a="59393866:sNHT29710868"
Date: Wed, 10 May 2006 16:17:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com, akpm@osdl.org,
       Andi Kleen <ak@suse.de>, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, hch@infradead.org
Subject: Re: [RFC] [PATCH 6/6] Kprobes: Remove breakpoints from the copied 
 pages
In-Reply-To: <20060510121750.GD12463@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0605101610300.17281@blonde.wat.veritas.com>
References: <20060509065455.GA11630@in.ibm.com> <20060509065917.GA22493@in.ibm.com>
 <20060509070106.GB22493@in.ibm.com> <20060509070508.GC22493@in.ibm.com>
 <20060509070911.GD22493@in.ibm.com> <20060509071204.GE22493@in.ibm.com>
 <20060509071523.GF22493@in.ibm.com> <Pine.LNX.4.64.0605091747050.10238@blonde.wat.veritas.com>
 <20060510121750.GD12463@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 May 2006 19:16:38.0808 (UTC) FILETIME=[431CB980:01C67466]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006, Prasanna S Panchamukhi wrote:
> 
> As Andi Kleen and Christoph suggested pagecache contention can be avoided
> using the COW approach.

Yes, COWing is fine, I've no pagecache qualms if you go that way.

> Some thoughts about COW implications AFAIK
> 1. Need to hookup mmap() to make a per process copy.
I don't understand.
> 2. Bring in the pages just to insert the probes.
They'll be faulted in to insert probes, yes.
> 3. All the text pages need to be in memory until process exits.
No, COWed pages can go out to swap.
> 4. Free up the per process text pages by hooking exit() and exec().
exit_mmap frees process pages on exit and exec.
> 5. Maskoff probes visible across fork(), by hooking fork().
Depends on what semantics you want across fork.

Perhaps I don't understand, but you seem to be overcomplicating it,
seeing VM (mm) problems which would be automatically handled for you.

Wouldn't you just use ptrace(2) to insert and remove your uprobes?
See access_process_vm in kernel/ptrace.c for what that would do.
It goes on to get_user_pages to do the faulting and COWing.

Hugh
