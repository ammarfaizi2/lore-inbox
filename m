Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWFSU61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWFSU61 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWFSU60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:58:26 -0400
Received: from thunk.org ([69.25.196.29]:64472 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932328AbWFSU60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:58:26 -0400
Date: Mon, 19 Jun 2006 16:58:28 -0400
From: Theodore Tso <tytso@mit.edu>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 6/8] inode-diet: Move i_cindex from struct inode to struct file
Message-ID: <20060619205828.GA20362@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <20060619153110.075342000@candygram.thunk.org> <20060619193335.GL27946@ftp.linux.org.uk> <20060619193756.GM27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619193756.GM27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 08:37:56PM +0100, Al Viro wrote:
> > NAK.  Please, take it to the union into cdev part.
> 
> Explanation: the whole point of that sucker is to avoid i_rdev use
> in drivers, switching to i_cdev + i_cindex.  _Especially_ in open().
> There is a bunch of other drivers that would get cleaner from that,
> including a lot of tty code.

The problem is that we already have more stuff in the cdev union
(list_head's are *big*, especially on Opterons), so moving it there
doesn't actually save us anything.

Moving it into struct file however should be good enough clean up the
character devices drivers that you are concerned about, however.  They
are passed the struct file pointer in the file_operations->open call.
So we can clean up the tty code, et. al, by using file->f_cindex just
as easily.  

Furthermore, the inode->i_cindex isn't guaranteed to be valid until
the high-level vfs open code is called anyway, so you might as well
tell people to reference it from filp->f_cindex in the device driver's
open() routine.

Does that make sense?

						- Ted
