Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263219AbUEBUGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbUEBUGT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 16:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbUEBUGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 16:06:19 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:39438 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S263219AbUEBUGQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 16:06:16 -0400
Date: Sun, 2 May 2004 22:06:32 +0200
From: Jean Delvare <khali@linux-fr.org>
To: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Cc: greg@kroah.com, vsu@altlinux.ru,
       "Mark M. Hoffman" <mhoffman@lightlink.com>
Subject: [PATCH 2.6] Fix memory leaks in w83781d and asb100
Message-Id: <20040502220632.06cefb60.khali@linux-fr.org>
In-Reply-To: <20040417145309.4831f2b6.khali@linux-fr.org>
References: <20040403191023.08f60ff1.khali@linux-fr.org>
	<20040403202042.GA3898@sirius.home>
	<20040409173158.GC15820@kroah.com>
	<20040410165832.08e0c80d.khali@linux-fr.org>
	<20040417145309.4831f2b6.khali@linux-fr.org>
Reply-To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting myself

> U-ho. I think I've introduced a memory leak with this patch :(
> 
> For drivers that handle subclients (asb100 and w83781d on i2c), the
> sublient memory is never released if I read the code correctly. This
> is because we now free the private data on unload, assuming that it
> contains the i2c client data as well. That's true for the main i2c
> client, but not for the subclients (data == NULL so nothing is freed).
> 
> Could someone take a look and confirm?

I could test and actually saw memory leaking when cycling the w83781d
driver at a sustained rate (5/s).

> I can see two different fixes:
> 
> 1* When freeing the memory, free the data if it's not NULL (main
> client), else free client (subclients). Cleaner (I suppose?).
> 
> 2* When creating subclients, do data = &client instead of data = NULL.
> Then freeing will work. Less code, faster. Are there side effects? (I
> don't think so)
> 
> My preference would go to 2*.

I ended up implementing 1*. That's cleaner and there's actually almost
no extra code.

Mark, can you confirm that I'm doing the correct thing? I'll do
something similar in our CVS repository (for now, the asb100 and w83781d
drivers had not their memory allocation scheme reworked there).

Greg, please apply if it looks good to you. Sorry for introducing the
leak in the first place...

Thanks.

--- linux-2.6.6-rc3/drivers/i2c/chips/asb100.c.orig	Sun May  2 13:52:29 2004
+++ linux-2.6.6-rc3/drivers/i2c/chips/asb100.c	Sun May  2 21:51:17 2004
@@ -855,7 +855,13 @@
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	if (i2c_get_clientdata(client)==NULL) {
+		/* subclients */
+		kfree(client);
+	} else {
+		/* main client */
+		kfree(i2c_get_clientdata(client));
+	}
 
 	return 0;
 }
--- linux-2.6.6-rc3/drivers/i2c/chips/w83781d.c.orig	Sun May  2 15:09:44 2004
+++ linux-2.6.6-rc3/drivers/i2c/chips/w83781d.c	Sun May  2 21:51:11 2004
@@ -1336,7 +1336,13 @@
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	if (i2c_get_clientdata(client)==NULL) {
+		/* subclients */
+		kfree(client);
+	} else {
+		/* main client */
+		kfree(i2c_get_clientdata(client));
+	}
 
 	return 0;
 }



-- 
Jean Delvare
http://khali.linux-fr.org/
