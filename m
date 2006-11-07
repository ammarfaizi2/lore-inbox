Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753842AbWKGNku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbWKGNku (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 08:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840AbWKGNku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 08:40:50 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:47038 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1753813AbWKGNkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 08:40:49 -0500
Subject: Re: [RFC/PATCH] - revert generic_fillattr stat->blksize to	 
	PAGE_CACHE_SIZE
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Steve French <smfltc@us.ibm.com>
Cc: Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Theodore Tso <tytso@mit.edu>
In-Reply-To: <454FD2BE.2090302@us.ibm.com>
References: <454FAE0A.3070409@redhat.com>
	 <1162852069.11030.70.camel@kleikamp.austin.ibm.com>
	 <454FD2BE.2090302@us.ibm.com>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 07:40:45 -0600
Message-Id: <1162906845.8123.11.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 18:26 -0600, Steve French wrote:   
> I assumed that the original intent of the "inode diet patch" was to 
> remove fields in the inode,
> which most filesystems can get out of the superblock. 

I think I may have planted the idea that you could get i_blkbits from
sb->s_blocksize_bits, but I was wrong.  Consider a block device.  It's
blocksize is not related to the superblock of its containing filesystem.

>    If 
> inode->blksize and inode->blkbits were
> related (2**blkbits == blksize) , it also makes sense to me that someone 
> (Ted?) removed one and left the other
> as one would be redundant,

They were never really related.  Some filesystems treated them as if
they were, but the vfs always used i_blkbits for the block size.
i_blksize was only really used for returning stat->blksize.

>  but some filesystems like cifs have a large 
> recommended i/o size (16K),
> but if someone wants to remove both from the inode that is fine by me, 
> as long as cifs
> stat->blksize is set as you suggested on the way out of cifs_getattr.    
> Eventually cifs should set
> the stat->blksize to  a smaller value for one rarer case.   For the most 
> common case
> cifs should still set it to 16K (CIFS_MAX_MSGSIZE) as that is the most 
> common negotiated
> buffer size but if the server does not negotiate large read support, and 
> the server also is so old
> that it negotiates a buffer size smaller than 16K (e.g. Windows95 
> negotiates 2K IIRC)
> then we could set stat-blksize to the smaller negotiated buffer size - 
> but since those servers are
> getting rarer it is probably not that important.    More interesting 
> will be the future cases in
> which we will be able to set this value larger to more servers, as in 
> general for modern
> network adapters, the larger network i/o size the better.

It would probably be best to just set stat->blksize to the negotiated
buffer size.
-- 
David Kleikamp
IBM Linux Technology Center

