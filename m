Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261408AbREQMFa>; Thu, 17 May 2001 08:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbREQMFU>; Thu, 17 May 2001 08:05:20 -0400
Received: from zeus.kernel.org ([209.10.41.242]:19934 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261406AbREQMFJ>;
	Thu, 17 May 2001 08:05:09 -0400
Message-ID: <3B03BD9D.16662D1C@uow.edu.au>
Date: Thu, 17 May 2001 22:01:33 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] preserve symlinked .configs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When one has several machines it is nice to keep each
machine's .config under revision control.  Then, on
each machine,

	ln [-s] .config-$(hostname -s) .config

Problem is, `make menuconfig/oldconfig/config' goes and
removes your link, causing much irritation.

--- linux-2.4.4-ac9/scripts/Configure	Sun Dec 31 13:16:13 2000
+++ ac/scripts/Configure	Sun May  6 09:40:25 2001
@@ -566,9 +566,10 @@
 
 rm -f .config.old
 if [ -f .config ]; then
-	mv .config .config.old
+	cp .config .config.old
 fi
-mv .tmpconfig .config
+cp .tmpconfig .config
+rm .tmpconfig
 mv .tmpconfig.h include/linux/autoconf.h
 
 echo
--- linux-2.4.4-ac9/scripts/Menuconfig	Tue May 15 14:11:09 2001
+++ ac/scripts/Menuconfig	Wed May  9 11:33:30 2001
@@ -1290,12 +1290,12 @@
 
 		if [ -f "$DEF_CONFIG" ]
 		then
-			rm -f ${DEF_CONFIG}.old
-			mv $DEF_CONFIG ${DEF_CONFIG}.old
+			cp $DEF_CONFIG ${DEF_CONFIG}.old
 		fi
 
-		mv $CONFIG $DEF_CONFIG
-			
+		cp $CONFIG $DEF_CONFIG
+		rm $CONFIG
+	
 		return 0
 	else
 		return 1


-
