Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAKMFI>; Thu, 11 Jan 2001 07:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbRAKME7>; Thu, 11 Jan 2001 07:04:59 -0500
Received: from colorfullife.com ([216.156.138.34]:29714 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129324AbRAKMEk>;
	Thu, 11 Jan 2001 07:04:40 -0500
From: Manfred <manfred@colorfullife.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
Message-ID: <979215027.3a5da2b3781d7@localhost>
Date: Thu, 11 Jan 2001 07:10:27 -0500 (EST)
Cc: Andrea Arcangeli <andrea@suse.de>, Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <200101110734.f0B7Y1x01512@flint.arm.linux.org.uk>
In-Reply-To: <200101110734.f0B7Y1x01512@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 134.96.7.114
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zitiere Russell King <rmk@arm.linux.org.uk>:
> The API changed:
>  struct nfs_mount_data {
>         int             version;                /* 1 */
>         int             fd;                     /* 1 */
> -       struct nfs_fh   root;                   /* 1 */
> +       struct nfs2_fh  old_root;               /* 1 */

I don't see an API change:
the 2.2.17 "struct nfs_fs" and the 2.2.18 "struct nfs2_fh" are identical.

Ok, I see the problem:

struct nfs_fh {
    unsigned short          size;
    unsigned char           data[NFS_MAXFHSIZE];
}

The compiler thinks that data is a character array, thus no padding is inserted.
nlm_lookup_file casts f->data to "struct knfs_fs", a structure with pointers and
u32. --> unaligned u32 read --> boom.

Is that correct?
Is &(((struct nfs_fh*)0)->data) 2 or 4?

ARM isn't the only cpu that can't handle unaligned memory reads, why doesn't the
code fail on Alpha/Sparc? Does gcc insert padding on these cpus?


--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
