Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032195AbWLGNJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032195AbWLGNJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 08:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032197AbWLGNJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 08:09:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41321 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032195AbWLGNJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 08:09:27 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061206195006.GH4587@ftp.linux.org.uk> 
References: <20061206195006.GH4587@ftp.linux.org.uk>  <20061206184145.GC4587@ftp.linux.org.uk> <20061206185140.GD4587@ftp.linux.org.uk> <20061206191820.GF4587@ftp.linux.org.uk> <20061206194641.GG4587@ftp.linux.org.uk> 
To: Al Viro <viro@ftp.linux.org.uk>, mgreer@mvista.com
Cc: Linus Torvalds <torvalds@osdl.org>, dhowells@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: ... and more... 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 07 Dec 2006 13:08:00 +0000
Message-ID: <1693.1165496880@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:

> diff --git a/drivers/i2c/chips/m41t00.c b/drivers/i2c/chips/m41t00.c

This could be done differently.  m41t00_set() is only called on that global
variable, so why pass its address in as an argument?

The old code is also wrong: m41t00_set() was being passed a pointer to an
unsigned long, but then was casting it to a pointer to an int before
dereferencing it.  This works on a 32-bit platform, but it's just asking for
trouble on a 64-bit big-endian platform.  However, the driver can only be
configured when CONFIG_PPC32=y, so it will have gone unnoticed.

David
---
Fix m41t00_set() and its usage with workqueues

From: David Howells <dhowells@redhat.com>

Fix m41t00_set() and its usage with workqueues.  It doesn't really need an
argument since it always affects the same global variable.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 drivers/i2c/chips/m41t00.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/chips/m41t00.c b/drivers/i2c/chips/m41t00.c
index 420377c..98978ab 100644
--- a/drivers/i2c/chips/m41t00.c
+++ b/drivers/i2c/chips/m41t00.c
@@ -165,11 +165,13 @@ read_err:
 }
 EXPORT_SYMBOL_GPL(m41t00_get_rtc_time);
 
+static ulong new_time;
+
 static void
-m41t00_set(void *arg)
+m41t00_set(struct work_struct *unused)
 {
 	struct rtc_time	tm;
-	int nowtime = *(int *)arg;
+	int nowtime = new_time;
 	s32 sec, min, hour, day, mon, year;
 	u8 wbuf[9], *buf = &wbuf[1], msgbuf[1] = { 0 };
 	struct i2c_msg msgs[] = {
@@ -214,16 +216,8 @@ m41t00_set(void *arg)
 		dev_err(&save_client->dev, "m41t00_set: Write error\n");
 }
 
-static ulong new_time;
-/* well, isn't this API just _lovely_? */
-static void
-m41t00_barf(struct work_struct *unusable)
-{
-	m41t00_set(&new_time);
-}
-
 static struct workqueue_struct *m41t00_wq;
-static DECLARE_WORK(m41t00_work, m41t00_barf);
+static DECLARE_WORK(m41t00_work, m41t00_set);
 
 int
 m41t00_set_rtc_time(ulong nowtime)
@@ -233,7 +227,7 @@ m41t00_set_rtc_time(ulong nowtime)
 	if (in_interrupt())
 		queue_work(m41t00_wq, &m41t00_work);
 	else
-		m41t00_set(&new_time);
+		m41t00_set(NULL);
 
 	return 0;
 }
