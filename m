Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTLKBcl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbTLKBbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:31:37 -0500
Received: from mail.kroah.org ([65.200.24.183]:63183 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264337AbTLKBaZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:30:25 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10711061483686@kroah.com>
Subject: Re: [PATCH] USB Fixes for 2.6.0-test11
In-Reply-To: <10711061482794@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 10 Dec 2003 17:29:08 -0800
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1526, 2003/12/10 16:00:53-08:00, arvidjaar@mail.ru

[PATCH] USB: prevent catch-all USB aliases in modules.alias

visor.c defines one empty slot in USB ids table that can be filled in at
runtime using module parameters. file2alias generates catch-all alias for it:

alias usb:v*p*dl*dh*dc*dsc*dp*ic*isc*ip* visor

patch adds the same sanity check as in depmod to scripts/file2alias.


 scripts/file2alias.c |    7 +++++++
 1 files changed, 7 insertions(+)


diff -Nru a/scripts/file2alias.c b/scripts/file2alias.c
--- a/scripts/file2alias.c	Wed Dec 10 16:46:45 2003
+++ b/scripts/file2alias.c	Wed Dec 10 16:46:45 2003
@@ -52,6 +52,13 @@
 	id->bcdDevice_lo = TO_NATIVE(id->bcdDevice_lo);
 	id->bcdDevice_hi = TO_NATIVE(id->bcdDevice_hi);
 
+	/*
+	 * Some modules (visor) have empty slots as placeholder for
+	 * run-time specification that results in catch-all alias
+	 */
+	if (!(id->idVendor | id->bDeviceClass | id->bInterfaceClass))
+		return 1;
+
 	strcpy(alias, "usb:");
 	ADD(alias, "v", id->match_flags&USB_DEVICE_ID_MATCH_VENDOR,
 	    id->idVendor);

