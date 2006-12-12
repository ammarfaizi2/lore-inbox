Return-Path: <linux-kernel-owner+w=401wt.eu-S932549AbWLLWr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbWLLWr6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbWLLWr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:47:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39798 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932549AbWLLWr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:47:57 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: mapping PCI registers with write combining (and PAT on x86)...
References: <adalklcu5w3.fsf@cisco.com>
Date: Tue, 12 Dec 2006 15:47:43 -0700
In-Reply-To: <adalklcu5w3.fsf@cisco.com> (Roland Dreier's message of "Tue, 12
	Dec 2006 14:05:32 -0800")
Message-ID: <m1irggrasw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rdreier@cisco.com> writes:

> Suppose that I would like to map some PIO registers (in a PCI BAR) to
> userspace, and I would like to enable write combining if possible.
>
> I have two problems.  First, there's no generic interface for
> requesting write combining if possible when doing
> io_remap_pfn_range().  Would it make sense to define
> pageprot_writecombine for all architectures (and make it fall back to
> doing non-cached access if write combining is not possible)?  And it
> seems that making pgprot_noncached() universal wouldn't hurt either.

So I think we may simplify this but there is pci_mmap_page_range.  That
already handles this for the architectures that currently support it.
So it is probably the case the fbdev should be changed to use that.

I am certainly in favor of simpler infrastructure like making
pgprot_writecombine and pgprot_uncached universal but I would like to
start with what works today.

Then we can go reexamine things like the ia64 slavishly trusting the
BIOS to know which page protections are good.

> Second, given the extreme shortage of MTRRs, it seems that write
> combining is not really possible in general on x86 without some
> interface to use PATs instead.  What is holding up something like Eric
> Biederman's patches from going in?

No one had any serious objections to my patches as they were.  The actual
problem was that the patches were incomplete.  In particular if you
mismatch page protections it is possible to get silent data corruption
or processor crashes.  So we need checks to ensure all mappings of
a given page are using the same protections.

To a certain extent I think adding those checks really is a strawman
and should not stop the merge effort, because we have this feature and
those possible bugs on other architectures right now and we don't have
those checks.  But I also think in the long term we need them, it just
requires several days of going through the mm so we don't leave any
path uncovered.

> Right now we end up with stuff like the absolutely hair-raising code
> in drivers/video/fbmem.c shown below.  I really would like to make
> progress towards having a better interface for doing this stuff, and
> I'm more than willing to work on getting something mergable.

I hope my comments help.

Eric
