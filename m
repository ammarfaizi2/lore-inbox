Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262968AbVAKX7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbVAKX7Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbVAKXlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:41:45 -0500
Received: from coderock.org ([193.77.147.115]:7366 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262941AbVAKXfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:35:17 -0500
Subject: [patch 06/11] Re: sbus/aurora: replace schedule_timeout() with msleep_interruptible()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com,
       janitor@sternwelten.at
From: domen@coderock.org
Date: Wed, 12 Jan 2005 00:35:08 +0100
Message-Id: <20050111233508.9D5E81F226@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Description: Use msleep_interruptible() instead of
schedule_timeout() to guarantee the task delays as expected.

On Wed, Sep 29, 2004 at 06:10:06PM +0200, Domen Puncer wrote:
> On 27/09/04 10:24 -0700, Nishanth Aravamudan wrote:
> > -			current->state = TASK_INTERRUPTIBLE;
> > -			schedule_timeout(port->close_delay);
> > +			msleep_interruptible(port->close_delay);
> 
> I think you forgot jiffies_to_msecs here.

Please find the corrected patch below.
Thanks for catching this, Domen.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/sbus/char/aurora.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/sbus/char/aurora.c~msleep_interruptible-drivers_sbus_char_aurora drivers/sbus/char/aurora.c
--- kj/drivers/sbus/char/aurora.c~msleep_interruptible-drivers_sbus_char_aurora	2005-01-10 18:00:11.000000000 +0100
+++ kj-domen/drivers/sbus/char/aurora.c	2005-01-10 18:00:11.000000000 +0100
@@ -1519,8 +1519,7 @@ static void aurora_close(struct tty_stru
 		 */
 		timeout = jiffies+HZ;
 		while(port->SRER & SRER_TXEMPTY)  {
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(port->timeout);
+			msleep_interruptible(jiffies_to_msecs(port->timeout));
 			if (time_after(jiffies, timeout))
 				break;
 		}
@@ -1537,8 +1536,7 @@ static void aurora_close(struct tty_stru
 	port->tty = 0;
 	if (port->blocked_open) {
 		if (port->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(port->close_delay);
+			msleep_interruptible(jiffies_to_msecs(port->close_delay));
 		}
 		wake_up_interruptible(&port->open_wait);
 	}
_
