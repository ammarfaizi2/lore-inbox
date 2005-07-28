Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVG1Uzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVG1Uzn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVG1U3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:29:13 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:14405 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262184AbVG1U2U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:28:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QlVyHGF6/KntzxuympMGgghW87CQ4iJAcDSL3J4zxGX8QqgkdUv9Hj7/mOjAsSLvm5YKgI2AhDzTsLsWQSQxxiWVqlTIZC659R3xqC2HUxxfzl3xp5E74I422mg94v16dTLjWRb2Q7LgT8SM4Vmqr+TGZ4Xs1UmLYAgsswGUnrU=
Message-ID: <9e473391050728132757a75d5f@mail.gmail.com>
Date: Thu, 28 Jul 2005 16:27:32 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: Greg KH <greg@kroah.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050728202214.GA9041@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e47339105072719057c833e62@mail.gmail.com>
	 <9e473391050727205971b0aee@mail.gmail.com>
	 <20050728040544.GA12476@kroah.com>
	 <9e47339105072721495d3788a8@mail.gmail.com>
	 <20050728054914.GA13904@kroah.com>
	 <20050728070455.GF9985@gaz.sfgoth.com>
	 <9e47339105072805545766f97d@mail.gmail.com>
	 <20050728190352.GA29092@kroah.com>
	 <9e47339105072812575e567531@mail.gmail.com>
	 <20050728202214.GA9041@gaz.sfgoth.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even simpler version....

-- 
Jon Smirl
jonsmirl@gmail.com

Remove leading and trailing whitespace when text sysfs attribute is set
signed-off-by: Jon Smirl <jonsmirl@gmail.com>

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -6,6 +6,7 @@
 #include <linux/fsnotify.h>
 #include <linux/kobject.h>
 #include <linux/namei.h>
+#include <linux/ctype.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 
@@ -207,8 +208,23 @@ flush_write_buffer(struct dentry * dentr
 	struct attribute * attr = to_attr(dentry);
 	struct kobject * kobj = to_kobj(dentry->d_parent);
 	struct sysfs_ops * ops = buffer->ops;
+	char *x;
 
-	return ops->store(kobj,attr,buffer->page,count);
+	/* locate trailing white space */
+	while ((count > 0) && isspace(buffer->page[count - 1]))
+		count--;
+
+	/* locate leading white space */
+	x = buffer->page;
+	if (count > 0) {
+		while (isspace(*x))
+			x++;
+		count -= (x - buffer->page);
+	}
+	/* terminate the string */
+	x[count] = '\0';
+
+	return ops->store(kobj, attr, x, count);
 }
