Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbUDHWLW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 18:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUDHWLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 18:11:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:19863 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262810AbUDHWLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 18:11:20 -0400
Date: Thu, 8 Apr 2004 15:11:19 -0700
From: Chris Wright <chrisw@osdl.org>
To: Kirill Korotaev <kirillx@7ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Errors in load_elf_binary()?
Message-ID: <20040408151118.H22989@build.pdx.osdl.net>
References: <40753919.2070202@sw.ru> <791543157.20040409012711@7ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <791543157.20040409012711@7ka.mipt.ru>; from kirillx@7ka.mipt.ru on Fri, Apr 09, 2004 at 01:27:11AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kirill Korotaev (kirillx@7ka.mipt.ru) wrote:
> File: fs/binfmt_elf.c
> 1.
> load_elf_binary()
> 2002/02/05 torvalds   | retval = kernel_read(bprm->file, elf_ex.e_phoff, (char *) elf_phdata, size);
> 2002/02/05 torvalds   | if (retval < 0)
> 2002/02/05 torvalds   |       goto out_free_ph;
> 2003/06/29 alan       |
> 2003/06/29 alan       | files = current->files;           /* Refcounted so ok */
> 2003/06/29 alan       | if(unshare_files() < 0)
> 2003/06/29 alan       |       goto out_free_ph;
> <<<< retval is not set >>>>
> should be something like:
> retval = unshare_files()
> if (retval < 0)
>    goto ....;

yes, this looks like a bug.

> 2.
> load_elf_binary()
> 2002/02/05 torvalds   | out_free_dentry:
> 2002/02/05 torvalds   |       allow_write_access(interpreter);
> 2002/02/05 torvalds   |       fput(interpreter);
> <<<< interpreter can be NULL >>>>
> e.g. we got oopses here when flush_old_exec()
> returns error
> should be something like:
> if (interpreter)
>    fput(interpreter);

yup, this change is already in 2.6.

> 3.
> load_elf_binary()
> Why there is no steal_locks() call in exit path (after label 
> "out_free_fh")? Shouldn't were steal locks back when undoing our changes?

No, on this error path locks never got stolen to begin with.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
