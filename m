Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261348AbSJQL0u>; Thu, 17 Oct 2002 07:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbSJQL0u>; Thu, 17 Oct 2002 07:26:50 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:13836 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S261348AbSJQL0s>; Thu, 17 Oct 2002 07:26:48 -0400
From: Chris Evans <chris@scary.beasts.org>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Reply-To: Chris Evans <chris@scary.beasts.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <87smza1p7f.fsf@goat.bogus.local> <87bs5tba9j.fsf@goat.bogus.local>
In-Reply-To: <87bs5tba9j.fsf@goat.bogus.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP3 Imap webMail Program 2.0.11
X-Originating-IP: 217.163.5.253
Subject: Re: [PATCH][RFC] 2.5.42: remove capable(CAP_SYS_RAWIO) check from open_kmem
Message-Id: <E1828tD-0000V0-00@sphinx.mythic-beasts.com>
Date: Thu, 17 Oct 2002 12:32:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

No, please DON'T apply.

If /dev/mem and /dev/kmem are only protected by
filesystem permissions, then:

1) Ownership of either will confer CAP_SYS_RAWIO
2) CAP_DAC_OVERRIDE, etc. will confer CAP_SYS_RAWIO
3) Ability to mknod() one of the these will confer
CAP_SYS_RAWIO (I think to make one you only need
CAP_SYS_ADMIN, could be wrong).

CAP_SYS_RAWIO is extremely dangerous and must not
be leverageable via other system capabilities or
filesystem permissions.

There are many people who have systems with elaborate
security setups where root access is limited in what
it can do. If we allow a root user to get
CAP_SYS_RAWIO easily, this is lost.

Cheers
Chris

Quoting Olaf Dietsche
<olaf.dietsche#list.linux-kernel@t-online.de>:

> Olaf Dietsche
<olaf.dietsche#list.linux-kernel@t-online.de> writes:
> 
> > In drivers/char/mem.c there's open_port(), which is
used as open_mem()
> > and open_kmem() as well. I don't see the benefit of
this, since
> > /dev/mem and /dev/kmem are already protected by
filesystem
> > permissions.
> >
> > mem.c, line 526:
> > static int open_port(struct inode * inode, struct
file * filp)
> > {
> > 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
> > }
> >
> > If anyone knows, why this is done this way, please
let me
> > know. Otherwise, I suggest the patch below.
> 
> I haven't got a convincing answer against this patch,
so far. The
> patch applies to 2.5.43 as well.
> Linus, please apply.
> 
> Regards, Olaf.
> 
> --- a/drivers/char/mem.c	Sat Oct  5 18:44:55 2002
> +++ b/drivers/char/mem.c	Sun Oct 13 13:59:25 2002
> @@ -533,15 +533,12 @@
>  #define full_lseek      null_lseek
>  #define write_zero	write_null
>  #define read_full       read_zero
> -#define open_mem	open_port
> -#define open_kmem	open_mem
>  
>  static struct file_operations mem_fops = {
>  	llseek:		memory_lseek,
>  	read:		read_mem,
>  	write:		write_mem,
>  	mmap:		mmap_mem,
> -	open:		open_mem,
>  };
>  
>  static struct file_operations kmem_fops = {
> @@ -549,7 +546,6 @@
>  	read:		read_kmem,
>  	write:		write_kmem,
>  	mmap:		mmap_kmem,
> -	open:		open_kmem,
>  };
>  
>  static struct file_operations null_fops = {
> -
> To unsubscribe from this list: send the line
"unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

