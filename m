Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTISXEG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 19:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbTISXEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 19:04:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:34447 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261798AbTISXEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 19:04:02 -0400
Date: Fri, 19 Sep 2003 16:03:53 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, sds@epoch.ncsc.mil
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030919160353.H27079@osdlab.pdx.osdl.net>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>; from dychen@stanford.edu on Mon, Sep 15, 2003 at 09:35:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Yu Chen (dychen@stanford.edu) wrote:
> [FILE:  2.6.0-test5/security/selinux/selinuxfs.c]
> START -->
>  253:	ar = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  254:	if (!ar)
>  255:		return -ENOMEM;
>  256:	memset(ar, 0, PAGE_SIZE); /* clear buffer, particularly last byte */
>  257:	ar->size = 0;
>  258:	down(&file->f_dentry->d_inode->i_sem);
>         ... DELETED 5 lines ...

A reference to ar is stored away for kfree() on ->release():
		file->private_data = ar;

>  268:	if (copy_from_user(ar->data, buf, size))
> END -->
>  269:		return -EFAULT;

So, this will be freed when the file is closed.  I don't think it's a
bug.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
