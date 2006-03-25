Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWCYEJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWCYEJy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWCYEJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:09:53 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:23783
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750768AbWCYEJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:09:52 -0500
Date: Fri, 24 Mar 2006 20:09:31 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, rolandd@cisco.com,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [PATCH 01/08] IB/srp: Don't send task management commands after target removal
Message-ID: <20060325040931.GB16955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325040852.GA16955@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>

Just fail abort and reset requests that come in after we've already
decided to remove a target.  This fixes a nasty crash if a storage
target goes away.

Signed-off-by: Roland Dreier <rolandd@cisco.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

This is upstream in Linus's tree as 1285b3a0b0aa2391ac6f6939e6737203c8220f68

 drivers/infiniband/ulp/srp/ib_srp.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.15.6.orig/drivers/infiniband/ulp/srp/ib_srp.c
+++ linux-2.6.15.6/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1154,6 +1154,12 @@ static int srp_send_tsk_mgmt(struct scsi
 
 	spin_lock_irq(target->scsi_host->host_lock);
 
+	if (target->state == SRP_TARGET_DEAD ||
+	    target->state == SRP_TARGET_REMOVED) {
+		scmnd->result = DID_BAD_TARGET << 16;
+		goto out;
+	}
+
 	if (scmnd->host_scribble == (void *) -1L)
 		goto out;
 
