Return-Path: <linux-kernel-owner+w=401wt.eu-S964996AbXAMGiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbXAMGiF (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 01:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbXAMGiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 01:38:04 -0500
Received: from ns.suse.de ([195.135.220.2]:56819 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964996AbXAMGiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 01:38:03 -0500
From: Oliver Neukum <oneukum@suse.de>
Organization: Novell
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [patch]cleanup and error reporting for sound/core/init.c
Date: Sat, 13 Jan 2007 07:37:59 +0100
User-Agent: KMail/1.9.1
Cc: Jaroslav Kysela <perex@suse.cz>, linux-sound@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200701121449.58186.oneukum@suse.de> <s5h64bcgmzn.wl%tiwai@suse.de>
In-Reply-To: <s5h64bcgmzn.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701130737.59435.oneukum@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 12. Januar 2007 18:42 schrieb Takashi Iwai:
> At Fri, 12 Jan 2007 14:49:57 +0100,
> Oliver Neukum wrote:
> > 
> > +	} else {
> > +		 if (idx < snd_ecards_limit) {
> > +			if (snd_cards_lock & (1 << idx))
> > +				err = -EBUSY;	/* invalid */
> > +		} else if (idx < SNDRV_CARDS)
> > +				snd_ecards_limit = idx + 1; /* increase the limit */
> > +			else
> > +				err = -ENODEV;
> 
> The indent looks strange in the above three lines.
> Also, for me it's not much better than before... :)
> (all if's are comparisons of idx with other values.)

Hi,

OK, how about this one? The original indentation makes the control
flow very hard to follow.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oneukum@suse.de>
--

--- sound/core/init.c.alt	2007-01-12 14:26:47.000000000 +0100
+++ sound/core/init.c	2007-01-13 07:34:29.000000000 +0100
@@ -114,22 +114,28 @@
 	if (idx < 0) {
 		int idx2;
 		for (idx2 = 0; idx2 < SNDRV_CARDS; idx2++)
+			/* idx == -1 == 0xffff means: take any free slot */
 			if (~snd_cards_lock & idx & 1<<idx2) {
 				idx = idx2;
 				if (idx >= snd_ecards_limit)
 					snd_ecards_limit = idx + 1;
 				break;
 			}
-	} else if (idx < snd_ecards_limit) {
-		if (snd_cards_lock & (1 << idx))
-			err = -ENODEV;	/* invalid */
-	} else if (idx < SNDRV_CARDS)
-		snd_ecards_limit = idx + 1; /* increase the limit */
-	else
-		err = -ENODEV;
+	} else {
+		 if (idx < snd_ecards_limit) {
+			if (snd_cards_lock & (1 << idx))
+				err = -EBUSY;	/* invalid */
+		} else {
+			if (idx < SNDRV_CARDS)
+				snd_ecards_limit = idx + 1; /* increase the limit */
+			else
+				err = -ENODEV;
+		}
+	}
 	if (idx < 0 || err < 0) {
 		mutex_unlock(&snd_card_mutex);
-		snd_printk(KERN_ERR "cannot find the slot for index %d (range 0-%i)\n", idx, snd_ecards_limit - 1);
+		snd_printk(KERN_ERR "cannot find the slot for index %d (range 0-%i), error: %d\n",
+			 idx, snd_ecards_limit - 1, err);
 		goto __error;
 	}
 	snd_cards_lock |= 1 << idx;		/* lock it */

