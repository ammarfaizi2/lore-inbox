Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286328AbRLTS57>; Thu, 20 Dec 2001 13:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286327AbRLTS5u>; Thu, 20 Dec 2001 13:57:50 -0500
Received: from web12308.mail.yahoo.com ([216.136.173.106]:16902 "HELO
	web12308.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S286341AbRLTS5m>; Thu, 20 Dec 2001 13:57:42 -0500
Message-ID: <20011220185741.7324.qmail@web12308.mail.yahoo.com>
Date: Thu, 20 Dec 2001 10:57:41 -0800 (PST)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: [PATCH] cciss 2.5.1 for 2.5.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> [...]
> > Here is a new patch against 2.5.1-pre11:
> > http://www.geocities.com/smcameron/cciss_2.5.0_for_2.5.1-pre11.patch.gz
> > Having played with it some more, I see it is seriously flawed
> in the area of SCSI tape support and locking. [...]

Ok.  I think I fixed all that.  (Main problem was how I was allocating
my commands for SCSI side of the driver, this bug has been there a 
long time, I'm surprised it lasted as long as it did without me seeing it.)

I tested it with 2 tape drives going simultaneously 
on a 2 processor system, which was embarassingly 
fatal for the previous.drivers.

http://www.geocities.com/smcameron/cciss_2.5.1_for_2.5.1.patch.gz

About the prior patch, 
had some complaint that first arg of pci_*_consistent was NULL in
some places in the driver.  So I included comments explaining why
it is that way. (Documentation/DMA-mapping.txt says this is 
permissible.)

Another complaint that various explicit initializations 
to NULL or 0 should be left up to the compiler.  Whatever.
Change them if you must.

An excerpt from the patch:
Thu Dec 20 09:43:04 CST 2001
v. 2.5.1       * Fixed longstanding problem in allocation of SCSI commands
                 which meant physical addresses of cmds for tape drives could
                 be wrong.  Problem showed easily if 2 tape drives used
                 simultaneously, though in theory it could show with only 1
                 tape drive.
               * Fixed races/deadlocks resulting from first attempt
                 at removing io_request_lock
               * Changed pci_alloc_consistent call in cciss_scsi.c so
                 that the SCSI command pool would be guaranteed to have
                 addresses that fit through the 32 bit command register.
Thu Dec 13 16:39:05 CST 2001
v. 2.5.0       * Removal of io_request_lock for 2.5.x kernels.
               * no longer sets block_size to zero for volumes where
                 read capacity fails (caused div by zero)
               * reset MAXSGENTRIES back to 31 (controllers reject 32)
Thu Oct  4 14:29:15 CDT 2001  Changelog begins.
v. 2.4.21      * Added support for SCSI tape drives (Steve Cameron)
               * Added support for dynamically adding and removing
                 logical volumes, This implies that the disk index
                 ("x" in /dev/cciss/c*b*dx*) is no longer a contiguous
                 sequential series (e.g. 0,1,2,3) as it now maps to logical
                 volume numbers directly and thus there may be gaps.
                 (Charles White)
-- steve





__________________________________________________
Do You Yahoo!?
Check out Yahoo! Shopping and Yahoo! Auctions for all of
your unique holiday gifts! Buy at http://shopping.yahoo.com
or bid at http://auctions.yahoo.com
