Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTGFT2S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 15:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTGFT2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 15:28:18 -0400
Received: from mail48-s.fg.online.no ([148.122.161.48]:49374 "EHLO
	mail48.fg.online.no") by vger.kernel.org with ESMTP id S263298AbTGFT2O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 15:28:14 -0400
From: Svein Ove Aas <svein.ove@aas.no>
To: Jesse Pollard <jesse@cats-chateau.net>, rmoser <mlmoser@comcast.net>,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
Date: Sun, 6 Jul 2003 21:30:23 +0200
User-Agent: KMail/1.5.2
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <200306291545410600.02136814@smtp.comcast.net> <03063008265401.14007@tabby>
In-Reply-To: <03063008265401.14007@tabby>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307062130.27771.svein.ove@aas.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

mandag 30. juni 2003, 15:26, skrev Jesse Pollard:

> You are ASSUMING that the new filesystem requires lessthan or equal amount
> of metadata. This is NOT always true. A conversion of a full EXT2 to
> Riserfs would fail simply because there is no free space to expand the
> needed additional overhead.
>
> Going in the other direction usually is possible (again, depending on the
> filesystem) but there are exceptions... Try converting an EXT2 to DosFS.
> In place. And maintain a recoverable state when aborted.
>
> Not gonna happen.
>
> Too much depends on what the target filesystem is, and what it may require.
>
> Consider another - switching to an extent filesystem... If the datablocks
> don't move, then you need MORE extents than the current indirect pointers.
> And each extent is LARGER than the indirect pointers.
>
> Then you have to compress/condense the extents (requiring shuffling data
> blocks around to reduce the number of extents). Each requires free space
> to do it's work, and the amount of free blocks is not the same.
>
> Faster to do a copy. more reliable too. and recoverable.

What this boils down to is, "there may not be enough space".
Personally I prefer incrementally resizing LVM partitions for conversion 
anyway, but I'll take a stab at this.

Simple solution: In your conversion routines, allocate a chunk of another 
filesystem (just another file), and use that for scratch space. Journalling 
and the like won't get much harder, so why not?
And you can easily expand the file if you need to.

Problem: You might wind up with a 99%-converted filesystem and not have enough 
space to do without the scratch file. This could be bad.
If you can mount the filesystem as-is, then simply deleting a few large files 
would allow the conversion to complete. Otherwise you'll have to resize the 
underlying partition and the partial FS - difficult, but doable.

I'm think this idea ranks under "cool, but difficult and not quite necessary". 
Union mounts coupled with LVM and online resizing (which both Reiser3.6 and 
Reiser4 support, I presume) would render it irrelevant anyway; even without 
them, it can still be done with just LVM if taking the filesystem offline for 
a few hours is okay.

And if it isn't then you can likely afford some backup tape.

- - Svein Ove Aas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/CHjS9OlFkai3rMARAtvRAKCJhS4pMI73/AQmT4Nu8nT3XkKfOwCeLfWI
DL+O7LSIRnWaXKJFoT6L550=
=lMxE
-----END PGP SIGNATURE-----

