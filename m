Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUHJKp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUHJKp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUHJKpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:45:55 -0400
Received: from colin2.muc.de ([193.149.48.15]:12558 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264261AbUHJKps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:45:48 -0400
Date: 10 Aug 2004 12:45:47 +0200
Date: Tue, 10 Aug 2004 12:45:47 +0200
From: Andi Kleen <ak@muc.de>
To: Paul Jackson <pj@sgi.com>
Cc: bcasavan@sgi.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] get_nodes mask miscalculation
Message-ID: <20040810104547.GA59597@muc.de>
References: <2rr7U-5xT-11@gated-at.bofh.it> <m31xifu5pn.fsf@averell.firstfloor.org> <20040809222531.1d2d8d05.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809222531.1d2d8d05.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 10:25:31PM -0700, Paul Jackson wrote:
> While I'm here, the statement that only the highest zone is policied
> actually applies only to MPOL_BIND, right?  The comment that asserts

That is correct. I can add a comment.

>  1) Change the man page wording, for each of get_mempolicy(2), mbind(2),
>     and set_mempolicy(2), to boldly state:
> 
> 	Beware:
> 		Pass in a value of maxnode that is * one more * than the
> 		number of nodes represented in nodemask.  If for example,
> 		nodemask represents 64 nodes, numbered 0 to 63, pass in a
> 		value of 65 for maxnodes.

Yes, I will clarify the manpages.

I see no problem with hardcoding 8 bits per byte. 

> 
>  2) Review, test, fix, and apply as fixed the following patch.  For extra
>     credit, get rid of the hard coded 8, 32 and 64 values in the compat stuff,
>     visible in the patch below.  I compiled the patch, once, on an ia64.
>     Otherwise totally untested.
> 
>     This patch:
> 	a) Notes the situation in a prominent "==> Beware <==".
> 	b) Consistently decrements maxnode immediately on each system call
> 	   entry (where someone reading the code might best notice).
> 	c) Otherwise treats maxnode consistently within the code.
> 	d) Addresses the MPOL_BIND max policy only comment.
> 	e) Addresses the harcoded numbers 64 and 8 in copy_nodes_to_user().

Yes, the 64 should be addressed agreed. That came from a misguided
attempt by me to not require compat_* functions (by making the 32bit
and 64bit ABI be the same), but that didn't work out.

> 
>     Yes - it's ugly.  The time that will be lost by those who try to use
>     this interface directly will be ugly too.
> 
>  3) Could you propose a strategy for fixing this?  It might take a couple

The only way would be to allocate new system call slots for the 
two calls. But I'm not convinced it is worth it.

Sorry, but I don't want to break binary compatibility. 

If it was really that bad you should have complained earlier (the
code was out long enough for review), now it is too late.

> If
>    you have to tell me that SGI has to put in a workaround for a year, on
>    any machine with _exactly_ 2049 nodes, such as padding the user nodemask
>    up to 2050 nodes, I'm prepared to deal with that <grin>.

There are many more users of these calls than SGI. And most of them are
using libnuma, which you are proposing to break. 


-Andi
