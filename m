Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVJSEi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVJSEi0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 00:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbVJSEi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 00:38:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13287 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750736AbVJSEiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 00:38:25 -0400
Date: Tue, 18 Oct 2005 21:37:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
Cc: andrew.j.wade@gmail.com, gfiala@s.netic.de, linux-kernel@vger.kernel.org
Subject: Re: large files unnecessary trashing filesystem cache?
Message-Id: <20051018213721.236b2107.akpm@osdl.org>
In-Reply-To: <200510182302.59604.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <200510182201.11241.gfiala@s.netic.de>
	<200510182302.59604.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew James Wade <andrew.j.wade@gmail.com> wrote:
>
> Sometimes you want a single file to take up most of the memory; databases
>  spring to mind. Perhaps files/processes that take up a large proportion of
>  memory should be penalized by preferentially reclaiming their pages, but
>  limit the aggressiveness so that they can still take up most of the memory
>  if sufficiently persistent (and the rest of the system isn't thrashing).

Yes.  Basically any smart heuristic we apply here will have failure modes. 
For example, the person whose application does repeated linear reads of the
first 100MB of a 4G file will get very upset.

So any such change really has to be opt-in.  Yes, it can be done quite
simply via repeated application of posix_fadvise().  But practically
speaking, it's very hard to get upstream GPL'ed applications changed, let
alone proprietary ones.

An obvious approach would be an LD_PRELOAD thingy which modifies read() and
write(), perhaps controlled via an environment variable.  AFAIK nobody has
even attempted this.

For a kernel-based solution you could take a look at my old 2.4-based
O_STREAMING patch.  It works OK, but it still needs modification of each
application (or an LD_PRELOAD hook into open()).

A decent kernel implementation would be to add a max_resident_pages to
struct file_struct and to use that to perform drop-behind within read() and
write().  That's a bit of arithmetic and a call to
invalidate_mapping_pages().  The userspace interface to that could be a
linux-specific extension to posix_fadvise() or to fcntl().

But that still requires that all the applications be modified.

So I'd also suggest a new resource limit which, if set, is copied into the
applications's file_structs on open().  So you then write a little wrapper
app which does setrlimit()+exec():

	limit-cache-usage -s 1000 my-fave-backup-program <args>

Which will cause every file which my-fave-backup-program reads or writes to
be limited to a maximum pagecache residency of 1000 kbytes.

This facility could trivially be used for a mini-DoS: shooting down other
people's pagecache so their apps run slowly.  But you can use fadvise() for
that already.


Or raise a patch against glibc's read() and write() which uses some
environment string to control fadvise-based invalidation.  That's pretty
simple.


