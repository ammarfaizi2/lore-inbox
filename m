Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWCWOtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWCWOtl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 09:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWCWOtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 09:49:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2321 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932428AbWCWOtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 09:49:40 -0500
Date: Thu, 23 Mar 2006 14:49:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: Re: 2.6.16-mm1
Message-ID: <20060323144922.GA25849@flint.arm.linux.org.uk>
Mail-Followup-To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20060323014046.2ca1d9df.akpm@osdl.org> <6bffcb0e0603230631r5e6cc3d3p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0603230631r5e6cc3d3p@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 03:31:45PM +0100, Michal Piotrowski wrote:
> Hi,
> 
> On 23/03/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/
> >
> 
> Something went wrong with serial code.
> 
> make
> [..]
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function
> `serial_pnp_probe':/usr/src/linux-mm/drivers/serial/8250_pnp.c:435:
> undefined reference to `serial8250_register_port'
> drivers/built-in.o: In function
> `serial_pnp_remove':/usr/src/linux-mm/drivers/serial/8250_pnp.c:447:
> undefined reference to `serial8250_unregister_port'
> drivers/built-in.o: In function
> `pciserial_suspend_ports':/usr/src/linux-mm/drivers/serial/8250_pci.c:1690:
> undefined reference to `serial8250_suspend_port'
> drivers/built-in.o: In function
> `pciserial_resume_ports':/usr/src/linux-mm/drivers/serial/8250_pci.c:1706:
> undefined reference to `serial8250_resume_port'
> drivers/built-in.o: In function
> `pciserial_remove_ports':/usr/src/linux-mm/drivers/serial/8250_pci.c:1665:
> undefined reference to `serial8250_unregister_port'
> drivers/built-in.o: In function
> `pciserial_init_ports':/usr/src/linux-mm/drivers/serial/8250_pci.c:1640:
> undefined reference to `serial8250_register_port'
> make[1]: *** [.tmp_vmlinux1] B??d 1
> make: *** [_all] B??d 2
> 
> Here is config http://www.stardust.webpages.pl/files/mm/2.6.16-mm1/mm-config

CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_PNP=y

That's an illegal configuration.

+config SERIAL_8250_PCI
+       tristate "8250/16550 PCI device support" if EMBEDDED
+       depends on SERIAL_8250 && PCI
+       default y

if SERIAL_8250 is 'm' there's no way that SERIAL_8250_PCI should be 'y'.
Maybe it's a bug in kconfig - seems like it.  Let's try some experiments:

config SYM_Y
        bool
        default y

config SYM_M
        tristate
        default m

config SYM_D
        tristate 'SYM_D'
        depends on SYM_M && SYM_Y

With this I'm offered:

SYM_D (SYM_D) [N/m] (NEW)

so Kconfig thinks the only legal values for SYM_D are 'n' and 'm', and
the default is 'n'.

If I add a default line to SYM_D thusly:

config SYM_D
        tristate 'SYM_D'
        depends on SYM_M && SYM_Y
        default y

I'm now offered:

SYM_D (SYM_D) [M/n] (NEW)

Okay, so the default is now 'm', but the legal values are still only 'n'
and 'm'.  I can only select 'm' or 'n', and this is what I end up with in
the config file.  Now, if I remove the prompt text:

config SYM_D
        tristate
        depends on SYM_M && SYM_Y
        default y

and hey presto, suddenly 'y' becomes a legal value.

CONFIG_SYM_Y=y
CONFIG_SYM_M=m
CONFIG_SYM_D=y

So it would seem to be a Kconfig bug.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
