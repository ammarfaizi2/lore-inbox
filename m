Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVA3Kbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVA3Kbe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 05:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVA3Kbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 05:31:33 -0500
Received: from av2-1-sn3.vrr.skanova.net ([81.228.9.107]:9697 "EHLO
	av2-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261666AbVA3Kbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 05:31:31 -0500
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/4] Make mousedev.c report all events to user space immediately
From: Peter Osterlund <petero2@telia.com>
Date: 30 Jan 2005 11:31:26 +0100
Message-ID: <m34qgz9pj5.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mousedev_packet() incorrectly clears list->ready when called with
"tail == head - 1".  The effect is that the last mouse event from the
hardware isn't reported to user space until another hardware mouse
event arrives.  This can make the left mouse button get stuck when
tapping on a touchpad.  When this happens, the button doesn't unstick
until the next time you interact with the touchpad.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/input/mousedev.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/input/mousedev.c~mousedev-ready-fix drivers/input/mousedev.c
--- linux/drivers/input/mousedev.c~mousedev-ready-fix	2005-01-30 03:06:49.000000000 +0100
+++ linux-petero/drivers/input/mousedev.c	2005-01-30 03:06:49.000000000 +0100
@@ -467,10 +467,10 @@ static void mousedev_packet(struct mouse
 	}
 
 	if (!p->dx && !p->dy && !p->dz) {
-		if (list->tail != list->head)
-			list->tail = (list->tail + 1) % PACKET_QUEUE_LEN;
 		if (list->tail == list->head)
 			list->ready = 0;
+		else
+			list->tail = (list->tail + 1) % PACKET_QUEUE_LEN;
 	}
 
 	spin_unlock_irqrestore(&list->packet_lock, flags);
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
