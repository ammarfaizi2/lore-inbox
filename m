Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbUCQUfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUCQUfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:35:23 -0500
Received: from fep21-0.kolumbus.fi ([193.229.0.48]:49112 "EHLO
	fep21-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262026AbUCQUfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:35:10 -0500
Date: Wed, 17 Mar 2004 22:35:07 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Matthias Andree <ma+lscsi@dt.e-technik.uni-dortmund.de>
cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.5-rc1 SCSI + st regressions (was: Linux 2.6.5-rc1)
In-Reply-To: <20040316215659.GA3861@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.58.0403172145420.1093@kai.makisara.local>
References: <Pine.LNX.4.58.0403152154070.19853@ppc970.osdl.org>
 <20040316211203.GA3679@merlin.emma.line.org> <20040316211700.GA25059@parcelfarce.linux.theplanet.co.uk>
 <20040316215659.GA3861@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2004, Matthias Andree wrote:

> On Tue, 16 Mar 2004, Matthew Wilcox wrote:
> 
> > On Tue, Mar 16, 2004 at 10:12:03PM +0100, Matthias Andree wrote:
> > > I have some SCSI troubles with 2.6.5-rc1 (from BK) that 2.6.4 didn't
> > > have.
> > > 
> > > Modprobe, loading the st driver, tries a NULL pointer dereference in
> > > kernel space and my 2nd tape drive isn't found: st1 is not shown. cat
> > > /proc/scsi/scsi (typed after the attempted zero page dereference) hangs
> > > in rwsem_down_read_failed with process state D.
> > 
> > I notice you're using the sym2 driver.  Could you try backing out the
> > changes made to it in 2.6.5-rc1, just to be sure we're looking at an st
> > problem, not a sym2 problem?
> 
I was able to reproduce this with the scsi_debug driver (you can use it 
for simple tape tests by changing TYPE_DISK to TYPE_TAPE). Reverting the 
patch:

# ChangeSet
#   2004/03/12 16:22:36-08:00 greg@kroah.com 
#   remove cdev_set_name completely as it is not needed.

(and editing drivers/char/tty_io.c to get the kernel to compile) solved 
the problem for me. st.c is using the name put into kobj.name in making 
the class file names. I will make a patch that removes this dependency.

While looking at this problem, I noticed that the naming changes already 
committed to BK had disappeared. Looking at st.c history revealed that the 
following change had been committed (sorry for wrapping) by greg@kroah.com 
46 hours ago:

--- 1.80+1.79.1.2/drivers/scsi/st.c	Wed Mar 17 12:25:28 2004
+++ 1.81/drivers/scsi/st.c	Wed Mar 17 12:25:28 2004
@@ -3896,11 +3896,6 @@
 				       dev_num);
 				goto out_free_tape;
 			}
-			/* Make sure that the minor numbers corresponding 
to the four
-			   first modes always get the same names */
-			i = mode << (4 - ST_NBR_MODE_BITS);
-			snprintf(cdev->kobj.name, KOBJ_NAME_LEN, "%s%s%s", 
j ? "n" : "",
-				 disk->disk_name, st_formats[i]);
 			cdev->owner = THIS_MODULE;
 			cdev->ops = &st_fops;

The change comment was "merge" and it resulted in st.c version 1.81. (I am 
not using Bitkeeper but trying to extract information from bkbits.net.)

	Kai

