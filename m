Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVEDWnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVEDWnB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 18:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVEDWnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 18:43:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:42665 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261936AbVEDWm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 18:42:56 -0400
Date: Wed, 4 May 2005 15:42:45 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Leszek Koltunski <leszek@serwer.3miasto.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot read from /dev/kmem
Message-Id: <20050504154245.28d27a6f.rddunlap@osdl.org>
In-Reply-To: <Pine.NEB.4.60.0505041712240.12334@serwer.3miasto.net>
References: <Pine.NEB.4.60.0505041712240.12334@serwer.3miasto.net>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2005 17:20:36 +0200 (CEST)
Leszek Koltunski <leszek@serwer.3miasto.net> wrote:

> 
> Kernel 2.6.11 , I cannot seem to be able to read from /dev/kmem... The 
> following little proggie
> 
> #include <stdio.h>
> #include <fcntl.h>
> #include <errno.h>
> 
> struct {
>          unsigned short limit;
>          unsigned int base;
> } __attribute__ ((packed)) idtr;
> 
> struct {
>          unsigned short off1;
>          unsigned short sel;
>          unsigned char none,flags;
>          unsigned short off2;
> } __attribute__ ((packed)) idt;
> 
> int main()
> {
>          int result, kmem = open ("/dev/kmem",O_RDONLY);
> 
>          asm ("sidt %0" : "=m" (idtr));
>          printf("idtr base at 0x%X\n",(int)idtr.base);
> 
>          if (kmem<0) return 1;
> 
>          if (lseek(kmem,  idtr.base + 8*0x80,SEEK_SET) != idtr.base + 
> 8*0x80 )
>          {
>                  perror("kmem lseek"); exit(1);
>          }
> 
>          result = read(kmem, &idt , sizeof(idt) );
> 
>          if( result != sizeof(idt) )
>          {
>                  printf("result: %d, sizeof(idt)= %d errno=%d\n", result, 
> sizeof(idt), errno);
>          }
> 
>          close(kmem);
> 
>          return 0;
> }
> 
> returns
> 
> utumno:/home/leszek/progs/module/hijack# ./test
> idtr base at 0xC0423000
> result: -1, sizeof(idt)= 8 errno=22
> 
> ??? EINVAL
> 
> I remember this working on a 2.4.x kernel....

Hm, let me see if I can explain what I see here...

vfs_llseek() sets f_pos (file position) to 0xffffffff.c04230000 (due
to sign extension).  In read(), rw_verify_area() sees that pos
as < 0 and balks on it.

I futzed around with lseek() and read(), to no avail.
However, I did get your test program to work by using lseek64()
instead of lseek().  It prints (after I added code) a selector
value of 0x60, which makes sense.

Maybe you have to use llseek() or lseek64() with large 32-bit
file offsets (that look like 32-bit negative numbers)...
I dunno.

HTH.
---
~Randy
