Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWF2RYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWF2RYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWF2RYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:24:31 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:19917 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751049AbWF2RYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:24:31 -0400
Date: Thu, 29 Jun 2006 10:30:45 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Takashi Sato <sho@tnes.nec.co.jp>
Cc: Johann Lombardi <johann.lombardi@bull.net>,
       ext2-devel@lists.sourceforge.net, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 1/2] ext3: enlarge blocksize and fix rec_lenoverflow
Message-ID: <20060629163045.GA5318@schatzie.adilger.int>
Mail-Followup-To: Takashi Sato <sho@tnes.nec.co.jp>,
	Johann Lombardi <johann.lombardi@bull.net>,
	ext2-devel@lists.sourceforge.net, cmm@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <20060628202421.GL5318@schatzie.adilger.int> <04d401c69b69$581db0d0$4168010a@bsd.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04d401c69b69$581db0d0$4168010a@bsd.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 29, 2006  19:46 +0900, Takashi Sato wrote:
> >On Jun 28, 2006  17:50 +0200, Johann Lombardi wrote:
> >>ext2/ext3_dir_entry_2 has a 16-bit entry(rec_len) and it would overflow
> >>with 64KB blocksize.  This patch prevent from overflow by limiting
> >>rec_len to 65532.
> >
> >Having a max rec_len of 65532 is rather unfortunate, since the dir
> >blocks always need to filled with dir entries.
> 
> Oh, that's right.
> 
> >65536 - 65532 = 4, and
> >the minimum ext3_dir_entry size is 8 bytes.  I would instead make this
> >maybe 64 bytes less so that there is room for a filename in the "tail"
> >dir_entry.
> 
> What does "64 bytes" mean?
> Do you mean that the following dummy entry should be added
> at the tail of the directory block?
> 
> struct ext3_dir_entry_2 {
> __le32 inode   = 0
> __le16 rec_len = 16
> __u8 name_len  = 4
> __u8 file_type = 0
> char name      = "dir_end"
> };

Sure, something like this.  The goal of this dir entry is to:
a) fill up the remaining space in the dir block
b) be large enough to be used later on when the start of the block has
   been consumed, so it shouldn't be too small.  It could even be as
   large as 4kB or 8kB or 32kB.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

