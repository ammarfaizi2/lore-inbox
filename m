Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265134AbTLFLpu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 06:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbTLFLpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 06:45:50 -0500
Received: from gaia.cela.pl ([213.134.162.11]:49932 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S265134AbTLFLpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 06:45:49 -0500
Date: Sat, 6 Dec 2003 12:43:28 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Pat LaVarre <p.lavarre@ieee.org>
cc: linux-fsdevel@vger.kernel.org, <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>, Erez Zadok <ezk@cs.sunysb.edu>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Phillip Lougher <phillip@lougher.demon.co.uk>,
       Kallol Biswas <kbiswas@neoscale.com>
Subject: Re: partially encrypted filesystem
In-Reply-To: <1070674555.2939.35.camel@patibmrh9>
Message-ID: <Pine.LNX.4.44.0312061233280.11259-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Suppose we wish to encrypt the files on a disc or disk or drive that we
> carry from one computer to another.
> 
> Where else can the encryption go, if not "down to the file system"?

Of course down to the file system - in this sense.  My point was that you
were utilizing sparse features of the filesystem in ways for which it
likely wasn't designed, thus you would likely encounter problems and/or
slowdowns.  Face it: sparse files are seldom used and when they are used
it is mostly for static files.  It is unusual for a file of 500 blocks to
have 200 1 block sparse holes and 25 2 block sparse holes.  This is what
you'd get with your compression (assuming a 50% comp ratio).  That's a
single smallish files with 225 sparse empty regions.  I doubt the
filesystem is optimized to deal nicely with that.  The problem being that
any later write access to such a file which compresses better or worse
than the original data in that area (ie uses one (or more) less/more
blocks than what used to be there) causes fragmentations and requires
extra pointers etc... you may soon end up with a 500 block file with 225
sparse holes and 275 pointers to single blocks (instead of one long
continuous area with data represented with a single pointer and length).  
Sure, the file system will likely manage to deal with it - but a) this'll
be a real filesystem stress test (assuming stuff like this happens in
every file... you'd have millions of single blocks instead of thousands of
contiguous areas)) and b) this'll stress code (which hasn't been as
optimized as the rest) and algorithms (which aren't fast to begin with).  
In other words you are likely to hit fs bugs and slowdowns.  I'm not
saying this isn't the best way to do it - but, you may be required to
invest significant time into making sparse file handling work _well_ in
extreme cases in order for this to work stabily and/or quickly.  And of 
course if you then change the underlying file system you'll have to start 
the sparse handling rewrite over from the bottom-up.  That's why I'm not 
sure whether this shouldn't be done with some other method - a method 
which would be less likely to cause massive disk fragmentation.

Cheers,
MaZe.

