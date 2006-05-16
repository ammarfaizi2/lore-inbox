Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWEPPXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWEPPXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWEPPXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:23:31 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:10756 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932089AbWEPPXb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:23:31 -0400
Date: Tue, 16 May 2006 17:23:46 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       Greg KH <gregkh@suse.de>, Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc4-mm1
Message-Id: <20060516172346.b729da01.khali@linux-fr.org>
In-Reply-To: <20060516164846.4d42ed11.khali@linux-fr.org>
References: <20060515005637.00b54560.akpm@osdl.org>
	<6bffcb0e0605151137v25496700k39b15a40fa02a375@mail.gmail.com>
	<20060515115302.5abe7e7e.akpm@osdl.org>
	<6bffcb0e0605151210x21eb0d24g96366ce9c121c26c@mail.gmail.com>
	<20060515122613.32661c02.akpm@osdl.org>
	<6bffcb0e0605151317u51bbf67ey124b808fad920d36@mail.gmail.com>
	<20060516103930.0c0d5d33.khali@linux-fr.org>
	<20060516145517.2c2d4fe4.khali@linux-fr.org>
	<20060516164846.4d42ed11.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting myself:
> And the winner is...
> gregkh-driver-driver-core-class_device_add-needs-error-checks.patch
> 
> Stephen, Greg?

Indeed this patch breaks class_device_add in the success case...

Andrew, maybe you want to put this in the hot-fixes directory for
2.6.17-rc1-mm4, as the problem hits all drivers which register with a
class.

Fix class_device_add success case after
gregkh-driver-driver-core-class_device_add-needs-error-checks.patch
broke it. class_dev was no more put and class_name was no more freed
before leaving. The former caused locks on driver removal (class_dev
usage count could never be 0.)

This fix should be folded into
gregkh-driver-driver-core-class_device_add-needs-error-checks.patch

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/base/class.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17-rc4-mm1.orig/drivers/base/class.c	2006-05-16 16:38:02.000000000 +0200
+++ linux-2.6.17-rc4-mm1/drivers/base/class.c	2006-05-16 17:00:24.000000000 +0200
@@ -620,7 +620,7 @@
 	}
 	up(&parent_class->sem);
 
-	return 0;
+	goto out1;
 
  out8:
 	if (class_dev->dev)


-- 
Jean Delvare
