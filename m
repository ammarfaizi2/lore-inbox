Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbUC2Etx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 23:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbUC2Etx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 23:49:53 -0500
Received: from fmr02.intel.com ([192.55.52.25]:39810 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262618AbUC2Etu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 23:49:50 -0500
Subject: Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
From: Len Brown <len.brown@intel.com>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1080535754.16221.188.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Mar 2004 23:49:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-28 at 10:24, Arkadiusz Miskiewicz wrote:

> ACPI uses cmpxchg so it's not possible to build it for i386 it seems.
>
> +__acpi_release_global_lock (unsigned int *lock)
> +{
> +       unsigned int old, new, val;
> +       do {
> +               old = *lock;
> +               new = old & ~0x3;
> +               val = cmpxchg(lock, old, new);
> +       } while (unlikely (val != old));
> +       return old & 0x1;
> +}
> 

> -o vmlinux
> drivers/acpi/acpi.o(.text+0x4cf4): In function
> `acpi_ev_global_lock_handler':
> : undefined reference to `cmpxchg'
> drivers/acpi/acpi.o(.text+0x4dc6): In function
> `acpi_ev_acquire_global_lock':
> : undefined reference to `cmpxchg'
> drivers/acpi/acpi.o(.text+0x4e4b): In function
> `acpi_ev_release_global_lock':
> : undefined reference to `cmpxchg'

ACPI unconditionally used cmpxchg before this change also -- from asm().
The asm() was broken, so we replaced it with C,
which invokes the cmpxchg macro, which isn't defined for
an 80386 build.

I guess it is a build bug that the assembler allowed us
to invoke cmpxchg in an asm() for an 80386 build in earlier releases.

I'm open to suggestions on the right way to fix this.

1. recommend CONFIG_ACPI=n for 80386 build.

2. force CONFIG_ACPI=n for 80386 build.

3. invoke cmpxchg from acpi even for 80386 build.

4. re-implement locks for the 80386 case.

I guess it depends on why one would build
for 808386 and CONFIG_ACPI=y.  Certainly
there is no risk of 80386 hardware actually
running the CMPXCHG in the ACPI code --
80386 was EOL'd long before ACPI came out
and 2.4.25 (and earlier) would have died on us.

I don't like #1 b/c I don't want to get more
e-mail like this;-)

#2 wouldn't bother me.  But if somebody is
building for i386 for the purpose for de-tuning
the compiler and they really do want ACPI support,
it would bother them.

#3 would be the old behaviour, which also
wouldn't bother me.  I guess we'd duplicate the
macro inside the ACPI code so that others didn't
use it by mistake.

#4 would be an academic exercise, since the code
would never actually execute on an 80386.

suggestions?

thanks,
-Len


