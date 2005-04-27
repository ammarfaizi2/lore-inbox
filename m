Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVD0DP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVD0DP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 23:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVD0DP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 23:15:57 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:12661 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261896AbVD0DPs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 23:15:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RHNBmA6yl23DO0vXp8UbsPNQ4U9iEIDQ0IE0iGiKY8EE5ZErkoYfYaTUrozO3weplr+o7n9lP3NzqHMlmYEJVdH2NGFRfisMFAaioyyiodv6WAK17052Nlh2SE2rNKGVKLg0WMcoaFUUSkNk3i3LuZAlx7nhYFfovFoE+FH8Wl0=
Message-ID: <469958e00504262015772c9181@mail.gmail.com>
Date: Tue, 26 Apr 2005 20:15:46 -0700
From: Caitlin Bestler <caitlin.bestler@gmail.com>
Reply-To: Caitlin Bestler <caitlin.bestler@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Cc: Roland Dreier <roland@topspin.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       timur.tabi@ammasso.com
In-Reply-To: <20050426122850.44d06fa6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050425135401.65376ce0.akpm@osdl.org>
	 <20050425153256.3850ee0a.akpm@osdl.org> <52vf6atnn8.fsf@topspin.com>
	 <20050425171145.2f0fd7f8.akpm@osdl.org> <52acnmtmh6.fsf@topspin.com>
	 <20050425173757.1dbab90b.akpm@osdl.org> <52wtqpsgff.fsf@topspin.com>
	 <20050426084234.A10366@topspin.com> <52mzrlsflu.fsf@topspin.com>
	 <20050426122850.44d06fa6.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/05, Andrew Morton <akpm@osdl.org> wrote:
> Roland Dreier <roland@topspin.com> wrote:
> >
> >     Libor>   Do you mean that the set/clear parameters to do_mlock()
> >     Libor> are the actual flags which are set/cleared by the caller?
> >     Libor> Also, the issue remains that the flags are not reference
> >     Libor> counted which is a problem if you are dealing with
> >     Libor> overlapping memory region, or even if one region ends and
> >     Libor> another begins on the same page. Since the desire is to be
> >     Libor> able to pin any memory that a user can malloc this is a
> >     Libor> likely scenario.
> >
> > Good point... we need to figure out how to handle:
> >
> >     a) app registers 0x0000 through 0x17ff
> >     b) app registers 0x1800 through 0x2fff
> >     c) app unregisters 0x0000 through 0x17ff
> >     d) the page at 0x1000 must stay pinned
> 
> The userspace library should be able to track the tree and the overlaps,
> etc.  Things might become interesting when the memory is MAP_SHARED
> pagecache and multiple independent processes are involved, although I guess
> that'd work OK.
> 
> But afaict the problem wherein part of a page needs VM_DONTCOPY and the
> other part does not cannot be solved.
> 

Which portion of the userspace library? HCA-dependent code, or common code?

The HCA-dependent code would fail to count when the same memory was
registered to different HCAs (for example to the internal network device and
the external network device).

The vendor-independent code *could* do it, but only by maintaining a 
complete list of all registrations that had been issued but not cancelled.
That data would be redundant with data kept at the verb layer, and by
the kernel.

It *would' work, but maintaining highly redundant data at multiple layers
is something that I generally try to avoid.
