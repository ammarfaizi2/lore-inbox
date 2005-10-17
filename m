Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbVJQRZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbVJQRZz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVJQRZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:25:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26759 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751173AbVJQRZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:25:53 -0400
Date: Mon, 17 Oct 2005 10:25:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] libata: fix broken Kconfig setup
In-Reply-To: <4353DB2C.10905@pobox.com>
Message-ID: <Pine.LNX.4.64.0510171017010.3369@g5.osdl.org>
References: <20051017044606.GA1266@havoc.gtf.org> <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org>
 <4353C42A.3000005@pobox.com> <Pine.LNX.4.64.0510170848180.23590@g5.osdl.org>
 <4353CF7E.1090404@pobox.com> <Pine.LNX.4.64.0510170930420.23590@g5.osdl.org>
 <Pine.LNX.4.64.0510170946250.23590@g5.osdl.org> <4353DB2C.10905@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Jeff Garzik wrote:
> Linus Torvalds wrote:
>
> > Btw, if you want to have the _question_ always be y/n only, that's easy
> > enough to do, just make that one do
> > 
> > 	config SATA_MENU
> > 		bool "Want to see SATA drivers"
> > 		depends on SCSI != n
> > 
> > 	config SCSI_SATA
> > 		tristate
> > 		depends on SCSI && SATA_MENU
> > 		default y
> > 
> > and now you have a totally sensible setup, where the low-level drivers can
> > depend on something sane. 
> > I don't think it _buys_ you anything, but hey, at least it's logical. 
> 
> That's a reasonable solution.  I think it does buy you reduced user confusion.

The thing that worries me is that while the question may appear a bit more 
straightforward that way, I actually think it makes the end result _less_ 
so.

Let's say that I'm a clueless user, and I just don't realize that SATA 
depends on SCSI. After all, to a user, SATA sure as hell isn't SCSI, 
that's just an implementation detail inside the kernel.

So I've happened to say "m" to SCSI (for whatever reason - don't ask why 
users do strange things, but maybe I realize that USB storage needs it), 
and now I see the question for SATA. And I say "y".

And then I wonder why I can only select my sata drivers as modules. I 
didn't ask for SATA as a module, but they refuse to say "m".

Now, with SCSI_SATA as a straight M/n choice (or whatever), if I had SCSI 
as a module, at least I'll see at SATA selection time that I can only 
compile SATA drivers as modules. I might wonder at that time why, but I 
think it's less confusing there (and we could even mention it in the 
help-text).

I dunno. 

The _best_ choice as far as I can tell, is to just dis-associate SATA from 
SCSI entirely. Even if it's an implementation choice, we could make it a 
"select SCSI" instead of "depends on SCSI", so that from a _logical_ 
standpoint the user could just select SATA support without even knowing 
that the kernel happens to need the SCSI layer for it.

I think that's what USB storage ended up doing, exactly because it 
confused people too badly that they had to select SCSI in order to be able 
to say "I want USB disk supprt".

Of course, eventually I still hope that SATA could be done on the block 
layer instead of even depending on SCSI at all, but hey, that's a totally 
different issue.

			Linus
