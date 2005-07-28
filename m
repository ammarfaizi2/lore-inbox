Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVG1UEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVG1UEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVG1T6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:58:25 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:49317 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261812AbVG1T5a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:57:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bAywYJhY+qtsKIPtNprGN/jbd0hpF1fLj2TS7uMcOND0PuYqdSzQUJf2dfjBy1UCKSr0eGz6o37/yBdc31R76RArQanJXi9aCWIl9RzwNEsjhL859dPDaz8GlMYLoqV7a/WKLw9/JCkOME16hTQ/6yKr2fIZ/v2t4dR3Nbn61LE=
Message-ID: <9e47339105072812575e567531@mail.gmail.com>
Date: Thu, 28 Jul 2005 15:57:20 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: Mitchell Blank Jr <mitch@sfgoth.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050728190352.GA29092@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050726015401.GA25015@kroah.com>
	 <9e47339105072719057c833e62@mail.gmail.com>
	 <20050728034610.GA12123@kroah.com>
	 <9e473391050727205971b0aee@mail.gmail.com>
	 <20050728040544.GA12476@kroah.com>
	 <9e47339105072721495d3788a8@mail.gmail.com>
	 <20050728054914.GA13904@kroah.com>
	 <20050728070455.GF9985@gaz.sfgoth.com>
	 <9e47339105072805545766f97d@mail.gmail.com>
	 <20050728190352.GA29092@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New, simplified version of the sysfs whitespace strip patch...

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
 
@@ -207,8 +208,22 @@ flush_write_buffer(struct dentry * dentr
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
+	while (isspace(*x) && (x - buffer->page < count))
+		x++;
+	count -= (x - buffer->page);
+
+	/* terminate the string */
+	x[count] = '\0';
+
+	return ops->store(kobj, attr, x, count);
 }
