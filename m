Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVDEQwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVDEQwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVDEQwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:52:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:154 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261822AbVDEQsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:48:46 -0400
Date: Tue, 5 Apr 2005 09:46:05 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
Subject: [01/08] Fix Oops with ALSA timer event notification
Message-ID: <20050405164604.GB17299@kroah.com>
References: <20050405164539.GA17299@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405164539.GA17299@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

the patch below fixes the bug of ALSA timer notification, which is
used in the recent ALSA dmix plugin.

 - fixed Oops in read()
 - fixed wake-up polls and signals with new events

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux/sound/core/timer.c	20 Jan 2005 17:37:00 -0000	1.50
+++ linux/sound/core/timer.c	14 Mar 2005 22:07:32 -0000
@@ -1117,7 +1117,8 @@
 	if (tu->qused >= tu->queue_size) {
 		tu->overrun++;
 	} else {
-		memcpy(&tu->queue[tu->qtail++], tread, sizeof(*tread));
+		memcpy(&tu->tqueue[tu->qtail++], tread, sizeof(*tread));
+		tu->qtail %= tu->queue_size;
 		tu->qused++;
 	}
 }
@@ -1140,6 +1141,8 @@
 	spin_lock(&tu->qlock);
 	snd_timer_user_append_to_tqueue(tu, &r1);
 	spin_unlock(&tu->qlock);
+	kill_fasync(&tu->fasync, SIGIO, POLL_IN);
+	wake_up(&tu->qchange_sleep);
 }
 
 static void snd_timer_user_tinterrupt(snd_timer_instance_t *timeri,
