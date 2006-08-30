Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWH3RlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWH3RlX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWH3RlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:41:23 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:29371 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751223AbWH3RlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:41:22 -0400
Date: Wed, 30 Aug 2006 12:42:51 -0500
From: Corey Minyard <minyard@acm.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Olaf Kirch <okir@suse.de>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH] IPMI: fix occasional oops on module unload
Message-ID: <20060830174251.GA20983@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Olaf Kirch of SuSE tracked down a problem where module unloads of
the IPMI driver would occasionally result in Oopses.  He tracked
that down to a variable that wasn't always initialized properly
in some situations.  This patch initializes that variable.
Olaf sent a patch that kzalloc-ed the data, but this structure
is large enough that I would perfer to not do that.
Thanks Olaf!

Signed-off-by: Corey Minyard <minyard@acm.org>
Cc: Olaf Kirch <okir@suse.de>

Index: linux-2.6.17/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.17.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.17/drivers/char/ipmi/ipmi_msghandler.c
@@ -3470,6 +3470,7 @@ struct ipmi_recv_msg *ipmi_alloc_recv_ms
 
 	rv = kmalloc(sizeof(struct ipmi_recv_msg), GFP_ATOMIC);
 	if (rv) {
+		rv->user = NULL;
 		rv->done = free_recv_msg;
 		atomic_inc(&recv_msg_inuse_count);
 	}
