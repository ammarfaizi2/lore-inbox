Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271412AbTHHOpS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271414AbTHHOpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:45:18 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54765 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271412AbTHHOoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:44:17 -0400
Date: Fri, 8 Aug 2003 16:44:08 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Surprising Kconfig depends semantics
Message-ID: <20030808144408.GX16091@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

I traced some unresolved symbol problems in 2.6.0-test2-mm5 down to the 
following:

drivers/input/keyboard/Kconfig contains the following:

config KEYBOARD_ATKBD
        tristate "AT keyboard support" if EMBEDDED || !X86 
        default y
        depends on INPUT && INPUT_KEYBOARD && SERIO


The .config includes:
  # CONFIG_EMBEDDED is not set
  CONFIG_X86=y
  CONFIG_INPUT=y
  CONFIG_INPUT_KEYBOARD=y
  CONFIG_SERIO=m

Kconfig sets
  CONFIG_KEYBOARD_ATKBD=y

CONFIG_SERIO=m with CONFIG_KEYBOARD_ATKBD=y shouldn't be a valid 
combination.

The correct solution is most likely a
	default y if INPUT=y && INPUT_KEYBOARD=y && SERIO=y
	default m if INPUT!=n && INPUT_KEYBOARD!=n && SERIO!=n


The semantics that in

config FOO
	tristate
	default y if BAR

FOO will be set to y if BAR=m is a bit surprising.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

