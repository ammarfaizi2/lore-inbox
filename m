Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWFOAQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWFOAQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 20:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWFOAQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 20:16:28 -0400
Received: from gw.openss7.com ([142.179.199.224]:2244 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S965051AbWFOAQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 20:16:28 -0400
Date: Wed, 14 Jun 2006 18:16:27 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
Message-ID: <20060614181627.B28144@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org
References: <E1Foqjw-00010e-Ln@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1Foqjw-00010e-Ln@candygram.thunk.org>; from tytso@mit.edu on Fri, Jun 09, 2006 at 07:50:08PM -0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore,

On Fri, 09 Jun 2006, Theodore Ts'o wrote:
> 1) Move i_blksize (optimal size for I/O, reported by the stat system
>    call).  Is there any reason why this needs to be per-inode, instead
>    of per-filesystem?
> 
> 2) Move i_blkbits (blocksize for doing direct I/O in bits) to struct
>    super.  Again, why is this per-inode?

Have you considered NFS?

> 3) Move i_pipe, i_bdev, and i_cdev into a union.  An inode cannot
>     simultaneously be a pipe, block device, and character device at the
>     same time.

A STREAMS-based FIFO is both a (named) pipe and a character device at the
same time.  I would prefer if you did not merge i_pipe with i_cdev for this
reason.  In the current GPL'ed out of tree STREAMS implementation, i_pipe
is used to point to the Stream head (as the normal v_str pointer in the UNIX
vnode).  STREAMS-based FIFOs are the only instance in STREAMS where it
ventures outside its own filesystem (specfs) and adjusts inodes from other
filesystems.  This is also true for Linux native FIFOs (named pipes) that
use the i_pipe pointer in the filesystem in which they are named instead of
creating inodes within the pipefs.

I suppose that the other two permutations are correct:

  - a block device inode cannot also be a character device inode
  - a block device inode cannot also be a pipe

so at least i_cdev and i_bdev could be merged, however, you will need some
way to determine which actual object was attached to the union to allow the
object reference to be dropped when the inode is cleaned.  It might be better
to leave that one alone too, as any flag or mode that might be used could get
munged by a filesystem during the inode lifecycle causing incorrect reference
counts, or worse, an attempt to free the object against the wrong cache.

No comment on the rest.

