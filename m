Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135548AbRAVXqh>; Mon, 22 Jan 2001 18:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135719AbRAVXq3>; Mon, 22 Jan 2001 18:46:29 -0500
Received: from 64-32-134-244.phx1.phoenixdsl.net ([64.32.134.244]:36620 "EHLO
	virtualwire.org") by vger.kernel.org with ESMTP id <S135548AbRAVXqT>;
	Mon, 22 Jan 2001 18:46:19 -0500
Date: Mon, 22 Jan 2001 16:46:24 -0700
From: Duncan Laurie <duncan@virtualwire.org>
To: "Randy.Dunlap" <randy.dunlap@intel.com>
Cc: Petr Matula <pem@informatics.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: int. assignment on SMP + ServerWorks chipset
Message-ID: <20010122164624.A16437@virtualwire.org>
In-Reply-To: <20010121215423.A20953@virtualwire.org> <3A6CAE8E.CFECDF23@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A6CAE8E.CFECDF23@intel.com>; from "randy.dunlap@intel.com" on Mon, Jan 22, 2001 at 02:05:02PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2001, Randy.Dunlap wrote:
| 
| (BTW, it's an STL2 board, not SBT2.  And it's Randy, not Mr. Dunlap. :)
| 

Hi Randy,
(I'll spare you the formality ;)

Oops, I knew it was an STL2, but somehow couldn't get it right in the
message..  It looks like they both use ServerWorks LE chipsets, do you
know if the SBT2 has the same problem?

I did see that your BIOS is build 16 (STL20.86B.0016.P01.0010111108)
while Petr has build 17 (STL20.86B.0017.P01.0011291152) which also
appears to be the latest release.  Not that it has any affect on this
particular problem, but it might explain why the patch worked for you
and not him.

I looked at the Technical Product Specification,
(ftp://download.intel.com/support/motherboards/server/stl2/stl2_tps.pdf)
and it appears that they have released BIOS updates to fix Errata 
regarding Linux boot problems, so chances are good that it may be fixed
by a future update.  Until then, the 'mpint' parameter patch seems
pretty harmless, yet flexible enough to handle subtle differences
in hardware and configuration.

However, there are also hooks for a 16KB region of user-supplied BIOS
code that could possibly be used to fixup the mptable.  The info and
instructions are in section 4.5.2.1 of the tech spec for anyone with
hardware brave enough to give it a shot...  (this looks like a pretty
cool feature, hopefully other MB vendors will take the hint)

|
| Here's my output from dump_pirq.  Is the PCI router info unique
| enough so that you'll need to debug it instead of me doing so?
| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| [root@localhost src]# ./dump_pirq
|  
| Interrupt routing table found at address 0xfdf10
|   Version 1.0, 0 bytes
|   Interrupt router is device ff:1f.7
|   PCI exclusive interrupt mask: 0x0000 []
|  
| Interrupt router at ff:1f.7:
| Could not read router info from /proc/bus/pci/ff/1f.7.
| [root@localhost src]#
| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|

Hrm, this certainly doesn't look right.  You mentioned in a previous
message that changing the OS type from PnP-aware did not have any
effect, but if disabled the BIOS might not be creating the PIRQ
tables.  Hopefully it will still take care of the IRQ routing, which
means you should be able to read the value directly.  (it better or
USB shouldn't work in UP!)  Try the following program:

-----------------------------------------------
/* compile with gcc -O */
#include <stdio.h>
#include <stdlib.h>
#include <sys/io.h>

int main(void) {
    if (iopl(3) < 0) exit(1);
    outb(1, 0xc00);
    printf("USB Interrupt: %d\n", inb(0xc01));
    exit(0);
}
-----------------------------------------------

Good luck,
  -duncan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
