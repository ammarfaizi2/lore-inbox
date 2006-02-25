Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWBYPNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWBYPNy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 10:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWBYPNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 10:13:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29958 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030268AbWBYPNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 10:13:53 -0500
Date: Sat, 25 Feb 2006 16:13:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org
Subject: [RFC: 2.6.16 patch] drivers/acpi/ec.c: default to polling mode for 2.6.16
Message-ID: <20060225151351.GR3674@stusta.de>
References: <3ACA40606221794F80A5670F0AF15F840B020D85@pdsmsx403> <20060222122317.GF4661@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222122317.GF4661@stusta.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 01:23:17PM +0100, Adrian Bunk wrote:
> On Wed, Feb 22, 2006 at 02:55:10PM +0800, Yu, Luming wrote:
> > > >Subject    : S3 sleep hangs the second time - 600X
> > >> >References : http://bugzilla.kernel.org/show_bug.cgi?id=5989
> > >> >Submitter  : Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
> > >> >Status     : problematic commit identified,
> > >> >             further discussion is in the bug
> > >> 
> > >> The real problem is there are some bugs hidden by ec_intr=0.
> > >> ec_intr=1 just get these bug  just exposed, and we need to fix them. 
> > >
> > >From a users' point of view, these are regressions from 
> > >2.6.15, and not 
> > >all of them might be fixed in time for 2.6.16.
> > >
> > >What is a possible short term solution/workaround for 2.6.16?
> > 
> > ec_intr=0 is a reasonable workaround for this box,
> > if we couldn't root-cause and fix the real problem on time.
> > 
> > >Can we go back to default to polling mode in 2.6.16?
> > 
> > No, don't do this.  There are other laptops need this. And I didn't
> > get regression report that is root-caused to enabling ec_intr=1 by
> > default. If you argue bug 5989, 6075 could be,  I think
> > the truth is, for 5989, we need to fix thermal and processor driver
> > issue.
> 
> We do both agree that defaulting to polling mode is not a long term 
> solution.
> 
> The question is what to do until it's resolved - assuming that issues 
> like 5989 might not be fixed in time for 2.6.16.
> 
> Breaking setups working with the defaults under 2.6.15 in 2.6.16 doesn't 
> sound that good.
> 
> > for 6075, we need to fix interrupt issue.
> 
> As far as I understand 6075, the submitter already tried ec_intr=0 
> without success.
>...

Let me suggest the following patch for going back to default to polling 
mode in 2.6.16.

The idea is to get this patch into 2.6.16, immediately revert it in 
Len's ACPI tree, and properly fix all issues before 2.6.17.

This way, there will be less regressions when the changed default is in 
a stable kernel.

cu
Adrian


<--  snip  -->


The changed default seems to cause regressions (see 
http://bugzilla.kernel.org/show_bug.cgi?id=5989).

Let's change the default back to polling mode for one more stable 
kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/kernel-parameters.txt |    4 ++--
 drivers/acpi/ec.c                   |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc4-mm2-full/Documentation/kernel-parameters.txt.old	2006-02-25 16:01:51.000000000 +0100
+++ linux-2.6.16-rc4-mm2-full/Documentation/kernel-parameters.txt	2006-02-25 16:02:04.000000000 +0100
@@ -460,8 +460,8 @@
 
 	ec_intr=	[HW,ACPI] ACPI Embedded Controller interrupt mode
 			Format: <int>
-			0: polling mode
-			non-0: interrupt mode (default)
+			0: polling mode (default)
+			non-0: interrupt mode
 
 	eda=		[HW,PS2]
 
--- linux-2.6.16-rc4-mm2-full/drivers/acpi/ec.c.old	2006-02-25 16:00:22.000000000 +0100
+++ linux-2.6.16-rc4-mm2-full/drivers/acpi/ec.c	2006-02-25 16:01:24.000000000 +0100
@@ -73,7 +73,7 @@
 	.class = ACPI_EC_CLASS,
 	.ids = ACPI_EC_HID,
 	.ops = {
-		.add = acpi_ec_intr_add,
+		.add = acpi_ec_poll_add,
 		.remove = acpi_ec_remove,
 		.start = acpi_ec_start,
 		.stop = acpi_ec_stop,
@@ -147,7 +147,7 @@
 
 /* External interfaces use first EC only, so remember */
 static struct acpi_device *first_ec;
-static int acpi_ec_poll_mode = EC_INTR;
+static int acpi_ec_poll_mode = EC_POLL;
 
 /* --------------------------------------------------------------------------
                              Transaction Management
