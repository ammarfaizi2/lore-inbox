Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbSLTXd5>; Fri, 20 Dec 2002 18:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266411AbSLTXd5>; Fri, 20 Dec 2002 18:33:57 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:36615 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266368AbSLTXd4>;
	Fri, 20 Dec 2002 18:33:56 -0500
Date: Fri, 20 Dec 2002 15:38:56 -0800
From: Greg KH <greg@kroah.com>
To: lvm-devel@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove __MOD_* from dm
Message-ID: <20021220233855.GA13962@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another patch against 2.5.52-bk that gets rid of the old __MOD_*
functions for the newer module api.  This also allows the modules to be
unloaded.

Joe, please add this to your next round of patches.

thanks,

greg k-h


# DM: convert old __MOD_INC and __MOD_DEC calls to the new style.

diff -Nru a/drivers/md/dm-target.c b/drivers/md/dm-target.c
--- a/drivers/md/dm-target.c	Fri Dec 20 15:38:41 2002
+++ b/drivers/md/dm-target.c	Fri Dec 20 15:38:41 2002
@@ -46,10 +46,14 @@
 	ti = __find_target_type(name);
 
 	if (ti) {
-		if (ti->use == 0 && ti->tt.module)
-			__MOD_INC_USE_COUNT(ti->tt.module);
+		if (ti->use == 0)
+			if (!try_module_get(ti->tt.module)) {
+				ti = NULL;
+				goto exit;
+			}
 		ti->use++;
 	}
+exit:
 	read_unlock(&_lock);
 
 	return ti;
@@ -86,8 +90,8 @@
 	struct tt_internal *ti = (struct tt_internal *) t;
 
 	read_lock(&_lock);
-	if (--ti->use == 0 && ti->tt.module)
-		__MOD_DEC_USE_COUNT(ti->tt.module);
+	if (--ti->use == 0)
+		module_put(ti->tt.module);
 
 	if (ti->use < 0)
 		BUG();
