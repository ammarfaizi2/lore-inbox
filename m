Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUBRECH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUBRECH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:02:07 -0500
Received: from mail.kroah.org ([65.200.24.183]:24750 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261950AbUBRECB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:02:01 -0500
Date: Tue, 17 Feb 2004 20:01:54 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: sensors@stimpy.netroedge.com
Subject: Re: 2.6.3rc4 ali1535 i2c driver rmmod oops.
Message-ID: <20040218040153.GB6729@kroah.com>
References: <20040218031544.GB26304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218031544.GB26304@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 03:15:44AM +0000, Dave Jones wrote:
> Erk, whats going on here ?

Hm, I'll try to debug this tomorrow.

Oh nevermind, that's just a dumb driver.  It's doing a release_region on
memory it didn't get.  Stupid, stupid, stupid...

Dave can you verify that this patch fixes the problem for you?

thanks,

greg k-h


===== i2c-ali1535.c 1.12 vs edited =====
--- 1.12/drivers/i2c/busses/i2c-ali1535.c	Tue Jan 20 08:58:03 2004
+++ edited/i2c-ali1535.c	Tue Feb 17 20:00:44 2004
@@ -517,6 +517,7 @@
 static void __devexit ali1535_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&ali1535_adapter);
+	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
 }
 
 static struct pci_driver ali1535_driver = {
@@ -534,7 +535,6 @@
 static void __exit i2c_ali1535_exit(void)
 {
 	pci_unregister_driver(&ali1535_driver);
-	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
 }
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
