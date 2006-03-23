Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWCWJPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWCWJPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWCWJPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:15:40 -0500
Received: from pro75-4-82-238-201-39.fbx.proxad.net ([82.238.201.39]:57231
	"EHLO puako.maunakeatech.zone") by vger.kernel.org with ESMTP
	id S1751394AbWCWJPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:15:39 -0500
From: Jean-Baptiste MUR <jeanbaptiste@maunakeatech.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] ieee1394/ohci1394 : CycleTooLong interrupt management
Date: Thu, 23 Mar 2006 10:15:29 +0100
User-Agent: KMail/1.8.3
Cc: linux1394-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200603171437.57519.jeanbaptiste@maunakeatech.com> <tkrat.6f7cb1ffe1d70bc4@s5r6.in-berlin.de>
In-Reply-To: <tkrat.6f7cb1ffe1d70bc4@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xcmIEwAaO5KQiyQ"
Message-Id: <200603231015.29960.jeanbaptiste@maunakeatech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_xcmIEwAaO5KQiyQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry for pollution. I have updated the patch accordingly to your comments.
It seems my mailer don't like tab very much so I send it as an attachment.
I hope this will be ok.

Jean-Baptiste

On Friday 17 March 2006 22:01, Stefan Richter wrote:
> Jean-Baptiste MUR wrote:
> ...
> > Kernel version : 2.6.16-rc4
> 
> (actually plus an ohci1394 patch from the linux1394 development tree)
> 
> ...
> > +                /* If this event occurs, we try to reactivate the "cycle 
> > master" bit. */
> > +                reg_write(ohci, OHCI1394_LinkControlSet, 
> > OHCI1394_LinkControl_CycleMaster);
> ...
> 
> Three minor nits:
> 
> There are tabs replaced by spaces and superfluous line breaks inserted
> in your posting. Take care that the mailer does not mangle whitespace.
> If you cannot prevent this nor switch the mailer, send the patch as
> attachment without recoding (i.e. 7bit encoding, not base64 or the
> like).
> 
> Take care of a maximum line length of 80 characters. For example:
> 
> 		/* Try to reactivate the "cycle master" bit. */
> 		reg_write(ohci, OHCI1394_LinkControlSet,
> 			  OHCI1394_LinkControl_CycleMaster);
> 
> The comment is unnecessary since the actual code is clear enough, at
> least IMO.
> 
> Anyway, thanks again for identifying this problem.
> -- 
> Stefan Richter
> -=====-=-==- --== =---=
> http://arcgraph.de/sr/
> 

--Boundary-00=_xcmIEwAaO5KQiyQ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="CycleTooLong.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="CycleTooLong.patch"

diff --git a/drivers/ieee1394/ohci1394.c b/drivers/ieee1394/ohci1394.c
index ab01a54..a240b2a 100644
--- a/drivers/ieee1394/ohci1394.c
+++ b/drivers/ieee1394/ohci1394.c
@@ -580,6 +580,7 @@ static void ohci_initialize(struct ti_oh
 		  OHCI1394_isochRx |
 		  OHCI1394_isochTx |
 		  OHCI1394_postedWriteErr |
+		  OHCI1394_cycleTooLong |
 		  OHCI1394_cycleInconsistent);
 
 	/* Enable link */
@@ -2386,6 +2387,15 @@ static irqreturn_t ohci_irq_handler(int 
 		PRINT(KERN_ERR, "physical posted write error");
 		/* no recovery strategy yet, had to involve protocol drivers */
 	}
+	if (event & OHCI1394_cycleTooLong) {
+		if(printk_ratelimit())
+			PRINT(KERN_WARNING, "isochronous cycle too long");
+		else
+			DBGMSG("OHCI1394_cycleTooLong");
+		reg_write(ohci, OHCI1394_LinkControlSet, 
+			  OHCI1394_LinkControl_CycleMaster);
+		event &= ~OHCI1394_cycleTooLong;
+	}
 	if (event & OHCI1394_cycleInconsistent) {
 		/* We subscribe to the cycleInconsistent event only to
 		 * clear the corresponding event bit... otherwise,

--Boundary-00=_xcmIEwAaO5KQiyQ--
