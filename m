Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129816AbRBAAcd>; Wed, 31 Jan 2001 19:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129863AbRBAAcX>; Wed, 31 Jan 2001 19:32:23 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:41794 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129816AbRBAAcP>; Wed, 31 Jan 2001 19:32:15 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: LA Walsh <law@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Power usage Q and parallel make question (separate issues) 
In-Reply-To: Your message of "Wed, 31 Jan 2001 11:44:28 -0800."
             <3A786B1C.F6A3CE83@sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Feb 2001 11:32:00 +1100
Message-ID: <9806.980987520@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001 11:44:28 -0800, 
LA Walsh <law@sgi.com> wrote:
>So, just about anyone I know uses make -j X [-l Y] bzImage modules, but I noticed that
>make modules_install isn't parallel safe in 2.4 -- since it takes much longer than the
>old, it would make sense to want to run it in parallel as well, but it has a 
>delete-old, <multiple sub-dirs>, index-new for deps.  Those "3" steps can't be done
>in parallel safely.  Was this intentional or would a 'fix' be desired?

The only bit that could run in parallel is this one.

.PHONY: $(patsubst %, _modinst_%, $(SUBDIRS))
$(patsubst %, _modinst_%, $(SUBDIRS)) :
        $(MAKE) -C $(patsubst _modinst_%, %, $@) modules_install

The erase must be done first (serial), then make modules_install in
every subdir (parallel), then depmod (serial).

>Is it the intention of the Makefile maintainers to allow a parallel or distributed
>make?  I know for me it makes a noticable difference even on a 1 CPU machine
>(CPU overlap with disk I/O), and with multi CPU machines, it's even more noticable.
>
>Is a make of the kernel and/or the modules designed to be parallel safe?  Is it 
>something I should 'rely' on?  If it isn't, should it be?

make dep, make clean and the various install targets are not parallel
safe in 2.4.  Most of the make vmlinux, bzImage, modules is parallel
safe but even in those phases there are known problems because the 2.4
makefiles do not make it easy to handle cross directory dependencies.
The recommended sequence for 2.4 is

  make xxxconfig
  make dep
  make clean <if necessary>
  make -j n bzImage modules
  make modules_install

The makefile rewrite for 2.5 will fix these parallelism problems.  The
2.4 system is too fragile with too many special cases, nobody is game
to fix the parallelism and guarantee that it will not break anything
else.  modules_install in 2.5 will be fast!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
