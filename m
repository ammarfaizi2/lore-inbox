Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129295AbQKYQDE>; Sat, 25 Nov 2000 11:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129434AbQKYQCy>; Sat, 25 Nov 2000 11:02:54 -0500
Received: from d-dialin-1303.addcom.de ([62.96.164.103]:4356 "EHLO
        felix.home.kai") by vger.kernel.org with ESMTP id <S129295AbQKYQCs>;
        Sat, 25 Nov 2000 11:02:48 -0500
Date: Sat, 25 Nov 2000 16:17:14 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Keith Owens <kaos@ocs.com.au>
cc: "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch(?): isapnp_card_id tables for all isapnp drivers in
 2.4.0-test11 
In-Reply-To: <4906.975116492@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.30.0011251545560.19603-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2000, Keith Owens wrote:

> On Fri, 24 Nov 2000 15:37:33 -0800,
> "Adam J. Richter" <adam@yggdrasil.com> wrote:
> >	Note that this is not a "final" version.  I plan to go
> >through all of the changes and bracket all of these new tables
> >with #ifdef MODULE...#endif so they do not result in complaints
> >about the table being defined static and never used in cases where
> >the driver is compiled directly into the kernel.
>
> This is cleaner.  Append MODULE_ONLY after __initdata and remove the
> ifdef.  It increases the size of initdata in the kernel, compared to
> ifdef, but since initdata is promptly reused as scratch space it should
> not be a problem.
>
> Index: 0-test11.1/include/linux/module.h
> --- 0-test11.1/include/linux/module.h Sun, 12 Nov 2000 14:59:01 +1100 kaos (linux-2.4/W/33_module.h 1.1.2.1.2.1.2.1.2.1.1.3 644)
> +++ 0-test11.1(w)/include/linux/module.h Sat, 25 Nov 2000 12:40:10 +1100 kaos (linux-2.4/W/33_module.h 1.1.2.1.2.1.2.1.2.1.1.3 644)
> @@ -261,6 +261,7 @@ extern struct module __this_module;
>  #define MOD_INC_USE_COUNT	__MOD_INC_USE_COUNT(THIS_MODULE)
>  #define MOD_DEC_USE_COUNT	__MOD_DEC_USE_COUNT(THIS_MODULE)
>  #define MOD_IN_USE		__MOD_IN_USE(THIS_MODULE)
> +#define MODULE_ONLY		__attribute__ ((unused))

What about the making MODULE_DEVICE_TABLE reference this table? This has
the same disadvantage (i.e. having a little unneeded __initdata in the
kernel image), but it wouldn't need the rather ugly MODULE_ONLY macro.

I'ld suggest something like this in module.h, #ifndef MODULE part:

#define MODULE_DEVICE_TABLE(type,name) \
static struct type##_device_id *__dummy_##name \
       __attribute__ ((unused, __section__(".text.exit"))) \
       = name;

This references the table (the variable holding the reference is in
text.exit and thus discarded at link time), maybe there's an easier way to
accomplish this. This of course smells like a hack, but at least it's
hidden away from the drivers ;-)

--Kai


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
