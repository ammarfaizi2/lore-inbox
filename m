Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266525AbUA3FQP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266531AbUA3FQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:16:14 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:54404 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266525AbUA3FPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:15:02 -0500
Date: Thu, 29 Jan 2004 23:59:51 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.2-rc2
Message-ID: <20040129235951.GG12308@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040129235304.GA12308@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129235304.GA12308@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates file2alias.c to support pnp ids.  It is from Takashi Iwai
<tiwai@suse.de>.

--- a/scripts/file2alias.c	2004-01-09 06:59:33.000000000 +0000
+++ b/scripts/file2alias.c	2004-01-29 20:34:35.000000000 +0000
@@ -176,6 +176,29 @@
 	return 1;
 }
 
+/* looks like: "pnp:dD" */
+static int do_pnp_entry(const char *filename,
+			struct pnp_device_id *id, char *alias)
+{
+	sprintf(alias, "pnp:d%s", id->id);
+	return 1;
+}
+
+/* looks like: "pnp:cCdD..." */
+static int do_pnp_card_entry(const char *filename,
+			struct pnp_card_device_id *id, char *alias)
+{
+	int i;
+
+	sprintf(alias, "pnp:c%s", id->id);
+	for (i = 0; i < PNP_MAX_DEVICES; i++) {
+		if (! *id->devs[i].id)
+			break;
+		sprintf(alias + strlen(alias), "d%s", id->devs[i].id);
+	}
+	return 1;
+}
+
 /* Ignore any prefix, eg. v850 prepends _ */
 static inline int sym_is(const char *symbol, const char *name)
 {
@@ -242,6 +265,12 @@
 	else if (sym_is(symname, "__mod_ccw_device_table"))
 		do_table(symval, sym->st_size, sizeof(struct ccw_device_id),
 			 do_ccw_entry, mod);
+	else if (sym_is(symname, "__mod_pnp_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct pnp_device_id),
+			 do_pnp_entry, mod);
+	else if (sym_is(symname, "__mod_pnp_card_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct pnp_card_device_id),
+			 do_pnp_card_entry, mod);
 }
 
 /* Now add out buffered information to the generated C source */
