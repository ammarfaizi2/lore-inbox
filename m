Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVAER2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVAER2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVAER2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:28:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31147 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262287AbVAERZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:25:09 -0500
Date: Wed, 5 Jan 2005 17:25:06 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Vincent Pelletier <subdino2004@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.6.10 : fs/openpromfs/inode.c : small mistakes makes module oops   when writing
Message-ID: <20050105172505.GJ26051@parcelfarce.linux.theplanet.co.uk>
References: <crbg4j$vbr$1@sea.gmane.org> <crh1ni$v8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <crh1ni$v8$1@sea.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 04:39:21PM +0100, Vincent Pelletier wrote:
> Hello.
> 
> Here is the patch.
> 
> Changelog:
> 	2005/01/05  Vincent Pelletier  <subdino2004@yahoo.fr>
> 	inode.c: (nodenum_read, property_read, property_write):
> 	Protected against NULL parameters. property_read: Returns 0 when
> 	called with a 0-length buffer. (property_write): Don't expect an
> 	hex list to begin with a dot.

NAK.  Patch
	a) loses needed checks
	b) adds utterly bogus ones
	c) is much bigger than it should be

All it really takes is

diff -urN RC10-bk6-base/fs/openpromfs/inode.c RC10-bk6-current/fs/openpromfs/inode.c
--- RC10-bk6-base/fs/openpromfs/inode.c	2004-10-18 17:54:07.000000000 -0400
+++ RC10-bk6-current/fs/openpromfs/inode.c	2005-01-05 12:22:08.710924933 -0500
@@ -94,8 +94,6 @@
 	openprom_property *op;
 	char buffer[64];
 	
-	if (*ppos >= 0xffffff || count >= 0xffffff)
-		return -EINVAL;
 	if (!filp->private_data) {
 		node = nodes[(u16)((long)inode->u.generic_ip)].node;
 		i = ((u32)(long)inode->u.generic_ip) >> 16;
@@ -168,6 +166,8 @@
 		op = (openprom_property *)filp->private_data;
 	if (!count || !(op->len || (op->flag & OPP_ASCIIZ)))
 		return 0;
+	if (*ppos >= 0xffffff || count >= 0xffffff)
+		return -EINVAL;
 	if (op->flag & OPP_STRINGLIST) {
 		for (k = 0, p = op->value; p < op->value + op->len; p++)
 			if (!*p)
