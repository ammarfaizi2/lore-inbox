Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278358AbRJMSug>; Sat, 13 Oct 2001 14:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278356AbRJMSu1>; Sat, 13 Oct 2001 14:50:27 -0400
Received: from ip122-15.asiaonline.net ([202.85.122.15]:22188 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S278358AbRJMSuG>; Sat, 13 Oct 2001 14:50:06 -0400
Message-ID: <3BC88B44.E461CB63@rcn.com.hk>
Date: Sun, 14 Oct 2001 02:43:16 +0800
From: David Chow <davidchow@rcn.com.hk>
Organization: Resources Computer Network Ltd.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: zh_TW, en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: linux-kernel@vger.kernel.org, nfs-devel@linux.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: [PATCH] NFSv3 symlink bug
In-Reply-To: <jelmiuj7w2.fsf@sykes.suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not just that. the call to vfs_symlink on an NFS v3 mounted filesystem,
the dentry that passed to vfs_symlink did not result with an inode
member it remains null. This also lead to problem in the dcache and
didn't have a d_instantiate() and d_add() in the nfs_symlink() . I have
proved this is a bug. in kernel version 2.4.0 up to 2.4.10 . Not tested
with 2.4.12 and 2.4.11 . This will not affect most of the process
context calls, since after creating a symlink on the filesystem, because
the dentry is not valid in the dcache, the call to the created link will
result in a subsequent inode_lookup(). This will affect the performance
a little bit but this bug voids the VFS standard. We are developing
kernel modules that have file system operations, we are get stucked when
using the NFS . NFS maintainers please help or at least acknowledge or
otherwise we will start bug fix the code. Thanks.

regards,

David Chow (DC)

Andreas Schwab wrote:
> 
> The NFSv3 server in the 2.4.10 kernel has a bug in the symlink
> implementation.  The target pathname of the symlink is not necessarily
> zero terminated when passed to vfs_symlink.  This does not happen with
> NFSv2, because it explicitly zero terminates the string when decoding it
> from XDR (xdr_decode_string does this), but NFSv3 uses
> xdr_decode_string_inplace.  As a result you may get a spurious
> ENAMETOOLONG when trying to create a symbolic link on a NFSv3 mounted
> filesystem (if the length of the target path is a multiple of four).  If
> you don't get an error the created symlink will have random characters
> appended, which exposes kernel memory to user space (that's why it's a
> security problem).
> 
> This patch changes the NFSv3 xdr function to use xdr_decode_string for the
> symlink target, which seems to be the easiest solution.  I also considered
> adding an additional parameter to vfs_symlink to pass the length, but that
> requires changes in each and every filesystem and changes the VFS API.
> That could be a task for 2.5.x.
> 
> --- linux/fs/nfsd/nfs3xdr.c.~1~ Fri Sep 21 06:02:01 2001
> +++ linux/fs/nfsd/nfs3xdr.c     Tue Oct  2 16:12:27 2001
> @@ -99,7 +99,11 @@
>         char            *name;
>         int             i;
> 
> -       if ((p = xdr_decode_string_inplace(p, namp, lenp, NFS3_MAXPATHLEN)) != NULL) {
> +       /*
> +        * Cannot use xdr_decode_string_inplace here, the name must be
> +        * zero terminated for vfs_symlink.
> +        */
> +       if ((p = xdr_decode_string(p, namp, lenp, NFS3_MAXPATHLEN)) != NULL) {
>                 for (i = 0, name = *namp; i < *lenp; i++, name++) {
>                         if (*name == '\0')
>                                 return NULL;
> 
> Andreas.
> 
> --
> Andreas Schwab                                  "And now for something
> Andreas.Schwab@suse.de                          completely different."
> SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
> Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


