Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWFCIut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWFCIut (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 04:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWFCIut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 04:50:49 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:47305 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1750772AbWFCIus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 04:50:48 -0400
Subject: [patch] Declare explicit, hardware based lock ranking in serio
From: Arjan van de Ven <arjan@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       mingo@redhat.com, arjanv@redhat.com, Linux Portal <linportal@gmail.com>
In-Reply-To: <20060602161354.687168de.akpm@osdl.org>
References: <ceccffee0606020953q545d1f3aw211da426e5cfc768@mail.gmail.com>
	 <20060602161354.687168de.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 03 Jun 2006 10:50:20 +0200
Message-Id: <1149324621.3109.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thanks.
> 
> So we're taking ps2->cmd_mutex and then we're recurring back into
> ps2_command() and then taking ps2->serio->cmd_mutex.
> 
> I suspect that's all correct/natural/expected and needs another
> make-lockdep-shut-up patch.


The PS/2 code has a natural device order and there is a one level
recursion in this device order in terms of the cmd_mutex; annotate 
this explicit recursion as ok

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/input/serio/libps2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.17-rc5-mm2/drivers/input/serio/libps2.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/input/serio/libps2.c
+++ linux-2.6.17-rc5-mm2/drivers/input/serio/libps2.c
@@ -177,7 +177,7 @@ int ps2_command(struct ps2dev *ps2dev, u
 		return -1;
 	}
 
-	mutex_lock(&ps2dev->cmd_mutex);
+	mutex_lock_nested(&ps2dev->cmd_mutex, SINGLE_DEPTH_NESTING);
 
 	serio_pause_rx(ps2dev->serio);
 	ps2dev->flags = command == PS2_CMD_GETID ? PS2_FLAG_WAITID : 0;

