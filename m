Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTDTNTw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 09:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTDTNTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 09:19:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5604 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263573AbTDTNTn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 09:19:43 -0400
Date: Sun, 20 Apr 2003 14:31:43 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: linux-kernel@vger.kernel.org
Cc: linus@transmeta.com
Subject: [CFT] more kdev_t-ectomy
Message-ID: <20030420133143.GF10374@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Patchset is on ftp.linux.org.uk/pub/people/viro/T*
So far it kills kdev_t crap in tty and console layers; more to follow.
The goal is to kill kdev_t completely and switch the character device
side of things to real objects.  Fortunately it's nowhere near the
nastiness of corresponding block device work.

	Please, test.  Patches are against 2.5.68 and It Works Here(tm).
If there will be no screams, it goes to Linus.

	Summary of patches follows:

1)	tty.driver turned into a pointer
	* we never modify any fields of tty.driver
	* we initialize it with a copy of registered struct tty_driver
	* we never use any fields that might be modified in original
	* we pin the original down until we free tty
ergo, we can store a reference instead of copying the damn thing.  Aside
of shrinking tty_struct, it allows for much saner refcounting and a bunch
of cleanups later.

2)	/proc/tty/drivers converted to seq_file

3)	removed fake drivers
	instead of registering "drivers" for /dev/tty, /dev/vc/0, /dev/ptmx
and /dev/console (they are never looked up since tty_open() special-cases
them and they should not be looked up - these devices are remapped on open)
we register corresponding chrdev ranges and devfs nodes directly.
	/proc/tty/drivers code updated to keep the contents unchanged

4)	tty->tty_name added
	new field; initialized to <driver->name><tty index+driver->base_name>
when we allocate tty_struct.  Drivers code switched to use of that beast (in
debugging printks, mostly).

5)	tty->tty_index added
	tty->tty_index added; we initialize it with minor(tty->device) -
tty->driver->minor_start.  Majority of remaining tty->device uses had
that form and are switched to use of tty->index.

6)	driver->driver_name cleanup
	sanitized driver->driver_name initialization and use

7)	misc tty cleanups
	* generic_serial.c typo fix (->driver used instead of correct
->driver_data)
	* tubio cleaned up

8)	rio cleanups and fixes
	* drivers/char/rio/* supports up to 4 boards, each with up to 128
lines.  It used to share termios for 1st/3rd and 2nd/4th boards,  Fixed.
	* cleanups and kdev_t removals - we pass tty instead of tty->device
in a couple of helper functions and instead of comparisons on major(tty->device)
we check where does tty->driver point to.

9)	tty_io.c::init_dev() change
	Preparations to cleanup:
	* call of get_tty_driver() moved from init_dev() to its callers
	* instead of kdev_t dev we pass struct tty_struct *driver and int index

10)	tty->device switched to dev_t
	There are very few uses of tty->device left by now; most of
them actually want dev_t (process accounting, proc/<pid>/stat, several
ioctls, slip.c logics, etc.) and the rest will go away shortly.

11)	Big ranges for tty_driver
	* we allow tty_driver to cover more than 256 devices
	* pty.c cleaned up - now we only one driver for UNIX98 masters and
only one driver for UNIX98 slaves, so a lot of ugliness can be killed.
	* get_tty_driver() became an analog of get_gendisk() - it does
a lookup by device number and gives (pointer to tty_driver,index).
	* registration/unregistration of tty_driver updated
	* /proc/tty/drivers code updated (now one structure can be responsible
for several lines)

The next two patches deal with interaction between tty and console.

12)	uart_console_device() helper
	console drivers that come from drivers/serial switched to common
->device() method.

13)	console->device() change
	instead of returning kdev_t console->device() returns tty_driver and
index.  Caller updated.

14)	fbdev->node kdev_t removal
	All places that use fbdev->node are interested only in one thing -
number of framebuffer (i.e. minor(fbdev->node)).  The place setting that
beast finds an unused number and sets ->node to mk_kdev(FB_MAJOR, number).
Obvious cleanup: stop messing with kdev_t and just store what we really
want to store - an integer.

15)	ppc boot partition cleanup
	gratitious uses of kdev_t when we are actually dealing with
device numbers (as visible by userland) removed.
