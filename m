Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbTH0Izy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 04:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263198AbTH0Izy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 04:55:54 -0400
Received: from holomorphy.com ([66.224.33.161]:60085 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263196AbTH0Izw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 04:55:52 -0400
Date: Wed, 27 Aug 2003 01:56:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-ID: <20030827085656.GZ4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
	linux-kernel@vger.kernel.org
References: <20030827051853.181C92C0C1@lists.samba.org> <Pine.LNX.4.44.0308270846580.2063-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308270846580.2063-100000@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 09:37:25AM +0100, Hugh Dickins wrote:
> But I disagree over move_to/from_swap_cache: nothing should
> be done there at all.  Once you have mapping,index in struct
> futex_q, it's irrelevant what tmpfs might be doing to the
> page->mapping,page->index of the unmapped page.
> I dare not think what locking may be necessary, to manage
> the switch from hashing by struct page * to hashing by
> swapper_space,index.

PG_locked and mapping->page_lock held for writing are needed to
switch in general AIUI; adding the vcache/futex locks into the mix
sounds like some deep hierarchy, especially since the page is
meant to go away in the middle of this process. move_to_swap_cache()
has mapping->page_lock held for writing, as is needed; PG_locked is
required to add_to_swap() and some other callers are from call chains
not checking BUG_ON(!PageLocked(page)) so it sounds as if things are
partly there, assuming vcache_lock/futex_lock stay at the bottom.

I think it's worth coming up with an answer to in order to remove
the DoS scenario and/or resource scalability limitations.


-- wli
