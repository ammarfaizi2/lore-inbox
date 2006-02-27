Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWB0LIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWB0LIK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 06:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWB0LIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 06:08:10 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:61373 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S1750743AbWB0LIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 06:08:09 -0500
From: Marc Zyngier <maz@misterjones.org>
To: R.E.Wolff@BitWizard.nl
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: [PATCH] Fix Specialix SX corruption
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: maz@misterjones.org
Date: Mon, 27 Feb 2006 12:08:00 +0100
Message-ID: <wrpk6bh9i0f.fsf@wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: 192.168.70.139
X-SA-Exim-Rcpt-To: R.E.Wolff@BitWizard.nl, linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org, alan@lxorguk.ukuu.org.uk
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on young-lust.wild-wind.fr.eu.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger,

With the latest kernels, I experienced some strange corruption, some
'*****' being randomly inserted in the character flow, like this:

ashes:~#
ashes:~#
a*******shes:~#
ashes:~#
ashes:~#

Further investigation shows that the problem was introduced during
Alan's "TTY layer buffering revamp" patch, the amount of data to be
copied being reduced after buffer allocation. Moving the count fixup
around solves the problem.

Patch against v2.6.16-rc5.

Signed-off-by: Marc Zyngier <maz@misterjones.org>

diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index 588e75e..a6b4f02 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -1095,17 +1095,17 @@ static inline void sx_receive_chars (str
 
 		sx_dprintk (SX_DEBUG_RECEIVE, "rxop=%d, c = %d.\n", rx_op, c); 
 
+		/* Don't copy past the end of the hardware receive buffer */
+		if (rx_op + c > 0x100) c = 0x100 - rx_op;
+
+		sx_dprintk (SX_DEBUG_RECEIVE, "c = %d.\n", c);
+
 		/* Don't copy more bytes than there is room for in the buffer */
 
 		c = tty_prepare_flip_string(tty, &rp, c);
 
 		sx_dprintk (SX_DEBUG_RECEIVE, "c = %d.\n", c); 
 
-		/* Don't copy past the end of the hardware receive buffer */
-		if (rx_op + c > 0x100) c = 0x100 - rx_op;
-
-		sx_dprintk (SX_DEBUG_RECEIVE, "c = %d.\n", c);
-
 		/* If for one reason or another, we can't copy more data, we're done! */
 		if (c == 0) break;
 

-- 
And if you don't know where you're going, any road will take you there...
