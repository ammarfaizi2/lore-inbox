Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965186AbVKVVKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbVKVVKO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbVKVVKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:10:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48031 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965200AbVKVVKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:10:09 -0500
Date: Tue, 22 Nov 2005 13:08:50 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, Greg KH <greg@kroah.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jean Delvare <khali@linux-fr.org>, Yuan Mu <Ymu@winbond.com.tw>
Subject: [patch 21/23] [PATCH] hwmon: Fix missing boundary check when setting W83627THF in0 limits
Message-ID: <20051122210850.GV28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="hwmon-w83627hf-missing-in0-limit-check.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Add SENSORS_LIMIT in store VCore limit functions. This fixes a potential
u8 overflow on out-of-range user input.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/hwmon/w83627hf.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-2.6.14.2.orig/drivers/hwmon/w83627hf.c
+++ linux-2.6.14.2/drivers/hwmon/w83627hf.c
@@ -454,7 +454,9 @@ static ssize_t store_regs_in_min0(struct
 		(w83627thf == data->type || w83637hf == data->type))
 
 		/* use VRM9 calculation */
-		data->in_min[0] = (u8)(((val * 100) - 70000 + 244) / 488);
+		data->in_min[0] =
+			SENSORS_LIMIT(((val * 100) - 70000 + 244) / 488, 0,
+					255);
 	else
 		/* use VRM8 (standard) calculation */
 		data->in_min[0] = IN_TO_REG(val);
@@ -479,7 +481,9 @@ static ssize_t store_regs_in_max0(struct
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
