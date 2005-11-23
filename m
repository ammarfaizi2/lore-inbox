Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030519AbVKWXrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030519AbVKWXrT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVKWXqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:46:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:21186 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751325AbVKWXqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:30 -0500
Date: Wed, 23 Nov 2005 15:44:21 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       khali@linux-fr.org, Ymu@winbond.com.tw
Subject: [patch 05/22] hwmon: Fix missing boundary check when setting W83627THF in0 limits
Message-ID: <20051123234421.GF527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="hwmon-w83627hf-missing-in0-limit-check.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuan Mu <Ymu@winbond.com.tw>

Add SENSORS_LIMIT in store VCore limit functions. This fixes a potential
u8 overflow on out-of-range user input.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/hwmon/w83627hf.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- usb-2.6.orig/drivers/hwmon/w83627hf.c
+++ usb-2.6/drivers/hwmon/w83627hf.c
@@ -456,7 +456,9 @@ static ssize_t store_regs_in_min0(struct
 		(w83627thf == data->type || w83637hf == data->type))
 
 		/* use VRM9 calculation */
-		data->in_min[0] = (u8)(((val * 100) - 70000 + 244) / 488);
+		data->in_min[0] =
+			SENSORS_LIMIT(((val * 100) - 70000 + 244) / 488, 0,
+					255);
 	else
 		/* use VRM8 (standard) calculation */
 		data->in_min[0] = IN_TO_REG(val);
@@ -481,7 +483,9 @@ static ssize_t store_regs_in_max0(struct
 		(w83627thf == data->type || w83637hf == data->type))
 		
 		/* use VRM9 calculation */
-		data->in_max[0] = (u8)(((val * 100) - 70000 + 244) / 488);
+		data->in_max[0] =
+			SENSORS_LIMIT(((val * 100) - 70000 + 244) / 488, 0,
+					255);
 	else
 		/* use VRM8 (standard) calculation */
 		data->in_max[0] = IN_TO_REG(val);

--
