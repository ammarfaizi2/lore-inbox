Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUCUW7t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUCUW7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:59:49 -0500
Received: from smtpq3.home.nl ([213.51.128.198]:62417 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S261439AbUCUW7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:59:45 -0500
Message-ID: <405E1E32.7020808@keyaccess.nl>
Date: Sun, 21 Mar 2004 23:58:58 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Osamu Tomita <tomita@cinet.co.jp>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] 2.6.5-rc2{,-mm1} i386 probe_roms() damage
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

sending this to you because, well, I guess it's sort of mm-ish. Patch is
against 2.6.5-rc2-mm1, but applies (with two offsets) to 2.6.5-rc2 as
well. Please advice if you want me to pester someone else instead.

The i386 probe_roms() function has a fair number of problems currently:

- When you actually have an adapter ROM in the machine, your video ROM
   disappears. This is due to the pc9800 subarch merge that split it up
   in probe_video_rom(int roms) and probe_extension_roms(int roms), but
   expects a "roms++" in probe_video_roms() to have an effect outside of
   that function.

- The majority of VGA adapters these days host a ROM larger then 32K,
   yet the current code hardcodes a 32K ROM. The VGA BIOS "length" byte
   is normally valid (it in fact needs to be for a regular mainboard BIOS
   to accept it) and I've verified on a few dozen very new to very old
   VGAs that it is. However, assuming someone actually did not check for
   the length and checksum there for a reason, the safe thing to do here
   is accept the length byte when we also get a valid checksum.

- The current code scans 0xc0000 to 0xdffff for a video ROM while the
   standard PC thing to do (that which the BIOS does) is only scan for a
   video ROM starting between 0xc0000 and 0xc7fff. This means that on a
   headless- (or BIOS-less monochrome adapter-) box, the first adapter
   ROM found triggers the registration of a 32K "Video ROM" at hardcoded
   address 0xc0000, even when _nothing_ is present between 0xc0000 and
   0xc7fff.

- The current adapter ROM scan stops at 0xdffff, whether or not an
   extension ROM is present at 0xe0000. The PC thing to do is scan
   0xc8000 upto 0xdffff if an extension ROM is present, and upto 0xeffff
   when it's not (it's not/hardly ever).

- Adapter ROMs are called "Extension ROM", but the latter term is really
   better reserved for a motherboard extension ROM.

- Currently, the code happily starts scanning through a ROM it just
   registered looking for the next one (just does += 2048, even when
   that's inside the previous ROM) which is at least silly.

Unfortunately, this code is "subarched" between mach-default and
mach-pc9800, meaning the patch got a bit involved. Currently all this
code, and gobs of data, is defined (not just declared) in the header:

   include/asm-i386/mach-{default,pc9800}/mach_resources.h

which isn't nice. That .h really wants to be a .c. The first patch, in
the next message, does not change any code but only undoes the
probe_video_rom / probe_extension_roms split and moves the code to a new
file

   arch/i386/mach-{default,pc9800}/std_resources.c

with a header

   include/asm-i386/std_resources.h

for the prototypes only. The second patch overhauls the code itself for
mach-default. Please see comments on top of that patch for (yet more)
comments. It's tested on various machines, with and without adapter ROMs.

I haven't touched pc9800. Nothing should have changed though. The pc9800
author, as given in the code, is CCed.

Also, x86-64 inherits the probe_roms() code from 2.4, and while it
doesn't have the subarch specific problems, it has all others. I'll
convert it to if this i386 version is deemed desirable.

Rene.


