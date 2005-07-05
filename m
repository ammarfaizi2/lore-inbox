Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVGEGBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVGEGBo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 02:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVGEGBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 02:01:44 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:47500 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261755AbVGEGAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 02:00:52 -0400
Subject: Submission of Suspend2 for inclusion in mainline
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bernard Blackham <bernard@blackham.com.au>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120543335.4179.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 05 Jul 2005 16:02:16 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I want, at last, to submit Suspend2 for inclusion in the vanilla kernel.
For those who don't already know, Suspend2 is an implementation of
suspend-to-disk for Linux, which grew out of the same codebase as the
'swsusp' code currently in the kernel and maintained by Pavel, but has
seen far more working and reworking.

Suspend2 was initially developed for the 2.4 kernel, but was ported to
2.6 around a year and a half ago. Since then it has been actively
developed and maintained. The version being submitted (currently
2.1.9.8) is prepared against the 2.6.12 kernel.

So why should Suspend2 be merged?

The current suspend-to-disk implementation has a number of drawbacks. 

The most important of these is that it seeks to do the minimum required
to be able to say you suspended to disk. As much memory as can be freed
is freed, and the remainder written strictly synchronously to disk.
While this is good from the point of view of simplicity and ease of
maintenance, it is not what most users want. In contrast, Suspend2
developed as a result of a user (me) wanting something better, and
putting the time and effort into making it. Other users have of course
contributed along the way. It is therefore been designed to
simultaneously meet the goals of reliability, speed, user friendliness
and flexibility. I am not claiming that Suspend2 does everything
perfectly or that I don't still have work to do. What I am arguing is
that it provides suspend-to-disk functionality that users want. This can
be proven empirically: A recent stable release of Suspend (2.1.8) was
downloaded more than 12,000 times over the 4 months before it was
superseded.

Additional features in Suspend2:

Summary of suspend2 features:
- Asynchronous I/O;
- Readahead where I/O needs to be synchronous (compression/encryption);
- Optional ability to cancel a suspend while the image is being written;
- Compression and encryption support via Cryptoapi;
- LZF Cryptoapi module for fast on-the-fly compression of the image.
- Support for writing the image to swap partitions, swap files and
normal files. With relatively trivial additions for managing the link to
the server, the image could be written to a network connection.
- Support for block size != 4096;
- Ability to store a full image of memory, or to set an arbitrary soft
limit;
- Variety of possible actions after writing the image: powerdown,
reboot, suspend-to-ram;
- Support (via netlink socket) for userspace programs providing a nice
interface;
- Support for PPC and x86. x86_64 support in the works;
- Support for setting an arbitrary image size limit, or for writing all
memory (which gives the most responsive system post-resume);
- When writing the image, always backs out cleanly if problems occur;
- All settings can be saved and restored using a single file;
- Designed to play nicely with swsusp;
- Internal interfaces simplify and speed changes to methods of writing
the image, compressing and encrypting (as well as making for cleaner
code)

Another issue with the existing implementation is that support for
swsusp not great. In contrast, Suspend2 has a dedicated website
including Wiki, HowTos, FAQs and a Bugzilla as well as mailing lists and
an irc room on freenode.

So, what has changed since November, when I last submitted code for
commentary. A number of comments were received then. Some of these were
considered unreasonable and discarded, but most suggestions have been
implemented. As a result, since that time:

- dropped the modifications to the device tree;
- framebuffer patches have been merged in the meantime;
- minimised the number of #ifdefs
- removed module list from debugging info
- removed OOM killer disabling
- removed use of highmem_start_page
- removed unneeded timer freezer
- tidied up all code (kernel/power and lowlevel), getting rid of some
ugly #includes.
- user interaction has been moved to a userspace app, which communicates
with the kernel through a netlink socket;
- switched to using dynamically allocated bitmaps for storing page
states. This allowed the removal of the memory pool and a number of
flow-on simplifications;
- made LZF support a cryptoapi module, and added a more generic
cryptoapi compression module for suspend;
- checksumming code removed;
- support for building Suspend as modules has been removed, with the
result that only one EXPORT_SYMBOL is added by Suspend; one for the
refrigerator function, which should already be in mainline so that
modules with kernel threads can enter the refrigerator. Code is still
modular and interfaces abstracted so as to provide a clean separation
between the parts of the implementation.
- diffs now use -ruNp

Changes that could still be made:
- (In progress) Cleanup of userui code after removing the old in-kernel
ui components;
- Proc file read/write routines could be changed to use the seq file
layer if I could find documentation on how to use it. 

Would people like me to post the patches to LKML, or are you happy to
download from suspend2.net for yourselves?

Regards,

Nigel

