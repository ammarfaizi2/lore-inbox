Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUJOWjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUJOWjt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 18:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUJOWjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 18:39:48 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:27105 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S266263AbUJOWjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 18:39:45 -0400
Subject: Re: [ACPI] Re: [PATCH/RFC] exposing ACPI objects in sysfs
From: Alex Williamson <alex.williamson@hp.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@suse.de>, acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040921210218.GJ30425@elf.ucw.cz>
References: <1095716476.5360.61.camel@tdi>
	 <20040921122428.GB2383@elf.ucw.cz> <1095785315.6307.6.camel@tdi>
	 <20040921172625.GA30425@elf.ucw.cz> <20040921190606.GE18938@wotan.suse.de>
	 <1095794035.24751.54.camel@tdi> <20040921191826.GF18938@wotan.suse.de>
	 <1095795954.24751.74.camel@tdi> <20040921195802.GF30425@elf.ucw.cz>
	 <1095799248.24751.103.camel@tdi>  <20040921210218.GJ30425@elf.ucw.cz>
Content-Type: text/plain
Organization: LOSL
Date: Fri, 15 Oct 2004 16:39:58 -0600
Message-Id: <1097879998.5971.69.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Back for another round of discussions...  We last left this at:

      * The acpi_sysfs evaluate on read interface has problems (imagine
        tar'ing up /sys/firmware/acpi...)
      * No support for 32 bit apps on 64 bit kernels.

  I played around with an evaluate on write approach, but couldn't come
up with anything I liked.  I decided to go back to the ioctl dev_acpi
approach I proposed a few months ago.  It's unfortunate that dev_acpi
doesn't take advantage of the sysfs namespace, but overall I think its
more functional.  For instance, the sysfs interface didn't allow
operations on ACPI devices because they show up as directories in sysfs.
This isn't an issue with dev_acpi.  I should have written up some new
documentation on dev_acpi, but the theory of operation hasn't changed
that much since my original post here:

http://groups.google.com/groups?selm=2paXA-7Li-7%40gated-at.bofh.it

Essentially, it boils down to write(2) parameters (if necessary),
ioctl(2) with a command and a structure containing ACPI path and return
buffer size, read(2) data returned (if any).  I don't think I can
transfer all the data in the ioctl, the data structures are just too
complex.  The ioctl now clearly defines the point at which we're
operating on ACPI namespace.

   I finally got hit by the clue bat of what Andi was trying to describe
with the compatibility layer and found the ioctl32_conversion interface.
I've made use of these to allow a 32bit application to read and write
32bit data structures into the device file.  Prior to calling into ACPI,
the ioctl32 interface converts the write data to native structures.  On
the other side, native structures are converted to their 32bit
equivalent and stored in the read buffer.  I've successfully run a 32bit
x86 binary of my test program on an ia64 system using this interface.

   I've been building dev_acpi as a standalone module, so the makefiles
and test program are a little large for the mailing list.  The current
revision is available here:

http://free.linux.hp.com/~awilliam/acpi/dev_acpi/dev_acpi-20041015.tar.bz2

(Sorry, the makefile is rather kludgey, but should be easy to get
working given a path to kernel source)  I haven't tested much of the
32->64 bit compatibility path, but the 64->32 side seems to work fine.
The provided test program (acpitree) provides a tree listing of ACPI
namespace with the object type listed next to the name.  Values of
strings and integers will be printed along with raw dumps of select
other "safe" objects.  Standard disclaimers apply, this is all
development code.  The driver could stand a good round or two of code
cleanup and far more testing, but I wanted to get some feedback on this
approach before spending too much time on it.  Please take a look and
let me know what you think.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

