Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262826AbUKTMMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbUKTMMv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 07:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbUKTMKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 07:10:08 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:8711 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262851AbUKTMHn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 07:07:43 -0500
Date: Sat, 20 Nov 2004 13:07:42 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] I2C updates for 2.4.28 (1/5)
Message-Id: <20041120130742.06079393.khali@linux-fr.org>
In-Reply-To: <20041120125423.42527051.khali@linux-fr.org>
References: <20041120125423.42527051.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Original report and discussion:
http://archives.andrew.net.au/lm-sensors/msg18839.html

Bottom line:
i2c_register_entry shouldn't rely on the procname field to detect the
end of the control table, but on the ctl_name field. The latter is
guaranteed to be non-zero except for the table terminator, the former
can be null even in the middle of the table.

The bug wasn't caught so far because all users of this function
(basically the lm_sensors project's drivers) were exporting all entries
through /proc so procname was never null (except for the table
terminator, obviously).

Credits go to Louis-Martin Cote for discovering the bug and proposing a
fix.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.4.28-pre3/drivers/i2c/i2c-proc.c.orig	2004-09-29 22:35:29.000000000 +0200
+++ linux-2.4.28-pre3/drivers/i2c/i2c-proc.c	2004-09-29 22:34:59.000000000 +0200
@@ -152,7 +152,7 @@
 	id += 256;
 
 	len = 0;
-	while (ctl_template[len].procname)
+	while (ctl_template[len].ctl_name)
 		len++;
 	len += 7;
 	if (!(new_table = kmalloc(sizeof(ctl_table) * len, GFP_KERNEL))) {


-- 
Jean Delvare
http://khali.linux-fr.org/
