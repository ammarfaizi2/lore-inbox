Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbTELN0w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 09:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbTELN0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 09:26:52 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:4878 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S262138AbTELN0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 09:26:49 -0400
Date: Mon, 12 May 2003 15:39:11 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-kernel@vger.kernel.org
Subject: [PATCH] new kconfig goodies
Message-ID: <Pine.LNX.4.44.0305111838300.14274-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is a new kconfig patch at 
http://www.xs4all.nl/~zippel/lc/patches/kconfig-2.5.69.diff.gz
It adds a few new features, which were requested a few times:
- ability to force the value of a config symbol
- defaults accept now an expression
- easier way to define derived symbols
- support for ranges

BTW this clears my todo list of important features for the kconfig syntax 
itself, if you think there is something missing, please tell me now, 
otherwise it might have to wait for 2.7. After this I work a bit more on 
xconfig and the library interface.

The changes in detail:

1. Working with derived symbols becomes simpler, e.g. this:

config FS_MBCACHE
	tristate
	depends on EXT2_FS_XATTR || EXT3_FS_XATTR
	default y if EXT2_FS=y || EXT3_FS=y
	default m if EXT2_FS=m || EXT3_FS=m

can now also be written as:

config FS_MBCACHE     
	def_tristate EXT2_FS || EXT3_FS
	depends on EXT2_FS_XATTR || EXT3_FS_XATTR

There are two new keywords "def_bool" and "def_tristate", which behave 
like "default", except that they also set the type of the config symbol.
Defaults also accept expressions now, the result of it will be used as 
default (this works of course only with boolean and tristate symbols).

2. There is a new keyword "enable", which can be used to force the value 
of another config value, e.g.

config NLS
	bool
	depends on JOLIET || FAT_FS || NTFS_FS || NCPFS_NLS || SMB_NLS || JFS_FS || CIFS || BEFS_FS
	default y

this could be written as:

config NLS
	def_bool JOLIET || FAT_FS || NTFS_FS || NCPFS_NLS || SMB_NLS || JFS_FS || CIFS || BEFS_FS

but this is now possible as well:

config NLS
	bool

config JOLIET
	bool "Microsoft Joliet CDROM extensions"
	enable NLS

config FAT_FS
	tristate "DOS FAT fs support"
	enable NLS

...

This means the information that a file system needs NLS is now specified 
with the file system itself and if the file system is selected, so is NLS.

Another example:

config AGP
	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU
	default y if GART_IOMMU

this can be changed into:

config AGP
	tristate "/dev/agpgart (AGP Support)"

config GART_IOMMU
	bool "IOMMU support"
	enable AGP

This will cause AGP to be selected if GART_IOMMU is selected.

To better understand how this new feature works, it might help to describe 
how a config value is calculated:

	config value = (user input && visibility) || reverse dependency

Visibility are the normal dependencies and limit the maximum value a user 
can select. Reverse dependencies on the other hand limit the minimum value 
a user can select. In above example this means there is a reverse 
dependency of GART_IOMMU added to AGP, so that value of AGP cannot be less 
than GART_IOMMU anymore.
This feature can be easily abused, so please use it with care, don't use 
it to take the choice away from user, e.g. only enable another subsystem 
if it would result in compile errors otherwise. If you're not sure, just 
ask. To avoid bigger mistakes I finally added the code to check for 
recursive dependencies.

3. Finally I added support for ranges, so that this becomes possible:

config LOG_BUF_SHIFT
	int "Kernel log buffer size" if DEBUG_KERNEL
	range 10 20
	...

Right now this is only used to check the direct user input, this means 
directly editing .config will ignore the range (please don't rely on this
feature :) ).

bye, Roman

