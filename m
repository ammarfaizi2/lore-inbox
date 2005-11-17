Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVKQNK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVKQNK0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVKQNK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:10:26 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:29895
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750795AbVKQNK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:10:26 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Quick and dirty miniconfig howto, with feature suggestions.
Date: Thu, 17 Nov 2005 06:29:41 -0600
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511170629.42389.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- What is a miniconfig?

A new feature of 2.6.15 lets you use miniature configuration files, listing 
just the symbols you want to enable and letting the configurator enable any 
dependencies to give you a valid configuration.

To make it work, create a mini.config file and run allnoconfig (to create 
a .config file with all unspecified symbols switched off) with the extra 
argument "KCONFIG_ALLCONFIG=mini.config".

--- Advantages of miniconfigs

Miniconfigs have several advantages over conventional configuration files:

 * They're portable between versions.  A miniconfig from linux 2.6.15 will
   probably build an equivalent 2.6.16 kernel.

 * It's easy to see exactly what features have been specified.

 * Miniconfigs are flexible and human editable, while generated .config files
   are brittle and easy to break if you try to edit them.  (And if you
   redirect the output > /dev/null so you just see stderr, it'll show you
   any unrecognized symbols it couldn't set due to typos.)

--- Real-world example.

Here's the mini.config I use to build User Mode Linux:

CONFIG_MODE_SKAS=y
CONFIG_BINFMT_ELF=y
CONFIG_HOSTFS=y
CONFIG_SYSCTL=y
CONFIG_STDERR_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_UBD=y
CONFIG_TMPFS=y
CONFIG_SWAP=y
CONFIG_LBD=y
CONFIG_EXT2_FS=y
CONFIG_PROC_FS=y

And here's how I build and test it (as a normal user, not as root):

# Configure, building in an external directory and using a mini.config file in
# my home directory.

make KCONFIG_ALLCONFIG=~/mini.config ARCH=um O=../linux-umlbuild allnoconfig

# change to build directory and build User Mode Linux

cd ../linux-umlbuild
make ARCH=um

# Test run

./linux rootfstype=hostfs rw init=/bin/sh
$ whoami
$ mount -t proc /proc /proc
$ cat /proc/cpuinfo
$ exit

--- Suggestions.

1) Add a "make miniconfig" which works like allnoconfig but A) takes 
mini.config as its' default name, B) redirects stdout to /dev/null to make it 
easier to spot typoed symbols, C) aborts (exits with an error, does not write 
new .config) if mini.config isn't found or if it contains an unrecognized 
symbol.

2) Fix the interaction with O= so that it looks for the mini.config file in 
the O= directory and not the source directory, so people don't _have_ to 
specify KCONFIG_ALLCONFIG when building out of tree.
