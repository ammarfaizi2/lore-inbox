Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSGVGOb>; Mon, 22 Jul 2002 02:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSGVGOb>; Mon, 22 Jul 2002 02:14:31 -0400
Received: from holomorphy.com ([66.224.33.161]:61313 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316408AbSGVGOb>;
	Mon, 22 Jul 2002 02:14:31 -0400
Date: Sun, 21 Jul 2002 23:17:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com,
       anton@samba.org
Subject: Re: pte_chain_mempool-2.5.27-1
Message-ID: <20020722061732.GD919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, riel@surriel.com, anton@samba.org
References: <20020721035513.GD6899@holomorphy.com> <3D3BA131.34D2BD86@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D3BA131.34D2BD86@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2002 at 11:07:45PM -0700, Andrew Morton wrote:
> mempool?  Guess so.
> mempool is really designed for things like IO request structures.
> BIOs, etc.  Things which are guaranteed to have short lifecycles.
> Things which make the "wait for some objects to be freed" loop
> in mempool_alloc() reliable.

My usage of it was incorrect. Slab allocation alone will have to do.


On Sun, Jul 21, 2002 at 11:07:45PM -0700, Andrew Morton wrote:
> Be aware that mempool kmallocs a contiguous chunk of element
> pointers.  This statement is asking for a
> kmalloc(16384 * sizeof(void *)), which is 128k. It will work,
> but only just.
> How did you engineer the size of this pool, btw?  In the
> radix_tree code, we made the pool enormous.  It was effectively
> halved in size when the ratnodes went to 64 slots, but I still
> have the fun task of working out what the pool size should really
> be.  In retrospect it would have been smarter to make it really
> small and then increase it later in response to tester feedback.
> Suggest you do that here.

Any contiguous allocation that large is a bug. There was no engineering.
It was a "conservative guess", and hence even worse than the radix tree
node pool sizing early on. Removing mempool from it entirely is the best
option. pte_chains aren't transient enough to work with this, and my
misreading of mempool led me to believe it had the logic to deal with
the cases you described above.

OOM handling is on the way soon anyway, so mempool for "extra
reliability" will be a non-issue then.


Cheers,
Bill
