Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUBEU6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 15:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266629AbUBEU6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 15:58:33 -0500
Received: from defout.telus.net ([199.185.220.240]:51628 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S266569AbUBEU6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 15:58:31 -0500
Subject: Re: [BUG] 2.6.2 crazy mouse under heavy load
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076014751.4682.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 05 Feb 2004 13:59:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The exception seems to be coming from
linux-2.6.2/drivers/input/mouse/psmouse-base.c, specifically from

if (psmouse->state == PSMOUSE_ACTIVATED &&
            psmouse->pktcnt && time_after(jiffies, psmouse->last +
HZ/2)) {
                printk(KERN_WARNING "psmouse.c: %s at %s lost
synchronization, throwing %d bytes away.\n",
                       psmouse->name, psmouse->phys, psmouse->pktcnt);
                psmouse->pktcnt = 0;
        }


where (for me) HZ is 1804768000, and therefore HZ/2 is 902384000,  
psmouse->pktcnt is 3, and (I assume) PSMOUSE_ACTIVATED is non-0 after
boot.  I assume that pktcnt is fed by interrupt, and the problem then is
that psmouse->last + HZ/2 blows past the jiffies value, causing the
warning message to be issued.  When mouse service finally comes back,
pktcnt is non-zero (and possibly whatever the maximum is that it will
hold), and when it flushes, the mouse pointer goes nuts for a second. 
The real problem then, is why does the sum of ps->last + HZ/2 grow to
beyond the size of jiffies (or what is delaying the mouse service)?

This is just a rough guesstimate of what is going on, but seems to fit
the facts.   Cheers!

Bob

