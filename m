Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVCEUZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVCEUZW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 15:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVCEUWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 15:22:44 -0500
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:63405 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261253AbVCEURj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 15:17:39 -0500
From: "Panagiotis Issaris" <panagiotis.issaris@mech.kuleuven.ac.be>
Date: Sat, 5 Mar 2005 21:17:34 +0100
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Matt_Domsch@dell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EFI missing failure handling
Message-ID: <20050305201734.GA8880@mech.kuleuven.ac.be>
References: <20050305153841.GA7808@mech.kuleuven.ac.be> <200503051906.31518.adobriyan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503051906.31518.adobriyan@mail.ru>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Mar 05, 2005 at 07:06:29PM +0200 or thereabouts, Alexey Dobriyan wrote:
> On Saturday 05 March 2005 17:38, Panagiotis Issaris wrote:
> 
> > The EFI driver allocates memory and writes into it without checking the
> > success of the allocation:
> > 
> > 668     efi_char16_t *variable_name = kmalloc(1024, GFP_KERNEL);
> > ...
> > 696     memset(variable_name, 0, 1024);
> 
> > --- linux-2.6.11-orig/drivers/firmware/efivars.c
> > +++ linux-2.6.11-pi/drivers/firmware/efivars.c
> > @@ -670,6 +670,9 @@ efivars_init(void)
> 
> > +	if (!variable_name)
> > +		return -ENOMEM;
> > +
> >  	if (!efi_enabled)
> >  		return -ENODEV; 
> 
> I'd better move kmalloc() and checking for success down right before
> memset(). Otherwise you leak if efi_enabled == 0.
> Oh, and efivars_init() wants to return "error", not unconditionally 0.
> 
> 	Alexey

Thanks! How about the updated patch?

With friendly regards,
Takis

Signed-off-by: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>

diff -pruN linux-2.6.11-orig/drivers/firmware/efivars.c linux-2.6.11-pi/drivers/firmware/efivars.c
--- linux-2.6.11-orig/drivers/firmware/efivars.c	2005-03-05 02:23:29.000000000 +0100
+++ linux-2.6.11-pi/drivers/firmware/efivars.c	2005-03-05 21:09:33.000000000 +0100
@@ -665,13 +665,19 @@ efivars_init(void)
 {
 	efi_status_t status = EFI_NOT_FOUND;
 	efi_guid_t vendor_guid;
-	efi_char16_t *variable_name = kmalloc(1024, GFP_KERNEL);
+	efi_char16_t *variable_name;
 	struct subsys_attribute *attr;
 	unsigned long variable_name_size = 1024;
 	int i, rc = 0, error = 0;
 
 	if (!efi_enabled)
 		return -ENODEV;
+	
+	variable_name = kmalloc(variable_name_size, GFP_KERNEL);
+	if (!variable_name)
+		return -ENOMEM;
+	
+	memset(variable_name, 0, variable_name_size);
 
 	printk(KERN_INFO "EFI Variables Facility v%s %s\n", EFIVARS_VERSION,
 	       EFIVARS_DATE);
@@ -682,8 +688,10 @@ efivars_init(void)
 
 	rc = firmware_register(&efi_subsys);
 
-	if (rc)
+	if (rc) {	
+		kfree(variable_name);
 		return rc;
+	}
 
 	kset_set_kset_s(&vars_subsys, efi_subsys);
 	subsystem_register(&vars_subsys);
@@ -693,8 +701,6 @@ efivars_init(void)
 	 * the variable name and variable data is 1024 bytes.
 	 */
 
-	memset(variable_name, 0, 1024);
-
 	do {
 		variable_name_size = 1024;
 
@@ -735,7 +741,7 @@ efivars_init(void)
 	}
 
 	kfree(variable_name);
-	return 0;
+	return error;
 }
 
 static void __exit

-- 
  K.U.Leuven, Mechanical Eng.,  Mechatronics & Robotics Research Group
  http://people.mech.kuleuven.ac.be/~pissaris/
