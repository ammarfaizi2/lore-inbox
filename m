Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264867AbTLFA7J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 19:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbTLFA7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 19:59:09 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:59652 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S264867AbTLFA6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 19:58:55 -0500
Message-ID: <3FD127D4.9030007@lougher.demon.co.uk>
Date: Sat, 06 Dec 2003 00:50:28 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.2.1) Gecko/20030228
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Erez Zadok <ezk@cs.sunysb.edu>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
References: <20031205191447.GC29469@parcelfarce.linux.theplanet.co.uk> <200312051947.hB5Jlupp030878@agora.fsl.cs.sunysb.edu> <20031205202838.GD29469@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20031205202838.GD29469@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Fri, Dec 05, 2003 at 02:47:56PM -0500, Erez Zadok wrote:
> 
>>Thanks for the info, Matthew.  Yes, clearly a scheme that keeps some "holes"
>>in compressed files can help; one of our ideas was to leave sparse holes
>>every N blocks, exactly for this kind of expansion, and to update the index
>>file's format to record where the spaces are (so we can efficiently
>>calculate how many holes we need to consume upon a new write).

FYI, Acorn's scheme was described in "Compressed Executables: An 
Exercise in Thinking Small" by Mark Taunton, in the Usenix Spring '91 
conference, it doesn't seem to be online, but a search on google groups 
for "group:comp.unix.internals taunton compressed executables" brings up 
a description.  I used to work with Mark Taunton at Acorn.

> 
> But the genius is that you don't need to calculate anything.  If the
> data block turns out to be incompressible (those damn .tar.bz2s!), you
> just write the block in-place.  If it is compressible, you write as much
> into that block's entry as you need and leave a gap.  The underlying
> file system doesn't write any data there.  There's no need for an index
> file -- you know exactly where to start reading each block.
> 

Of course this is all being done at the file level, which relies on 
proper support of holes in the underlying filesystem (which Acorn's BSD 
FFS filesystem did).  FiST's scheme is much more how it would be 
implemented without hole support, where you *have* to pack the data, 
otherwise the "unused" space would physically consume disk blocks. In 
this case an index to find the start of each compressed block is essential.

I'm guessing that FiST lacks support for holes or data insertion in the 
  filesystem model, which explains why on writing to the middle of a 
file, the entire file from that point has to be re-written.

Of course, all this is at the logical file level, and ignores the 
physical blocks on disk.  All filesystems assume physical data blocks 
can be updated in place.  With compression it is possible a new physical 
block has to be found, especially if blocks are highly packed and not 
aligned to block boundaries.  I expect this is at least partially why 
JFFS2 is a log structured filesystem.

Phillip

