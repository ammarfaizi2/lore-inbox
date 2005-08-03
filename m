Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVHCGxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVHCGxJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVHCGvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:51:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60634 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262118AbVHCGtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:49:13 -0400
Date: Tue, 2 Aug 2005 23:48:38 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org,
       "alan@lxorguk.ukuu.org.uk Andrew Vasquez" <andrew.vasquez@qlogic.com>,
       Michael Reed <mdr@sgi.com>
Subject: [02/13] qla2xxx: Correct handling of fc_remote_port_add() failure case.
Message-ID: <20050803064838.GQ7762@shell0.pdx.osdl.net>
References: <20050803064439.GO7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803064439.GO7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

Correct handling of fc_remote_port_add() failure case.

Immediately return if fc_remote_port_add() fails to allocate
resources for the rport.  Original code would result in NULL
pointer dereference upon failure.

Reported-by: Michael Reed <mdr@sgi.com>

Signed-off-by: Andrew Vasquez <andrew.vasquez@qlogic.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/scsi/qla2xxx/qla_init.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.12.3.orig/drivers/scsi/qla2xxx/qla_init.c	2005-07-28 11:17:01.000000000 -0700
+++ linux-2.6.12.3/drivers/scsi/qla2xxx/qla_init.c	2005-07-28 11:17:08.000000000 -0700
@@ -1914,9 +1914,11 @@
 		rport_ids.roles |= FC_RPORT_ROLE_FCP_TARGET;
 
 	fcport->rport = rport = fc_remote_port_add(ha->host, 0, &rport_ids);
-	if (!rport)
+	if (!rport) {
 		qla_printk(KERN_WARNING, ha,
 		    "Unable to allocate fc remote port!\n");
+		return;
+	}
 
 	if (rport->scsi_target_id != -1 && rport->scsi_target_id < MAX_TARGETS)
 		fcport->os_target_id = rport->scsi_target_id;
