Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSFQQCr>; Mon, 17 Jun 2002 12:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSFQQCq>; Mon, 17 Jun 2002 12:02:46 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:9424 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314602AbSFQQCp>; Mon, 17 Jun 2002 12:02:45 -0400
Date: Mon, 17 Jun 2002 11:02:44 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Kristian Peters <kristian.peters@korseby.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: isdn oops with 2.4.19-pre10
In-Reply-To: <20020617174746.0b8ec0a4.kristian.peters@korseby.net>
Message-ID: <Pine.LNX.4.44.0206171053450.22308-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Kristian Peters wrote:

> I'm connecting with the avmb1-card to a provider via pppd and starting
> my iptables firewall (with qos scheduling). While connected or after
> shutting down the connection unloading the hisax or isdn modules
> produces that oops. I haven't tried it without the sched-modules loaded.
> Should I ? It seems that they could be responsible too.

Actually that's the case I was thinking of. capidrv gets loaded last, but 
is not removed first.

Could you try if the appended patch fixes it?

--Kai


===== drivers/isdn/isdn_common.c 1.15 vs edited =====
--- 1.15/drivers/isdn/isdn_common.c	Tue Feb  5 08:07:05 2002
+++ edited/drivers/isdn/isdn_common.c	Mon Jun 17 10:57:11 2002
@@ -75,9 +75,11 @@
 isdn_lock_drivers(void)
 {
 	int i;
+	isdn_ctrl cmd;
 
-	for (i = 0; i < dev->drivers; i++) {
-		isdn_ctrl cmd;
+	for (i = 0; i < ISDN_MAX_DRIVERS; i++) {
+		if (!dev->drv[i])
+			continue;
 
 		cmd.driver = i;
 		cmd.arg = 0;
@@ -99,7 +101,10 @@
 {
 	int i;
 
-	for (i = 0; i < dev->drivers; i++)
+	for (i = 0; i < ISDN_MAX_DRIVERS; i++) {
+		if (!dev->drv[i])
+			continue;
+
 		if (dev->drv[i]->locks > 0) {
 			isdn_ctrl cmd;
 
@@ -109,6 +114,7 @@
 			isdn_command(&cmd);
 			dev->drv[i]->locks--;
 		}
+	}
 }
 
 void

