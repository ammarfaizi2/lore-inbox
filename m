Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262631AbSK0Nnp>; Wed, 27 Nov 2002 08:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbSK0Nnp>; Wed, 27 Nov 2002 08:43:45 -0500
Received: from penguin-ext.wise.edt.ericsson.se ([193.180.251.47]:51376 "EHLO
	penguin.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S262631AbSK0Nno>; Wed, 27 Nov 2002 08:43:44 -0500
From: =?iso-8859-1?q?K=E5re=20S=E4rs?= <Kare.Sars@lmf.ericsson.se>
Reply-To: Kare.Sars@lmf.ericsson.se
Organization: Oy LM Ericsson Ab
To: Rui Prior <rprior@inescn.pt>
Subject: nicstar ATM bug patch
Date: Wed, 27 Nov 2002 15:50:45 +0200
User-Agent: KMail/1.4.3
Cc: mitch@sfgoth.com, Christoph Hellwig <hch@lst.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_LGM87GHWADTRF7HRSFZ5"
Message-Id: <200211271550.45445.Kare.Sars@lmf.ericsson.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_LGM87GHWADTRF7HRSFZ5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi!

I'm not sure who to send this patch to, but here goes.

I have encountered a bug in the nicstar ATM driver for linux.
If you open a CBR TX only connection on a specific vpi/vci and later open a RX 
only connection on the same vpi/vci, the RX connection will overwrite the 
pointer to the SCQ of the TX connection. This changes the cell rate of the TX 
channel and what is worse is that when the TX connection is closed we get a 
segmentationfault and the TX part of the vpi/vci remains reserved.

The bug in the driver is that if the opened channel is not TX CBR, the driver 
assumes it is TX UBR. I have attached a patch that adds a check for TX UBR. 
The patch is against RedHat kernel 2.4.18-3. I have checked linux vanilla 
kernels 2.4.19 and 2.5.49 and not found a fix.


Kåre Särs


--------------Boundary-00=_LGM87GHWADTRF7HRSFZ5
Content-Type: text/x-diff;
  charset="us-ascii";
  name="nicstar_ubr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="nicstar_ubr.patch"

--- linux/drivers/atm/nicstar.c	Wed Oct 16 15:45:13 2002
+++ linux/drivers/atm/nicstar.c	Wed Oct 16 15:46:10 2002
@@ -1597,7 +1597,7 @@
          
 	 fill_tst(card, n, vc);
       }
-      else /* not CBR */
+      else if (vcc->qos.txtp.traffic_class == ATM_UBR)
       {
          vc->cbr_scd = 0x00000000;
 	 vc->scq = card->scq0;

--------------Boundary-00=_LGM87GHWADTRF7HRSFZ5--

