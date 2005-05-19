Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVESIqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVESIqJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 04:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVESIqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 04:46:09 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:30405 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262442AbVESIp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 04:45:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] libfs: add simple attribute files
Date: Thu, 19 May 2005 10:29:06 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <200505132117.37461.arnd@arndb.de> <200505181441.01495.arnd@arndb.de> <20050518202446.GA20041@kroah.com>
In-Reply-To: <20050518202446.GA20041@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505191029.07970.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Middeweken 18 Mai 2005 22:24, Greg KH wrote:

> Thanks for the patch.  I've cleaned it up a bit (drop the spufs
> comments, changed the access check, and made the val be u64, and
> exported the symbols and cleaned up the debugfs portion) and added it to
> my tree.  It should show up in the next -mm release.  I've included the
> patch below so you can see my
> changes.

Great, thanks for cleaning up those mistakes.

I noticed one small problem with the change from 'long' to 'u64', in 
that you did not change it in all places. In particular, using "%lu" to
print a u64 value will always do the wrong thing on big-endian 32 bit 
platforms and maybe on some others.
Since 'u64' is '%llu' on most platforms but '%lu' on some 64 bit
platforms, I'd either do explicit cast to unsigned long long in
the printf or use unsigned long long throughout the code.

> void foo_set(void *data, long val); and
                           ^^     u64
> long foo_get(void *data);
  ^^   u64

> +#define DEFINE_SIMPLE_ATTRIBUTE(__fops, __get, __set, __fmt)		\
> +static int __fops ## _open(struct inode *inode, struct file *file)	\
> +{									\
> +	__simple_attr_check_format(__fmt, 0ul);				\
                                         ^^^^    0ull

> +	else	  /* first read */
> +		size = scnprintf(attr->get_buf, sizeof(attr->get_buf),
> +				 attr->fmt,  attr->get(attr->data));
					   ^^ (unsigned long long)

> +DEFINE_SIMPLE_ATTRIBUTE(fops_u8, debugfs_u8_get, debugfs_u8_set, "%lu\n");
> +DEFINE_SIMPLE_ATTRIBUTE(fops_u16, debugfs_u16_get, debugfs_u16_set, "%lu\n");
> +DEFINE_SIMPLE_ATTRIBUTE(fops_u32, debugfs_u32_get, debugfs_u32_set, "%lu\n");
                                                                 %llu   ^^^^ 

I also noticed that it is not possible to pass NULL operations to
DEFINE_SIMPLE_ATTRIBUTE() unless you change

--- a/include/linux/fs.h	2005-05-19 10:17:53.000000000 +0200
+++ b/include/linux/fs.h	2005-05-19 10:14:57.000000000 +0200
@@ -1680,7 +1680,7 @@
 static int __fops ## _open(struct inode *inode, struct file *file)	\
 {									\
 	__simple_attr_check_format(__fmt, 0ul);				\
-	return simple_attr_open(inode, file, &__get, &__set, __fmt);	\
+	return simple_attr_open(inode, file, __get, __set, __fmt);	\
 }									\
 static struct file_operations __fops = {				\
 	.owner	 = THIS_MODULE,						\

I'm currently away from my test machine, so I think it's easier if you
just update your patch yourself, but I could also send you an update
patch later if you prefer.

	Arnd <><
