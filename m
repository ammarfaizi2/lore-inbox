Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131316AbRBLQY4>; Mon, 12 Feb 2001 11:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131373AbRBLQYq>; Mon, 12 Feb 2001 11:24:46 -0500
Received: from lipta.cendio.se ([193.180.23.53]:62986 "EHLO lipta.cendio.se")
	by vger.kernel.org with ESMTP id <S131316AbRBLQYb>;
	Mon, 12 Feb 2001 11:24:31 -0500
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in i810 kernel module
In-Reply-To: <0102121440560G.00759@steph> <E14SKWq-0007Dc-00@the-village.bc.nu>
From: Marcus Sundberg <marcus@cendio.se>
Date: 12 Feb 2001 17:23:32 +0100
In-Reply-To: alan@lxorguk.ukuu.org.uk's message of "Mon, 12 Feb 2001 15:04:33 +0000 (GMT)"
Message-ID: <vewvaveupn.fsf@lipta.cendio.se>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk (Alan Cox) writes:

> > I don't think this why i got this behavior but using xmms sucked 98% of the 
> > CPU time reading either mp3s or ogg files. Something is definitly wrong with 
> > this driver as ALSA ones work just fine (xmms then uses only 0.5% of the CPU 
> > time).
> 
> Or something is wrong with xmms. Right now I dont know which. I can tell you
> the speed thing is unrelated.

My patch which was included in 2.2 seems to be missing from 2.4.1.
The idea was taken from trident.c, and it keeps xmms at normal CPU
usage. Same patch against 2.4.1 would look like this, but it's
totally untested:

--- drivers/sound/i810_audio.c.orig	Thu Jan  4 21:50:17 2001
+++ drivers/sound/i810_audio.c	Mon Feb 12 17:05:48 2001
@@ -879,7 +879,9 @@
 					dmabuf->endcleared = 1;
 				}
 			}			
-			wake_up(&dmabuf->wait);
+			if (dmabuf->count < (signed)dmabuf->dmasize/2) {
+				wake_up(&dmabuf->wait);
+			}
 		}
 	}
 	/* error handling and process wake up for DAC */
@@ -899,7 +901,9 @@
 				printk("DMA overrun on send\n");
 				dmabuf->error++;
 			}
-			wake_up(&dmabuf->wait);
+			if (dmabuf->count < (signed)dmabuf->dmasize/2) {
+				wake_up(&dmabuf->wait);
+			}
 		}
 	}
 }

Also I'll have to ask you to please go and play some mirrormagic as
you promised when I sent the 2.2-patch. ;-)
As of 2.2.18 the sound in most games still sounds like crap on my
82443MX-100-based laptop with the i810_audio driver, while alsa works
quite nicely.

//Marcus
-- 
---------------------------------+---------------------------------
         Marcus Sundberg         |      Phone: +46 707 452062
   Embedded Systems Consultant   |     Email: marcus@cendio.se
        Cendio Systems AB        |      http://www.cendio.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
