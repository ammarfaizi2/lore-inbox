Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVGZDPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVGZDPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 23:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVGZDPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 23:15:42 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:37394 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261606AbVGZDPi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 23:15:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mos7HfqUH0ofwwij6//2h89OyXzGJToU/1LaZAvFKKYAmLbSUGHRGRN8a97v3yqCCguu/A4/vMnvk262u6viTgvOC044lz3eFpKWnBc3K/rAbxG1QnccLp8fCasj1OdZSBU7OEz7Z3Ujgjx+rKlVjhix9c3KzLNtZ/KJXu/pBm4=
Message-ID: <9e473391050725201553f3e8be@mail.gmail.com>
Date: Mon, 25 Jul 2005 23:15:37 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050726015401.GA25015@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e47339105072421095af5d37a@mail.gmail.com>
	 <200507242358.12597.dtor_core@ameritech.net>
	 <9e4733910507250728a7882d4@mail.gmail.com>
	 <d120d5000507250748136a1e71@mail.gmail.com>
	 <9e47339105072509307386818b@mail.gmail.com>
	 <20050726000024.GA23858@kroah.com>
	 <9e473391050725172833617aca@mail.gmail.com>
	 <20050726003018.GA24089@kroah.com>
	 <9e47339105072517561f53b2f9@mail.gmail.com>
	 <20050726015401.GA25015@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/05, Greg KH <greg@kroah.com> wrote:
> > I'll put one together to trim leading/trailing white space from the
> > buffer before it is passed into the attribute functions. Now that I
> > think about this I believe the attributes should have always had the
> > leading/trailing white space removed. If we don't do it in the sysfs
> > code then every driver has to do it.
> 
> Ok, sounds good.

How does this look? This is a count based interface but a lot of
attributes don't work unless I add the terminating zero. This
interface should be documented: count or zero terminated, white space
stripped or not, etc. Are these strings ASCII, UTF8, Unicode?

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
 
@@ -207,6 +208,28 @@ flush_write_buffer(struct dentry * dentr
  	struct attribute * attr = to_attr(dentry);
  	struct kobject * kobj = to_kobj(dentry->d_parent);
  	struct sysfs_ops * ops = buffer->ops;
+	char *x, *y, *z;
+
+	/* locate leading white space */
+	x = buffer->page;
+	while( isspace(*x) && (x - buffer->page < count))
+		x++;
+
+	/* locate trailng white space */
+	z = y = x;
+	while (y - buffer->page < count) {
+		y++;
+		z = y;
+		while( isspace(*y) && (y - buffer->page < count)) {
+			y++;
+		}
+	}
+	count = z - x;
+
+	/* strip the white space */
+	if (buffer->page != x)
+		memmove(buffer->page, x, count);
+	buffer->page[count] = '\0';
 
  	return ops->store(kobj,attr,buffer->page,count);
 }


-- 
Jon Smirl
jonsmirl@gmail.com
