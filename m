Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262684AbRFLRDc>; Tue, 12 Jun 2001 13:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262694AbRFLRDW>; Tue, 12 Jun 2001 13:03:22 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:16627 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S262684AbRFLRDP>;
	Tue, 12 Jun 2001 13:03:15 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: DJBARROW@de.ibm.com
cc: schwidefsky@de.ibm.com, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: bug in /net/core/dev.c 
In-Reply-To: Your message of "Tue, 12 Jun 2001 18:43:41 +0200."
             <C1256A69.005BF601.00@d12mta09.de.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Jun 2001 03:02:44 +1000
Message-ID: <10973.992365364@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2001 18:43:41 +0200, 
DJBARROW@de.ibm.com wrote:
>Hi Keith,
>This is a cure the syntom not the problem, build order shouldn't mess up
>something this simple.

I totally agree on one point.  Having the automatic initialisers in the
same source as the related code is a good idea, it is far better than
the old Space.c method.  Automatically executing the initialisers in
the order they are linked into vmlinux is also a good idea, you must
have some automatic order or you are back to the horrors of Space.c.
But controlling the link order of the initialisers as a side effect of
Makefile compile order sucks big rocks, especially when you have some
Makefiles executing other Makefiles which are not their children.

Link order should be independent of Makefile compile order and it
should be explicitly specified, instead of occurring as a little known
side effect of the convoluted and twisted way that the Makefile tree is
processed.  Alas Linus likes it this way :(.  At least with my 2.5
Makefile rewrite[*] it is more obvious what is going on.  I abhore the
line order dependencies and controling link order at the level of
entire directories when it should be at the level of individual
sources.

>I've forwarded your patch to Ulrich & Martin ( the s390 maintainers ) &
>they may use it
>seeing as you & possibly others would prefer a /drivers/net/s390.

DaveM suggested a drivers/net/s390, I recommended against changing the
diretory structure right now, wait for 2.5.  My patch just changes the
compilation order for drivers/s390/net while keeping the same name.


[*] Extract from top level Makefile in my 2.5 rewrite.

# Link order information to build vmlinux.

link_subdirs(arch/$(ARCH)/boot)
link_subdirs(init)

link_subdirs($(arch_core_subdirs))

link_subdirs(kernel)
link_subdirs(mm)
link_subdirs(fs)
link_subdirs(ipc)

# FIXME: Built from the DRIVERS definitions in the old Makefile.  Some of this
# is just to link intermediate objects into the kernel, some of it is link order
# specific but the old Makefile had no documentation.  Preserve the old list,
# even though most of it is unnecessary.  The problem is, we do not know which
# bits are necessary because they have link order requirements.  Anybody feeling
# brave?  KAO

link_subdirs(drivers/block)
link_subdirs(drivers/char)
link_subdirs(drivers/misc)
link_subdirs(drivers/net)
link_subdirs(drivers/media)
...
link_subdirs(drivers/acpi)
link_subdirs(drivers/md)

link_subdirs($(arch_drivers_subdirs))

link_subdirs(net)

link_subdirs($(arch_libs))
link_subdirs(lib)

