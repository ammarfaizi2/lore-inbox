Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbUDMRpb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 13:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263615AbUDMRpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 13:45:30 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:44708 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263394AbUDMRp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 13:45:27 -0400
Date: Tue, 13 Apr 2004 19:45:16 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Guillaume =?iso-8859-1?Q?Lac=F4te?= <Guillaume@lacote.name>
Cc: linux-kernel@vger.kernel.org, Linux@glacote.com
Subject: Re: Using compression before encryption in device-mapper
Message-ID: <20040413174516.GB1084@wohnheim.fh-wedel.de>
References: <200404131744.40098.Guillaume@Lacote.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200404131744.40098.Guillaume@Lacote.name>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 April 2004 17:44:40 +0200, Guillaume Lacôte wrote:
> 
> I hope this is the right place to post this message; I tried to keep it small.
> Basically I really would like to implement compression at the dm level, 
> despite all of the problems. The reason for this is that reducing redundancy 
> through compression tremendously reduces the possibilities of success for an 
> attacker. I had implemented this idea in a java archiver ( 
> http://jsam.sourceforge.net ).
> 
> Although I am not a good kernel hacker, I have spent some time reading 
> compressed-loop.c, loop-aes, dm-crypt.c, and various threads from lkml 
> including http://www.uwsg.iu.edu/hypermail/linux/kernel/0402.2/0035.html
> Thus I would appreciate if you could answer the following questions regarding 
> the implementation of a "dm-compress" dm personality. 
> 
> 0) Has this problem already been adressed, and if yes, where ?

Yes, on the filesystems level.  Jffs2 is usable, although not
well-suited for disks and similar, ext2compr appears to be unusable.
On the device level, I haven't heard of anything yet.

> 1) Using dm: I want to be able to use compression both above dm (to compress 
> before encrypting a volume) and below it (to do a RAID on compressed 
> volumes). I assume there is no other way than to make compression be a dm 
> personality. Is this correct (or shall I use something more similar to a 
> compressed loop device) ?

I'd go for a dm implementation.

> 2) Block I/O boundaries: compression does not preserve size. I plan to use a 
> mapping from real sectors to their compressed location (e.g. struct { 
> sector_t sector; size_t compressed_length }* mapping; ). I believe this 
> mapping can be stored on another dm target and bufferized dynamically. Is 
> this correct, or shall it remain in (non-swappable ?) memory ?
> 
> 3) Compressed sectors have varying sizes, while dm targets only deal with full 
> blocks. Thus every compressed request may need to be fragmented into several 
> block aligned requests. This might imply reading a full block before 
> partially filling it with new data. Is it an exceedingly difficult task ? 
> Will this kill performance ?
> 
> 4) Block allocation on writes: this is the most difficult problem I believe. 
> When rewriting a sector, its new compressed length might not be the same as 
> before. This would require a whole sector allocation mechanism: magaging 
> lists of free space, optimizing dynamic allocation to reduce fragmentation, 
> etc. Is there another solution than to adapt algorithms used in for e.g. ext2 
> ?

If you really want to deal with this, you end up with a device that
can grow and shrink depending on the data.  Unless you have a strange
fetish for pain, you shouldn't even think about it.

> 5) As a workaround to 2,3,4 I plan to systematically allocate 2 sectors per 
> real sector (space efficiency is _not_ my aim, growing entropy per bit is) 
> and to use a trivial dynamic huffman compression algorithm. Is this solution 
> (which means having half less space than physically available) acceptable ?

Makes sense.  One of the zlib developers actually calculated the
maximum expansion when zlib-compressing data, so you could even get
away with more than 50% net size, but that makes the code more
complicated.  Your call.

Performance should not be a big issue, as encryption is a performance
killer anyway.

Whether it is acceptable depends on the user.  Make it optional and
let the user decide.

> 6) Shall this whole idea of compression be ruled out of dm and only be 
> implemented at the file-system level (e.g. as a plugin for ReiserFS4) ?

Again, depends on the user.  But from experience, there are plenty of
users who want something like this.

Jörn

-- 
A victorious army first wins and then seeks battle.
-- Sun Tzu
