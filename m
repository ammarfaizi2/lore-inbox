Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313182AbSEMMNr>; Mon, 13 May 2002 08:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313183AbSEMMNq>; Mon, 13 May 2002 08:13:46 -0400
Received: from imladris.infradead.org ([194.205.184.45]:62991 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313182AbSEMMNo>; Mon, 13 May 2002 08:13:44 -0400
Date: Mon, 13 May 2002 13:13:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, axboe@suse.de,
        akpm@zip.com.au, martin@dalecki.de, neilb@cse.unsw.edu.au
Subject: Re: [PATCH] remove 2TB block device limit
Message-ID: <20020513131339.A4610@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com, axboe@suse.de,
	akpm@zip.com.au, martin@dalecki.de, neilb@cse.unsw.edu.au
In-Reply-To: <1060250300@toto.iv> <15583.38222.512544.921796@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 08:28:30PM +1000, Peter Chubb wrote:
> 
> There's now a patch available against 2.5.15, and the BK repository
> has been updated to v2.5.15 as well:
> 
>     http://www.gelato.unsw.edu.au/patches/2.5.15-largefile-patch
>     bk://gelato.unsw.edu.au:2023/

This looks really good, I'd like to see something like that merged soon!
Some comments:

 - please move the sector_t typedef from <linux/types.h> to <asm/types.h>,
   so 64 bit arches don't have to have the CONFIG_ option at all, some
   32bit plattforms that are unlikely to ever support large disks
   (m68k comes to mind) can make it 32bit unconditionally and some like
   i386 can use a config option.
 - sector_div should move to a common header (blkdev.h?)

And something related to general sector_t usage:

 - what about sector_t vs daddr_t?  Linux still has daddr_t, but it is
   still always 32bit, I think a big s/sector_t/daddr_t/ would fit the
   traditional unix way of doing disk addressing
 - why is the get_block block argument a sector_t?  It presents a logical
   filesystem block which usually is larger than the sector, not to
   mention that for the usual blocksize == PAGE_SIZE case a ulong is
   enough as that is the same size the pagecache limit triggers.
