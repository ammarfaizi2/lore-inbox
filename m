Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135305AbRAJPcJ>; Wed, 10 Jan 2001 10:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135210AbRAJPb7>; Wed, 10 Jan 2001 10:31:59 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:41560 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135305AbRAJPbs>; Wed, 10 Jan 2001 10:31:48 -0500
Date: Wed, 10 Jan 2001 16:31:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
Message-ID: <20010110163158.F19503@athlon.random>
In-Reply-To: <20010110013755.D13955@suse.de> <200101100654.f0A6sjJ02453@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101100654.f0A6sjJ02453@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Jan 10, 2001 at 06:54:45AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 06:54:45AM +0000, Russell King wrote:
> This is an internal kernel data structure.  Do you know of some program

No, it isn't, that's the whole point.

> that breaks as a result of this?

(spotted by Andi) util-linux-2.10o/mount/nfs_mount4.h:

struct nfs3_fh {
        unsigned short          size;
        unsigned char           data[64];
};

(see also nfs_mount_data structure in both kernel and mount)

I also don't understand Alan's comment, what has the cast of data to a
structure have to do with the size of a field in the structure? Furthmore the
cast of data to a struct should work on all architectures as far as C is
concerned (if you then run alignment problems then it's your mistake).

As far I can see the only reason size makes sense to be 32bit is to get some
more strict behaviour in the below code (to avoid discarding the most
significant 16bits in sanity checks like this):

nlm4_decode_fh(u32 *p, struct nfs_fh *f)
{
        memset(f->data, 0, sizeof(f->data));
        f->size = ntohl(*p++);
        if (f->size > NFS_MAXFHSIZE) {
                printk(KERN_NOTICE
                        "lockd: bad fhandle size %d (should be <=%d)\n",
                        f->size, NFS_MAXFHSIZE);
                return NULL;
        }
        memcpy(f->data, p, f->size);
        return p + XDR_QUADLEN(f->size);
}

So for now I backed it out. If you want to push it in again then implement it
right and make an mount backwards compatible nfs_fh type for the
nfs_mount_data.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
