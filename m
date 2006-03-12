Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbWCLRXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbWCLRXP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 12:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWCLRXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 12:23:15 -0500
Received: from pat.uio.no ([129.240.130.16]:6307 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751244AbWCLRXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 12:23:14 -0500
Subject: Re: [2.6 PATCH]: Incorrect lack of {m,c}time modification for
	ftruncate.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Neil Brown <neilb@suse.de>, Christoph Hellwig <hch@lst.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603121544050.14340@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0603121544050.14340@hermes-2.csi.cam.ac.uk>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 12:22:57 -0500
Message-Id: <1142184177.32707.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.207, required 12,
	autolearn=disabled, AWL 1.61, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-12 at 16:28 +0000, Anton Altaparmakov wrote:
> Hi,
> 
> Recently Neil Brown's patch to fix the standards compliance of setting 
> {m,c}time on {f,}truncate and open(O_TRUNC) was applied to the kernel.
> 
> See 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=4a30131e7dbb17e5fec6958bfac9da9aff1fa29b
> 
> From the patch description:
> <quote>
> SUS requires that when truncating a file to the size that it currently
> is:
>   truncate and ftruncate should NOT modify ctime or mtime
>   O_TRUNC SHOULD modify ctime and mtime.
> [snip]
> With this patch:
>   ATTR_CTIME|ATTR_MTIME are sent with ATTR_SIZE precisely when
>     an update of these times is required whether size changes or not
>     (via a new argument to do_truncate).  This allows NFS to do
>     the right thing for O_TRUNC.
>   inode_setattr nolonger forces ATTR_MTIME|ATTR_CTIME when the ATTR_SIZE
>     sets the size to it's current value.  This allows local filesystems
>     to do the right thing for f?truncate.
> </quote>
> 
> The problem with this patch is that the standard does not actually say the 
> above, it in fact says that:
> 
> - both open(O_TRUNC) and ftruncate() _always_ modify {m,c}time and 
> 
> - truncate() modifies {m,c}time _only_ if the file size changes due to the 
> truncate.
> 
> (This IMO is completely brain damaged... but I guess no-one claims 
> standards are not braindamaged...)
> 
> Here are the relevant three pages from posix/sus3 together with the 
> relevant paragraph quoted:
> 
> http://www.opengroup.org/onlinepubs/009695399/functions/open.html
> <quote>
> If O_TRUNC is set and the file did previously exist, upon successful 
> completion, open() shall mark for update the st_ctime and st_mtime fields 
> of the file.
> </quote>
> 
> http://www.opengroup.org/onlinepubs/009695399/functions/ftruncate.html
> <quote>
> Upon successful completion, if fildes refers to a regular file, the 
> ftruncate() function shall mark for update the st_ctime and st_mtime 
> fields of the file and the S_ISUID and S_ISGID bits of the file mode may 
> be cleared. If the ftruncate() function is unsuccessful, the file is 
> unaffected.
> </quote>
> 
> http://www.opengroup.org/onlinepubs/009695399/functions/truncate.html
> <quote>
> Upon successful completion, if the file size is changed, this function 
> shall mark for update the st_ctime and st_mtime fields of the file, and 
> the S_ISUID and S_ISGID bits of the file mode may be cleared.
> </quote>
> 
> So at present we handle open(O_TRUNC) and truncate() correctly but we do 
> the Wrong Thing (TM) for ftruncate().
> 
> This is fixed by the simple one liner patch at the bottom of this email.
> 
> Please apply or tell me that I can't read the standard and kindly point 
> out to me what I have missed...  (-:

The page for ftruncate() appears to be a tad self-contradictory. In the
"Issue 6" text at the bottom of the page it appears to say that S_ISUID
and S_ISGID are only changed if the file size is changed.

I also had a look at the Solaris manpages: they say that ftruncate()
changes st_mtime/st_ctime and clears S_ISUID/S_ISGID only if the file
size changes (which would make it act just like truncate()).

Cheers,
  Trond

