Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWJAWJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWJAWJA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 18:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWJAWI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 18:08:59 -0400
Received: from [198.99.130.12] ([198.99.130.12]:19692 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932433AbWJAWI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 18:08:58 -0400
Date: Sun, 1 Oct 2006 18:07:27 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 4/5] UML - Close file descriptor leaks
Message-ID: <20061001220727.GA5194@ccure.user-mode-linux.org>
References: <200609271757.k8RHvtNK005742@ccure.user-mode-linux.org> <200610011910.37805.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610011910.37805.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 07:10:37PM +0200, Blaisorblade wrote:
> NACK on the ubd driver part. It adds a bugs and does fix the one you found in
> the right point. ACK on the other hunk.
> 
> Now, Andrew, you can ignore what follows if you want:
> 
> Jeff, please explain me the exact ubd driver bug - I believe that the open 
> must be done there, that it is balanced by ubd_close(), and that the leak fix
> should be done differently. 

The code as it was was just wrong.  There was a call to ubd_open_dev
at the start and a matching ubd_close at the end.  So far, so good,
since ubd_close inverts ubd_open_dev.  However, neither manipulates
dev->count (this is done by ubd_open/ubd_release) and the call to
ubd_add_disk indirectly calls ubd_open, which, since dev->count is
still zero redoes the initialization, leaking the descriptor and
vmalloc space allocated by the first ubd_open_dev call.

The fix is simple - there is no need for ubd_add to call ubd_open_dev
or ubd_close (ubd_file_size doesn't require the device be opened), so
the calls can simply be deleted.  With the non-count-changing
device-opening call gone, the leaks just disappear.

There are multiple things wrong with the code, many of which are still
there, but I don't see this as being an argument against this change.
It eliminates some useless code, which is good from both a maintenance
and performance standpoint.  However, leaks aside, the main benefit of
this change is that eliminates the one call to ubd_open_dev outside of
ubd_open, and thus opening stuff on the host and allocating memory is
always inside a check of dev->open.

> I've done huge changes to the UBD driver and I'll
> send them you briefly for your tree (they work but they're not yet in a 
> perfect shape).

OK, just make sure you preserve (or add) this property.

> For what I can gather from your description and code, the leak you diagnosed 
> is a bug in ubd_open_dev(), and is valid for any call to it: 

No, the bug is doing the work of opening the device outside a check of
the device refcount.

> generally, if an
> _open function fails it should leave nothing to cleanup, and in particular 
> the corresponding _close should not be called (this is the implicit standard 
> I've seen in Linux). 

This is true - however the _open function was succeeding, so it's
irrelevant in this case.

> Btw, ubd_open_dev() and ubd_close() are matching functions, while ubd_close()
> does not match ubd_open(), so I renamed ubd_close -> ubd_close_dev.

Yes, this is one of the things wrong with the current code - the names
are messed up.

				Jeff
