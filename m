Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288027AbSAHNpe>; Tue, 8 Jan 2002 08:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288028AbSAHNpY>; Tue, 8 Jan 2002 08:45:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17169 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288027AbSAHNpI>; Tue, 8 Jan 2002 08:45:08 -0500
Subject: Re: [PATCH][RFC] Lightweight user-level semaphores
To: matthew@hairy.beasts.org (Matthew Kirkwood)
Date: Tue, 8 Jan 2002 13:56:30 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201071902070.5064-101000@sphinx.mythic-beasts.com> from "Matthew Kirkwood" at Jan 07, 2002 08:05:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Nwju-0006TB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  * I don't do the:
> 
> 	if (kfs->user_address != fs)
> 		goto bad_sem;
> 
>    because it doesn't seem to add anything, and prevents
>    putting these locks in a non-fixed file or SysV SHM
>    map.

The security side of it is basically non existant anyway. If you can map it
you can play naughty. If I decide to do raw I/O DMA directly into that
segment you either litter the kernel with special cases or accept that
if you do stupid things it breaks. 

I'm for the latter 8)

> +static inline struct ksem *get_ksem(struct fast_sem *s)
> +{
> +	struct ksem *r = (struct ksem*)s->__opaque_ksem;
> +	if(!r) return NULL;
> +	if(r->magic != FS_SIG_MAGIC) return NULL;

Bang, dead, raw hardware access - game over. You can't dereference the
untrusted pointer to check if its valid, even to look at it. Wouldn't it
be easier and safer to create a two page map, where page 0 is the r/w
objects and page 1 is mapped r/o or kernel private and consists of identical 
sized objects ? Then its a case of offset from page start + array bias.

> +	struct ksem *s;
> +	s = kmalloc(sizeof(*s), GFP_KERNEL);

if(s==NULL) check missing
 

Alan
