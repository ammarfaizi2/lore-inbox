Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932726AbVJCX4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbVJCX4T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 19:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbVJCX4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 19:56:19 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57745
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932726AbVJCX4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 19:56:19 -0400
Date: Mon, 03 Oct 2005 16:56:16 -0700 (PDT)
Message-Id: <20051003.165616.70305022.davem@davemloft.net>
To: jmacbaine@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.13 crash on sparc64 in sunsu_kbd_ms_interrupt
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051003.165046.126193591.davem@davemloft.net>
References: <3afbacad050831085155914ef6@mail.gmail.com>
	<20051003.165046.126193591.davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 03 Oct 2005 16:50:46 -0700 (PDT)

> Please turn off CONFIG_PREEMPT on sparc64, it really doesn't
> get very much testing on this platform.

Nevermind, there is a real bug there in the sunsu driver.
We drop/retake the lock when it's not actually held.

The preempt debugging was good at catching this. :-)

Please try this fix, thanks.

diff-tree 62ba86fc7c72edc77a67e04b6fb593db5046cc92 (from baaf9033270c9cb10c1441195bc1a0a7665bee7e)
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon Oct 3 16:55:10 2005 -0700

    [SUNSU]: Fix bogus locking in sunsu_change_mouse_baud()
    
    The lock is not held when calling this function, so we
    shouldn't drop then reacquire it.
    
    Based upon a report from Jim MacBaine.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
--- a/drivers/serial/sunsu.c
+++ b/drivers/serial/sunsu.c
@@ -518,11 +518,7 @@ static void sunsu_change_mouse_baud(stru
 
 	quot = up->port.uartclk / (16 * new_baud);
 
-	spin_unlock(&up->port.lock);
-
 	sunsu_change_speed(&up->port, up->cflag, 0, quot);
-
-	spin_lock(&up->port.lock);
 }
 
 static void receive_kbd_ms_chars(struct uart_sunsu_port *up, struct pt_regs *regs, int is_break)
