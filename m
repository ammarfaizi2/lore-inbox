Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263293AbUKUL6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbUKUL6B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 06:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbUKUL4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 06:56:24 -0500
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:28050 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263222AbUKULxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 06:53:11 -0500
Date: Sun, 21 Nov 2004 11:53:04 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
cc: bulb@ucw.cz, pavel@ucw.cz, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <E1CVpuQ-0008Fl-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.60.0411211143340.19278@hermes-1.csi.cam.ac.uk>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
 <20041117190055.GC6952@openzaurus.ucw.cz> <E1CUVkG-0005sV-00@dorka.pomaz.szeredi.hu>
 <20041117204424.GC11439@elf.ucw.cz> <E1CUhTd-0006c8-00@dorka.pomaz.szeredi.hu>
 <20041118144634.GA7922@openzaurus.ucw.cz> <E1CVmN5-0007qq-00@dorka.pomaz.szeredi.hu>
 <20041121095038.GV2870@vagabond> <E1CVp0g-0008Cw-00@dorka.pomaz.szeredi.hu>
 <20041121103956.GW2870@vagabond> <E1CVpuQ-0008Fl-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2004, Miklos Szeredi wrote:
> OK, I see your point.  But can't the memory subsystem be tought, that
> those pages are not guaranteed to be written back in a limited time?

It already is.  Your address space ->writepage can do 

redirty_page_for_writepage(wbc, page);
unlock_page(page);
return 0;

And that is fine.  NTFS does this.  As does Reiserfs I believe.

For NTFS I do it exactly when I get to -ENOMEM so that I don't have enough 
memory to coplete the writepage so I abort the write and redirty the page 
so it gets tried again at a later time when more memory is freed.  The 
writeback control (wbc) ensures the VM doesn't just keep calling us trying 
to clean the page to free it.  It knows it is pointless so it gives up.  
The OOM killer can then kill some other app which will free memory, and 
then the writepage will be retried and it will succeed.  Now I know 
the fuse fs can be swapped out but why that would lead to a deadlock I 
can't see.  There always is something else to kill to free memory so the 
fs can be swapped back in.  And if the fs is killed surely all its pages 
will be invalidated and thrown away by fuse, no?

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
