Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTEGTEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbTEGTEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:04:52 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:45822 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S264178AbTEGTEu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:04:50 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "David S. Miller" <davem@redhat.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Date: Wed, 7 May 2003 21:13:07 +0200
User-Agent: KMail/1.5.1
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <20030507104008$12ba@gated-at.bofh.it> <20030507152856.GF412@elf.ucw.cz> <1052323484.9817.14.camel@rth.ninka.net>
In-Reply-To: <1052323484.9817.14.camel@rth.ninka.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="euc-jp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305072113.07004.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 May 2003 18:04, David S. Miller wrote:
> You can define it as follows:
>
> 1) If entry exists in COMPAT or TRANSLATE table, invoke
>    fops->ioctl(), else
>
> 2) If ->compat_ioctl() exists, invoke that, else
>
> 3) Fail.

Another solution could be to use the tables only if
->compat_ioctl() is undefined or returned -ENOTTY. That
would save the hash table lookup in many cases and makes
it possible for a driver to override a generic handler
with its more specialized version (e.g. CIODEVPRIVATE).

> The COMPAT tables are sort of valuable, in that it eliminates
> the need to duplicate code when all of a drivers ioctls need
> no translation.

Right. Of course you can just as well do 

	.ioctl = &foo_ioctl,
	.compat_ioctl = &foo_ioctl,

in that case.

Btw: is there any bit in the ioctl number definition that can
be (ab)used for compat_ioctl? Maybe we don't even need another
callback if the compatibility mode can be encoded in the
number itself (simplified):

long compat_sys_ioctl(unsigned int fd, unsigned int cmd,
	unsigned long arg)
{
	long err = sys_ioctl(fd, cmd | _IOC_COMPAT, arg);
	if (err == -ENOTTY) /* use ioctl_trans table */
		err = compat_do_ioctl(fd, cmd, arg);
	return err;
}
...
long foo_ioctl(struct inode * inode, struct file * filp,
		unsigned int cmd, unsigned long arg)
{
	switch(cmd) {
	case SOMEIOCTL:
		return do_something(inode, arg);
	case SOMEIOCTL | _IOC_COMPAT:
		return compat_do_something(inode, arg);
	case ANOTHERIOCTL:
	case ANOTHERIOCTL | _IOC_COMPAT:	
		return do_something_else(inode, arg);
	}
	return -ENOTTY;
}

	Arnd <><	
