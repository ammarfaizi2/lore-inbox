Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161561AbWJKWUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161561AbWJKWUb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 18:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161570AbWJKWUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 18:20:31 -0400
Received: from [82.67.71.117] ([82.67.71.117]:58832 "EHLO siegfried.gbfo.org")
	by vger.kernel.org with ESMTP id S1161561AbWJKWU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 18:20:29 -0400
Date: Thu, 12 Oct 2006 00:20:01 +0200 (CEST)
From: Jean-Marc Saffroy <saffroy@gmail.com>
X-X-Sender: saffroy@erda.mds
To: linux-kernel@vger.kernel.org
Subject: [announce] kdump2gdb 0.2
Message-ID: <Pine.LNX.4.64.0610111644580.4801@erda.mds>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[bcc to fastboot@lists.osdl.org, which is moderated for non-members]

Hello folks,

I have released kdump2gdb 0.2, a small tool that converts a kdump core to 
an ELF core that can be used with gdb. It now enables kernel-level 
backtracing of all processes from within gdb.

Download it from here:
   http://jeanmarc.saffroy.free.fr/kdump2gdb/

Each process is seen as a thread, so you can use gdb's internal 
thread-related commands (which are much faster and richer than scripts): 
"info threads" to list them, "thread <NN>" to switch to any thread (no VMM 
context switch here), "bt" and "bt full", "up" and "down", as with a 
userland multithreaded core file. Due to optimizations (?), the stack 
frames decoded by gdb can be unaccurate, and should be taken with a grain 
of salt; I suspect setting CONFIG_STACK_UNWIND could yield better results.

Below is the README. Feedback is welcome!


Cheers,

-- 
saffroy@gmail.com

kdump2gdb
---------

The kdump2gdb script converts a kdump core file (which is essentially an ELF
core) into a slightly different ELF core that can be directly used with gdb.
It also produces a gdb script that loads the required kernel modules.

Features:
  - completely automated: run kdump2gdb, then start gdb on your new core file,
    load modules, and enjoy!
  - the power of gdb to explore stack frames with full debug infos on all
    tasks

Limitations:
  - currently limited to x86-64; but support for other arches should not be
    difficult to add
  - gdb scripting is *slow*! But a patch that improves this is already
    available, and I suspect there could be more in the near future.


Sample session
--------------

Below is an example of how I use kdump2gdb (from the tarball). As you can see,
even on a 2GHz Athlon box with a patched gdb, it takes several minutes to
complete.

  $ cd kdump2gdb-0.2
  $ make
gcc -Wall -g  -lelf  kdumpfix.c   -o kdumpfix
  $ time ./kdump2gdb -k /var/dump/dump-2006-09-21_11\:15\:21 \
    -d ~/kernel/build-2.6.18 -o /tmp/core -g modload
Restoring low identity-mapped areas...
Gathering vmalloc-mapped areas...

warning: shared library handler failed to enable breakpoint
Gathering thread data...

warning: shared library handler failed to enable breakpoint
Restoring vmalloc-mapped areas...
Preparing gdb script to map modules...

warning: shared library handler failed to enable breakpoint
All done. Now you can do:
  $ gdb /home/saffroy/kernel/build-2.6.18/vmlinux /tmp/core
  (gdb) source modload
  (gdb) bt

real    7m42.250s
user    6m15.658s
sys     0m6.520s

(The warnings are produced by gdb, they are harmless.)


Gdb patches
-----------

I use gdb 6.5, and encountered the following problems:
  - gdb crashes in realloc on add-symbol-file:
    the fix is here:
      http://sources.redhat.com/ml/gdb-patches/2006-10/msg00056.html
  - gdb scripts are sooooooooooo sloooooow:
    a significant improvement is observed with the patch mentioned here:
      http://sources.redhat.com/ml/gdb/2006-10/msg00023.html

You should edit the kdump2gdb script to use a specific gdb binary if needed.


Licensing
---------

This program is free software, distributed under the terms of the
GNU General Public License version 2.


Contact
-------

Jean-Marc Saffroy <saffroy@gmail.com>
