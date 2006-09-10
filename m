Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWIJTUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWIJTUE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 15:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWIJTUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 15:20:03 -0400
Received: from mout1.freenet.de ([194.97.50.132]:29146 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S932542AbWIJTUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 15:20:01 -0400
Date: Sun, 10 Sep 2006 21:27:53 +0200
To: "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH] pktcdvd: added sysfs interface + bio write queue handling fix
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Cc: linux-kernel@vger.kernel.org, "petero2@telia.com" <petero2@telia.com>
Content-Type: text/plain; charset=iso-8859-15
MIME-Version: 1.0
References: <op.tfkmp60biudtyh@master> <20060908210042.GA6877@kroah.com> <4501E33B.50204@cfl.rr.com> <20060908220129.GB20018@kroah.com> <op.tfmh56j9iudtyh@master> <20060909213054.GC19188@kroah.com>
Content-Transfer-Encoding: 7bit
Message-ID: <op.tfogcsaaiudtyh@master>
In-Reply-To: <20060909213054.GC19188@kroah.com>
User-Agent: Opera Mail/9.00 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am 09.09.2006, 23:30 Uhr, schrieb Greg KH <greg@kroah.com>:

> Use /sys/class/pktcdvd/ and use struct device instead of struct
> class_device, so I don't have to convert the code later :)

I moved the pktcdvd control files (device add/remove/map)
into /sys/class/pktcdvd/.
I only use "struct class", no need to use struct class_device,
since this /sys/class/pktcdvd represents not a real device.
The real devices are in /sys/block/pktcdvd[0-7] as created
by a "struct gendisk".

I have a little improvement request for the class code:
since the create_class() function has no attributes parameter,
i have to copy+paste the class_create() code into the module,
assign the class attribute array to the struct class and do a
class_register().
Would be nice if class_create() can be passed the class
attribute array...


The file layout is now as follows:

/sys/block/pktcdvd[0-7]/      # device dir created by gendisk
                   packet/     # pktcdvd subdir
                     <files>   # pktcdvd per device files
                     mapped_to # symlink to mapped device in /sys/block

/sys/class/pktcdvd/		# class dir for control files
                  add          # add new device mapping, creates new pktcdvd device
                  remove       # ...
                  device_map
                  packet_buffers

/debugfs/pktcdvd[0-7]/		# per device debugfs dir entry
                  info         # lot of human readable device infos, previous
                               # found in /proc/driver/pktcdvd[0-7]



Suggestions/Alteratives:
* should there be pktcdvd[0-7] subdirs in /sys/class/pktcdvd/ ?
   With content stored in /sys/block/../packet/ ? Or a symlink to it?

* the files in /sys/class/pktcdvd can be moved to /sys/module/pktcdvd/ ?!
   Seems that some modules have control files in their /sys/module directory.

-Thomas Maier
