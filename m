Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265617AbUBBNEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 08:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265635AbUBBNEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 08:04:52 -0500
Received: from thunk.org ([140.239.227.29]:5600 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265617AbUBBNEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 08:04:46 -0500
Date: Mon, 2 Feb 2004 08:04:37 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: duplicated inode numbers for different files?
Message-ID: <20040202130437.GA8196@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
References: <E1AnaaH-000HCr-00.arvidjaar-mail-ru@f16.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AnaaH-000HCr-00.arvidjaar-mail-ru@f16.mail.ru>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 12:41:37PM +0300, "Andrey Borzenkov"  wrote:
> 
> Are inode numbers supposed to be unique inside a filesystem? There
> is some code in nfsd (at least in 2.4) that suggests that it is not
> always the case.

Yes, at least in theory.  If you stat a file, the combination of
st_dev and st_ino are supposed to be unique.  For example, if two
separately named pathnames when stat'ed return the same values in
their stat structure for st_dev and st_ino, a userpsace program (such
as GNU tar) is allowed to presume they are the same hard links of each
other.  Since each filesystem is supposed to have a unique st_dev, it
follows that inode numbers are supposed to be unique inside a
filesystem.

That being said, there are filesystems, generally remote, distributed
filesystems such as AFS, that have "cheated", mainly because they can
address more files than st_dev/st_ino combined.  When they cheat, such
that two files have the same st_dev and st_ino, programs can get
confused.  However, to the extent that filesystems can manage to keep
related files (that are likely to be tar'ed together) from having
duplicated inode numbers, they can mostly get away with it.  

(So for example, although AFS looks like a single mounted filesystem
to AFS clients, it is made up of individual volumes which can be
located one or more different servers.  Files inside each volume are
guaranteed to have unique inodes, and users rarely run tar across
multiple AFS volumes, so AFS gets away with this, mostly.  By the way,
I'm not picking on AFS here.  Anytime you have a massively distributed
filesystem, this is going to be a potential problem.  So for example,
the Lustre filesystem has to deal with this as well.)

> Supermount is currently using 1-to-1 correspondence
> between super- and subfs inodes. This is OK for all except root
> inode - it still has to have some inode number for root all the time.
> So it assigns arbitrary number and changes it after subfs has been
> mounted to reflect subfs root.

Yup, that can certainly cause problems, mainly because supermount is
trying to create the illusion that the filesystem was always mounted,
except that it only mounts it when you traverse into the filesystem.
This is actually different from the duplicate inode problem, although
certainly using a 1:1 correspondence between super and subfs inodes
also runs that risk.

> idea is to use fixed root number; it can be done but may result
> in duplicated number. Using ino == 0 may lessen chances (is it valid
> BTW?)

Don't use ino of 0 --- that's just asking for trouble.

I'd probably use a very high number ((unsigned)-3), for example.  That
puts it out of the way, and less likely to collide with "real" inodes
--- at least, for filesystems that aren't playing games with synthetic
inode numbers....

						- Ted
