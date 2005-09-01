Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030386AbVIAVRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbVIAVRD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbVIAVRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:17:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21733 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030386AbVIAVRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:17:01 -0400
Date: Thu, 1 Sep 2005 17:16:47 -0400
From: Alan Cox <alan@redhat.com>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: Alan Cox <alan@redhat.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
Message-ID: <20050901211647.GC25405@devserv.devel.redhat.com>
References: <20050901035542.1c621af6.akpm@osdl.org> <6970000.1125584568@[10.10.2.4]> <20050901145006.GF5427@devserv.devel.redhat.com> <43176AE8.8060105@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43176AE8.8060105@austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 03:56:08PM -0500, Joel Schopp wrote:
> There are at least a couple other spots where flip got missed, after 
> fixing the count and flip problem mentioned these come up:
> 
> drivers/char/hvcs.c:459: error: structure has no member named `flip'
> drivers/char/hvcs.c:472: error: structure has no member named `flip'

Try the diff below although I suspect much of the extra logic can go
away and something like

	len = tty_buffer_request_root(tty, HVCS_BUFF_LEN);
	if(len) {
		len = hvc_get_chars(...., len);
		tty_insert_flip_string(tty, buf, len);
	}

is better.


--- drivers/char/hvcs.c~	2005-09-01 22:08:42.205515648 +0100
+++ drivers/char/hvcs.c	2005-09-01 22:08:42.206515496 +0100
@@ -456,12 +456,11 @@
 	/* remove the read masks */
 	hvcsd->todo_mask &= ~(HVCS_READ_MASK);
 
-	if ((tty->flip.count + HVCS_BUFF_LEN) < TTY_FLIPBUF_SIZE) {
+	if (tty_buffer_request_room(tty, HVCS_BUFF_LEN) >= HVCS_BUFF_LEN) {
 		got = hvc_get_chars(unit_address,
 				&buf[0],
 				HVCS_BUFF_LEN);
-		for (i=0;got && i<got;i++)
-			tty_insert_flip_char(tty, buf[i], TTY_NORMAL);
+		tty_insert_flip_string(tty, buf, got);
 	}
 
 	/* Give the TTY time to process the data we just sent. */
@@ -469,10 +468,9 @@
 		hvcsd->todo_mask |= HVCS_QUICK_READ;
 
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	if (tty->flip.count) {
-		/* This is synch because tty->low_latency == 1 */
+	/* This is synch because tty->low_latency == 1 */
+	if(got)
 		tty_flip_buffer_push(tty);
-	}
 
 	if (!got) {
 		/* Do this _after_ the flip_buffer_push */
