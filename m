Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264793AbUD1NxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264793AbUD1NxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 09:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264789AbUD1NxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 09:53:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30225 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264804AbUD1NxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 09:53:20 -0400
Date: Wed, 28 Apr 2004 14:53:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [BUG] 2.6.6-rc3: make xxx_defconfig randomly sets options
Message-ID: <20040428145316.C24948@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If I have an ARM defconfig file which contains:

# CONFIG_SERIO is not set

with none of the other CONFIG_SERIO symbols, and I run make foo_defconfig,
I get the following in the resulting .config:

CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y

This is despite not being an X86 architecture, and isn't affected by
whether CONFIG_EMBEDDED is set or not.

If I run "make oldconfig" after switching CONFIG_SERIO off and removing
the other CONFIG_SERIO_* symbols, I get:

Serial i/o support (SERIO) [Y/?] y
i8042 PC Keyboard controller (SERIO_I8042) [Y/n/m/?] (NEW)

It appears SERIO is forced on because SERIO_I8042 _may_ be wanted by
the user, which in turn forces SERIO_I8042 to Y in the defconfig case
because we don't accept input from the user and the default is Y.

So, there is _no_ way to presently have a working defconfig file for
a machine which does not support I8042 - I8042 will always be
_unconditionally_ selected no matter what.

Can we please take Aunt Tillie out to the firing squad?  This hacking
around with the Kconfig files to make X86 life simple is causing _real_
bugs for other architectures.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
