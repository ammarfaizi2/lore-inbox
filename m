Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbUCPOrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUCPOqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:46:00 -0500
Received: from styx.suse.cz ([82.208.2.94]:27521 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261891AbUCPOT3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:29 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467762838@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 1/44] Fix hid-core for devices with #usages < #values
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:36 +0100
In-Reply-To: <20040316141703.GA5214@ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1474.188.1, 2004-01-26 13:15:32+01:00, jamesl@appliedminds.com
  input: Fix hid-core for devices that have less usages than values
         in a hid report. We could iterate beyond the end of array of
         usages before.


 hid-core.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Tue Mar 16 13:20:15 2004
+++ b/drivers/usb/input/hid-core.c	Tue Mar 16 13:20:15 2004
@@ -224,6 +224,9 @@
 	offset = report->size;
 	report->size += parser->global.report_size * parser->global.report_count;
 
+	if (usages < parser->global.report_count)
+		usages = parser->global.report_count;
+
 	if (usages == 0)
 		return 0; /* ignore padding fields */
 
@@ -235,9 +238,13 @@
 	field->application = hid_lookup_collection(parser, HID_COLLECTION_APPLICATION);
 
 	for (i = 0; i < usages; i++) {
-		field->usage[i].hid = parser->local.usage[i];
+		int j = i;
+		/* Duplicate the last usage we parsed if we have excess values */
+		if (i >= parser->local.usage_index)
+			j = parser->local.usage_index - 1;
+		field->usage[i].hid = parser->local.usage[j];
 		field->usage[i].collection_index =
-			parser->local.collection_index[i];
+			parser->local.collection_index[j];
 	}
 
 	field->maxusage = usages;

