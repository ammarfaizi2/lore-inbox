Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132462AbRAHVew>; Mon, 8 Jan 2001 16:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132266AbRAHVen>; Mon, 8 Jan 2001 16:34:43 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:62239 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131388AbRAHVed>; Mon, 8 Jan 2001 16:34:33 -0500
Date: Mon, 8 Jan 2001 22:34:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010108223445.V27646@athlon.random>
In-Reply-To: <UTC200101082056.VAA147872.aeb@texel.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200101082056.VAA147872.aeb@texel.cwi.nl>; from Andries.Brouwer@cwi.nl on Mon, Jan 08, 2001 at 09:56:18PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 09:56:18PM +0100, Andries.Brouwer@cwi.nl wrote:
> You think that it fails with EBUSY. That would be allowed but not required:
> 
> [EBUSY]: The directory to be removed is currently in use by
>          the system or some process and the implementation
>          considers this to be an error.
> 
> Here we are free to consider this "in use" an error or not.

I think the above is to allow implementations without something like our dcache
to not be declared "broken" w.r.t. specs.

> But in fact it fails with EINVAL, and
> 
> [EINVAL]: The path argument contains a last component that is dot.

I can't confirm. The specs I'm checking are here:

	http://www.opengroup.org/onlinepubs/007908799/xsh/rmdir.html

They definitely don't say that `rmdir .` must return -EINVAL.

> Indeed, rmdir("P/D") does roughly the following:
> (i) check that P/D is a directory
> (ii) check that P/D does not have entries other than . and ..
> (iii) delete the names . and .. from P/D
> (iv) delete the name D from P

The definition of rmdir according to 2.2.19pre6 and the single unix
specification version 2 is this:

	int rmdir(const char *path);

	DESCRIPTION
		The rmdir() function removes a directory whose name is given by
		path. The directory is removed only if it is an empty
		directory. 

That is strightforward. It doesn't talk about (iv).

> In cases where hard links to directories are permitted,
> it is not even clear we can talk about "the parent directory".

Hardlinks have nothing to do with `rmdir .`. See rmdir . as the equivalent
pointed out by Alexander: "rmdir `pwd`".  `pwd` returns the same thing
regardless the current directory has nlink > 1 or not (even if it has
nlink = 0 infact). The parent directory is still identified as "`pwd`/.." (or
in kernel terms read_lock(current->fs->lock); current->fs->pwd->d_parent).
hardlinks (of files or directories) only matters at the inode level, not at the
dentry level.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
