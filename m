Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264929AbUFAIVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUFAIVW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 04:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUFAIVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 04:21:21 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:54164 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S264929AbUFAIVS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 04:21:18 -0400
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <20040528195709.GB5175@pclin040.win.tue.nl> <20040525201616.GE6512@gucio> <xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de>
Subject: BUG: atkbd.c keyboard driver bug [Was: keyboard problem with 2.6.6]
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 01 Jun 2004 10:21:16 +0200
Message-ID: <xb73c5f8z9f.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    Andries> Sau Dan Lee wrote:

    >> Actually, I have a side issue with input/i8042 related things:
    >> The keyboard on my laptop worked slightly different: On 2.4.*,
    >> SysRq is activated using a [Fn] key-combo, which agrees with
    >> the keycap labels on the laptop keyboard. After upgrading to
    >> 2.6, that key-combo no longer works. Instead, I must use
    >> Alt-PrintScreen as the key for SysRq. (And unfortunately,
    >> PrintScreen is a [Fn] combo on the laptop, thus requiring press
    >> 3 keys at the same time for SysRq, and a fourth key to use the
    >> various SysRq features. Very inconvenient.) Is this again due
    >> to some dirty translation processes down in the input layer?
    >> Is the input layer always assuming that Alt-PrintScreen ==
    >> SysRq?  This is not always true. Can the input layer be so
    >> configured that it never tries to interpret the scancodes, but
    >> pass them to the upper layers?

    Andries> So, what scancodes do you get in 2.4? And in 2.6? (Use
    Andries> scancode -s.)

Here they are:

        On Linux 2.4.*:
        PrintScreen: 0xe0 0x2a 0xe0 0x37 0xe0 0xb7 0xe0 0xaa
        SysRq:       0x54 0xd4

        On Linux 2.6.*:
        PrintScreen: 0xe0 0x2a 0xe0 0x37 0xe0 0xb7 0xe0 0xaa
        SysRq:       0xe0 0x2a 0xe0 0x37 0xe0 0xb7 0xe0 0xaa

No  wonder: "showkey  -s"  in 2.6.*  is  deceiving: it  shows what  an
emulated keyboard  generates, not the  *real* scancodes.  Fortunately,
the SERIO_USERDEV patch is very very helpful here.

Using the SERIO_USERDEV patch from Tuukka Toivonen and me, the correct
scancodes are displayed:

        On Linux 2.6.*: od -t x1 /dev/misc/isa0060/serio0
        PrintScreen: 0xe0 0x2a 0xe0 0x37 0xe0 0xb7 0xe0 0xaa
        SysRq:       0x54 0xd4


So, obviously, it is the fault of the Linux 2.6.* keyboard driver.


The story continues:

I've studied  the 2.6 keyboard driver  atkbd.c and found  the bug: The
keyboard  driver is  UNABLE  to distinguish  SysRq and  PrintScreen!!!
I've checked  this with  the help of  the 'evbug' module.   The driver
reports both keys to be KEY_SYSRQ, which is obviously wrong.

I've got a patch for this bug already.  See Bugzilla #2808.


Relatedly,  drivers/char/keyboard.c  assumes   that  SysRq  cannot  be
activated unless the Alt key(s) is/are pressed (and not yet released).
I'm going to fix this.  But since  this not a module, I need to reboot
to test it.  So, please be patient.


See http://bugzilla.kernel.org/show_bug.cgi?id=2808 for more info.



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

