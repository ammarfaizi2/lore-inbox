Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWHDFoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWHDFoG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWHDFnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:43:55 -0400
Received: from mx1.suse.de ([195.135.220.2]:63204 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030320AbWHDFnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:43:51 -0400
Date: Thu, 3 Aug 2006 22:39:13 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Juan Pedro Paredes Caballero <juampe@iquis.com>,
       Duncan Sands <baldrick@free.fr>, Andrew Beverley <andy@andybev.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 08/23] UHCI: Fix handling of short last packet
Message-ID: <20060804053913.GI769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="uhci-fix-handling-of-short-last-packet.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Alan Stern <stern@rowland.harvard.edu>

This patch (as753) fixes the way uhci-hcd handles a short packet when it
is the last packet of an URB.  Right now the driver handles short packets
the same no matter when they occur.  However, the controller stops
transferring packets when the short packet is not the last one (otherwise
it would be reading beyond the end of the device's data) and needs to be
restarted, whereas no such need occurs when the short packet is the last
one.

The result of the bug is that USB endpoint queues experience intermittent
hangs, a regression in 2.6.17 with respect to earlier kernels.  The bug
was raised in Bugzilla #6752 and this patch fixed it.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/usb/host/uhci-q.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.17.7.orig/drivers/usb/host/uhci-q.c
+++ linux-2.6.17.7/drivers/usb/host/uhci-q.c
@@ -896,12 +896,14 @@ static int uhci_result_common(struct uhc
 			/*
 			 * This URB stopped short of its end.  We have to
 			 * fix up the toggles of the following URBs on the
-			 * queue and restart the queue.
+			 * queue and restart the queue.  But only if this
+			 * TD isn't the last one in the URB.
 			 *
 			 * Do this only the first time we encounter the
 			 * short URB.
 			 */
-			if (!urbp->short_transfer) {
+			if (!urbp->short_transfer &&
+					&td->list != urbp->td_list.prev) {
 				urbp->short_transfer = 1;
 				urbp->qh->initial_toggle =
 						uhci_toggle(td_token(td)) ^ 1;

--
