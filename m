Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318308AbSGYAek>; Wed, 24 Jul 2002 20:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318309AbSGYAek>; Wed, 24 Jul 2002 20:34:40 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:4872 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318308AbSGYAei>;
	Wed, 24 Jul 2002 20:34:38 -0400
Date: Wed, 24 Jul 2002 17:37:36 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: i810_audio.c cli/sti fix
Message-ID: <20020725003735.GA12682@kroah.com>
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 26 Jun 2002 23:36:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small patch to get the i810_audio.c driver working again.

thanks,

greg k-h


diff -Nru a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
--- a/sound/oss/i810_audio.c	Wed Jul 24 17:35:31 2002
+++ b/sound/oss/i810_audio.c	Wed Jul 24 17:35:32 2002
@@ -1733,7 +1733,7 @@
 		}
 
 		spin_unlock_irqrestore(&state->card->lock, flags);
-		synchronize_irq();
+		synchronize_irq(state->card->irq);
 		dmabuf->ready = 0;
 		dmabuf->swptr = dmabuf->hwptr = 0;
 		dmabuf->count = dmabuf->total_bytes = 0;
@@ -2814,15 +2814,15 @@
 		}
 		dmabuf->count = dmabuf->dmasize;
 		outb(31,card->iobase+dmabuf->write_channel->port+OFF_LVI);
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
+		local_irq_disable();
 		start_dac(state);
 		offset = i810_get_dma_addr(state, 0);
 		mdelay(50);
 		new_offset = i810_get_dma_addr(state, 0);
 		stop_dac(state);
 		outb(2,card->iobase+dmabuf->write_channel->port+OFF_CR);
-		restore_flags(flags);
+		local_irq_restore(flags);
 		i = new_offset - offset;
 #ifdef DEBUG
 		printk("i810_audio: %d bytes in 50 milliseconds\n", i);
