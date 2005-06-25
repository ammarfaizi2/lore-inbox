Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVFYC2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVFYC2a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 22:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbVFYC2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 22:28:30 -0400
Received: from cantor2.suse.de ([195.135.220.15]:63390 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261395AbVFYC2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 22:28:23 -0400
Date: Sat, 25 Jun 2005 04:28:12 +0200
From: Andi Kleen <ak@suse.de>
To: Stuart_Hayes@Dell.com
Cc: riel@redhat.com, ak@suse.de, andrea@suse.dk, linux-kernel@vger.kernel.org
Subject: Re: page allocation/attributes question (i386/x86_64 specific)
Message-ID: <20050625022811.GY14251@wotan.suse.de>
References: <7A8F92187EF7A249BF847F1BF4903C040AFD05@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7A8F92187EF7A249BF847F1BF4903C040AFD05@ausx2kmpc103.aus.amer.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 01:20:04PM -0500, Stuart_Hayes@Dell.com wrote:
> Rik Van Riel wrote:
> > On Wed, 22 Jun 2005 Stuart_Hayes@Dell.com wrote:
> > 
> >> My question is this:  when split_large_page() is called, should it
> >> make the other 511 PTEs inherit the page attributes from the large
> >> page (with the exception of PAGE_PSE, obviously)?
> > 
> > I suspect it should.
> 
> (Copying Andi Kleen & Andrea Arcangeli since they were involved in a
> previous discussion of this.  I'm trying to fix the NX handling when
> change_page_attr() is called in i386.)
> 
> After looking into it further, I agree completely.  I found a thread in
> which this was discussed
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=109964359124731&w=2),
> and discovered that this has been addressed in the X86_64 kernel.

You don't say which kernel you were working against. 2.6.11 has
some fixes in this area (in particular with the reference counts) 

> However, when I used "change_page_attr()" to change the page to
> PAGE_KERNEL, it did just that.  But PAGE_KERNEL has the _PAGE_NX bit set
> and isn't executable.  And, since PAGE_KERNEL (with _PAGE_NX set) didn't
> match the original pages attributes, the 512 PTEs weren't reverted back
> into a large page.  (Also, __change_page_attr() did *another* get_page()
> on the page containing these 512 PTEs, so now the page_count has gone up
> to 3, instead of going back down to 1 (or staying at 2).)

That should be already fixed.
> 
> Is the function that calls "change_page_attr()" expected to look at the
> attributes of the page before calling change_page_attr(), so it knows
> how to un-change the attributes when it is finished with the page (since
> PAGE_KERNEL isn't always what the page was originally)?

No, it's not supposed to do such checks on its own.

> 
> Or should "change_page_attr()" ignore the NX bit in the "pgprot_t prot"
> parameter that's passed to it, and just inherit NX from the
> large/existing page?  Then change_page_attr(page,PAGE_KERNEL) could be
> used to undo changes, but change_page_attr() couldn't be used to modify
> the NX bit.

I don't think that makes sense. It should exactly set the protection
the caller requested and revert when the protection is exactly like
it was before.

-Andi
