Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261423AbSJUPut>; Mon, 21 Oct 2002 11:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSJUPut>; Mon, 21 Oct 2002 11:50:49 -0400
Received: from fmr01.intel.com ([192.55.52.18]:64707 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261423AbSJUPuq>;
	Mon, 21 Oct 2002 11:50:46 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000E6AE154@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: RE: [PATCH] fixes for building kernel using Intel compiler
Date: Mon, 21 Oct 2002 08:56:49 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it depends on the assumptions for the compiler quality. If you don't
trust __attribute__ ((align(xxx)), many other things are broken as well. Why
do you need to check this particular one, especially? For example, even if
__attribute__ ((align(16)) works, __attribute__ ((align(32)) may not work.
But I agree that having such a sanity test is a good thing, and I won't back
it out.

Having said that, one occasion where people might be surprised by gcc (this
might be a known issue, though) is: typedef + __attribute__; it ignores
__attribute__. For example, 
#include <stdio.h>

struct foo_16 {
        char    xxx[3];
        short   yyy;
} __attribute__ ((aligned (16)));

typedef struct bar_16 {
        char    xxx[3];
        short   yyy;
} bar_16_t __attribute__ ((aligned (16)));

struct foo_16   f;
bar_16_t        b0;
bar_16_t        b1;

main() {
        printf("&f = 0x%lx, &b0 = 0x%lx, &b1 = 0x%lx\n", &f, &b0, &b1);
}

$./a.out
&f = 0x8049630, &b0 = 0x8049646, &b1 = 0x8049640

Another example is packed.

#include <stdio.h>
#ifdef TYPEDEF
typedef struct NewSectorMap {
        char byte;
        int c;
} SectorCount __attribute__((packed));
#else
struct SectorCount {
        char byte;
        int c;
}  __attribute__((packed));
#endif


int main() {

#ifdef TYPEDEF
        printf("%p %p\n", &(((SectorCount *)0)->byte), &(((SectorCount
*)0)->c));
#else
        printf("%p %p\n", &(((struct SectorCount *)0)->byte), &(((struct
SectorCount *)0)->c));
#endif
        return 0;
}

$ gcc  typedef.c
$ ./a.out 
(nil) 0x1
$ gcc -D TYPEDEF typedef.c
$ ./a.out 
(nil) 0x4

In the kernel, there are several device drivers (ftape-bsm.h, e100.h, for
example) are doing this kind of thing (i.e. typedef + attribute). 

Thanks,
Jun

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Monday, October 21, 2002 5:48 AM
To: Nakajima, Jun
Cc: Linus Torvalds; Linux Kernel Mailing List; Mallick, Asit K; Saxena,
Sunil
Subject: Re: [PATCH] fixes for building kernel using Intel compiler


On Sat, 2002-10-19 at 00:48, Nakajima, Jun wrote:
> -/* Enable FXSR and company _before_ testing for FP problems. */
> -       /*
> -        * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
> -        */
> -       if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
> -               extern void __buggy_fxsr_alignment(void);
> -               __buggy_fxsr_alignment();
> -       }
>         if (cpu_has_fxsr) {
>                 printk(KERN_INFO "Enabling fast FPU save and restore...
");

So you back out a test that is pretty much essential to catch misaligned
stuff if we do get something wrong in our alignments or due to compiler
suprises and hope it doesnt happen ?

This isnt "fixing" this is the mad axeman at work. Linus this patch
should not go in as it is

