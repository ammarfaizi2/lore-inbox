Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269501AbUIZHFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269501AbUIZHFX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 03:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269502AbUIZHFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 03:05:22 -0400
Received: from av7-1-sn1.fre.skanova.net ([81.228.11.113]:8892 "EHLO
	av7-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S269501AbUIZHFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 03:05:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gerd Knorr <kraxel@bytesex.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc2
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org>
	<m3ekl5de7b.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 26 Sep 2004 09:05:05 +0200
In-Reply-To: <m3ekl5de7b.fsf@telia.com>
Message-ID: <m3pt49ik7y.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Gerd Knorr:
> >   o v4l: bttv driver update
> 
> This patch,
> 
>     http://linus.bkbits.net:8080/linux-2.5/cset@4138a998OBJaigDdWZo3Y58C5Brqlg?nav=index.html|ChangeSet@-2w
> 
> makes my computer lock up or instantly reboot when I try to do a tv
> recording with mplayer.

I think the patch below should be applied before 2.6.9. It fixes the
bug that made the card DMA lots of data to random memory locations,
causing lockups and instant reboots.

The problem was that the yoffset variable got modified inside the
loop, but the logic in the switch statement was meant to work on the
initial value of the yoffset variable.

(Bug fix extracted from
http://marc.theaimsgroup.com/?l=linux-kernel&m=109532814823565&w=2)

Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 linux-petero/drivers/media/video/bttv-risc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/media/video/bttv-risc.c~bttv-crash-fix drivers/media/video/bttv-risc.c
--- linux/drivers/media/video/bttv-risc.c~bttv-crash-fix	2004-09-26 08:39:52.627762048 +0200
+++ linux-petero/drivers/media/video/bttv-risc.c	2004-09-26 08:42:23.642804272 +0200
@@ -125,6 +125,7 @@ bttv_risc_planar(struct bttv *btv, struc
 	struct scatterlist *ysg;
 	struct scatterlist *usg;
 	struct scatterlist *vsg;
+	int topfield = (0 == yoffset);
 	int rc;
 
 	/* estimate risc mem: worst case is one write per page border +
@@ -153,13 +154,13 @@ bttv_risc_planar(struct bttv *btv, struc
 			chroma = 1;
 			break;
 		case 1:
-			if (!yoffset)
+			if (topfield)
 				chroma = (line & 1) == 0;
 			else
 				chroma = (line & 1) == 1;
 			break;
 		case 2:
-			if (!yoffset)
+			if (topfield)
 				chroma = (line & 3) == 0;
 			else
 				chroma = (line & 3) == 2;
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
