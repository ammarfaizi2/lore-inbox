Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVACXDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVACXDj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVACXCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:02:23 -0500
Received: from mail.dif.dk ([193.138.115.101]:14983 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261901AbVACXAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:00:12 -0500
Date: Tue, 4 Jan 2005 00:11:27 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-scsi <linux-scsi@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ZP Gu <zpg@castle.net>
Subject: [PATCH][RFC] clean out old cruft from FD MCS driver
Message-ID: <Pine.LNX.4.61.0501032350040.3529@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

(please keep me in the CC loop since I'm not subscribed to linux-scsi)

Funny how a tiny little warning can lead you to make much bigger changes 
than you initially intended...

I saw this little warning when doing an allyesconfig build of 2.6.10-bk6 : 

  CC      drivers/scsi/fd_mcs.o
In file included from drivers/scsi/fd_mcs.c:92:
drivers/scsi/fd_mcs.h:27: warning: 'fd_mcs_command' declared `static' but never defined

So, I took a look at the header and yes indeed, there's a function 
prototype in there for fd_mcs_command, but the actual function is nowhere 
to be found.
I then took a look at the fd_mcs.c file to see if this function was ever 
used - and as a matter of fact it is, but the code using it is inside an 
#ifdef DO_DETECT block and even without considering the missing function, 
if you happen to define DO_DETECT gcc will barf all over you since the 
code in there uses members of a struct that no longer exist : 

  CC      drivers/scsi/fd_mcs.o
In file included from drivers/scsi/fd_mcs.c:92:
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please move your driver to the new sysfs api"
drivers/scsi/fd_mcs.c: In function `fd_mcs_detect':
drivers/scsi/fd_mcs.c:532: error: structure has no member named `lun'
drivers/scsi/fd_mcs.c:533: error: structure has no member named `host'
drivers/scsi/fd_mcs.c:539: error: structure has no member named `target'
drivers/scsi/fd_mcs.c: At top level:
drivers/scsi/fd_mcs.h:27: warning: 'fd_mcs_command' declared `static' but never defined
make[1]: *** [drivers/scsi/fd_mcs.o] Error 1
make: *** [drivers/scsi/] Error 2

So, this bit of code wouldn't actually work, with or without 
fd_mcs_command().

At this point I got the feeling that this driver had been left to rot and 
I desided to see if there was more cruft in there that we might as well 
get rid of, and indeed there is.
There are a few macros that are defined but never used and the header file 
seems to be completely superfluous since all functions are nicely defined 
before their first use and so are properly prototyped with or without the 
header and no other files seem to be including the header (at least 
according to grep).
So, I've made a patch that removes all the unbuildable stuff and the 
unused macros but, I don't actually have *any* familiarity with this code 
nor do I have hardware to test with, so I'd really like someone else to go 
through my changes and verify that they are ok.

There's also a block of code in there that's inside a suspiciously looking 
#ifdef NOT_USED block, but at least that bit of code builds if you remove 
the conditional, so I've let that be for now but added a FIXME comment. 
Could this just go the way of the Dodo as well?

The patch below does the following :
 - Remove the unused macro DEBUG_DETECT
 - Remove code inside DO_DETECT conditional that's broken
 - Remove superfluous header


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


diff -up linux-2.6.10-bk6-orig/drivers/scsi/fd_mcs.h /dev/null
--- linux-2.6.10-bk6-orig/drivers/scsi/fd_mcs.h	2004-12-24 22:34:01.000000000 +0100
+++ /dev/null	2005-01-03 18:52:44.000000000 +0100
@@ -1,37 +0,0 @@
-/* fd_mcs.h -- Header for Future Domain MCS 600/700 (or IBM OEM) driver
- * 
- * fd_mcs.h v0.2 03/11/1998 ZP Gu (zpg@castle.net)
- *
-
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2, or (at your option) any
- * later version.
-
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
-
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
-
- */
-
-#ifndef _FD_MCS_H
-#define _FD_MCS_H
-
-static int fd_mcs_detect(Scsi_Host_Template *);
-static int fd_mcs_release(struct Scsi_Host *);
-static int fd_mcs_command(Scsi_Cmnd *);
-static int fd_mcs_abort(Scsi_Cmnd *);
-static int fd_mcs_bus_reset(Scsi_Cmnd *);
-static int fd_mcs_device_reset(Scsi_Cmnd *);
-static int fd_mcs_host_reset(Scsi_Cmnd *);
-static int fd_mcs_queue(Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));
-static int fd_mcs_biosparam(struct scsi_device *, struct block_device *,
-			    sector_t, int *);
-static const char *fd_mcs_info(struct Scsi_Host *);
-
-#endif				/* _FD_MCS_H */



diff -up linux-2.6.10-bk6-orig/drivers/scsi/fd_mcs.c linux-2.6.10-bk6/drivers/scsi/fd_mcs.c
--- linux-2.6.10-bk6-orig/drivers/scsi/fd_mcs.c	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.10-bk6/drivers/scsi/fd_mcs.c	2005-01-03 23:39:27.000000000 +0100
@@ -96,7 +96,6 @@
 
 #include "scsi.h"
 #include <scsi/scsi_host.h>
-#include "fd_mcs.h"
 
 #define DRIVER_VERSION "v0.2 by ZP Gu<zpg@castle.net>"
 
@@ -104,14 +103,12 @@
 
 #define DEBUG            0	/* Enable debugging output */
 #define ENABLE_PARITY    1	/* Enable SCSI Parity */
-#define DO_DETECT        0	/* Do device detection here (see scsi.c) */
 
 /* END OF USER DEFINABLE OPTIONS */
 
 #if DEBUG
 #define EVERY_ACCESS     0	/* Write a line on every scsi access */
 #define ERRORS_ONLY      1	/* Only write a line if there is an error */
-#define DEBUG_DETECT     1	/* Debug fd_mcs_detect() */
 #define DEBUG_MESSAGES   1	/* Debug MESSAGE IN phase */
 #define DEBUG_ABORT      1	/* Debug abort() routine */
 #define DEBUG_RESET      1	/* Debug reset() routine */
@@ -119,7 +116,6 @@
 #else
 #define EVERY_ACCESS     0	/* LEAVE THESE ALONE--CHANGE THE ONES ABOVE */
 #define ERRORS_ONLY      0
-#define DEBUG_DETECT     0
 #define DEBUG_MESSAGES   0
 #define DEBUG_ABORT      0
 #define DEBUG_RESET      0
@@ -432,6 +428,7 @@ static int fd_mcs_detect(Scsi_Host_Templ
 				FIFO_COUNT = user_fifo_count ? user_fifo_count : fd_mcs_adapters[loop].fifo_count;
 				FIFO_Size = user_fifo_size ? user_fifo_size : fd_mcs_adapters[loop].fifo_size;
 
+/* FIXME: Do we need to keep this bit of code inside NOT_USED around at all? */
 #ifdef NOT_USED
 				/* *************************************************** */
 				/* Try to toggle 32-bit mode.  This only
@@ -510,59 +507,6 @@ static int fd_mcs_detect(Scsi_Host_Templ
 				outb(0, SCSI_Mode_Cntl_port);
 				outb(PARITY_MASK, TMC_Cntl_port);
 				/* done reset */
-
-#if DO_DETECT
-				/* scan devices attached */
-				{
-					const int buflen = 255;
-					int i, j, retcode;
-					Scsi_Cmnd SCinit;
-					unsigned char do_inquiry[] = { INQUIRY, 0, 0, 0, buflen, 0 };
-					unsigned char do_request_sense[] = { REQUEST_SENSE,
-						0, 0, 0, buflen, 0
-					};
-					unsigned char do_read_capacity[] = { READ_CAPACITY,
-						0, 0, 0, 0, 0, 0, 0, 0, 0
-					};
-					unsigned char buf[buflen];
-
-					SCinit.request_buffer = SCinit.buffer = buf;
-					SCinit.request_bufflen = SCinit.bufflen = sizeof(buf) - 1;
-					SCinit.use_sg = 0;
-					SCinit.lun = 0;
-					SCinit.host = shpnt;
-
-					printk("fd_mcs: detection routine scanning for devices:\n");
-					for (i = 0; i < 8; i++) {
-						if (i == shpnt->this_id)	/* Skip host adapter */
-							continue;
-						SCinit.target = i;
-						memcpy(SCinit.cmnd, do_request_sense, sizeof(do_request_sense));
-						retcode = fd_mcs_command(&SCinit);
-						if (!retcode) {
-							memcpy(SCinit.cmnd, do_inquiry, sizeof(do_inquiry));
-							retcode = fd_mcs_command(&SCinit);
-							if (!retcode) {
-								printk("     SCSI ID %d: ", i);
-								for (j = 8; j < (buf[4] < 32 ? buf[4] : 32); j++)
-									printk("%c", buf[j] >= 20 ? buf[j] : ' ');
-								memcpy(SCinit.cmnd, do_read_capacity, sizeof(do_read_capacity));
-								retcode = fd_mcs_command(&SCinit);
-								if (!retcode) {
-									unsigned long blocks, size, capacity;
-
-									blocks = (buf[0] << 24) | (buf[1] << 16)
-									    | (buf[2] << 8) | buf[3];
-									size = (buf[4] << 24) | (buf[5] << 16) | (buf[6] << 8) | buf[7];
-									capacity = +(+(blocks / 1024L) * +(size * 10L)) / 1024L;
-
-									printk("%lu MB (%lu byte blocks)\n", ((capacity + 5L) / 10L), size);
-								}
-							}
-						}
-					}
-				}
-#endif
 			}
 		}
 



