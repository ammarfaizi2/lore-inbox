Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVDXTpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVDXTpj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 15:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVDXTpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 15:45:39 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:8655 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S262374AbVDXTpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 15:45:32 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3 fails to read partition table
Date: Sun, 24 Apr 2005 19:15:44 GMT
Message-ID: <055UQU811@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Tonneau wrote:
>
> 2.6.11 and 2.6.11.7 work fine.
> 2.6.12-rc1 2.6.12-rc2 and 2.6.12-rc3 fail to read partiton table on my laptop,
> also 2.6.12-rc3 works fine on another box also running FullPliant.

I tracked down the trouble to the following patch.
Partitions with type 0 are now ignored, and my hda1 single partition has been
unwisely set so.
The question might be: is it a good idea to introduce that extra constrain
in the middle of a stable serie ?

diff -urN linux-2.6.11/fs/partitions/msdos.c linux-2.6.12-rc3/fs/partitions/msdos.c
--- linux-2.6.11/fs/partitions/msdos.c	2005-03-01 23:38:12.000000000 -0800
+++ linux-2.6.12-rc3/fs/partitions/msdos.c	2005-04-20 17:03:15.000000000 -0700
@@ -114,6 +114,9 @@
 		 */
 		for (i=0; i<4; i++, p++) {
 			u32 offs, size, next;
+
+			if (SYS_IND(p) == 0)
+				continue;
 			if (!NR_SECTS(p) || is_extended_partition(p))
 				continue;
 
@@ -430,6 +433,8 @@
 	for (slot = 1 ; slot <= 4 ; slot++, p++) {
 		u32 start = START_SECT(p)*sector_size;
 		u32 size = NR_SECTS(p)*sector_size;
+		if (SYS_IND(p) == 0)
+			continue;
 		if (!size)
 			continue;
 		if (is_extended_partition(p)) {

