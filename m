Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbVLGUBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbVLGUBM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 15:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbVLGUBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 15:01:11 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:47833 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1030336AbVLGUBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 15:01:10 -0500
Date: Wed, 7 Dec 2005 13:01:09 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: [PATCH] ext3: return FSID for statvfs
Message-ID: <20051207200109.GG14509@schatzie.adilger.int>
Mail-Followup-To: Pekka J Enberg <penberg@cs.Helsinki.FI>,
	akpm@osdl.org, linux-kernel@vger.kernel.org, sct@redhat.com
References: <1133900600.3279.7.camel@localhost> <20051207124043.GD14509@schatzie.adilger.int> <Pine.LNX.4.58.0512071512170.21616@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0512071512170.21616@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 07, 2005  15:13 +0200, Pekka J Enberg wrote:
> On Wed, 7 Dec 2005, Andreas Dilger wrote:
> > The bug mentions some reasons why this patch is sub-optimal - namely that
> > the beginning of the UUID has common fields in it.  It may make more sense
> > to e.g. XOR the first 2 * u32 with the last 2 * u32 to reduce the chance
> > of an FSID collision.
> 
> This patch changes ext3_statfs() to return a FSID based on 64 bit XOR of the
> 128 bit filesystem UUID as suggested by Andreas Dilger. This patch is partial
> fix for Bugzilla Bug <http://bugzilla.kernel.org/show_bug.cgi?id=136>.

That seems at least slightly better, as it involves all the bits.  

Question - what is rule for "Signed-off-by:"?  I'm hesitant to add that if
I haven't actually compiled+tested a fix, as I've seen too many instances
of "obvious fix contains bug" to believe visual inspection is enough.  If
"Signed-off-by:" simply indicates "Yes, this person approves of the change
in principle" then that's OK by me.  Andrew, do you use the "CC" tag for
that?

> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
> ---
> 
>  super.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> Index: 2.6/fs/ext3/super.c
> ===================================================================
> --- 2.6.orig/fs/ext3/super.c
> +++ 2.6/fs/ext3/super.c
> @@ -2294,6 +2294,7 @@ static int ext3_statfs (struct super_blo
>  	struct ext3_super_block *es = EXT3_SB(sb)->s_es;
>  	unsigned long overhead;
>  	int i;
> +	u64 fsid;
>  
>  	if (test_opt (sb, MINIX_DF))
>  		overhead = 0;
> @@ -2340,6 +2341,10 @@ static int ext3_statfs (struct super_blo
>  	buf->f_files = le32_to_cpu(es->s_inodes_count);
>  	buf->f_ffree = ext3_count_free_inodes (sb);
>  	buf->f_namelen = EXT3_NAME_LEN;
> +	fsid = le64_to_cpup((void *)es->s_uuid) ^
> +	       le64_to_cpup((void *)es->s_uuid + sizeof(u64));
> +	buf->f_fsid.val[0] = fsid & 0xFFFFFFFFUL;
> +	buf->f_fsid.val[1] = (fsid >> 32) & 0xFFFFFFFFUL;
>  	return 0;
>  }
>  

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

