Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268520AbUJPFsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268520AbUJPFsv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 01:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268525AbUJPFsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 01:48:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26064 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268520AbUJPFss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 01:48:48 -0400
Date: Fri, 15 Oct 2004 22:48:22 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: schwidefsky@de.ibm.com
Cc: viro@parcelfarce.linux.theplanet.co.uk, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Patch to add RAID autostart to IBM partitions
Message-ID: <20041015224822.7d980a9e@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs119.1 (GTK+ 2.4.7; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, guys:

This is an implementation of essentially the same mechanism which exists
in msdos.c and sun.c. It is needed when initrd tries to mount a root
on a RAID. One might ask, why the heck initrd cannot do it without a
kernel help. The answer is in the contrived API of the MD driver: there
is no way to ask "assemble md0"; applications must list components.
Anyway, if msdos.c does it, surely ibm.c ought to do it as well.

Please apply.

-- Pete

P.S. Martin: this is for bug LTC10616.

diff -urp -X dontdiff linux-2.6.9-rc4-mm1/fs/partitions/ibm.c linux-2.6.9-rc4-mm1-autoraid/fs/partitions/ibm.c
--- linux-2.6.9-rc4-mm1/fs/partitions/ibm.c	2003-10-01 15:18:05.000000000 -0700
+++ linux-2.6.9-rc4-mm1-autoraid/fs/partitions/ibm.c	2004-10-15 22:38:12.712453680 -0700
@@ -129,6 +129,7 @@ ibm_partition(struct parsed_partitions *
 		while ((data = read_dev_sector(bdev, blk*(blocksize/512),
 					       &sect)) != NULL) {
 			format1_label_t f1;
+			char *ch;
 
 			memcpy(&f1, data, sizeof(format1_label_t));
 			put_dev_sector(sect);
@@ -154,6 +155,14 @@ ibm_partition(struct parsed_partitions *
 			put_partition(state, counter + 1, 
 					 offset * (blocksize >> 9),
 					 size * (blocksize >> 9));
+
+			/* Corrupting the label buffer now to save the stack. */
+			EBCASC(f1.DS1DSNAM, 44);
+			f1.DS1DSNAM[44] = 0;
+			ch = strstr(f1.DS1DSNAM, "PART");
+			if (ch != NULL && strncmp(ch + 9, "RAID  ", 6) == 0)
+				state->parts[counter + 1].flags = 1;
+
 			counter++;
 			blk++;
 		}
