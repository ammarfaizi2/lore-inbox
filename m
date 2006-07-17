Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWGQQfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWGQQfT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWGQQeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:34:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:1981 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750986AbWGQQd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:56 -0400
Date: Mon, 17 Jul 2006 09:29:20 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Takashi Iwai <tiwai@suse.de>,
       Jaroslav Kysela <perex@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 41/45] ALSA: Fix a deadlock in snd-rtctimer
Message-ID: <20060717162920.GP4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="alsa-fix-a-deadlock-in-snd-rtctimer.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: Fix a deadlock in snd-rtctimer

Fix an occasional deadlock occuring with snd-rtctimer driver,
added irqsave to the lock in tasklet (ALSA bug#952).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jaroslav Kysela <perex@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/core/timer.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.17.6.orig/sound/core/timer.c
+++ linux-2.6.17.6/sound/core/timer.c
@@ -628,8 +628,9 @@ static void snd_timer_tasklet(unsigned l
 	struct snd_timer_instance *ti;
 	struct list_head *p;
 	unsigned long resolution, ticks;
+	unsigned long flags;
 
-	spin_lock(&timer->lock);
+	spin_lock_irqsave(&timer->lock, flags);
 	/* now process all callbacks */
 	while (!list_empty(&timer->sack_list_head)) {
 		p = timer->sack_list_head.next;		/* get first item */
@@ -649,7 +650,7 @@ static void snd_timer_tasklet(unsigned l
 		spin_lock(&timer->lock);
 		ti->flags &= ~SNDRV_TIMER_IFLG_CALLBACK;
 	}
-	spin_unlock(&timer->lock);
+	spin_unlock_irqrestore(&timer->lock, flags);
 }
 
 /*

--
