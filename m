Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030458AbVLHFA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbVLHFA2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 00:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbVLHFA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 00:00:28 -0500
Received: from pat.uio.no ([129.240.130.16]:15599 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030458AbVLHFA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 00:00:27 -0500
Subject: Re: nfs question - ftruncate vs pwrite
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: Peter Staubach <staubach@redhat.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1134017608.8002.55.camel@lade.trondhjem.org>
References: <20051207215040.15310.qmail@web34106.mail.mud.yahoo.com>
	 <1134017608.8002.55.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 00:00:00 -0500
Message-Id: <1134018000.8002.58.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.971, required 12,
	autolearn=disabled, AWL 1.84, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 23:53 -0500, Trond Myklebust wrote:
> On Wed, 2005-12-07 at 13:50 -0800, Kenny Simpson wrote:
> > --- Peter Staubach <staubach@redhat.com> wrote:
> > > You might use tcpdump or etherreal to see what the different traffic looks
> > > like.  I suspect that ftruncate() leads a SETATTR operation while pwrite()
> > > leads to a WRITE operation.
> > 
> > Ethereal results interpreted with wild speculation:
> > The pwrite case:
> >   This does a bunch of reads, but the server always returns a short read responding with EOF.  It
> > seems that a pwrite does cause a getattr call, but that's it.
> >   Once memory is exhausted, the pages are written out.
> > 
> > The ftruncate case:
> >   This does a setattr, then does a read - this time the server responds with a large amount of
> > 0's.
> 
> That is as expected. The ftruncate() causes an immediate change in
> length of the file on the server, and so reads will.

...Err... 

...and so reads of the empty pages will succeed.

>  In the case of
> pwrite(), that is cached on the client until you fsync/close, and so the
> server returns short reads.
>
> > Since this is using the buffer cache (not opened with O_DIRECT), and since we know we are
> > extending the file... is it strictly necessary to read in pages of 0's from the server?
> 
> Possibly not, but is this a common case that is worth optimising for?
> Note that use of the standard write() syscall as opposed to mmap() will
> not trigger this avalanche of page-ins.
> 
> Cheers,
>   Trond
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

