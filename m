Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbVFJEeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVFJEeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 00:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVFJEeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 00:34:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:46993 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262487AbVFJEdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 00:33:45 -0400
Date: Thu, 9 Jun 2005 21:33:25 -0700
From: Greg KH <greg@kroah.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] libfs: add simple attribute files
Message-ID: <20050610043325.GA15040@kroah.com>
References: <200505132117.37461.arnd@arndb.de> <200505181441.01495.arnd@arndb.de> <20050518202446.GA20041@kroah.com> <200505191029.07970.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505191029.07970.arnd@arndb.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 10:29:06AM +0200, Arnd Bergmann wrote:
> On Middeweken 18 Mai 2005 22:24, Greg KH wrote:
> 
> > Thanks for the patch.  I've cleaned it up a bit (drop the spufs
> > comments, changed the access check, and made the val be u64, and
> > exported the symbols and cleaned up the debugfs portion) and added it to
> > my tree.  It should show up in the next -mm release.  I've included the
> > patch below so you can see my
> > changes.
> 
> Great, thanks for cleaning up those mistakes.
> 
> I noticed one small problem with the change from 'long' to 'u64', in 
> that you did not change it in all places. In particular, using "%lu" to
> print a u64 value will always do the wrong thing on big-endian 32 bit 
> platforms and maybe on some others.
> Since 'u64' is '%llu' on most platforms but '%lu' on some 64 bit
> platforms, I'd either do explicit cast to unsigned long long in
> the printf or use unsigned long long throughout the code.
> 
> > void foo_set(void *data, long val); and
>                            ^^     u64
> > long foo_get(void *data);
>   ^^   u64
> 
> > +#define DEFINE_SIMPLE_ATTRIBUTE(__fops, __get, __set, __fmt)		\
> > +static int __fops ## _open(struct inode *inode, struct file *file)	\
> > +{									\
> > +	__simple_attr_check_format(__fmt, 0ul);				\
>                                          ^^^^    0ull
> 
> > +	else	  /* first read */
> > +		size = scnprintf(attr->get_buf, sizeof(attr->get_buf),
> > +				 attr->fmt,  attr->get(attr->data));
> 					   ^^ (unsigned long long)
> 
> > +DEFINE_SIMPLE_ATTRIBUTE(fops_u8, debugfs_u8_get, debugfs_u8_set, "%lu\n");
> > +DEFINE_SIMPLE_ATTRIBUTE(fops_u16, debugfs_u16_get, debugfs_u16_set, "%lu\n");
> > +DEFINE_SIMPLE_ATTRIBUTE(fops_u32, debugfs_u32_get, debugfs_u32_set, "%lu\n");
>                                                                  %llu   ^^^^ 
> 
> I also noticed that it is not possible to pass NULL operations to
> DEFINE_SIMPLE_ATTRIBUTE() unless you change
> 
> --- a/include/linux/fs.h	2005-05-19 10:17:53.000000000 +0200
> +++ b/include/linux/fs.h	2005-05-19 10:14:57.000000000 +0200
> @@ -1680,7 +1680,7 @@
>  static int __fops ## _open(struct inode *inode, struct file *file)	\
>  {									\
>  	__simple_attr_check_format(__fmt, 0ul);				\
> -	return simple_attr_open(inode, file, &__get, &__set, __fmt);	\
> +	return simple_attr_open(inode, file, __get, __set, __fmt);	\
>  }									\
>  static struct file_operations __fops = {				\
>  	.owner	 = THIS_MODULE,						\
> 
> I'm currently away from my test machine, so I think it's easier if you
> just update your patch yourself, but I could also send you an update
> patch later if you prefer.

Thanks for the updates, I've made them by hand to the patch, and will
show up in the next -mm release.

thanks again,

greg k-h
