Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLWNHq>; Sat, 23 Dec 2000 08:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129480AbQLWNHg>; Sat, 23 Dec 2000 08:07:36 -0500
Received: from cicero1.cybercity.dk ([212.242.40.4]:53258 "HELO
	cicero1.cybercity.dk") by vger.kernel.org with SMTP
	id <S129228AbQLWNHc>; Sat, 23 Dec 2000 08:07:32 -0500
Date: Sat, 23 Dec 2000 13:37:37 +0100
From: Jens Axboe <axboe@suse.de>
To: David Mansfield <lkml@dm.ultramaster.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: cdrom changes in test13-pre2 slow down cdrom access by 70%
Message-ID: <20001223133737.D300@suse.de>
In-Reply-To: <3A43D48D.B1825354@dm.ultramaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22 2000, David Mansfield wrote:
> Jens, 
> 
> The cdrom changes that went into test13-pre2 really kill the performance
> of my cdrom.  I'm using cdparanoia to read audio data, and it normally
> reads at 2-3x.  Since test13-pre2 it's  down to .6 - .7x.  I've reverted
> the following files to the ones from test13-pre1 and it's back to
> normal:

Humm, interesting.

> This is a huge patch, is there some way I could break it apart to see
> what the relevant changes are?

The change affecting you is most likely the CDROMREADAUDIO change,
where we now just read a single cdda frame at the time. This gives
us less data per interrupt, and apparently this is more than a
theoretical slowdown for you. Please try with attached patch. If
this solves it (as it should), then we should probably try and do
persistent allocation of a bigger buffer for things like this.
Grabbing > 1 frame was disabled because multi-page allocation is not
reliable.

--- drivers/cdrom/cdrom.c~	Sat Dec 23 13:27:33 2000
+++ drivers/cdrom/cdrom.c	Sat Dec 23 13:30:39 2000
@@ -1985,7 +1985,7 @@
 		}
 	case CDROMREADAUDIO: {
 		struct cdrom_read_audio ra;
-		int lba;
+		int lba, frames;
 
 		IOCTL_IN(arg, struct cdrom_read_audio, ra);
 
@@ -2002,7 +2002,9 @@
 		if (lba < 0 || ra.nframes <= 0)
 			return -EINVAL;
 
-		if ((cgc.buffer = (char *) kmalloc(CD_FRAMESIZE_RAW, GFP_KERNEL)) == NULL)
+		frames = ra.nframes > 8 ? 8 : ra.nframes;
+
+		if ((cgc.buffer = (char *) kmalloc(CD_FRAMESIZE_RAW * frames, GFP_KERNEL)) == NULL)
 			return -ENOMEM;
 
 		if (!access_ok(VERIFY_WRITE, ra.buf, ra.nframes*CD_FRAMESIZE_RAW)) {
@@ -2011,12 +2013,14 @@
 		}
 		cgc.data_direction = CGC_DATA_READ;
 		while (ra.nframes > 0) {
-			ret = cdrom_read_block(cdi, &cgc, lba, 1, 1, CD_FRAMESIZE_RAW);
-			if (ret) break;
-			__copy_to_user(ra.buf, cgc.buffer, CD_FRAMESIZE_RAW);
-			ra.buf += CD_FRAMESIZE_RAW;
-			ra.nframes--;
-			lba++;
+			ret = cdrom_read_block(cdi, &cgc, lba, frames, 1, CD_FRAMESIZE_RAW);
+			if (ret)
+				break;
+			__copy_to_user(ra.buf, cgc.buffer,
+				       CD_FRAMESIZE_RAW * frames);
+			ra.buf += (CD_FRAMESIZE_RAW * frames);
+			ra.nframes -= frames;
+			lba += frames;
 		}
 		kfree(cgc.buffer);
 		return ret;

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
