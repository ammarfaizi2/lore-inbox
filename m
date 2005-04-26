Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVDZPoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVDZPoo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVDZPnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:43:40 -0400
Received: from webmail.houseafrika.com ([12.162.17.52]:26130 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S261576AbVDZPmf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:42:35 -0400
Date: Tue, 26 Apr 2005 08:42:34 -0700
From: Libor Michalek <libor@topspin.com>
To: Roland Dreier <roland@topspin.com>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       timur.tabi@ammasso.com
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050426084234.A10366@topspin.com>
References: <20050425135401.65376ce0.akpm@osdl.org> <521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org> <426D6D68.6040504@ammasso.com> <20050425153256.3850ee0a.akpm@osdl.org> <52vf6atnn8.fsf@topspin.com> <20050425171145.2f0fd7f8.akpm@osdl.org> <52acnmtmh6.fsf@topspin.com> <20050425173757.1dbab90b.akpm@osdl.org> <52wtqpsgff.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <52wtqpsgff.fsf@topspin.com>; from roland@topspin.com on Tue, Apr 26, 2005 at 08:31:32AM -0700
X-OriginalArrivalTime: 26 Apr 2005 15:42:35.0062 (UTC) FILETIME=[91155D60:01C54A76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 08:31:32AM -0700, Roland Dreier wrote:
>     Andrew> umm, how about we
> 
>     Andrew> - force the special pages into a separate vma
> 
>     Andrew> - run get_user_pages() against it all
> 
>     Andrew> - use RLIMIT_MEMLOCK accounting to check whether the user
>     Andrew> is allowed to do this thing
> 
>     Andrew> - undo the RMLIMIT_MEMLOCK accounting in ->release
> 
>     Andrew> This will all interact with user-initiated mlock/munlock
>     Andrew> in messy ways. Maybe a new kernel-internal vma->vm_flag
>     Andrew> which works like VM_LOCKED but is unaffected by
>     Andrew> mlock/munlock activity is needed.
> 
>     Andrew> A bit of generalisation in do_mlock() should suit?
> 
> Yes, it seems that modifying do_mlock() to something like
> 
> 	int do_mlock(unsigned long start, size_t len,
> 		     unsigned int set, unsigned int clear)
> 
> and then exporting a function along the lines of
> 
> 	int do_mem_pin(unsigned long start, size_t len, int on)
> 
> that sets/clears (VM_LOCKED_KERNEL | VM_DONTCOPY) according to the on
> flag.

  Do you mean that the set/clear parameters to do_mlock() are the
actual flags which are set/cleared by the caller? Also, the issue
remains that the flags are not reference counted which is a problem
if you are dealing with overlapping memory region, or even if one
region ends and another begins on the same page. Since the desire is
to be able to pin any memory that a user can malloc this is a likely
scenario.

-Libor
