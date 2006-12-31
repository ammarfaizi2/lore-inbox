Return-Path: <linux-kernel-owner+w=401wt.eu-S1030426AbWLaSk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWLaSk5 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 13:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbWLaSk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 13:40:57 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:54799 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030426AbWLaSk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 13:40:56 -0500
Date: Mon, 1 Jan 2007 03:39:49 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Denis Vlasenko <vda.linux@googlemail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
Message-ID: <20061231183949.GA8323@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Denis Vlasenko <vda.linux@googlemail.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain> <200612302149.35752.vda.linux@googlemail.com> <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain> <1167518748.20929.578.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612301750550.16519@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612301750550.16519@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2006 at 06:04:14PM -0500, Robert P. J. Day wrote:
> fair enough.  *technically*, not every call of the form
> "memset(ptr,0,PAGE_SIZE)" necessarily represents an address that's on
> a page boundary.  but, *realistically*, i'm guessing most of them do.
> just grabbing a random example from some grep output:
> 
> arch/sh/mm/init.c:
>   ...
>   /* clear the zero-page */
>   memset(empty_zero_page, 0, PAGE_SIZE);
>   ...
> 
The problem with random grepping is that it doesn't give you any context.
clear_page() isn't available in this case since we have a couple of
different ways of implementing it, and the optimal approach is selected
later on. There are also additional assumptions regarding alignment that
don't allow clear_page() to be used directly as replacement for the
memset() callsites (as has already been pointed out for some of the other
architectures). While the empty_zero_page in this case sits on a full page
boundary, others do not.

You might find some places in drivers that do this where you might be
able to optimize things slightly with a clear_page() (or copy_page() in
the memcpy() case), but it's going to need a lot of manual auditing
rather than a find and replace. Any sort of wins you get out of this
would be marginal at best, anyways.

The more interesting case would be page clustering/bulk page clearing
with offload engines, and there's certainly room to build on the SGI
patches for this.
