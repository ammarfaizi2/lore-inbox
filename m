Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268995AbUIAG0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268995AbUIAG0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 02:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268988AbUIAG0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 02:26:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32747 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268995AbUIAG0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 02:26:34 -0400
Date: Tue, 31 Aug 2004 23:26:28 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Clemens Schwaighofer <cs@tequila.co.jp>, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: oops in 2.6.8.1-mm4 and usb
Message-Id: <20040831232628.39dae8a3@lembas.zaitcev.lan>
In-Reply-To: <mailman.1093944725.30419.linux-kernel2news@redhat.com>
References: <mailman.1093944725.30419.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004 18:26:51 +0900
Clemens Schwaighofer <cs@tequila.co.jp> wrote:

> So I could mount it and then copied some files there. But when I tried
> to unmount the disk light on the iriver never went of. So after ~1 hour
> I just pulled the usb cable. I got the oops (see below).

> end_request: I/O error, dev uba, sector 64
> FAT bread failed in fat_clusters_flush
> Unable to handle kernel NULL pointer dereference at virtual address 0000004c
> EFLAGS: 00010202   (2.6.8.1-mm4)
> EIP is at kobject_get+0xf/0x4e
> ~ [<c02b03ee>] get_device+0x18/0x21
> ~ [<c02b0209>] device_remove_file+0x1b/0x4e
> ~ [<e19d7e4c>] ub_disconnect+0x105/0x1b5 [ub]
> ~ [<c032d855>] usb_unbind_interface+0x7a/0x7c
> ~ [<c02b1271>] device_release_driver+0x64/0x66
> ~ [<c02b148a>] bus_remove_device+0x64/0xa5
> ~ [<c02b045e>] device_del+0x5d/0x9b
> ~ [<c0334ac1>] usb_disable_device+0xb9/0xf9

This oops is very mysterious, because it indicates that sc->intf was
NULL, which is not possible when device_remove_file was called.

I'll look at it. For the moment, just make sure you have this:

--- linux-2.6.8.1-mm3/drivers/block/ub.c	2004-08-20 21:37:29.000000000 -0700
+++ linux-2.6.8.1-mm3-ub/drivers/block/ub.c	2004-08-31 23:12:53.918679808 -0700
@@ -1185,9 +1217,17 @@
 		goto error;
 	}
 
+	/*
+	 * ``If the allocation length is eighteen or greater, and a device
+	 * server returns less than eithteen bytes of data, the application
+	 * client should assume that the bytes not transferred would have been
+	 * zeroes had the device server returned those bytes.''
+	 */
 	memset(&sc->top_sense, 0, UB_SENSE_SIZE);
+
 	scmd = &sc->top_rqs_cmd;
 	scmd->cdb[0] = REQUEST_SENSE;
+	scmd->cdb[4] = UB_SENSE_SIZE;
 	scmd->cdb_len = 6;
 	scmd->dir = UB_DIR_READ;
 	scmd->state = UB_CMDST_INIT;

It won't resolve your oops, but at least the I/O should succeed now,
so you would have a chance to unmount the thing before unplugging.

-- Pete
