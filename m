Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbTEMPTe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTEMPTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:19:34 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:6951 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261388AbTEMPTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:19:32 -0400
Subject: Re: 2.5.69+bk: "sleeping function called from illegal context" on
	card release while shutting down
From: Paul Fulghum <paulkf@microgate.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: alexander.riesen@synopsys.COM, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1052837896.1000.2.camel@teapot.felipe-alfaro.com>
References: <20030513135759.GG32559@Synopsys.COM>
	 <1052837896.1000.2.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052839860.2255.19.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 May 2003 10:31:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-13 at 09:58, Felipe Alfaro Solana wrote:
> On Tue, 2003-05-13 at 15:57, Alex Riesen wrote:
> > Just tried to eject the card while the system was shutting down.

> Don't know if this is fixed by latest Russell patches, but vanilla and
> -bk snapshots do *not* contain the latest PCMCIA/CardBus code. Is it
> possible for you to try 2.5.69-mm4?

Russell's patches do not address this.

Individual PCMCIA drivers need to be updated to call
thier release function directly when processing a
CARD_RELEASE message instead of from a timer procedure.

Similar to this patch for synclink_cs.c:

diff -u -4 -r4.9 synclink_cs.c
--- synclink_cs.c	2003/05/08 19:26:53	4.9
+++ synclink_cs.c	2003/05/13 15:29:15
@@ -814,9 +814,9 @@
     case CS_EVENT_CARD_REMOVAL:
 	    link->state &= ~DEV_PRESENT;
 	    if (link->state & DEV_CONFIG) {
 		    ((MGSLPC_INFO *)link->priv)->stop = 1;
-		    mod_timer(&link->release, jiffies + HZ/20);
+		    mgslpc_release((u_long)link);
 	    }
 	    break;
     case CS_EVENT_CARD_INSERTION:
 	    link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;

The timer link->release is initialized with the release
function (in this case mgslpc_release, but called something
else in your driver). Now it is called directly.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


