Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUDIQ4x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 12:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUDIQ4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 12:56:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63954 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261313AbUDIQ4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 12:56:51 -0400
Date: Fri, 9 Apr 2004 18:56:19 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: framebuffer bugfix
Message-ID: <20040409165619.GB10291@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

patch below fixes a thinko in the frame buffer drivers;
the code does

cursor.image.data = kmalloc(size, GFP_KERNEL);
....
cursor.mask = kmalloc(size, GFP_KERNEL);
....
                if (copy_from_user(&cursor.image.data, sprite->image.data, size) ||
                    copy_from_user(cursor.mask, sprite->mask, size)) {
....

where it's clear that the & in the first copy_from_user is utterly bogus
since the destination is the content of the newly allocated buffer, and not
the pointer to it as the code does....


 

--- linux-2.6.5/drivers/video/fbmem.c~	2004-04-09 18:51:01.626902984 +0200
+++ linux-2.6.5/drivers/video/fbmem.c	2004-04-09 18:51:01.626902984 +0200
@@ -911,7 +911,7 @@
 			return -ENOMEM;
 		}
 		
-		if (copy_from_user(&cursor.image.data, sprite->image.data, size) ||
+		if (copy_from_user(cursor.image.data, sprite->image.data, size) ||
 		    copy_from_user(cursor.mask, sprite->mask, size)) { 
 			kfree(cursor.image.data);
 			kfree(cursor.mask);
