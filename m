Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVBHXmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVBHXmK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 18:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVBHXkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 18:40:51 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:64605 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261695AbVBHXkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 18:40:16 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Joseph Pingenot <trelane@digitasaru.net>
Subject: [PATCH] Fix ALPS sync loss
Date: Tue, 8 Feb 2005 18:40:12 -0500
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Peter Osterlund <petero2@telia.com>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502081840.12520.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the promised patch. It turns out protocol validation code was
a bit (or rather a byte ;) ) off.

Please let me know if it fixes your touchpad and I believe it would be
nice to have it in 2.6.11.

-- 
Dmitry


===================================================================


ChangeSet@1.2147, 2005-02-08 18:12:06-05:00, dtor_core@ameritech.net
  Input: alps - fix protocol validation rules causing touchpad
         to lose sync if an absolute packet is received after
         a relative packet with negative Y displacement.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  


 alps.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
--- a/drivers/input/mouse/alps.c	2005-02-08 18:16:27 -05:00
+++ b/drivers/input/mouse/alps.c	2005-02-08 18:16:27 -05:00
@@ -198,8 +198,8 @@
 		return PSMOUSE_BAD_DATA;
 
 	/* Bytes 2 - 6 should have 0 in the highest bit */
-	if (psmouse->pktcnt > 1 && psmouse->pktcnt <= 6 &&
-	    (psmouse->packet[psmouse->pktcnt] & 0x80))
+	if (psmouse->pktcnt >= 2 && psmouse->pktcnt <= 6 &&
+	    (psmouse->packet[psmouse->pktcnt - 1] & 0x80))
 		return PSMOUSE_BAD_DATA;
 
 	if (psmouse->pktcnt == 6) {
