Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWDLPou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWDLPou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 11:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWDLPou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 11:44:50 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:24008 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750781AbWDLPot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 11:44:49 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] spufs: fix context-switch decrementer code
Date: Wed, 12 Apr 2006 17:44:27 +0200
User-Agent: KMail/1.9.1
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604121744.27674.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordi Caubet <jordi_caubet@es.ibm.com>

We found that when the 'decrementer' is saved, the PPE saves the current
time 'csa->suspend_time'. When restoring the 'decrementer', (Step 34)
decrementer seems to be adjusted with the number of cycles th= at a spu
thread has not been running.

In that code it is missing a substract ('-') because 'delta_time' is
assigned a not substracted(see bellow).

Acked-by: Mark Nutter <mnutter@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

Index: linus-2.6/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/switch.c
@@ -1299,7 +1299,7 @@ static inline void setup_decr(struct spu
 		cycles_t resume_time = get_cycles();
 		cycles_t delta_time = resume_time - csa->suspend_time;
 
-		csa->lscsa->decr.slot[0] = delta_time;
+		csa->lscsa->decr.slot[0] -= delta_time;
 	}
 }
 
