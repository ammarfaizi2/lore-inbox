Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbTEMSeW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbTEMSeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:34:22 -0400
Received: from [216.148.213.132] ([216.148.213.132]:40425 "EHLO
	smtp.mailix.net") by vger.kernel.org with ESMTP id S262445AbTEMSeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:34:18 -0400
Date: Tue, 13 May 2003 20:46:49 +0200
From: Alex Riesen <fork0@users.sf.net>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       David Hinds <dahinds@users.sourceforge.net>
Subject: Re: 2.5.69+bk: "sleeping function called from illegal context" on card release while shutting down
Message-ID: <20030513184649.GA1366@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Paul,

your last suggestion (pcnet_close) helped. The previous patch was not
enough, of course.
I tried hard to reproduce it, and almost broke the card.
No "wrong sleepers" seen anymore.

Someone still has to remove the timer. It is not used anymore, in this
file, at least.

-alex

--- a/drivers/net/pcmcia/pcnet_cs.c	2003-05-13 20:34:12.000000000 +0200
+++ b/drivers/net/pcmcia/pcnet_cs.c	2003-05-13 20:34:08.000000000 +0200
@@ -848,7 +848,7 @@ static int pcnet_event(event_t event, in
 	link->state &= ~DEV_PRESENT;
 	if (link->state & DEV_CONFIG) {
 	    netif_device_detach(&info->dev);
-	    mod_timer(&link->release, jiffies + HZ/20);
+	    pcnet_release(link);
 	}
 	break;
     case CS_EVENT_CARD_INSERTION:
@@ -1054,7 +1054,7 @@ static int pcnet_close(struct net_device
     netif_stop_queue(dev);
     del_timer(&info->watchdog);
     if (link->state & DEV_STALE_CONFIG)
-	mod_timer(&link->release, jiffies + HZ/20);
+	pcnet_release((u_long)link);
 
     return 0;
 } /* pcnet_close */

