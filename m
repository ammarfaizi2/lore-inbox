Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262511AbRENVow>; Mon, 14 May 2001 17:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262513AbRENVoc>; Mon, 14 May 2001 17:44:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64708 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262511AbRENVoU>;
	Mon, 14 May 2001 17:44:20 -0400
Date: Mon, 14 May 2001 17:44:19 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Andreas Dilger <adilger@turbolinux.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Re: Inodes]
In-Reply-To: <3B004B90.5B2BD131@transmeta.com>
Message-ID: <Pine.GSO.4.21.0105141735001.19333-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 May 2001, H. Peter Anvin wrote:

> Correct.  At least at one time it used the offset of the directory entry
> when that particular inode was last "seen" by the kernel... meaning that
> when it finally dropped out of the inode cache, it would change inode
> numbers.  I thought that was a reasonable (by no means perfect, though)
> solution to a very sticky problem.

Unfortunately it wasn't a solution. Look: you open a file and rename it
away. Now you want to create something in the old directory. Woops - can't
use the old entry of our file, since we'll get icache conflict that way.
So we get this lovely notion of reserved entries and there lies the
madness. It gets especially nasty when you consider rmdir of something
that used to be non-empty, but everything had been renamed away from it.
And stayes open. Moreover, at every moment you need both the "original"
location (inumber) and current one (for write_inode()). Better yet, you
get to deal with opened files that are not renamed, but removed. Yes,
all of that can be dealt with. The old driver didn't.

