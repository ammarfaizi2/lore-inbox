Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751406AbWFEUNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWFEUNT (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWFEUNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:13:18 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:37333 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751406AbWFEUNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:13:17 -0400
Date: Mon, 5 Jun 2006 14:13:20 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Johann Lombardi <johann.lombardi@bull.net>
Cc: sho@tnes.nec.co.jp, cmm@us.ibm.com, jitendra@linsyssoft.com,
        ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [UPDATE][12/24]ext3 enlarge blocksize
Message-ID: <20060605201320.GL5964@schatzie.adilger.int>
Mail-Followup-To: Johann Lombardi <johann.lombardi@bull.net>,
	sho@tnes.nec.co.jp, cmm@us.ibm.com, jitendra@linsyssoft.com,
	ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20060525214902sho@rifu.tnes.nec.co.jp> <20060526120032.GN5964@schatzie.adilger.int> <20060605131311.GB2606@chiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605131311.GB2606@chiva>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 05, 2006  15:13 +0200, Johann Lombardi wrote:
> On Fri, May 26, 2006 at 06:00:32AM -0600, Andreas Dilger wrote:
> > On May 25, 2006  21:49 +0900, sho@tnes.nec.co.jp wrote:
> > > @@ -1463,11 +1463,17 @@ static int ext3_fill_super (struct super
> > > +	if (blocksize > PAGE_SIZE) {
> > > +		printk(KERN_ERR "EXT3-fs: cannot mount filesystem with "
> > > +		       "blocksize %u larger than PAGE_SIZE %u on %s\n",
> > > +		       blocksize, PAGE_SIZE, sb->s_id);
> > > +		goto failed_mount;
> > > +	}
> > > +
> > >  	if (blocksize < EXT3_MIN_BLOCK_SIZE ||
> > > -	    blocksize > EXT3_MAX_BLOCK_SIZE) {
> > > +	    blocksize > EXT3_EXTENDED_MAX_BLOCK_SIZE) {
> > 
> > We may as well just change EXT3_MAX_BLOCK_SIZE to be 65536, because no other
> > code uses this value.  It is already 65536 in the e2fsprogs.
> 
> AFAICS, ext3_dir_entry_2->rec_len will overflow with a 64kB blocksize.
> Do you know how ext2 handles this?

Hmm, good question, I hadn't considered this.  One option is to just limit
rec_len to 32768 or less (16k, 8k, 4k?), and require that there be multiple
such records in a directory block.  We could additionally require that the
records don't span such a boundary, which would potentially make it easier
to validate broken entries themselves, but would slightly hurt the case
where there are many large filenames.

I suppose the reason this wasn't hit during previous 64kB block testing is
that this has always been tested in relation to IO performance and not with
metadata, so the directories were probably all single-block dirs with a
"." and ".." entry at the beginning and a 65512-byte rec_len for the rest.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

