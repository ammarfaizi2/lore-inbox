Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUG2O0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUG2O0g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264702AbUG2OIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:08:52 -0400
Received: from styx.suse.cz ([82.119.242.94]:21398 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265082AbUG2OIO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:14 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 17/47] Fix boundary checks for GUSAGE/SUSAGE in hiddev.
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:55 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <1091110195893@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101953746@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.117.4, 2004-06-06 11:37:43+02:00, herbert@gondor.apana.org.au
  input: Fix boundary checks for GUSAGE/SUSAGE in hiddev.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 hiddev.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c	Thu Jul 29 14:41:02 2004
+++ b/drivers/usb/input/hiddev.c	Thu Jul 29 14:41:02 2004
@@ -638,16 +638,22 @@
 				goto inval;
 
 			field = report->field[uref->field_index];
-			if (uref->usage_index >= field->maxusage)
-				goto inval;
 
-			if (cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) {
-				if (uref_multi->num_values >= HID_MAX_MULTI_USAGES || 
-				    uref->usage_index >= field->maxusage || 
-				   (uref->usage_index + uref_multi->num_values) >= field->maxusage)
+			if (cmd == HIDIOCGCOLLECTIONINDEX) {
+				if (uref->usage_index >= field->maxusage)
 					goto inval;
+			} else if (uref->usage_index >= field->report_count)
+				goto inval;
+
+			else if ((cmd == HIDIOCGUSAGES ||
+				  cmd == HIDIOCSUSAGES) &&
+				 (uref->usage_index + uref_multi->num_values >=
+				  field->report_count ||
+				  uref->usage_index + uref_multi->num_values <
+				  uref->usage_index))
+				goto inval;
+
 			}
-		}
 
 		switch (cmd) {
 			case HIDIOCGUSAGE:

