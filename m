Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWCJVMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWCJVMu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 16:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWCJVMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 16:12:50 -0500
Received: from gold.veritas.com ([143.127.12.110]:59522 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932259AbWCJVMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 16:12:49 -0500
X-IronPort-AV: i="4.02,181,1139212800"; 
   d="scan'208"; a="56993551:sNHT31228408"
Date: Fri, 10 Mar 2006 21:13:44 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix pcmcia_device_probe oops
Message-ID: <Pine.LNX.4.61.0603102111460.4517@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Mar 2006 21:12:47.0502 (UTC) FILETIME=[61944AE0:01C64487]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix pcmcia_device_probe NULL pointer dereference at startup.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
This oops was in -mm for a long time, sorry, I never got around to
investigating it then; but now it has graduated to mainline -rc5-git.
It may well be a consequence of my ignoring pcmcia's "please expect
breakage unless you upgrade to new tools" - but I think this is not a
permissible kind of breakage, and my cards work as before with the fix.

 drivers/pcmcia/ds.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6.16-rc5-git14/drivers/pcmcia/ds.c	2006-03-10 10:07:30.000000000 +0000
+++ linux/drivers/pcmcia/ds.c	2006-03-10 17:16:27.000000000 +0000
@@ -411,7 +411,7 @@ static int pcmcia_device_probe(struct de
 	 * pseudo devices, and if not, add the second one.
 	 */
 	did = (struct pcmcia_device_id *) p_dev->dev.driver_data;
-	if ((did->match_flags & PCMCIA_DEV_ID_MATCH_DEVICE_NO) &&
+	if (did && (did->match_flags & PCMCIA_DEV_ID_MATCH_DEVICE_NO) &&
 	    (p_dev->socket->device_count == 1) && (p_dev->device_no == 0))
 		pcmcia_add_pseudo_device(p_dev->socket);
 
