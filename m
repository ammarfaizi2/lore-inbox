Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbUDDVxs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 17:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbUDDVxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 17:53:48 -0400
Received: from smtp.wp.pl ([212.77.101.160]:57136 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S262859AbUDDVxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 17:53:40 -0400
Date: Sun, 4 Apr 2004 23:54:11 +0200
From: Marek Szuba <scriptkiddie@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.6.5] A bunch of various minor bugs not fixed since 2.6.4
Message-Id: <20040404235411.7ffde014.scriptkiddie@wp.pl>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A. [wersja 2.0c]
X-WP-AntySpam-Rezultat: NIE-SPAM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

Having got the hot and fresh patch, I played around with the new kernel
to see what got fixed and what didn't. All in all, great work as always
- but there are some minor annoyances which remain still. As last time,
I'm posting my observations here in case the issues haven't been spotted
yet.

1. 'make *config' fails with missing header files
On my system I have got no symlinks from /usr/src/linux/include to
/usr/include, as it has turned out their number would have to increase
after switching to 2.6 - before only asm and linux symlinks were
required for me, now there were more (eg. asm-generic and some others I
don't remember) and as a result I began seeing lots of compilation
failures. Eventually I've decided to always access current kernel's
header files by adding
CPATH="/lib/modules/`uname -r`/build/include"; export CPATH
to my profile (by the way, maybe this procedure should be described
somewhere in the README - in the old days one was told to create the
asm, linux and scsi symlinks, now there is nothing). That solved
everything... except one thing: trying to configure the kernel after
patching it and changing the version number in the directory name. The
effect can be seen below:

# pwd
/usr/src/linux
# readlink /usr/src/linux
linux-2.6.5
# make oldconfig
  HOSTCC  scripts/basic/fixdep
In file included from /usr/include/bits/posix1_lim.h:126,
                 from /usr/include/limits.h:144,
                 from
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.2/include/limits.h:122,
                 from
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.2/include/syslimits.h:7,
                 from
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.2/include/limits.h:11,
                 from scripts/basic/fixdep.c:105:
/usr/include/bits/local_lim.h:36:26: linux/limits.h: No such file or
directory
In file included from /usr/include/netinet/in.h:212,
                 from scripts/basic/fixdep.c:107:
/usr/include/bits/socket.h:305:24: asm/socket.h: No such file or
directory
scripts/basic/fixdep.c: In function `use_config':
scripts/basic/fixdep.c:193: error: `PATH_MAX' undeclared (first use in
this function)
scripts/basic/fixdep.c:193: error: (Each undeclared identifier is
reported only once
scripts/basic/fixdep.c:193: error: for each function it appears in.)
scripts/basic/fixdep.c:193: warning: unused variable `s'
scripts/basic/fixdep.c: In function `parse_dep_file':
scripts/basic/fixdep.c:289: error: `PATH_MAX' undeclared (first use in
this function)
scripts/basic/fixdep.c:289: warning: unused variable `s'
make[1]: *** [scripts/basic/fixdep] Error 1
make: *** [scripts_basic] Error 2
#

While I know putting the version number in the kernel directory name is
frowned upon by Linus, I am not the only person doing it this way.
Besides, a solution for this particular problem seems to be trivial -
adding '-I/path/to/kernel/include' to the primary Makefile will take
care of the problem easily.


2. Platform-specific 'asm' symlink doesn't get created by 'make *config'
I have got no idea how this could have slipped everyone's attention, but
here it is:

# make menuconfig
  HOSTCC  scripts/basic/fixdep
In file included from /usr/include/netinet/in.h:212,
                 from scripts/basic/fixdep.c:107:
/usr/include/bits/socket.h:305:24: asm/socket.h: No such file or
directory
make[1]: *** [scripts/basic/fixdep] Error 1
make: *** [scripts_basic] Error 2

The same happens with oldconfig and config. I have to go to include and
execute 'ln -s asm-i386 asm' by hand to be able to continue.

3. 'make clean' seems to remove too much
It seems some people cannot be satisfied... Before I complained about
leftover junk, now I'm complaining about too few leftovers! Anyway, what
goes away with 'clean' which I believe should only go away with
'mrproper':
 - the include/asm symlink
 - include/linux/autoconf.h
Maybe there are more, but these are the two I have already found to
cause software compilation errors when not present.

4. Floppy LED remains on whenever LILO boots the kernel quickly
I have only got half a second delay between "LILO" and "Loading Linux",
where "Linux" is the name of my primary kernel. My floppy driver is a
module and isn't loaded by any of the startup scripts. Now, if I delay
the boot (e.g. by typing in command-line parameters for LILO or the
kernel) till after the floppy drive's LED has gone off (after the boot
disk search - my boot sequence is A:,C:) everything works fine - but if
I let the 2.6 kernel boot immediately, the LED remains on indefinitely
(i.e. until the floppy module gets loaded or I reboot the system). Under
2.4 with floppy support built as a module as well, the light is allowed
to go off no matter how quickly I boot the kernel).

5. "Default NLS charset" option is ignored for Joliet filesystems
All my consoles are ISO-8859-2, so the NLS part of my .config looks like
this (all the "not set" lines omitted for brevity):
#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-2"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_ISO8859_2=m

The above works fine for vfat. However, whenever I try to mount an
iso9660+Joliet filesystem without specifying the charset explicitly, I
get "Unable to load NLS charset iso8859-1" in kernel logs.
Please note this is NOT a 2.6-specific bug: I have no idea how long this
bug has been here, but at least the 2.4.25 kernel exhibits the same
behaviour.

6. (not really a bug) It would be nice if the ieee1394 subsystem got
sysfs'ed soon...

As always, please let me know if you need any further detail about what
I have noticed or about my configuration.

Keep on trucking, guys!
-- 
MS
