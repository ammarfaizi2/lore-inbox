Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280153AbRJaL0K>; Wed, 31 Oct 2001 06:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280154AbRJaL0B>; Wed, 31 Oct 2001 06:26:01 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:25828 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S280153AbRJaLZ4>;
	Wed, 31 Oct 2001 06:25:56 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15327.57317.942272.629551@harpo.it.uu.se>
Date: Wed, 31 Oct 2001 12:26:29 +0100
To: stevie@qrpff.net (Stevie O)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Local APIC option (CONFIG_X86_UP_APIC) locks up Inspiron 8100
In-Reply-To: <E15ysre-0003FD-00@the-village.bc.nu>
In-Reply-To: <5.1.0.14.2.20011030235723.022818d8@whisper.qrpff.net>
	<E15ysre-0003FD-00@the-village.bc.nu>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > > 2) Anytime I change the plugged-in status of the AC adapter (if it wasn't 
 > > plugged in, if I plug it in; if it was plugged in, if I unplug it), the 
 > > machine locks up completely.
 > 
 > Not all BIOS firmware can cope when we switch to UP-APIC. Some laptops 
 > really don't like it one bit.

Correct, and the I8x00 is the prime example of that.

I have a fix, but it involves fairly major surgery:
- Implement bt_ioremap()/bt_iounmap() which work at early boot-time (the
  normal ioremap doesn't work yet). This is done by adding 16 boot-time
  only fixmap entries, and using those for temporary mappings. These
  fixmap entries are reclaimed once vmalloc() is initialised, so they
  don't steal address space permanently.
  This would also help some other code which wants to scan arbitrary
  physical memory at early boot-time.
- Move dmi_scan from main to the i386 setup_arch(). To permit this, ioremap()
  is changed to bt_ioremap(), and vmalloc() to alloc_bootmem().
- Add a blacklist entry in dmi_scan, which sets a "don't enable local APIC"
  flag if the I8000 or any problematic machine is found.
- Move init_apic_mappings() from setup_arch() to trap_init(). This is
  so that kernel command-line parameters can be used to override stuff.
- Change detect_init_apic() to refuse to enable the local APIC if the
  blacklist flag is set.

The patch is still _very_ rough, but it seems to work. Let me know if you want it.

/Mikael
