Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264787AbUEKPhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264787AbUEKPhV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 11:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264790AbUEKPhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 11:37:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:49323 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264787AbUEKPhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 11:37:19 -0400
Date: Tue, 11 May 2004 08:28:48 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: gallir@atlas-iap.es, matthew.e.tolentino@intel.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH](2) efivars: check enabled {2.6.6 doesn't boot with 4k
 stacks}
Message-Id: <20040511082848.0b1d3bbd.rddunlap@osdl.org>
In-Reply-To: <20040511143833.GA14555@lists.us.dell.com>
References: <20040510172404.11a90ce9.rddunlap@osdl.org>
	<20040510210243.14bbd99b.rddunlap@osdl.org>
	<20040511143833.GA14555@lists.us.dell.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2004 09:38:33 -0500 Matt Domsch wrote:

| On Mon, May 10, 2004 at 09:02:43PM -0700, Randy.Dunlap wrote:
| > // linux-266
| > // efivars_init and efivars_exit need to check efi_enabled
| > // instead of assuming that the system is using EFI;
| 
| Good catch.  I missed the creation of that in the x86 EFI merge.
| 
| > +++ ./drivers/firmware/efivars.c	2004-05-10 20:45:55.000000000 -0700
| > @@ -664,6 +664,9 @@ efivars_init(void)
| >  	unsigned long variable_name_size = 1024;
| >  	int i, rc = 0, error = 0;
| >  
| > +	if (!efi_enabled)
| > +		return 0;
| 
| I would think this would be return -ENODEV; instead, yes?

um, OK.  I suppose that is a good idea... to prevent the module
from remaining loaded.

Here's an updated diff.

--
~Randy



// linux-266
// efivars_init and _exit need to check for efi_enabled (or else crash);

diffstat:=
 drivers/firmware/efivars.c |    6 ++++++
 1 files changed, 6 insertions(+)


diff -Naurp ./drivers/firmware/efivars.c~efivars_check_enabled ./drivers/firmware/efivars.c
--- ./drivers/firmware/efivars.c~efivars_check_enabled	2004-05-09 19:33:13.000000000 -0700
+++ ./drivers/firmware/efivars.c	2004-05-11 08:43:07.000000000 -0700
@@ -664,6 +664,9 @@ efivars_init(void)
 	unsigned long variable_name_size = 1024;
 	int i, rc = 0, error = 0;
 
+	if (!efi_enabled)
+		return -ENODEV;
+
 	printk(KERN_INFO "EFI Variables Facility v%s\n", EFIVARS_VERSION);
 
 	/*
@@ -733,6 +736,9 @@ efivars_exit(void)
 {
 	struct list_head *pos, *n;
 
+	if (!efi_enabled)
+		return;
+
 	list_for_each_safe(pos, n, &efivar_list)
 		efivar_unregister(get_efivar_entry(pos));
 
