Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVBXVyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVBXVyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbVBXVxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:53:01 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:41999 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262506AbVBXVto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:49:44 -0500
Date: Thu, 24 Feb 2005 22:49:57 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Stefan Eletzhofer <Stefan.Eletzhofer@eletztrick.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] Remove NULL client checks in rtc8564 driver
Message-Id: <20050224224957.278cdcd8.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Several functions in your rtc8564 driver verify the non-NULLity of the
i2c client that is passed to them. It doesn't seem to be necessary, as I
can't think of any case where these functions could possibly be called
with a NULL i2c client. As a matter of fact, I couldn't find any similar
driver doing such checks.

My attention was brought on this by Coverity's SWAT which correctly
noticed that three of these functions contain explicit or hidden
dereferences of the i2c client pointer *before* the NULL check. I guess
it wasn't a problem because the NULL case cannot happen (unless I miss
something), but this still is confusing code.

Thus I propose the following changes:

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-rc4/drivers/i2c/chips/rtc8564.c.orig	Fri Dec 24 22:33:49 2004
+++ linux-2.6.11-rc4/drivers/i2c/chips/rtc8564.c	Thu Feb 24 10:56:52 2005
@@ -89,7 +89,7 @@ static int rtc8564_read(struct i2c_clien
 
 	_DBG(1, "client=%p, adr=%d, buf=%p, len=%d", client, adr, buf, len);
 
-	if (!buf || !client) {
+	if (!buf) {
 		ret = -EINVAL;
 		goto done;
 	}
@@ -111,7 +111,7 @@ static int rtc8564_write(struct i2c_clie
 	struct i2c_msg wr;
 	int i;
 
-	if (!client || !data || len > 15) {
+	if (!data || len > 15) {
 		ret = -EINVAL;
 		goto done;
 	}
@@ -222,7 +222,7 @@ static int rtc8564_get_datetime(struct i
 
 	_DBG(1, "client=%p, dt=%p", client, dt);
 
-	if (!dt || !client)
+	if (!dt)
 		return -EINVAL;
 
 	memset(buf, 0, sizeof(buf));
@@ -256,7 +256,7 @@ rtc8564_set_datetime(struct i2c_client *
 
 	_DBG(1, "client=%p, dt=%p", client, dt);
 
-	if (!dt || !client)
+	if (!dt)
 		return -EINVAL;
 
 	_DBGRTCTM(2, *dt);
@@ -295,7 +295,7 @@ static int rtc8564_get_ctrl(struct i2c_c
 {
 	struct rtc8564_data *data = i2c_get_clientdata(client);
 
-	if (!ctrl || !client)
+	if (!ctrl)
 		return -1;
 
 	*ctrl = data->ctrl;
@@ -307,7 +307,7 @@ static int rtc8564_set_ctrl(struct i2c_c
 	struct rtc8564_data *data = i2c_get_clientdata(client);
 	unsigned char buf[2];
 
-	if (!ctrl || !client)
+	if (!ctrl)
 		return -1;
 
 	buf[0] = *ctrl & 0xff;
@@ -320,7 +320,7 @@
 static int rtc8564_read_mem(struct i2c_client *client, struct mem *mem)
 {
 
-	if (!mem || !client)
+	if (!mem)
 		return -EINVAL;
 
 	return rtc8564_read(client, mem->loc, mem->data, mem->nr);
@@ -329,7 +329,7 @@
 static int rtc8564_write_mem(struct i2c_client *client, struct mem *mem)
 {
 
-	if (!mem || !client)
+	if (!mem)
 		return -EINVAL;
 
 	return rtc8564_write(client, mem->loc, mem->data, mem->nr);


Side question: how/when is rtc8564_command called exactly? I think I
understand it has to do with ioctls, but besides that I'm kind of lost.
Can someone explain to me how it works?

Thanks,
-- 
Jean Delvare
