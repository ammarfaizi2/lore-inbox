Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVEWXs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVEWXs7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVEWXqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:46:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:12422 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261250AbVEWX04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:26:56 -0400
Date: Mon, 23 May 2005 16:26:26 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, gjasny@web.de,
       annabellesgarden@yahoo.de
Subject: [patch 09/16] usbaudio: prevent oops & dead keyboard on usb unplugging
Message-ID: <20050523232626.GU27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523231529.GL27549@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: prevent oops & dead keyboard on usb unplugging while the device is being used

Without this patch, some usb kobjects, which are parents to
the usx2y's kobjects can be freed before the usx2y's.
This led to an oops in get_kobj_path_length() and a dead
keyboard, when the usx2y's kobjects were freed.
The patch ensures the correct sequence.
Tested ok on kernel 2.6.12-rc2.

Present in ALSA cvs

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 sound/usb/usbaudio.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.11.10.orig/sound/usb/usbaudio.c	2005-05-16 10:52:18.000000000 -0700
+++ linux-2.6.11.10/sound/usb/usbaudio.c	2005-05-20 09:36:37.396488696 -0700
@@ -3276,7 +3276,7 @@
 		}
 		usb_chip[chip->index] = NULL;
 		up(&register_mutex);
-		snd_card_free_in_thread(card);
+		snd_card_free(card);
 	} else {
 		up(&register_mutex);
 	}
