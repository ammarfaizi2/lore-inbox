Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbUKVLGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbUKVLGS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 06:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbUKVLFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 06:05:41 -0500
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:57290 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262059AbUKVLDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 06:03:34 -0500
Subject: Re: [RFC][PATCH] problem of cont_prepare_write()
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041122024654.37eb5f3d.akpm@osdl.org>
References: <877joexjk5.fsf@devron.myhome.or.jp>
	 <20041122024654.37eb5f3d.akpm@osdl.org>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Mon, 22 Nov 2004 11:03:22 +0000
Message-Id: <1101121403.18623.10.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 02:46 -0800, Andrew Morton wrote:
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> >
> > 
> >  		status = __block_prepare_write(inode, new_page, zerofrom,
> >  						PAGE_CACHE_SIZE, get_block);
> >  		if (status)
> >  			goto out_unmap;
> >  		kaddr = kmap_atomic(new_page, KM_USER0);
> >  		memset(kaddr+zerofrom, 0, PAGE_CACHE_SIZE-zerofrom);
> >  		flush_dcache_page(new_page);
> >  		kunmap_atomic(kaddr, KM_USER0);
> >  		__block_commit_write(inode, new_page,
> >  				zerofrom, PAGE_CACHE_SIZE);
> >  		unlock_page(new_page);
> >  		page_cache_release(new_page);
> >  	}
> > 
> >  But until ->commit_write(), kernel doesn't update the ->i_size. Then,
> >  if kernel writes out that hole page before updates of ->i_size, dirty
> >  flag of buffer_head is cleared in __block_write_full_page(). So hole
> >  page was not writed to disk.
> 
> Oh I see.  After the above page is unlocked, it's temporarily outside
> i_size.
> 
> Perhaps cont_prepare_write() should look to see if the zerofilled page is
> outside the current i_size and if so, advance i_size to the end of the
> zerofilled page prior to releasing the page lock.

Would it be ok to modify i_size from prepare_write?  That would make my
life in NTFS a lot easier...  There are cases in NTFS where I need to do
page updates in prepare write that would benefit from an i_size update
as well rather than having to postpone the i_size update to
commit_write.  (Note commit_write would still update i_size, too, its
just that prepare write would set i_size to be up to the start of the
write because otherwise you have a potential hole between i_size and the
start of the write and at least on NTFS that causes me a lot of
headaches with resident files and non-resident files with
initialized_size != i_size that I could make a lot easier to deal with
by updating i_size in prepare_write to point to the start of the write.)

> We might need to run mark_inode_dirty() at some stage, or perhaps just rely
> on the caller doing that in ->commit_write().

Slight problem with not running mark_inode_dirty() at this point is that
if commit_write() fails for some reason (-ENOMEM springs to mind)
mark_inode_dirty() may never get run which may cause a problem,
depending on what exactly was done in prepare_write...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

