Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbUKUMFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUKUMFU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 07:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbUKUMDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 07:03:08 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:50378 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261928AbUKUMCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 07:02:00 -0500
To: aia21@cam.ac.uk
CC: bulb@ucw.cz, pavel@ucw.cz, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <Pine.LNX.4.60.0411211143340.19278@hermes-1.csi.cam.ac.uk>
	(message from Anton Altaparmakov on Sun, 21 Nov 2004 11:53:04 +0000
	(GMT))
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
 <20041117190055.GC6952@openzaurus.ucw.cz> <E1CUVkG-0005sV-00@dorka.pomaz.szeredi.hu>
 <20041117204424.GC11439@elf.ucw.cz> <E1CUhTd-0006c8-00@dorka.pomaz.szeredi.hu>
 <20041118144634.GA7922@openzaurus.ucw.cz> <E1CVmN5-0007qq-00@dorka.pomaz.szeredi.hu>
 <20041121095038.GV2870@vagabond> <E1CVp0g-0008Cw-00@dorka.pomaz.szeredi.hu>
 <20041121103956.GW2870@vagabond> <E1CVpuQ-0008Fl-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.60.0411211143340.19278@hermes-1.csi.cam.ac.uk>
Message-Id: <E1CVqPf-0008Jt-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 13:01:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It already is.  Your address space ->writepage can do 
> 
> redirty_page_for_writepage(wbc, page);
> unlock_page(page);
> return 0;
> 
> And that is fine.  NTFS does this.  As does Reiserfs I believe.

As does fuse.  Actually there might be a very limited number of pages
in transit (10 per mount currently), but above that writepage will not
attempt to send any more requests.  I don't see what are the effects
of these in-transit pages on the OOM killer triggering.

> For NTFS I do it exactly when I get to -ENOMEM so that I don't have enough 
> memory to coplete the writepage so I abort the write and redirty the page 
> so it gets tried again at a later time when more memory is freed.  The 
> writeback control (wbc) ensures the VM doesn't just keep calling us trying 
> to clean the page to free it.  It knows it is pointless so it gives up.  
> The OOM killer can then kill some other app which will free memory, and 
> then the writepage will be retried and it will succeed.  Now I know 
> the fuse fs can be swapped out but why that would lead to a deadlock I 
> can't see.  There always is something else to kill to free memory so the 
> fs can be swapped back in.  And if the fs is killed surely all its pages 
> will be invalidated and thrown away by fuse, no?

They will.

Miklos
