Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030457AbVLHEx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030457AbVLHEx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 23:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbVLHEx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 23:53:56 -0500
Received: from pat.uio.no ([129.240.130.16]:7145 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030457AbVLHEx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 23:53:56 -0500
Subject: Re: nfs question - ftruncate vs pwrite
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: Peter Staubach <staubach@redhat.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051207215040.15310.qmail@web34106.mail.mud.yahoo.com>
References: <20051207215040.15310.qmail@web34106.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 23:53:28 -0500
Message-Id: <1134017608.8002.55.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.002, required 12,
	autolearn=disabled, AWL 1.81, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 13:50 -0800, Kenny Simpson wrote:
> --- Peter Staubach <staubach@redhat.com> wrote:
> > You might use tcpdump or etherreal to see what the different traffic looks
> > like.  I suspect that ftruncate() leads a SETATTR operation while pwrite()
> > leads to a WRITE operation.
> 
> Ethereal results interpreted with wild speculation:
> The pwrite case:
>   This does a bunch of reads, but the server always returns a short read responding with EOF.  It
> seems that a pwrite does cause a getattr call, but that's it.
>   Once memory is exhausted, the pages are written out.
> 
> The ftruncate case:
>   This does a setattr, then does a read - this time the server responds with a large amount of
> 0's.

That is as expected. The ftruncate() causes an immediate change in
length of the file on the server, and so reads will. In the case of
pwrite(), that is cached on the client until you fsync/close, and so the
server returns short reads.

> Since this is using the buffer cache (not opened with O_DIRECT), and since we know we are
> extending the file... is it strictly necessary to read in pages of 0's from the server?

Possibly not, but is this a common case that is worth optimising for?
Note that use of the standard write() syscall as opposed to mmap() will
not trigger this avalanche of page-ins.

Cheers,
  Trond

