Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269442AbUINWi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269442AbUINWi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUINWeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:34:16 -0400
Received: from av1-1-sn1.fre.skanova.net ([81.228.11.107]:52953 "EHLO
	av1-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S266200AbUINWan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 18:30:43 -0400
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc2
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org>
	<m3ekl5de7b.fsf@telia.com> <20040914094928.GF27258@bytesex>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Sep 2004 00:30:44 +0200
In-Reply-To: <20040914094928.GF27258@bytesex>
Message-ID: <m33c1kxz3f.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr <kraxel@bytesex.org> writes:

> On Mon, Sep 13, 2004 at 11:57:44PM +0200, Peter Osterlund wrote:
> > Linus Torvalds <torvalds@osdl.org> writes:
> > 
> > > Gerd Knorr:
> > >   o v4l: bttv driver update
> > 
> > This patch,
> > 
> > Output from dmesg with a working kernel: (-rc2 with the above patch reverted)
> 
> > [ ... ]
> 
> > When running the crashing kernel, the last line in /var/log/messages
> > after the crash is:
> > 
> >     bttv0: pinnacle/mt: id=2 info="PAL+SECAM / stereo" radio=yes
> > 
> > Maybe there is more data that doesn't make it to the disk. I can try
> > again with a serial console if you think that would help.
> 
> That certainly is incomplete, at least the insmod messages should be
> there if mencoder triggeres the crash.  A serial console log would be
> helpful.

I got this with a serial console:

    ...
    bttv0: ioctl 0xc02c5638 (v4l2, VIDIOC_G_FREQUENCY)
    bttv0: ioctl 0xc02c5638 (v4l2, VIDIOC_G_FREQUENCY)
    bttv0: ioctl 0xc0cc5604 (v4l2, VIDIOC_G_FMT)
    bttv0: ioctl 0xc0cc5604 (v4l2, VIDIOC_G_FMT)
    bttv0: ioctl 0xc0cc5604 (v4l2, VIDIOC_G_FMT)
    bttv0: ioctl 0xc0145608 (v4l2, VIDIOC_REQBUFS)
    bttv0: ioctl 0xc0445609 (v4l2, VIDIOC_QUERYBUF)
    bttv0: mmap type=video-cap 0xb791f000+663552
    bttv0: ioctl 0xc044560f (v4l2, VIDIOC_QBUF)
    Unable to handle kernel NULL pointer dereference at virtual a

The computer rebooted while printing the "Unable to handle..."
message. DMA engine gone wild?

> You can also try to reverse only parts of the patch, only the
> changes in bttv-driver.c and/or in bttv-risc.c and see what happens.

I found the change that crashes my computer. This patch is enough to
fix it for me:

diff -puN drivers/media/video/bttv-risc.c~v3_revert drivers/media/video/bttv-risc.c
--- linux/drivers/media/video/bttv-risc.c~v3_revert	2004-09-15 00:18:21.280831360 +0200
+++ linux-petero/drivers/media/video/bttv-risc.c	2004-09-15 00:18:21.283830904 +0200
@@ -153,16 +153,10 @@ bttv_risc_planar(struct bttv *btv, struc
 			chroma = 1;
 			break;
 		case 1:
-			if (!yoffset)
-				chroma = (line & 1) == 0;
-			else
-				chroma = (line & 1) == 1;
+			chroma = !(line & 1);
 			break;
 		case 2:
-			if (!yoffset)
-				chroma = (line & 3) == 0;
-			else
-				chroma = (line & 3) == 2;
+			chroma = !(line & 3);
 			break;
 		default:
 			chroma = 0;

> Which format+size you are capturing with mencoder?

mencoder tv:// -tv driver=v4l2:device=/dev/video0:width=768:height=576:chanlist=europe-west:norm=PAL:channel=$channel -ovc lavc -lavcopts vcodec=mpeg4:vbitrate=$vbitrate -oac mp3lame -lameopts cbr:br=$abitrate -vf pp=lb -endpos $time -o $outfile >$outfile.log 2>&1

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
