Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319357AbSH2VvK>; Thu, 29 Aug 2002 17:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319361AbSH2VuL>; Thu, 29 Aug 2002 17:50:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:14226 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319354AbSH2VtX>;
	Thu, 29 Aug 2002 17:49:23 -0400
Date: Thu, 29 Aug 2002 14:53:42 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       Gerrit Huizenga <gerrit@us.ibm.com>,
       Hans-J Tannenberger <hjt@us.ibm.com>,
       Janet Morgan <janetmor@us.ibm.com>, Mike Anderson <andmike@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>, linux-scsi@vger.kernel.org
Subject: Re: 2.5.32 IO performance issues
Message-ID: <20020829145342.A25892@eng2.beaverton.ibm.com>
References: <3D6E6B64.66203783@zip.com.au> <200208292055.g7TKte224951@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200208292055.g7TKte224951@eng2.beaverton.ibm.com>; from pbadari@us.ibm.com on Thu, Aug 29, 2002 at 01:55:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 01:55:40PM -0700, Badari Pulavarty wrote:
> > 
> > block-highmem is bust for scsi. (aic7xxx at least).  Does
> > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.32/2.5.32-mm2/broken-out/scsi_hack.patch
> > fix it?
> 
> Hmm !! This patch fixed it. I remember you gave me this patch for 2.5.31. But 2.5.31 
> was doing fine without it. But 2.5.32 seem to need it.
> 

The above patch works fine to get back to the previous (pre-2.5.32) state.
But, it makes no sense to modify the bounce_limit based on the type of
storage that is attached to an adapter.

We want to allow high mem for block devices other than SCSI direct access
devices (TYPE_DISK), such as CD ROM (SDpnt->type TYPE_ROM), WORM devices
(TYPE_WORM), and optical disks (TYPE_MOD).

So it is better to patch scsi_initialize_merge_fn:

--- 1.16/drivers/scsi/scsi_merge.c	Fri Jul  5 09:43:00 2002
+++ edited/drivers/scsi/scsi_merge.c	Thu Aug 29 14:30:12 2002
@@ -140,7 +140,7 @@
 	 * Enable highmem I/O, if appropriate.
 	 */
 	bounce_limit = BLK_BOUNCE_HIGH;
-	if (SHpnt->highmem_io && (SDpnt->type == TYPE_DISK)) {
+	if (SHpnt->highmem_io) {
 		if (!PCI_DMA_BUS_IS_PHYS)
 			/* Platforms with virtual-DMA translation
  			 * hardware have no practical limit.

-- Patrick Mansfield
