Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbVLGMko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbVLGMko (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbVLGMkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:40:43 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:37024 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1751000AbVLGMkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:40:42 -0500
Date: Wed, 7 Dec 2005 05:40:43 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: [PATCH] ext3: return FSID for statvfs
Message-ID: <20051207124043.GD14509@schatzie.adilger.int>
Mail-Followup-To: Pekka Enberg <penberg@cs.helsinki.fi>,
	akpm@osdl.org, linux-kernel@vger.kernel.org, sct@redhat.com
References: <1133900600.3279.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133900600.3279.7.camel@localhost>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 06, 2005  22:23 +0200, Pekka Enberg wrote:
> This patch changes ext3_statfs() to return a FSID based on least significant
> 64-bits of the 128-bit filesystem UUID. This patch is a partial fix for
> Bugzilla Bug <http://bugzilla.kernel.org/show_bug.cgi?id=136>.

The bug mentions some reasons why this patch is sub-optimal - namely that
the beginning of the UUID has common fields in it.  It may make more sense
to e.g. XOR the first 2 * u32 with the last 2 * u32 to reduce the chance
of an FSID collision.

Also, there is a tiny memory of a security issue with exposing the FSID
to applications (something to do with NFS and guessing filehandles or
similar).  I have no idea if that is even relevant any longer, but
thought I'd mention it.

> @@ -2340,6 +2340,8 @@ static int ext3_statfs (struct super_blo
>  	buf->f_files = le32_to_cpu(es->s_inodes_count);
>  	buf->f_ffree = ext3_count_free_inodes (sb);
>  	buf->f_namelen = EXT3_NAME_LEN;
> +	buf->f_fsid.val[0] = le32_to_cpup((void *)es->s_uuid);
> +	buf->f_fsid.val[1] = le32_to_cpup((void *)es->s_uuid + sizeof(u32));
>  	return 0;
>  }
>  

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

