Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269538AbTGJSng (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 14:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269569AbTGJSnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 14:43:35 -0400
Received: from fc.capaccess.org ([151.200.199.53]:29444 "EHLO fc.capaccess.org")
	by vger.kernel.org with ESMTP id S269538AbTGJSls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 14:41:48 -0400
Message-id: <fc.0010c7b20095c2a30010c7b20095c2a3.95c2d1@capaccess.org>
Date: Thu, 10 Jul 2003 14:58:29 -0400
Subject: Ha3sm going 100% Squeal Mode
To: linux-assembly@vger.kernel.org, linux-kernel@vger.kernel.org
From: "Rick A. Hohensee" <rickh@capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ha3sm going 100% Squeal Mode
/Ha3sm/code/legmeg/ABOUT

Squeal Mode is fully scizophrenic operation of the 386+.

Neologisms used...

        dismiss  IRET, return with address, code segment and flags passed
        dual     16 bit datum, INTeLese "word"
        event    user/invoker of IDT or legvecs
        legvec   8086 interrupt vector
        reflex   device handler bottom end, event service
        pull     pop value keeping value
        submit   INT N, synchronous trap
        core     as in pullcore, A C D B SP BP SI and DI

This legmeg dir is for XT/AT stuff like BIOS calls. This is much of what a
PC is and I don't want to throw that info out. Proximity is the best
documentation. The ROMs are on your bus. I also don't want to write a lot
of 8086 code. Like floppy drivers. Although I don't even like the BIOS
keyboard driver. Options are good though, particularly when trying to get
a system going at all. I looked deep into the shiny yellow eyes of...

        o spot-reassembling the BIOS to USE16 pmode

        o VM86

        o switching to real mode

Switching to real mode is what the BIOS will like best. And is the
simplest of the three, and I've done it before. And is least dependant on
the more inscrutable INTeLnesses. This way we worry about the PE flag and
not much other pmode bletchery. This minimizes the Wintendo game of trying
to find out how things work that don't work. This is more
Chuck-Moore-grade stack gymnastics. Molesting a gargoyle like the PC isn't
half bad if you leave the flag draped over it's faces.

Here's the plan ...

init ...
                trivial & done
                Copy the legvecs to $legvec.

                well under way
                Write vsplice, which goes to ring0 and submits an event
                into a pmode reflex, returns to rmode, then dismisses
                (back to rmode). "pigcatcher" might be a better name.

                trivial
                set 0<->1k to the call addresses of each of the calls to
                        vsplice in the ESA.

                trivial
                Fill the 0->1k with the above.

                trivial
                Hook the hot ones like NMI with an rmode reflex. In
                        addition to the pmode reflex.

                Write a FIxNN that switches to real mode, calls the
                        BIOS from real mode, switches back to pmode.

                Replicate the above for the 16 or so interesting BIOS INTs.

from ring0 ...
                Use legacy BIOS calls at will via a fakeINT calls. Set up
                the call as per BIOS register conventions, ignoring the
                high duals of the core registers. Recieve BIOS return info
                as per BIOS legacy usual.


. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Squeal Mode bimodal events

               8086 legvecs @ 0
                    ______
                   |vsplice
                  /|8086   \
                 / |8086    \
living       r  /  |vsplice-->------->     vspliceN
well in        /   |8086      /               |
rmode    *POW*/    |vsplice  /                |
or --->>>EVENT     |vsplice /                 |
pmode         \    |___                       |
               \                              |
              p \                        switch to pmode ring 0
                 |           r                |
                 |       /---------  submit the event number N
                 |       |                    |
                 |       |             pmode event handler returns here
  A              V       V       /->      consuming submit frame
  |              |              /              |
  |    r         |             /        switch to rmode
  \ -----        |   <-------  |   <-\        |
                 |             |      \    dismiss
                 \      ____   |r      \_____/
                  \    |       |
                   \   | I  \  |
                    \  |     \ |dismiss
                     \ | D    \|
                      \|    __/\
                       | T   /  \
                       |    /    \
      /\               |   /      \
       |               |____       \p
       \    p                      /
        \_________________________/
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .


ring 0 wants to call a BIOS INT

There will be routines ala FIx10, FI0x11, FIx12... based on this, FIx10.

get your (386+) regs as per the particular
BIOS INT spec, but bigger
        |
        |
  call FIx10            (pmode interface to BIOS INT 0x10)
        |
    switch to rmode
          |
  push an 8086 dismiss frame
      by hand
          |
    jump far BIOS 0x10 entry point**  -----> BIOS ------> dismiss
          |                                              /
    BIOS dismisses to here ***      <-------------------/
          |
    set up BIOS reg returns
     for a pmode pullcore
          |
     switch to pmode
          |
     pullcore
          |
          return

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

** the far jump 16:16 pointers are selfmodded for each FIxnn to the
appropriate RAM ROM image at init time, based on the original bootup
legvecs+RAMROM shifts. Or just leave 'em in ROM. But still it's a self-mod
for more than one box.

You need about 16 instances of vsplice init-modded to the pertinent event
number. NMI will have a straight-8086 reflex in addition to the pmode
reflex, so you need vsplice for the IRQs. The 8086 exceptions can have
8086 ingnore reflexes.

*** part of the aforementioned 8086 IRET stack frame push.



SUMMARY

In order to flip back and forth from rmode to pmode and not kill
event-handling, i.e. to still run an OS, you have to leave events on. That
means you have to handle events in either mode roughly equivalently. I
want the option of calling the legacy BIOS INTs. Some of them probably
kill event-handling, but that's the breaks. I want the option of using the
BIOS only in the kernel though. That means I'm going from pmode to rmode,
BIOS, then back to pmode. I'm going to leave events on in those
circumstances. The BIOS probably varies from INT to INT on that. Worst
case, I doubt the BIOS turns off NMI except when asked to. Hope.

Given an rmode BIOS INT in what is otherwise a pmode OS, events occur in
rmode. Asynchronous events that may occur in such a scenario are NMI, 8086
exceptions, and IRQs. No protection exceptions, no synchronous traps. That
gives about 25 events that one has to prepare for in rmode. IRQs get
spliced back to pmode, dismiss, and return to rmode. They use the pmode
handlers. They need a splice. NMI will have an explicit rmode reflex in
addition to the pmode reflex, or the one NMI reflex will be coded
mode-indifferently. 8086 exceptions can be ignored in a kernel.

Thus to not throw out the BIOS and still have an OS one has to have a BIOS
INT wrapper (FIxNN in Ha3sm), and an IRQ modesplice (vsplice in Ha3sm).
Both are instantiated for each IRQ or INT in question to reduce problems
with the severe state restrictions on code handling events on a
scizophrenic machine.

So no, I'm not working on a "bootloader" in osimplay. Other than I'm
writing a femto-kernel. You may recall that my floppy "bootsector" is 15
bytes. Those 15 bytes apparently load one floppy cylinder to 0x7c00, which
18k or so I'm going to have a hard time consuming with the parts of a real
OS that interest me.

Rick Hohensee
Ha3sm is pronounced "haze 'em"


