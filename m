Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272966AbTGaKNp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 06:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272970AbTGaKNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 06:13:45 -0400
Received: from mailf.telia.com ([194.22.194.25]:16605 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id S272966AbTGaKNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 06:13:43 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm2
References: <20030730223810.613755b4.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 31 Jul 2003 11:50:58 +0200
In-Reply-To: <20030730223810.613755b4.akpm@osdl.org>
Message-ID: <m265ljf2il.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm2/
> 
> . Several changes to the synaptics and PS/2 drivers.  People who have had
>   problems with keyboards and mice, please test and report.

Thanks for including these patches. Here is one more that is needed to
make some old synaptics touchpads work.


When setting the mode byte, don't set bits that the touchpad doesn't
understand. Those bits are reserved and setting them can lead to
weird problems, like the left button not working, as reported by Miles
Lane.


 linux-petero/drivers/input/mouse/synaptics.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff -puN drivers/input/mouse/synaptics.c~synaptics-mode-set drivers/input/mouse/synaptics.c
--- linux/drivers/input/mouse/synaptics.c~synaptics-mode-set	Wed Jul 30 21:01:18 2003
+++ linux-petero/drivers/input/mouse/synaptics.c	Wed Jul 30 21:01:18 2003
@@ -182,6 +182,7 @@ static int query_hardware(struct psmouse
 {
 	struct synaptics_data *priv = psmouse->private;
 	int retries = 0;
+	int mode;
 
 	while ((retries++ < 3) && synaptics_reset(psmouse))
 		printk(KERN_ERR "synaptics reset failed\n");
@@ -192,10 +193,13 @@ static int query_hardware(struct psmouse
 		return -1;
 	if (synaptics_capability(psmouse, &priv->capabilities, &priv->ext_cap))
 		return -1;
-	if (synaptics_set_mode(psmouse, (SYN_BIT_ABSOLUTE_MODE |
-					 SYN_BIT_HIGH_RATE |
-					 SYN_BIT_DISABLE_GESTURE |
-					 SYN_BIT_W_MODE)))
+
+	mode = SYN_BIT_ABSOLUTE_MODE | SYN_BIT_HIGH_RATE;
+	if (SYN_ID_MAJOR(priv->identity) >= 4)
+		mode |= SYN_BIT_DISABLE_GESTURE;
+	if (SYN_CAP_EXTENDED(priv->capabilities))
+		mode |= SYN_BIT_W_MODE;
+	if (synaptics_set_mode(psmouse, mode))
 		return -1;
 
 	return 0;

_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
