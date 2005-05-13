Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVEMFU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVEMFU4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 01:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVEMFU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 01:20:56 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:46496 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S262243AbVEMFUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 01:20:44 -0400
Date: Thu, 12 May 2005 22:20:38 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>,
       linux@dominikbrodowski.net
Subject: [PATCH] pcmcia/ds: handle any error code
Message-Id: <20050512222038.325081b2.rdunlap@xenotime.net>
In-Reply-To: <20050512230206.GA1380@animx.eu.org>
References: <20050512015220.GA31634@animx.eu.org>
	<20050512230206.GA1380@animx.eu.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2005 19:02:06 -0400 Wakko Warner wrote:

| Wakko Warner wrote:
| > 3) I put together a boot kernel/initrd using 2.6.12-rc2 (also tested
| > 2.6.12-rc4) which seems to work, except that pcmcia does not function
| > properly.  When pcmcia.ko gets loaded, it is unable to register it's char
| > dev.  I'm not sure why this is.  2.6.11.8 worked fine with no modifications
| > to the system.  This is a system designed to boot from floppy minimally,
| > search for a device which has some files that populates a tmpfs filesystem
| > which becomes the root filesystem.  This module is loaded from the tmpfs
| > filesystem.  Module-init-tools version is 3.2-pre (Not sure if this makes a
| > difference).  I tested this on a notebook that I have.  I also have this
| > same kernel version installed which works fine.  It could be a different
| > version of module-init-tools, but I'm unsure at this point (I do not have
| > access to the notebook at this time.
| 
| I tested this again today with a few changes.  It appears that if pcmcia.ko
| (or rather the .c files that make it up) are compiled with -Os, it will fail
| to register a character device.  Being that one of my goals for this was to
| fit everything on a floppy, I had to use -Os when building the kernel. 
| (pcmcia was not one of the modules that belongs on the floppy, however I
| did not want to have to compile the kernel and then again for the modules
| w/o -Os)
| 
| I believe that pcmcia.ko is the only module I am using that  uses a dynamic
| major.

There is some small difference in locking in fs/char_dev.c between
2.6.12-rc4 and 2.6.11.8, but I don't yet see why it would cause a
failure in register_chrdev().

Oh, there's a big difference in drivers/pcmcia/ds.c, lots of probe
changes.  This is where to look further (but not tonight).
The question then becomes is this a real regression?

Do you suspect a problem with -Os code generation?

Looks to me like ds.c needs at least this small fix...

---

register_chrdev() can return errors (negative) other then -EBUSY,
so check for any negative error code.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

diffstat:=
 drivers/pcmcia/ds.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./drivers/pcmcia/ds.c~ds_check_major ./drivers/pcmcia/ds.c
--- ./drivers/pcmcia/ds.c~ds_check_major	2005-05-12 13:16:41.000000000 -0700
+++ ./drivers/pcmcia/ds.c	2005-05-12 19:45:36.000000000 -0700
@@ -1592,9 +1592,9 @@ static int __init init_pcmcia_bus(void)
 
 	/* Set up character device for user mode clients */
 	i = register_chrdev(0, "pcmcia", &ds_fops);
-	if (i == -EBUSY)
+	if (i < 0)
 		printk(KERN_NOTICE "unable to find a free device # for "
-		       "Driver Services\n");
+		       "Driver Services (error=%d)\n", i);
 	else
 		major_dev = i;
 

