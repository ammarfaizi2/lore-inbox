Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbUFAPLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUFAPLp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 11:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUFAPLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 11:11:45 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:19984 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S262100AbUFAPKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 11:10:31 -0400
To: Sean Estabrooks <seanlkml@sympatico.ca>
Cc: szepe@pinerecords.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.x partition breakage and dual booting
References: <40BA2213.1090209@pobox.com>
	<20040530183609.GB5927@pclin040.win.tue.nl>
	<40BA2E5E.6090603@pobox.com> <20040530200300.GA4681@apps.cwi.nl>
	<s5g8yf9ljb3.fsf@patl=users.sf.net>
	<20040531180821.GC5257@louise.pinerecords.com>
	<s5gaczonzej.fsf@patl=users.sf.net>
	<20040531170347.425c2584.seanlkml@sympatico.ca>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gfz9f2vok.fsf@patl=users.sf.net>
Date: 01 Jun 2004 11:10:27 -0400
In-Reply-To: <20040531170347.425c2584.seanlkml@sympatico.ca>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Estabrooks <seanlkml@sympatico.ca> writes:

> Just don't alter partition table entries of non Linux partitions?  

I have not been very clear, so let me try once more.

Yes, using the existing partition table geometry will work if you
install Windows before you install Linux.  But it will fail if you do
things the other way around.

I am suggesting an approach which will work either way; namely,
determine the Windows-compatible geometry and use it.

The Windows-compatible geometry is the one reported by the "legacy
INT13 BIOS interface"; i.e., INT13/AH=08h.

Because this legacy BIOS interface can only be invoked from real mode,
Linux 2.2.x and 2.4.x tried to infer the legacy geometry by parsing
CMOS tables.  This did not always work, both because the tables are
poorly specified and buggy and vendor-specific, and because it
requires mapping between BIOS disk numbers and Linux devices, which is
tricky.  So the old code was gutted for 2.6.x, and now the kernel
simply reports the geometry as reported by the disk controller.
(Linux itself does not care about the geometry, because it does
everything in "linear" mode.)

This means partitions created under Linux are incompatible with
Windows, unless you get lucky and your BIOS uses (or can be configured
to use) the geometry reported by the controller.

Now, starting with 2.6.5 Linux actually invokes INT13/AH=08h during
real-mode startup and stashes the values away.  They are available via
Dell's EDD module.  So, to find the Windows-compatible geometry, you
simply:

  modprobe edd
  cat /sys/firmware/edd/int13_dev80/{legacy_heads,legacy_sectors}

(And add 1 to the "heads" value because the legacy BIOS interface is
freaky.)

There is just one catch.  This assumes BIOS device 80h (the boot
device) is the disk you care about.  If not, you need to figure out
which BIOS device corresponds to the disk you do care about.  This is
the hard part, but it is not THAT hard, because the /sys/firmware/edd
interface exposes lots of information which will help you deduce this
correspondence.  It exports the extended (controller) geometry, the
disk size, and the MBR signature (see
http://seclists.org/lists/linux-kernel/2004/Jan/5257.html).  For a
sufficiently modern (EDD 3.0) BIOS, it will even include the exact
information (PCI device etc.) identifying the disk.

This is not surprising, because the EDD module was specifically
designed with this mapping goal in mind; one of Dell's interests is
automatically finding the boot disk on systems with lots of drives.

So, if we write a decent library routine to map between BIOS device
numbers and Linux devices, then we will be finished, and everything
will work fine no matter which OS the user installs first.

 - Pat
