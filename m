Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbUB2Old (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 09:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbUB2Old
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 09:41:33 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:39917 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261858AbUB2Ol1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 09:41:27 -0500
Date: Sun, 29 Feb 2004 09:37:56 -0500
From: Ben Collins <bcollins@debian.org>
To: Subodh Shrivastava <subodh@btopenworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sbp2 module not initialising external hdd connected on firewire port.
Message-ID: <20040229143756.GB1078@phunnypharm.org>
References: <40409D0A.8040903@btopenworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40409D0A.8040903@btopenworld.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 28, 2004 at 01:52:10PM +0000, Subodh Shrivastava wrote:
> Hi Ben,
> 
> I am trying to connect my external HDD on firewire port. Linux is not 
> recognising this disk. Same disk is recognised in windows, also its 
> recognised in linux when connected on USB port. Attached here is my 
> .config file, lspci output, dmesg output.

Can you try the latest code from our repo at linux1394.org? Or atleast
try this patch applied to 2.6.4-rc1.


--- ieee1394-2.6/drivers/ieee1394/csr1212.c	(revision 1120)
+++ ieee1394-2.6/drivers/ieee1394/csr1212.c	(working copy)
@@ -704,10 +704,11 @@
 			if (k->key.type == CSR1212_KV_TYPE_DIRECTORY) {
 				/* If the current entry is a directory, then move all
 				 * the entries to the destruction list. */
-				tail->next = k->value.directory.dentries_head;
-				if (k->value.directory.dentries_head)
+				if (k->value.directory.dentries_head) {
+					tail->next = k->value.directory.dentries_head;
 					k->value.directory.dentries_head->prev = tail;
-				tail = k->value.directory.dentries_tail;
+					tail = k->value.directory.dentries_tail;
+                                }
 			}
 			free_keyval(k);
 			k = a;
@@ -1347,6 +1348,12 @@
 	case CSR1212_KV_TYPE_DIRECTORY:
 		for (i = 0; i < kvi_len; i++) {
 			csr1212_quad_t ki = kvi->data[i];
+
+			/* Some devices put null entries in their unit
+			 * directories.  If we come across such and entry,
+			 * then skip it. */
+			if (ki == 0x0)
+				continue;
 			ret = csr1212_parse_dir_entry(kv, ki,
 						      (kv->offset +
 						       quads_to_bytes(i + 1)),

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
