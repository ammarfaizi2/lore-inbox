Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVA3JC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVA3JC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 04:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVA3JCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 04:02:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52891 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261655AbVA3JCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 04:02:44 -0500
Date: Sun, 30 Jan 2005 09:02:41 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [FIX] Re: [2.6 patch] drivers/cdrom/isp16.c: small cleanups
Message-ID: <20050130090241.GV8859@parcelfarce.linux.theplanet.co.uk>
References: <20050129171108.GB28047@stusta.de> <58cb370e05012909513cc96b17@mail.gmail.com> <20050129234624.GC3185@stusta.de> <58cb370e0501291554450fbef8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0501291554450fbef8@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 12:54:30AM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Sun, 30 Jan 2005 00:46:24 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > On Sat, Jan 29, 2005 at 06:51:25PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > Hi,
> > >
> > > On Sat, 29 Jan 2005 18:11:08 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > > > This patch makes the needlessly global function isp16_init static.
> > > >
> > > > As a result, it turned out that both this function and some other code
> > > > are only required #ifdef MODULE.

... assuming that driver had not been broken to start with

> > >
> > > Your patch is correct but it is wrong. ;)
> > >
> > > #ifdefs around isp16_init() need to be removed as
> > > otherwise this driver is not initialized in built-in case.

... assuming that driver is initialized in built-in case

> > It's somehow initialized via isp16_setup.

... assuming that magic exists, which would follow from the original
assumptions

> Could you explain?
> 
> AFAICS isp16_setup() only handles "isp16=" boot parameter.

Simple: driver is broken.  And "obvious" transformations of that sort are
safe only when they are applied to correct code.  Otherwise you end up with
obfuscation of original breakage.

Trivial check of history shows that
	a) until 2.5.1-pre1 isp16_init() had been called from blk_dev_init()
	b) in 2.5.1-pre2 Jens had taken that call out, but forgot to remove
ifdef in isp16.c
	c) nobody had cared since then.

Fix follows.

diff -u RC11-rc2-bk6-base/drivers/cdrom/isp16.c RC11-rc2-bk6-current/drivers/cdrom/isp16.c
--- RC11-rc2-bk6-base/drivers/cdrom/isp16.c	2005-01-28 17:06:37.000000000 -0500
+++ RC11-rc2-bk6-current/drivers/cdrom/isp16.c	2005-01-30 04:00:09.319617779 -0500
@@ -112,7 +112,7 @@
  *  ISP16 initialisation.
  *
  */
-int __init isp16_init(void)
+static int __init isp16_init(void)
 {
 	u_char expected_drive;
 
@@ -366,15 +366,13 @@
 	return 0;
 }
 
-void __exit isp16_exit(void)
+static void __exit isp16_exit(void)
 {
 	release_region(ISP16_IO_BASE, ISP16_IO_SIZE);
 	printk(KERN_INFO "ISP16: module released.\n");
 }
 
-#ifdef MODULE
 module_init(isp16_init);
-#endif
 module_exit(isp16_exit);
 
 MODULE_LICENSE("GPL");
