Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284242AbRLAUlV>; Sat, 1 Dec 2001 15:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284244AbRLAUlP>; Sat, 1 Dec 2001 15:41:15 -0500
Received: from mail.cs.umn.edu ([128.101.34.200]:43189 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id <S284242AbRLAUlB>;
	Sat, 1 Dec 2001 15:41:01 -0500
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, <sct@redhat.com>
Subject: Re: [PATCH] if (foo) kfree(foo) /fs cleanup + reverted JBD code
 path changes
In-Reply-To: <Pine.LNX.4.33.0112011830550.14290-100000@netfinity.realnet.co.sz>
From: Raja R Harinath <harinath@cs.umn.edu>
Date: Sat, 01 Dec 2001 14:40:58 -0600
In-Reply-To: <Pine.LNX.4.33.0112011830550.14290-100000@netfinity.realnet.co.sz>
 (Zwane Mwaikambo's message of "Sat, 1 Dec 2001 18:33:50 +0200 (SAST)")
Message-ID: <d9snau4qsl.fsf@han.cs.umn.edu>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.1.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linux.realnet.co.sz> writes:

> diff -urN linux-2.5.1-pre4.orig/fs/coda/inode.c linux-2.5.1-pre4.kfree/fs/coda/inode.c
> --- linux-2.5.1-pre4.orig/fs/coda/inode.c	Fri Apr 27 23:09:37 2001
> +++ linux-2.5.1-pre4.kfree/fs/coda/inode.c	Fri Nov 30 23:45:08 2001
> @@ -164,11 +164,10 @@
>
>   error:
>  	EXIT;
> -	if (sbi) {
> -		kfree(sbi);
> -		if(vc)
> -			vc->vc_sb = NULL;
> -	}
> +	kfree(sbi);
> +	if (vc)
> +		vc->vc_sb = NULL;
> +
>  	if (root)
>                  iput(root);

Not a safe change.  If you really really really want to change it, it
should be

        if (sbi && vc)
		vc->vc_sb = NULL;
        kfree(sbi);

Then, the maintainer of the code can decide if that's what he meant.

> -	if (opts.iocharset) {
> -		printk("FAT: freeing iocharset=%s\n", opts.iocharset);
> -		kfree(opts.iocharset);
> -	}
> -	if(sbi->private_data)
> -		kfree(sbi->private_data);
> +	printk("FAT: freeing iocharset=%s\n", opts.iocharset);
> +	kfree(opts.iocharset);

And, you get a Oops in 'printk' in the bargain.  The following is
better, but doesn't really buy you much.

	if (opts.iocharset) 
		printk("FAT: freeing iocharset=%s\n", opts.iocharset);
        kfree(opts.iocharset);

>  		printk("jffs_find_child(): Didn't find the file \"%s\".\n",
>  		       (copy ? copy : ""));
> -		if (copy) {
> -			kfree(copy);
> +		kfree(copy);
>  		}
                ^
Missed the closing brace.

- Hari
-- 
Raja R Harinath ------------------------------ harinath@cs.umn.edu
"When all else fails, read the instructions."      -- Cahn's Axiom
"Our policy is, when in doubt, do the right thing."   -- Roy L Ash
