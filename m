Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267959AbTCFJtZ>; Thu, 6 Mar 2003 04:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267963AbTCFJtZ>; Thu, 6 Mar 2003 04:49:25 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:62724 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267959AbTCFJtC>; Thu, 6 Mar 2003 04:49:02 -0500
Message-ID: <3E671C64.2040600@aitel.hist.no>
Date: Thu, 06 Mar 2003 11:01:08 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Ro0tSiEgE LKML <lkml@ro0tsiege.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel Boot Speedup
References: <1046909941.1028.1.camel@gandalf.ro0tsiege.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ro0tSiEgE LKML wrote:
> What are some things I can change/disable/etc. to cut down the boot time
> of the kernel (i386) ? I would like to get one to boot in a couple
> seconds, tops. Is this possible, and how?

As a first step, compile the kernel yourself.
Include only drivers for stuff you actually have and use, drop
everything else.  That should give you a kernel that boots in a
few seconds, unless you have some really slow piece of hardware.

Of course the kernel boot time is only part of what we perceive
as "boot time", i.e. time from power-on till you can use the machine.

A normal pc boot goes like this:
1. The bios does its stuff.  No amount of kernel tweaking can help
you with this, because this happens before the kernel is loaded.
You can tweak bios options or get a better bios or motherboard though.
Many bioses are really slow - I'm lucky and have one that gets to the
kernel loading stage so fast that the flat panel screen don't
have time to keep up.  (The bios starts briefly with some graphichs 
mode, then turns to 80x25 text for compatibility reasons.  I don't
get to see that transition unless I pause it at the lilo stage)

2. The bios loads a linux loader, typically lilo.  Lilo then loads the 
kernel of choice. Lilo may be configured with a keypress timeout of 
several seconds - I have shortened that to 0.2 seconds, you may remove 
it entirely. You may also want to configure lilo with the compact 
option, it loads a little faster that way.

3. The kernel boots.  This is what you may shorten by being clever.
Leave out everything you don't need, compile into the kernel
anything needed during boot. (I.e. don't use modules unnecessarily,
they cause extra disk accesses)
You know the kernel boot has started when it print something like
"Linux hh 2.5.63-mm2" or similiar.
The kernel boot has ended when it prints

VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 320k freed

or something like that.  This is usually pretty quick.  The machine
isn't ready for use yet though.

4. Various init scripts run - depending a lot on your distribution.
This typically involves lots of disk access and may be slow.  You can
trim down the init scripts a lot if you know what you're doing - they're
general-purpose but you may have something more specific in mind.

The easy tip is to uninstall anything that have a boot script but
you don't use.  Such as unnecessary servers.  This also makes the
machine safer on a network - less stuff to break into.

You may be able to speed the boot scripts up by creating
some _huge_ initrd containing as much of the boot scripts
and related executables as possible.  This works because an initrd
is loaded by sequential disk accesses while the boot process use
time-consuming seeking.

If all you care about is to login fast, move the script that
enables login earlier in the boot process.  Similiarly, if you
use X, move xdm (or whatever starts X) earlier.
There's no reason to wait for webservers and similar to start
before running X, but thats what distributors usually do,

And if you want to get into X fast - use a lightweight
window manager!  Something like icewm, twm or similiar.
You will particularly want to throw away KDE and gnome.  (This is
is not as drastic as it sounds, because you can run your
kde/gnome apps under plain icewm just fine.)
KDE alone adds 40 seconds or so to my startup time, more
than everything else taken together.  So of course I don't use it.

Unless you have a special machine, most of your startup waiting
will be waiting for the bios, or for disk seeks.
Having 256-512M of RAM helps, because the cache _won't_ run
out during boot.  10000RPM disks helps too.  And you definitely
want more than one drive.  Having /usr and /var on separate
spindles speeds up the boot because the programs loads
from /usr and tends to use data on /var.  Having the root
with /etc on some third spindle is even better, because /etc
is where the programs reads their configuration.
This division will avoid a lot of seeking around as
all your software starts up.

Helge Hafting







