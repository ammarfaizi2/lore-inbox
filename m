Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbUEKEEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbUEKEEz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 00:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUEKEEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 00:04:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:28326 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262026AbUEKEEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 00:04:52 -0400
Date: Mon, 10 May 2004 21:02:43 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: gallir@atlas-iap.es, Matt_Domsch@dell.com, matthew.e.tolentino@intel.com
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: [PATCH] efivars: check enabled {2.6.6 doesn't boot with 4k stacks}
Message-Id: <20040510210243.14bbd99b.rddunlap@osdl.org>
In-Reply-To: <20040510172404.11a90ce9.rddunlap@osdl.org>
References: <20040510172404.11a90ce9.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



| Perhaps I missed some readme, but just in case. One of my computer, P4HT[*]
| dies during booting. There is no log because nothing is still mounted, 
| but I took a photograph of the stack dump in the screen.
| 
| http://mnm.uib.es/~gallir/tmp/hang1s.jpg

Yes, easy to reproduce...

| The .config file:
| http://mnm.uib.es/~gallir/tmp/2.6.6-bad-config.txt
| 
| I unchecked the 4K stack option and it's working nice.


drivers/firmware/efivars.c::efivars_init & efivars_exit
need to check for efi_enabled before doing anything.

or you could disable CONFIG_EFI_VARS, but the kernel shouldn't
crash like that.


// linux-266
// efivars_init and efivars_exit need to check efi_enabled
// instead of assuming that the system is using EFI;

diffstat:=
 drivers/firmware/efivars.c |    6 ++++++
 1 files changed, 6 insertions(+)


diff -Naurp ./drivers/firmware/efivars.c~efi_check_enabled ./drivers/firmware/efivars.c
--- ./drivers/firmware/efivars.c~efi_check_enabled	2004-05-09 19:33:13.000000000 -0700
+++ ./drivers/firmware/efivars.c	2004-05-10 20:45:55.000000000 -0700
@@ -664,6 +664,9 @@ efivars_init(void)
 	unsigned long variable_name_size = 1024;
 	int i, rc = 0, error = 0;
 
+	if (!efi_enabled)
+		return 0;
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
 




--
http://www.madrone.org/quotes/2003.0226.akpm.txt
