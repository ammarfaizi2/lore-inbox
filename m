Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751761AbWJMSHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWJMSHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWJMSHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:07:04 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:14910 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751761AbWJMSHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:07:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=DmKNQ8aaKZ1Q6Uq+Lu/zbkG1mcUA3A9ofWAoeHq6aSModZDVmhDAOPn6Sf8SVv07iM9+h2lzVwQnM/fvtRNx5Bnjz+vzWX44jUwX/syTNk/HjWnhHlcGu9V5Tk+2wwTeTaLrGq+gGmzuhSQ2yhCCqfp4bWf7yJUgP+/bZ3DcCko=
Date: Sat, 14 Oct 2006 03:07:30 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
       Scott Murray <scottm@somanetworks.com>
Subject: [PATCH] cpcihp_generic: prevent loading without "bridge" parameter
Message-ID: <20061013180730.GE29079@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
	Scott Murray <scottm@somanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpcihp_generic module requires configured "bridge" module parameter.
But it can be loaded successfully without that parameter.
Because module init call ends up returning positive value.

This patch prevents from loading without setting "bridge" module parameter.

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Scott Murray <scottm@somanetworks.com>
Signed-off-by: Akinbou Mita <akinobu.mita@gmail.com>

Index: work-fault-inject/drivers/pci/hotplug/cpcihp_generic.c
===================================================================
--- work-fault-inject.orig/drivers/pci/hotplug/cpcihp_generic.c
+++ work-fault-inject/drivers/pci/hotplug/cpcihp_generic.c
@@ -84,7 +84,7 @@ static int __init validate_parameters(vo
 
 	if(!bridge) {
 		info("not configured, disabling.");
-		return 1;
+		return -EINVAL;
 	}
 	str = bridge;
 	if(!*str)
@@ -147,7 +147,7 @@ static int __init cpcihp_generic_init(vo
 
 	info(DRIVER_DESC " version: " DRIVER_VERSION);
 	status = validate_parameters();
-	if(status != 0)
+	if (status)
 		return status;
 
 	r = request_region(port, 1, "#ENUM hotswap signal register");
