Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262937AbUJ1UnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbUJ1UnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbUJ1Uj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:39:56 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:43020 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262949AbUJ1UiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 16:38:12 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andreas Herrmann <AHERRMAN@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce stack consumption in do_mount
Date: Thu, 28 Oct 2004 23:31:03 +0300
User-Agent: KMail/1.5.4
References: <OF2D3B25A6.EBF2AF62-ONC1256F3B.005D01ED-C1256F3B.005EBAFF@de.ibm.com>
In-Reply-To: <OF2D3B25A6.EBF2AF62-ONC1256F3B.005D01ED-C1256F3B.005EBAFF@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410282331.03668.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 20:14, Andreas Herrmann wrote:
> 
> I have seen a kernel stack overflow during mount of a SCSI disk on
> s390, 31bit, with 4K stack size.
> 
> The backtrace showed that there were 3 functions with stack
> consumption of above 200 bytes.
> 
> These are do_mount (328 bytes stack size), ext3_fill_super (288 bytes)
> and mpage_writepages (352 bytes).
> 
> For the latter 2 functions the large stack consumption seems to be
> just due to extensive inlining of GCC 3.4.
> 
> But do_mount and friends store one or more struct nameidata on the
> stack.  The size of this structure is 64 bytes on s390.
> 
> I suggest to kmalloc this structure in do_mount, do_loopback and
> do_move_mount.
> 
> Applying the patch, stack size consumption of do_mount is 80 bytes
> instead of 328 bytes. This would have avoided the kernel stack
> overflow that I have encountered.

[snip]

>  static int do_move_mount(struct nameidata *nd, char *old_name)
>  {
> -     struct nameidata old_nd, parent_nd;
> +     struct nameidata *old_nd, *parent_nd = NULL;
>       struct vfsmount *p;
>       int err = 0;
>       if (!capable(CAP_SYS_ADMIN))
>             return -EPERM;
>       if (!old_name || !*old_name)
>             return -EINVAL;
> -     err = path_lookup(old_name, LOOKUP_FOLLOW, &old_nd);
> -     if (err)
> +     old_nd = kmalloc(sizeof(*old_nd), GFP_KERNEL);
> +     if (!old_nd)
> +           return -ENOMEM;

[snip]

> +     parent_nd = kmalloc(sizeof(*parent_nd), GFP_ATOMIC);
> +     if (!parent_nd) {
> +           err = -ENOMEM;
> +           goto out2;
> +     }

Do it in one go:

	struct {
		struct nameidata old_nd, parent_nd;
	} *loc;
	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
	if (loc)
		return -ENOMEM;

and add loc-> to every occurrence of old_nd and parent_nd.

Reduces time, space, fragmentation overhead and code size.
--
vda

