Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWF2U1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWF2U1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWF2U1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:27:04 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:47541 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932408AbWF2U1C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:27:02 -0400
Date: Thu, 29 Jun 2006 14:27:00 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Daniel Phillips <phillips@google.com>
Cc: Johann Lombardi <johann.lombardi@bull.net>, sho@tnes.nec.co.jp,
       cmm@us.ibm.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] ext3: enlarge blocksize and fix rec_len overflow
Message-ID: <20060629202700.GD5318@schatzie.adilger.int>
Mail-Followup-To: Daniel Phillips <phillips@google.com>,
	Johann Lombardi <johann.lombardi@bull.net>, sho@tnes.nec.co.jp,
	cmm@us.ibm.com, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20060628205238sho@rifu.tnes.nec.co.jp> <20060628155048.GG2893@chiva> <20060628202421.GL5318@schatzie.adilger.int> <44A417A3.80001@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A417A3.80001@google.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 29, 2006  11:10 -0700, Daniel Phillips wrote:
> Andreas Dilger wrote:
> >On Jun 28, 2006  17:50 +0200, Johann Lombardi wrote:
> >>ext2/ext3_dir_entry_2 has a 16-bit entry(rec_len) and it would overflow
> >>with 64KB blocksize.  This patch prevent from overflow by limiting
> >>rec_len to 65532.
> >
> >Having a max rec_len of 65532 is rather unfortunate, since the dir
> >blocks always need to filled with dir entries.  65536 - 65532 = 4, and
> >the minimum ext3_dir_entry size is 8 bytes.  I would instead make this
> >maybe 64 bytes less so that there is room for a filename in the "tail"
> >dir_entry.
> 
> Then why not introduce a little symmetry by making max rec_len 2**15 and
> treat big directory blocks as an array of smaller ones?  I dimly recall
> the page-cache oriented Ext2 dir code already does this.

I have no objection to this at all, but I think it will lead to a slightly
more complex implementation.  We even discussed in the distant past to
make large directories a series of 4kB "chunks", for fs blocksize >= 4kB.
This has negative implications for large filenames because the internal
free space fragmentation is high, but has the advantage that it might
eventually still be usable if we can get blocksize > PAGE_SIZE.

The difficulty is that when freeing dir entires you would have to be
concerned with a merging a dir_entry that is spanning the middle
of a 2^16 block.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

