Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbWHDFnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbWHDFnz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWHDFni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:43:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:47588 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030315AbWHDFn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:43:28 -0400
Date: Thu, 3 Aug 2006 22:38:45 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 04/23] scx200_acb: Fix the state machine
Message-ID: <20060804053845.GE769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="i2c-01-scx200_acb-fix-state-machine.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Thomas Andrews <tandrews@grok.co.za>

Fix the scx200_acb state machine:

* Nack was sent one byte too late on reads >= 2 bytes.
* Stop bit was set one byte too late on reads.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/i2c/busses/scx200_acb.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.17.7.orig/drivers/i2c/busses/scx200_acb.c
+++ linux-2.6.17.7/drivers/i2c/busses/scx200_acb.c
@@ -181,21 +181,21 @@ static void scx200_acb_machine(struct sc
 		break;
 
 	case state_read:
-		/* Set ACK if receiving the last byte */
-		if (iface->len == 1)
+		/* Set ACK if _next_ byte will be the last one */
+		if (iface->len == 2)
 			outb(inb(ACBCTL1) | ACBCTL1_ACK, ACBCTL1);
 		else
 			outb(inb(ACBCTL1) & ~ACBCTL1_ACK, ACBCTL1);
 
-		*iface->ptr++ = inb(ACBSDA);
-		--iface->len;
-
-		if (iface->len == 0) {
+		if (iface->len == 1) {
 			iface->result = 0;
 			iface->state = state_idle;
 			outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
 		}
 
+		*iface->ptr++ = inb(ACBSDA);
+		--iface->len;
+
 		break;
 
 	case state_write:

--
