Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVARKoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVARKoz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 05:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVARKoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 05:44:55 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:64463 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261235AbVARKoy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 05:44:54 -0500
Date: Tue, 18 Jan 2005 12:45:15 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org,
       chrisw@osdl.org, davem@davemloft.net
Subject: [PATCH 1/5] compat_ioctl call seems to miss a security hook
Message-ID: <20050118104515.GA23127@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050118072133.GB76018@muc.de> <20050118103418.GA23099@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118072133.GB76018@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached patch is against 2.6.11-rc1-bk5

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Add a missing security hook for compatibility ioctl.

diff -rup linux-2.6.10-orig/fs/compat.c linux-2.6.10-ioctl-sym/fs/compat.c
--- linux-2.6.10-orig/fs/compat.c	2005-01-18 10:58:33.609880024 +0200
+++ linux-2.6.10-ioctl-sym/fs/compat.c	2005-01-18 10:54:26.289478440 +0200
@@ -437,6 +437,11 @@ asmlinkage long compat_sys_ioctl(unsigne
 	if (!filp)
 		goto out;
 
+	/* RED-PEN how should LSM module know it's handling 32bit? */
+	error = security_file_ioctl(filp, cmd, arg);
+ 	if (error)
+ 		goto out_fput;
+
 	if (filp->f_op && filp->f_op->compat_ioctl) {
 		error = filp->f_op->compat_ioctl(filp, cmd, arg);
 		if (error != -ENOIOCTLCMD)

