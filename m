Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbVITHwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbVITHwr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbVITHwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:52:47 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:12757 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S964913AbVITHwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:52:46 -0400
Date: Tue, 20 Sep 2005 00:53:25 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Markus.Lidel@shadowconnect.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.git] Fix I2O config-osm init to return proper error
Message-ID: <20050920075325.GA11867@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We currently unregister the config-osm driver if initialization of the
legacy ioctl() handlers failed but still return success. We should be
returning -EBUSY in this case.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/drivers/message/i2o/config-osm.c b/drivers/message/i2o/config-osm.c
--- a/drivers/message/i2o/config-osm.c
+++ b/drivers/message/i2o/config-osm.c
@@ -56,8 +56,11 @@ static int __init i2o_config_init(void)
 		return -EBUSY;
 	}
 #ifdef CONFIG_I2O_CONFIG_OLD_IOCTL
-	if (i2o_config_old_init())
+	if (i2o_config_old_init()) {
+		osm_err("old config handler initialization failed\n");
 		i2o_driver_unregister(&i2o_config_driver);
+		return -EBUSY;
+	}
 #endif
 
 	return 0;

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
