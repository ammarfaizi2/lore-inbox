Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbUKVXfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbUKVXfQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUKVXdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:33:04 -0500
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:36285 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262445AbUKVXaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:30:04 -0500
Date: Mon, 22 Nov 2004 23:30:01 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
cc: hirofumi@mail.parknet.co.jp, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] problem of cont_prepare_write()
In-Reply-To: <20041122135354.38feab51.akpm@osdl.org>
Message-ID: <Pine.LNX.4.60.0411222324150.27573@hermes-1.csi.cam.ac.uk>
References: <877joexjk5.fsf@devron.myhome.or.jp> <20041122024654.37eb5f3d.akpm@osdl.org>
 <1101121403.18623.10.camel@imp.csi.cam.ac.uk> <20041122135354.38feab51.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004, Andrew Morton wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> >
> > Would it be ok to modify i_size from prepare_write?
> 
> I think so - I seem to recall seeing that done somewhere else...

Great.

> One thing to watch out for is when to bring the page uptodate.  If the 
> page is uptodate then the read() code just won't try to lock it at all.  
> If you increase i_size AND set PG_uptodate too early you could open a 
> window which allows read() to peek at uninitialised data.
> 
> But if you set the page uptodate only when its contents really are sane
> then things should work OK.

Yes, I would never set PG_Uptodate without having sane page contents 
first.

In fact all the metadata writing code in NTFS actually clears PG_Uptodate 
on a locked page because it mangles the page contents, writes them out, 
and then demangles them again, before finally setting PG_Uptodate again 
to protect against read_cache_page() getting hold of pages with i/o in 
flight which for NTFS metadata would cause corruption.

> If you end up doing
> 
> 	memset(page, 0, N);
> 	SetPageUptodate(page);
> 
> then I think you'll need an smb_wmb() in between so the read() code sees the
> above two writes in the correct order.

Thanks.  I always have a flush_dcache_page(page) between the memset() and 
the SetPageUptodate() so I don't need the barrier, right?  Or does the 
flush_dcache_page() not imply ordering?  (I naively thought it did...)

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
