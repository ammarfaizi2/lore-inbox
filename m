Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965328AbWGJXju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965328AbWGJXju (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965331AbWGJXju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:39:50 -0400
Received: from thunk.org ([69.25.196.29]:36309 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S965328AbWGJXjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:39:49 -0400
Date: Mon, 10 Jul 2006 19:39:44 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: tty's use of file_list_lock and file_move
Message-ID: <20060710233944.GB30332@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jon Smirl <jonsmirl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com> <1152552806.27368.187.camel@localhost.localdomain> <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com> <1152554708.27368.202.camel@localhost.localdomain> <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 06:35:50PM -0400, Jon Smirl wrote:
> On 7/10/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >We hold file_list_lock because we have to find everyone using that tty
> >and hang up their instance of it, then flip the file operations not
> >because we need to protect against tty structs going away. It's needed
> >in order to walk the file list and protects against the file list itself
> >changing rather than the tty structs. It may well be possible to move
> >that to a tty layer private lock with care, but it would need care to
> >deal with VFS operations.
> 
> Assuming do_SAK has blocked anyone's ability to newly open the tty,
> why does it need to search every file handle in the system instead of
> just using tty->tty_files? tty->tty_files should contain a list of
> everyone who has the tty open. Is this global search needed because of
> duplicated handles?

When I wrote the do_SAK code about 12-13 years ago, tty->tty_files
didn't exist.  It should be safe to do this, but I'll echo Alan's
comment.  We really ought to implement revoke(2) at the VFS layer, and
then utilize to implement SAK and vhangup() functionality.

						- Ted
