Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbVFVG5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbVFVG5H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbVFVGy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:54:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:15516 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262788AbVFVFV7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:59 -0400
Cc: ladis@linux-mips.org
Subject: [PATCH] I2C: ds1337: search by bus number
In-Reply-To: <11194174621986@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:42 -0700
Message-Id: <11194174622658@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: ds1337: search by bus number

Chip is searched by bus number rather than its own proprietary id.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 86919833dbeac668762ae7056ead2d35d070f622
tree 5c704a3c8fb85f44cde1102d7e6f09508427be4d
parent 00588243053bb40d0406c7843833f8fae81294ab
author Ladislav Michl <ladis@linux-mips.org> Wed, 04 May 2005 08:14:38 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:52 -0700

 drivers/i2c/chips/ds1337.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -69,13 +69,11 @@ static struct i2c_driver ds1337_driver =
 struct ds1337_data {
 	struct i2c_client client;
 	struct list_head list;
-	int id;
 };
 
 /*
  * Internal variables
  */
-static int ds1337_id;
 static LIST_HEAD(ds1337_clients);
 
 static inline int ds1337_read(struct i2c_client *client, u8 reg, u8 *value)
@@ -213,7 +211,7 @@ static int ds1337_command(struct i2c_cli
  * Public API for access to specific device. Useful for low-level
  * RTC access from kernel code.
  */
-int ds1337_do_command(int id, int cmd, void *arg)
+int ds1337_do_command(int bus, int cmd, void *arg)
 {
 	struct list_head *walk;
 	struct list_head *tmp;
@@ -221,7 +219,7 @@ int ds1337_do_command(int id, int cmd, v
 
 	list_for_each_safe(walk, tmp, &ds1337_clients) {
 		data = list_entry(walk, struct ds1337_data, list);
-		if (data->id == id)
+		if (data->client.adapter->nr == bus)
 			return ds1337_command(&data->client, cmd, arg);
 	}
 
@@ -331,7 +329,6 @@ static int ds1337_detect(struct i2c_adap
 	ds1337_init_client(new_client);
 
 	/* Add client to local list */
-	data->id = ds1337_id++;
 	list_add(&data->list, &ds1337_clients);
 
 	return 0;

