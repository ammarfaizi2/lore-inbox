Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263914AbTJFAzX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 20:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbTJFAzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 20:55:23 -0400
Received: from CPE-203-51-31-218.nsw.bigpond.net.au ([203.51.31.218]:20975
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S263914AbTJFAzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 20:55:20 -0400
Message-ID: <3F80BD75.1BDCBBA2@eyal.emu.id.au>
Date: Mon, 06 Oct 2003 10:55:17 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.23-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa2 - some problems [with patches]
References: <20031004105731.GA1343@velociraptor.random> <3F7EE96C.4AC99553@eyal.emu.id.au> <20031005104008.GC1561@velociraptor.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Sun, Oct 05, 2003 at 01:38:20AM +1000, Eyal Lebedinsky wrote:
> > This is most unusual as -aa patches usually apply clean, but I am
> > encountering a number of build problems.
> 
> > And building i2c-2.7.0 (which I need for sensors) is failing.
> >
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.23-pre6-aa2/kernel/drivers/ie
> > ee1394/pcilynx.o
> > depmod:         i2c_bit_add_bus_Rca543f36
> > depmod:         i2c_transfer_R1dea91d1
> > depmod:         i2c_bit_del_bus_Rdf920b11
> > depmod: *** Unresolved symbols in
[trimmed]
> 
> this looks like if you didn't compile the needed i2c (or maybe it was
> due the lack of a `make dep` first), the above modules (pcilynx bttv
> msp3400) looks innocent.

OK, carefully inspecting the logs explains the above. -aa2 breaks the
build
of i2c-2.7.0, but my script already removed the original i2c modules by
then. The failure is just another static HZ initializer situation.

I think that we need an option to revert HZ to a constant for people
that do not want to fight with this change for now (I am sure there
are other drivers in the wild that will take a while to catch up
with this change even after it makes mainline).

gcc -I/usr/src/linux/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE
-fomit-frame
-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include
/usr/src/linux/include/linux/mod
versions.h -c kernel/i2c-philips-par.c -o kernel/i2c-philips-par.o
kernel/i2c-philips-par.c:163: initializer element is not constant
kernel/i2c-philips-par.c:163: (near initialization for
`bit_lp_data.timeout')
kernel/i2c-philips-par.c:172: initializer element is not constant
kernel/i2c-philips-par.c:172: (near initialization for
`bit_lp_data2.timeout')

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
