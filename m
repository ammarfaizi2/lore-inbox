Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbTEMRU2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbTEMRU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:20:28 -0400
Received: from us02smtp1.synopsys.com ([198.182.60.75]:48312 "HELO
	vaxjo.synopsys.com") by vger.kernel.org with SMTP id S261661AbTEMRU0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:20:26 -0400
Date: Tue, 13 May 2003 19:33:01 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.5.69+bk: "sleeping function called from illegal context" on card release while shutting down
Message-ID: <20030513173301.GA4826@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
References: <20030513135759.GG32559@Synopsys.COM> <1052837896.1000.2.camel@teapot.felipe-alfaro.com> <1052839860.2255.19.camel@diemos> <20030513172114.GH32559@Synopsys.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513172114.GH32559@Synopsys.COM>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen, Tue, May 13, 2003 19:21:14 +0200:
> Paul Fulghum, Tue, May 13, 2003 17:31:01 +0200:
> > Individual PCMCIA drivers need to be updated to call
> > thier release function directly when processing a
> > CARD_RELEASE message instead of from a timer procedure.
> > 
> > Similar to this patch for synclink_cs.c:
> ...
> > -		    mod_timer(&link->release, jiffies + HZ/20);
> > +		    mgslpc_release((u_long)link);
> 
> Tried that. This time the trace looks different:
> 

I was probably too fast with the conclusions. It seemed I didn't update
modules (though I and bash history distinctly remember doing that).

I cannot reproduce the trace anymore. The patch was:

--- pcnet_cs.c	2003-04-30 06:17:05.000000000 +0200
+++ pcnet_cs.c	2003-05-13 19:31:12.000000000 +0200
@@ -848,7 +848,7 @@ static int pcnet_event(event_t event, in
 	link->state &= ~DEV_PRESENT;
 	if (link->state & DEV_CONFIG) {
 	    netif_device_detach(&info->dev);
-	    mod_timer(&link->release, jiffies + HZ/20);
+	    pcnet_release((u_long)link);
 	}
 	break;
     case CS_EVENT_CARD_INSERTION:
