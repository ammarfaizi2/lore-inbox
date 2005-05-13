Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVEMKvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVEMKvo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 06:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVEMKvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 06:51:44 -0400
Received: from animx.eu.org ([216.98.75.249]:18580 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262334AbVEMKvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 06:51:36 -0400
Date: Fri, 13 May 2005 06:50:00 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>,
       linux@dominikbrodowski.net
Subject: Re: [PATCH] pcmcia/ds: handle any error code
Message-ID: <20050513105000.GA2589@animx.eu.org>
Mail-Followup-To: randy_dunlap <rdunlap@xenotime.net>,
	linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>,
	linux@dominikbrodowski.net
References: <20050512015220.GA31634@animx.eu.org> <20050512230206.GA1380@animx.eu.org> <20050512222038.325081b2.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512222038.325081b2.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

randy_dunlap wrote:
> | Wakko Warner wrote:
> | > 3) I put together a boot kernel/initrd using 2.6.12-rc2 (also tested
> | > 2.6.12-rc4) which seems to work, except that pcmcia does not function
> | > properly.  When pcmcia.ko gets loaded, it is unable to register it's char
> | > dev.  I'm not sure why this is.  2.6.11.8 worked fine with no modifications
> | 
> | I tested this again today with a few changes.  It appears that if pcmcia.ko
> | (or rather the .c files that make it up) are compiled with -Os, it will fail
> | to register a character device.  Being that one of my goals for this was to
> | fit everything on a floppy, I had to use -Os when building the kernel. 
> | (pcmcia was not one of the modules that belongs on the floppy, however I
> | did not want to have to compile the kernel and then again for the modules
> | w/o -Os)
> | 
> | I believe that pcmcia.ko is the only module I am using that  uses a dynamic
> | major.
> 
> There is some small difference in locking in fs/char_dev.c between
> 2.6.12-rc4 and 2.6.11.8, but I don't yet see why it would cause a
> failure in register_chrdev().
> 
> Oh, there's a big difference in drivers/pcmcia/ds.c, lots of probe
> changes.  This is where to look further (but not tonight).
> The question then becomes is this a real regression?
> 
> Do you suspect a problem with -Os code generation?

Definately.  Here's what I did.  The laptop I was testing has 2.6.12-rc2
installed (it's a multi boot).  This kernel was compiled specifically for
the laptop since it's one that I use for work.  The kernel I compiled with
-Os is a generic and this laptop was the only one I had to test this with. 
So basically, you could say this laptop currently has 2 linux installations
on it.  The generic one I'm trying to get partially on a floppy and it's
normal one.

I was first booting from floppy to test.  The kernel on the floppy is
compield with -Os and the kernel itself is compressed with upx-ucl-beta to
make it smaller.  Then it has a gzipped initrd with busybox and some
modules.  I call this stage1.  stage2 which has the pcmcia module comes from
either a cdrom or a usb stick (I have stage 1 on the laptop hdd, but stage 2
still comes from usb).  Figuring there might have been a problem with upx, I
decided to through the stage1 on my laptop's hdd (since it can't boot from
usb).  This time, I recompiled the kernel (make clean, remove optimize for
size, make bzImage modules, install modules to the usb stick and select ones
for the initrd).  Once I did this, pcmcia worked.  The configuration was the
same, all that changed was not using -Os.

> Looks to me like ds.c needs at least this small fix...

I'll forward this diff to myself at work and test it.  Thanks.  I'll let you
know what happens.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
