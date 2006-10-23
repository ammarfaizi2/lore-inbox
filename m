Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751894AbWJWKvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbWJWKvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 06:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWJWKvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 06:51:16 -0400
Received: from mailer.campus.mipt.ru ([194.85.82.4]:63178 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S1751894AbWJWKvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 06:51:15 -0400
Date: Mon, 23 Oct 2006 14:51:31 +0400
Message-Id: <200610231051.k9NApVSd006500@vass.7ka.mipt.ru>
From: Vasily Tarasov <vtaras@openvz.org>
To: Arnd Bergmann <arnd@arndb.de>
CC: Christoph Hellwig <hch@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
CC: Jan Kara <jack@suse.cz>
CC: Dmitry Mishin <dim@openvz.org>
CC: Vasily Averin <vvs@sw.ru>
CC: Kirill Korotaev <dev@openvz.org>
CC: OpenVZ Developers List <devel@openvz.org>
CC: David Chinner <dgc@sgi.com>
References: References: <200610191232.k9JCW7CF015486@vass.7ka.mipt.ru> <20061019172948.GA30975@infradead.org> <200610200610.k9K6AXgP031789@vass.7ka.mipt.ru> <200610211828.33230.arnd@arndb.de>
In-Reply-To: <200610211828.33230.arnd@arndb.de>
Subject: Re: [PATCH] diskquota: 32bit quota tools on 64bit architectures
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 23 Oct 2006 14:49:57 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Arnd Bergmann wrote:

<snip>
> On a related topic, I just noticed 
> 
> typedef struct fs_qfilestat {
> 	__u64		qfs_ino;	/* inode number */
> 	__u64		qfs_nblks;	/* number of BBs 512-byte-blks */
>  	__u32		qfs_nextents;	/* number of extents */
> } fs_qfilestat_t;
> 
> typedef struct fs_quota_stat {
> 	__s8		qs_version;	/* version number for future changes */
> 	__u16		qs_flags;	/* XFS_QUOTA_{U,P,G}DQ_{ACCT,ENFD} */
> 	__s8		qs_pad;		/* unused */
> 	fs_qfilestat_t	qs_uquota;	/* user quota storage information */
> 	fs_qfilestat_t	qs_gquota;	/* group quota storage information */
> 	__u32		qs_incoredqs;	/* number of dquots incore */
> 	__s32		qs_btimelimit;  /* limit for blks timer */	
> 	__s32		qs_itimelimit;  /* limit for inodes timer */	
> 	__s32		qs_rtbtimelimit;/* limit for rt blks timer */	
> 	__u16		qs_bwarnlimit;	/* limit for num warnings */
> 	__u16		qs_iwarnlimit;	/* limit for num warnings */
> } fs_quota_stat_t;
> 
> This one seems to have a more severe problem in x86_64 compat
> mode. I haven't tried it, but isn't everything down from
> gs_gquota aligned differently on i386?
<snip>

The problem indeed exists:

ia32:
sizeof(fs_qfilestat) = 0x14
sizeof(fs_quota_stat) = 0x44

x86_64:
sizeof(fs_qfilestat) = 0x18
sizeof(fs_quota_stat) = 0x50

Note, that the difference between sizes of fs_qfilestat on ia32 and 
on x86_64 doesn't equal 8 bytes, as was expected (by me :)), but equals 12 bytes: 
'cause of padding at the end of fs_quota_stat structure on x86_64.

I will add support of 32-bit XFS quotactl over 64bit OS in next patch.

Thank you!
