Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264175AbUDGVEV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264176AbUDGVEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:04:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:29883 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264175AbUDGVET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:04:19 -0400
Date: Wed, 7 Apr 2004 14:06:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Eggert <eggert@CS.UCLA.EDU>
Cc: adi@hexapodia.org, bug-coreutils@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
Message-Id: <20040407140628.72c4892e.akpm@osdl.org>
In-Reply-To: <87vfkbms7s.fsf@penguin.cs.ucla.edu>
References: <20040406220358.GE4828@hexapodia.org>
	<20040406173326.0fbb9d7a.akpm@osdl.org>
	<20040407173116.GB2814@hexapodia.org>
	<20040407111841.78ae0021.akpm@osdl.org>
	<87vfkbms7s.fsf@penguin.cs.ucla.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Eggert <eggert@CS.UCLA.EDU> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > In 2.6 we do the check at open() and fcntl() time.  In 2.4 we don't
> > fail until the actual I/O attempt.
> 
> This raises the issue of what "dd conv=direct" should do in 2.4
> kernels.  I propose that it should report an error and exit, when the
> write fails,

And when the read fails.

> since conv=direct can't be implemented.  The basic idea
> is that on systems that lack direct I/O, conv=direct should fail.

I think that's best.  It's a bit user-unfriendly, but a silent fallback is
misleading.

It might be acceptable to print a warning, then fall back.

> Another issue with this patch: in Solaris, direct I/O is done by
> invoking directio(DIRECTIO_ON); see
> <http://docs.sun.com/db/doc/816-0213/6m6ne37so?q=directio&a=view>.
> Is Solaris direct I/O a direct analog to Linux direct I/O, or are
> there subtle differences in semantics that should be made visible to
> the users of GNU "dd"?

solaris directio(DIRECTIO_ON) is a hint only.  If the system cannot perform
the uncached zerocopy then it will fall back to buffered IO.  Solaris will
perform direct-IO "when the application's buffer is aligned on a two-byte
(short) boundary, the offset into the file is on a device sector boundary,
and the size of the operation is a multiple of device sectors."


On Linux you set direct-io with open(O_DIRECT) or fcntl(F_SETFL, O_DIRECT).
If the filesystem doesn't support direct-io we will fail the open/fcntl
attempt up-front in 2.6 only.

If O_DIRECT was successfully set and the IO is not correctly aligned Linux
will fail the relevant I/O attempt.  Alignment requirements are:

2.4: page aligned on-disk and in-memory

2.6: device sector aligned on-disk and in-memory.

I'd recomment that dd use getpagesize() alignment on-disk and in-memory.
