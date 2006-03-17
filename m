Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932632AbWCQNiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbWCQNiH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWCQNiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:38:06 -0500
Received: from pro75-4-82-238-201-39.fbx.proxad.net ([82.238.201.39]:12170
	"EHLO puako.maunakeatech.zone") by vger.kernel.org with ESMTP
	id S932635AbWCQNiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:38:05 -0500
From: Jean-Baptiste MUR <jeanbaptiste@maunakeatech.com>
To: linux1394-devel@lists.sourceforge.net
Subject: [PATCH] ieee1394/ohci1394 : CycleTooLong interrupt management
Date: Fri, 17 Mar 2006 14:37:57 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603171437.57519.jeanbaptiste@maunakeatech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch modifies the ohci1394.c file to enable and manage the "cycle too 
long" interrupt. 
If this interrupt occurs, the "LinkControl.CycleMaster" bit of the host 
controller is reseted. This implies, that the host controller does not send 
"cycle start" packet anymore freezing then the isochronous communication. 
The management of the interrupt added by the patch is that when the interrupt 
occurs, the OHCI irq handler prints a kernel log warning and then sets the 
"LinkControl.CycleMaster" bit again resuming the isochronous communication.

Signed-off-by : Jean-Baptiste Mur <jeanbaptiste@maunakeatech.com>

---

Kernel version : 2.6.16-rc4

#############Patch begin
diff --git a/drivers/ieee1394/ohci1394.c b/drivers/ieee1394/ohci1394.c
index ab01a54..33850eb 100644
--- a/drivers/ieee1394/ohci1394.c
+++ b/drivers/ieee1394/ohci1394.c
@@ -580,6 +580,7 @@ static void ohci_initialize(struct ti_oh
                  OHCI1394_isochRx |
                  OHCI1394_isochTx |
                  OHCI1394_postedWriteErr |
+                  OHCI1394_cycleTooLong |
                  OHCI1394_cycleInconsistent);

        /* Enable link */
@@ -2386,6 +2387,15 @@ static irqreturn_t ohci_irq_handler(int
                PRINT(KERN_ERR, "physical posted write error");
                /* no recovery strategy yet, had to involve protocol drivers 
*/
        }
+        if (event & OHCI1394_cycleTooLong) {
+                if(printk_ratelimit())
+                        PRINT(KERN_WARNING, "isochronous cycle too long");
+                else
+                        DBGMSG("OHCI1394_cycleTooLong");
+                /* If this event occurs, we try to reactivate the "cycle 
master" bit. */
+                reg_write(ohci, OHCI1394_LinkControlSet, 
OHCI1394_LinkControl_CycleMaster);
+                event &= ~OHCI1394_cycleTooLong;
+        }
        if (event & OHCI1394_cycleInconsistent) {
                /* We subscribe to the cycleInconsistent event only to
                 * clear the corresponding event bit... otherwise,
#############Patch end
