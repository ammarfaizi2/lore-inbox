Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbTJNR1E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 13:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbTJNR1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 13:27:04 -0400
Received: from chaos.analogic.com ([204.178.40.224]:25984 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262581AbTJNR0z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 13:26:55 -0400
Date: Tue, 14 Oct 2003 13:27:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?q?Hartmut=20Zybell?= <u_zybell@yahoo.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ld-Script needed OR (predicted) Architecture of Kernel 3.0 ;-)
In-Reply-To: <20031014134636.9110.qmail@web80702.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0310141319320.1406@chaos>
References: <20031014134636.9110.qmail@web80702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From u_zybell@yahoo.de Tue Oct 14 11:42:18 2003
To: root@chaos.analogic.com
From: "[iso-8859-1] Hartmut Zybell" <u_zybell@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ld-Script needed OR (predicted) Architecture of Kernel 3.0 ;-)

    [ The following text is in the "iso-8859-1" character set. ]
    [ Your display is set for the "US-ASCII" character set.  ]
    [ Some characters may be displayed incorrectly. ]

 --- "Richard B. Johnson" <root@chaos.analogic.com>
schrieb: > On Tue, 14 Oct 2003, [iso-8859-1] Hartmut
Zybell
>> wrote:
>>
>> > First things first: Please CC me, because I'm not
>> > subscribed.
>> >
>> > I need a ld-Script to construct an elf-File that
>> is a
>> > tar-File too. Can
>> > anyone help me? Especially the Checksum is tricky.
>> >
>> [SNIPPED....]
>>
>> I don't think you are aware that the kernel is
>> compressed,
>> then expanded when installed. It therefore has all
>> the good
>> attributes of a `tar.gz` file without any of the bad
>> ones.
>>
>>
> Of course I'm aware. But what bad ones do you mean?

The wasted space of the header(s) themselves, plus the fact
that it can't be updated, only re-written from scratch.

>> Also, we have a module loader and unloader that
>> allows modules
>> to be inserted and removed from a running system.

> Can you remove modules from a running system, that
> are compiled into the kernel? For instance the
> Filesystem driver, that were used to boot and is
> not longer needed because / has another filesystem
> than
> /initrd.


Drivers that are compiled into the kernel are not modules.
Once the linking occurs, all information necessary to
replace such code is lost.

No system that is statically linked can have portions
of the statically-linked area removed or replaced except
with code and data that is exactly the same length
with the exact same offsets of the global symbols.

In general, to have such exact characteristics requires
that the code be identical. So, one would not usually
reload an identical section of code.

This applies to all systems, not just Linux on Intel.
All systems, including those which haven't been invented
yet. Anything that executes instructions loaded into RAM
will have the same problem. That's why 'relocatable' code
was invented. But once you preform a static allocation
on relocatable code so that it occupies some specific
contiguous RAM (like the kernel), then the relocation
information is gone. You can't re-do it.

Make a 'C' program with a single variable:

int foo;

Then compile it into an object file. Then look at
it with `objdump`. What do you see?  Nothing! That
variable doesn't even show up. The presence of
that variable was put into the header which basically
tells the loader (eventually) to allocate some space in
the .bss segment for this variable. Where that data
will eventually exist will not be known until it is
either statically linked or fixed up by the loader
during dynamic linking.

Now change that variable to:

int foo = 0;

This makes it exist in the .data segment because it
has been initialized. Now look at it with `objdump`.
You will see that there is an allocation, but the
offset of that allocation is 0x00000000. These are
the offsets that are fixed up by either the linker,
for static linking, or the loader for dynamic.

Modules relocate at run-time. They are entirely different
than the statically-linked built-in code, even though
both are generated from the same source and create
nearly indentical object files. The module objects
contain relocation tables (part of ELF object format)
that allow code to be put anywhere (on certain bounadries) and
then fixed up by the loader. The final fixup resolves
all the relative offsets.

>> There are
>> even experimental systems that allow the whole
>> kernel to be
>> changed without (apparent) re-booting.
>>
>> A file with a 'tar' header is useful for recovering
>> a
>> directory tree, intact, as it was initially
>> backed-up.
>> It has no usefulness in the kernel where the content
>> of a file (or files) are located into various
>> offsets
>> in RAM. This is done by the linker and 'helper code'
>> within the kernel itself.

> I seem to have misread here. I *don't* want to change
> the kernel with tar, as you seem to assume. Thats why
> I'm asking for an ld-script. I want to be able to
> *extract* (READ-ONLY) modules from a kernelfile that
> are compiled into this (not currently running) kernel
> to insert them into the currently running kernel to
> update it. And I want to do it *with* the current
> module loader.

You need the original object files. You can't take
portions of the statically-linked kernel. You need
these original object files because they contain
the required relocation information. Once they get
linked into the kernel, the essential information
is lost.

You can store these object files anyway you want.
The usual way to store them is to use `ar`. The
existing module loader doesn't know how to extract
the object files from an archive, but you could
make a simple script to do it.

>
>> You can readily run an install-system without any
>> runtime libraries and/or you can use temporary ones.
>> This is currently done for every major distribution.
>>
> Of course it's done. You have 2 files: one staticaly
> linked to run at install time, one binary archive
> (descendent of tar) to install into the system.
> If I could make the binary do double duty as install
> archive, I could save 50% space. Thats a lot on a
> floppy based install. And make no mistake: Even CDROM
> (not all, I know!) boot from a floppy image.

Well no. You have a kernel image that was built with
a minimum of built-in drivers. Then you have some code
that looks at the PCI bus and installs the modules
necessary to activate the devices it finds. Then you
have more code to probe for other devices and you
install those modules, etc. Then you have a kernel that
will run the specific configuration found. After that's
done, the install program writes an initrd script and
builds an initial RAM disk so that modules necessary
to access the root file-system can be installed prior
to attempting to mount it. It's all there, it all works
and it doesn't waste the 50% space you claim above.

>> The runtime libraries are not used by the kernel.
>> Instead they are used by user-mode code.
>>
> I *wrote* that the first example has nothing to do
> with
> the kernel. It's only there because it's simpler.
> And useful too.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


