Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274018AbRJGNvX>; Sun, 7 Oct 2001 09:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276361AbRJGNvO>; Sun, 7 Oct 2001 09:51:14 -0400
Received: from hermes.toad.net ([162.33.130.251]:58025 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S274018AbRJGNu6>;
	Sun, 7 Oct 2001 09:50:58 -0400
Subject: Re: Linux should not set the "PnP OS" boot flag
From: Thomas Hood <jdthood@mail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15qAlp-0005Mw-00@the-village.bc.nu>
In-Reply-To: <E15qAlp-0005Mw-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 07 Oct 2001 09:50:48 -0400
Message-Id: <1002462656.831.112.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-10-07 at 06:02, Alan Cox wrote:
> > This change has to be permanent.  Linux should never automatically
> > set the boot flag, no matter how PnP-competent we make it.
> > The reason is that setting the flag affects what the BIOS will
> > do on the _subsequent_ boot.  But Linux can't possibly know 
> > which operating system will be booted _next time_.  This is
> > something that has to be left up to the user to control.
> 
> When it cuts your reboot time right down then its a very useful thing to
> set.

Okay, clearly we do need the ability to set the PnP-OS flag.  But this
has to be under the user's control.  Microsoft itself says (from their
Simple Boot Flag FAQ
http://www.microsoft.com/hwdev/desinit/simp_bios.htm):

---------------------------------------------------------------------
How does this specification solve the multi-boot scenarios?
This specification does not attempt to solve multi-boot scenarios in
which a user has several different operating systems, some Plug and
Play, some not, installed on the machine. This specification only
provides a more reliable technique for detecting the presence of these
operating systems than previously published designs.

The multi-boot problem is fundamentally intractable: the information
needed by the system BIOS in order to boot is not available until after
boot. A system BIOS would like to know whether or not a Plug and Play
operating system will be booted. If so, it will only configure devices
that are required for boot. If not, it will configure all devices it
controls. The information about which OS will be booted is not known
until the user chooses the operating system in a boot menu. To present
the boot menu, however, the system BIOS must start booting the operating
system, which means it must have already configured devices. Thus, the
situation is a catch 22. The best any design can do is provide some hint
to the system BIOS that a Plug and Play operating system is installed.
This specification does no more than that.
---------------------------------------------------------------------

For these reasons it must be left up to the user to provide this
"hint".

> Also remember that this is entirely configurable.

I'm not sure what you mean by 'configurable' here.  All I see is that
the code that sets the PnP-OS flag gets compiled in if one chooses
to build the PnP BIOS driver by defining CONFIG_PNPBIOS.  But having
a PnP BIOS driver (merely an interface to the PnP BIOS) is not the
same thing as "being a PnP OS".  There ought to be some way of
overriding this---of building in the PnP BIOS driver without setting
the PnP-OS flag.  One solution is to put #ifdef CONFIG_PNPOS ... #endif
around the flag-setting code and add a new choice to the configuration.

> In fact the last stage of a pnp aware bootup requires that user space
> sets the "booted ok" flag.

Yes (if you mean: clears the "Booting" flag).  This is a different
flag from the PnP-OS flag.  The PnP-OS flag is bit 0; the "Booting"
flag is bit 1.  So this is a separate issue.

But look at the code (following).  The code DOES NOT clear the "Booting"
flag.  It ONLY sets the PnP-OS flag.  Not only that: when it does so
it fails to change bit 7 in order to preserve odd parity, as the spec
requires.

------------------------------------------------------------------
static void __init sbf_bootup(void)
{
        u8 v = sbf_read();
        if(!sbf_value_valid(v))
                v = 0;
#if defined(CONFIG_PNPBIOS)
        /* Tell the BIOS to fast init as we are a PnP OS */
        v |= (1<<0);    /* Set PNPOS flag */
#endif
        sbf_write(v);
}

#ifdef NOT_USED
void linux_booted_ok(void)
{
        u8 v = sbf_read();
        if(!sbf_value_valid(v))
                return;
        v &= ~(1<<1);   /* Clear BOOTING flag */
        sbf_write(v);
}
#endif /* NOT_USED */
----------------------------------------------------------------


> > If I'm right, then bootflag.c should be modified (see my patch)
> > to remove the bit that sets the flag.  It would be nice,
> > however, if the flag could be controlled via a /proc entry.
> 
> No need. It's all already handled

I think you'll understand why I say that it is not handled
_correctly_ and that the handling must be brought under
the user's control ... if not via a /proc entry then by
a build option or boot option.  I invite advice about this.

Please let me know if you still disagree.

--
Thomas



