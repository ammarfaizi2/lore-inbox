Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbRANXAo>; Sun, 14 Jan 2001 18:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130075AbRANXAe>; Sun, 14 Jan 2001 18:00:34 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:15630 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129523AbRANXAc>;
	Sun, 14 Jan 2001 18:00:32 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: Your message of "Sun, 14 Jan 2001 13:47:29 -0800."
             <Pine.LNX.4.10.10101141344430.4505-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Jan 2001 10:00:22 +1100
Message-ID: <17493.979513222@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2001 13:47:29 -0800 (PST), 
Linus Torvalds <torvalds@transmeta.com> wrote:
>On Sun, 14 Jan 2001, David Woodhouse wrote:
>> That's the one flaw in the inter_module_get() stuff - we could do with a
>> way to put entries in the table at _compile_ time, rather than _only_ at
>> run time. 
>
>Ok, I can buy that. Not having to initialize explicitly would be nice, but
>if so we should make module loading do it automatically too ...

It might be nice but it is also expensive.  Adding static
inter_module_xxx tables requires

* changes to linux/modules.h to define the new table format and
* changes to vmlinux.lds for _every_ architecture to bring all the
  static tables together in vmlinux and
* new initialisation code in module.c to read and load all the static
  tables at boot time and
* extra code in modutils to find any static tables in modules and
* an extension to struct modules to let modutils pass information about
  the static tables to the kernel and
* the kernel code will only work with an upgraded modutils.

That is a lot of work for a very few special cases.  OTOH, you could
just add a few lines of __initcall code in two source files (which I
did when I wrote inter_module_xxx) and swap the order of 3 lines in
drivers/mtd/Makefile.  Guess which alternative I am going for?

IMHO any automatic method that relies on ELF sections and/or modutils
support is the wrong approach, it is a complex solution with external
dependencies when we already have a simple solution with no external
dependencies.  What next, static tables for file system registration,
for device registration?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
