Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318467AbSGSISZ>; Fri, 19 Jul 2002 04:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318468AbSGSISZ>; Fri, 19 Jul 2002 04:18:25 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:19422 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318467AbSGSISY>;
	Fri, 19 Jul 2002 04:18:24 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] check shm mount succeeded in shmem_file_setup 
In-reply-to: Your message of "Thu, 18 Jul 2002 22:54:27 EST."
             <200207190354.WAA05241@ccure.karaya.com> 
Date: Fri, 19 Jul 2002 17:53:06 +1000
Message-Id: <20020719080027.EEA964479@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200207190354.WAA05241@ccure.karaya.com> you write:
> The kern_mount(&tmpfs_fs_type) in init_shmem_fs can fail, leaving shm_mnt
> NULL.  A subsequent shmget will enter shmem_file_setup, which will blindly
> dereference shm_mnt.  EIO was my best guess as to the appropriate errno.

I think the bug is checking the return value at all.  This code cannot
be a module (at least without significant furthur work), despite the
fact that someone nicely wrote an exitfunction for it.

And if the initialization fails at boot, we're screwed anyway.

> --- orig/mm/shmem.c     Mon Feb 25 12:50:45 2002
> +++ um/mm/shmem.c       Thu Jul 18 22:16:11 2002
> @@ -1455,6 +1455,9 @@
>         if (!vm_enough_memory((size) >> PAGE_CACHE_SHIFT))
>                 return ERR_PTR(-ENOMEM);
>  
> +       if(shm_mnt == NULL)
> +               return ERR_PTR(-EIO);
> +
>         this.name = name;
>         this.len = strlen(name);
>         this.hash = 0; /* will go */

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
