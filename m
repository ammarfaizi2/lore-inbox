Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423354AbWJUQ2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423354AbWJUQ2x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423355AbWJUQ2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:28:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:8155 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1423354AbWJUQ2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:28:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Vasily Tarasov <vtaras@openvz.org>
Subject: Re: [PATCH] diskquota: 32bit quota tools on 64bit architectures
Date: Sat, 21 Oct 2006 18:28:32 +0200
User-Agent: KMail/1.9.4
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jan Kara <jack@suse.cz>,
       Dmitry Mishin <dim@openvz.org>, Vasily Averin <vvs@sw.ru>,
       Kirill Korotaev <dev@openvz.org>,
       OpenVZ Developers List <devel@openvz.org>
References: <200610191232.k9JCW7CF015486@vass.7ka.mipt.ru> <20061019172948.GA30975@infradead.org> <200610200610.k9K6AXgP031789@vass.7ka.mipt.ru>
In-Reply-To: <200610200610.k9K6AXgP031789@vass.7ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610211828.33230.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 October 2006 08:10, Vasily Tarasov wrote:
> Christoph Hellwig wrote:
>
> <snip>
>
> > Please allocate the structure using compat_alloc_userspace and copy
> > with copy_in_user instead of the set_fs trick.
>
> <snip>
>
> Good idea, thank you for your tip, I'll do it.

I think it would be even better to integrate this into fs/quota.c
and get rid of the extra copy entirely. The only thing you need
to do differently in case of 32 bit Q_GETQUOTA is the size
of the copy_{from,to}_user.

On a related topic, I just noticed 

typedef struct fs_qfilestat {
	__u64		qfs_ino;	/* inode number */
	__u64		qfs_nblks;	/* number of BBs 512-byte-blks */
	__u32		qfs_nextents;	/* number of extents */
} fs_qfilestat_t;

typedef struct fs_quota_stat {
	__s8		qs_version;	/* version number for future changes */
	__u16		qs_flags;	/* XFS_QUOTA_{U,P,G}DQ_{ACCT,ENFD} */
	__s8		qs_pad;		/* unused */
	fs_qfilestat_t	qs_uquota;	/* user quota storage information */
	fs_qfilestat_t	qs_gquota;	/* group quota storage information */
	__u32		qs_incoredqs;	/* number of dquots incore */
	__s32		qs_btimelimit;  /* limit for blks timer */	
	__s32		qs_itimelimit;  /* limit for inodes timer */	
	__s32		qs_rtbtimelimit;/* limit for rt blks timer */	
	__u16		qs_bwarnlimit;	/* limit for num warnings */
	__u16		qs_iwarnlimit;	/* limit for num warnings */
} fs_quota_stat_t;

This one seems to have a more severe problem in x86_64 compat
mode. I haven't tried it, but isn't everything down from
gs_gquota aligned differently on i386?

	Arnd <><
