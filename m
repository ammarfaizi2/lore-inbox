Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWANV1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWANV1d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 16:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWANV1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 16:27:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:4756 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751297AbWANV1C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 16:27:02 -0500
Cc: akpm@osdl.org
Subject: [PATCH] spi: remove fastcall crap
In-Reply-To: <11371995933448@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 16:46:33 -0800
Message-Id: <11371995933258@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] spi: remove fastcall crap

gcc4 generates warnings when a non-FASTCALL function pointer is assigned to a
FASTCALL one.  Perhaps it has taste.

Cc: David Brownell <david-b@pacbell.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5d870c8e216f121307445c71caa72e7e10a20061
tree d1d73cf5e520a10086f9a50a00fecb6041def89d
parent 7111763d391b0c5a949a4f2575aa88cd585f0ff6
author Andrew Morton <akpm@osdl.org> Wed, 11 Jan 2006 11:23:49 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 16:29:56 -0800

 drivers/spi/spi.c       |    7 ++++++-
 include/linux/spi/spi.h |    2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cdb242d..791c4dc 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -480,6 +480,11 @@ EXPORT_SYMBOL_GPL(spi_busnum_to_master);
 
 /*-------------------------------------------------------------------------*/
 
+static void spi_complete(void *arg)
+{
+	complete(arg);
+}
+
 /**
  * spi_sync - blocking/synchronous SPI data transfers
  * @spi: device with which data will be exchanged
@@ -508,7 +513,7 @@ int spi_sync(struct spi_device *spi, str
 	DECLARE_COMPLETION(done);
 	int status;
 
-	message->complete = (void (*)(void *)) complete;
+	message->complete = spi_complete;
 	message->context = &done;
 	status = spi_async(spi, message);
 	if (status == 0)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 939afd3..b05f146 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -374,7 +374,7 @@ struct spi_message {
 	 */
 
 	/* completion is reported through a callback */
-	void 			FASTCALL((*complete)(void *context));
+	void 			(*complete)(void *context);
 	void			*context;
 	unsigned		actual_length;
 	int			status;

