Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264709AbTGLGXL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 02:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266807AbTGLGXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 02:23:11 -0400
Received: from fc.capaccess.org ([151.200.199.53]:31496 "EHLO fc.capaccess.org")
	by vger.kernel.org with ESMTP id S264709AbTGLGW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 02:22:58 -0400
Message-id: <fc.0010c7b2009622990010c7b200962299.96229b@capaccess.org>
Date: Sat, 12 Jul 2003 02:39:39 -0400
Subject: Nothin ackshully asquealin juss yet, 'cept the sow.
To: linux-kernel@vger.kernel.org, linux-assembly@vger.kernel.org
From: "Rick A. Hohensee" <rickh@capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not even at the level shown yet:
        hook the IRQups into the 8086 intvec table @ 0.
        write pure rmode bottom-ends for very frequent events.

sow goes in bootup-init control flow, IRQup and FINT go where subroutines
go.

Totally untested, but compembles OK.........

.....................................................................
/Ha3sm/code/legmeg/sow
# Piglet factory, 16 teats on a side

L sow

########
###### event-promote-to-pmode stuff

### fill the sty with IRQups for each IRQ

 szIRQup=$((endIRQup-IRQup))

= 16 to D
= $IRQup to SI
= $sty to DI

increasing
L piglet
        = $szIRQup to C
          copies bytes
        1- D
when not zero                   piglet

### set submit numbers in each instantiation of IRQup

pigoffset=$((pigname-IRQup-1))

= 16 to C
= 0x20 to D
= $((sty+pigoffset)) to DI

L nextpiglet
        = D to byte @ DI
        1+ D
        + $szIRQup to DI
when C-1                        nextpiglet



########-----------------------------------------------------------------
############# copy legacy intvecs to ~0x3000
# Not imperative, but good info to not lose.

zero SI
= $legvec to DI
= 0x100 to C
copies



########~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
########### fake-INTs-from-pmode init

FINTsz=$((FINT-endFINT))

= 16 to D
= $FINT to SI
= $wallow to DI

increasing
L squealer
        = $FINTsz to C
          copies bytes
        1- D
when not zero                   squealer


#######=============================================================
####  get the IRQ legvec offset:segs and garnish the FINTs with them
# After copying the legvecs.

FINToffset=$((eartag-FINT-4))

= 16 to C
= $((legvec+64)) to SI                  # INT 0x10
= $((wallow+FINToffset)) to DI

L nexstrip
        = @ SI to A
        = A to @ DI
        + 4 to SI
        + $FINTsize to DI
when C-1                        nexstrip


##### +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## declare individual FINTnum call addresses in compembly state

FINT10=$((wallow+(FINTsz*0)))
FINT11=$((wallow+(FINTsz*1)))
FINT12=$((wallow+(FINTsz*2)))
FINT13=$((wallow+(FINTsz*3)))
FINT14=$((wallow+(FINTsz*4)))
FINT15=$((wallow+(FINTsz*5)))
FINT16=$((wallow+(FINTsz*6)))
FINT17=$((wallow+(FINTsz*7)))
FINT18=$((wallow+(FINTsz*8)))
FINT19=$((wallow+(FINTsz*9)))
FINT1a=$((wallow+(FINTsz*10)))
FINT1b=$((wallow+(FINTsz*11)))
FINT1c=$((wallow+(FINTsz*12)))
FINT1d=$((wallow+(FINTsz*13)))
FINT1e=$((wallow+(FINTsz*14)))
FINT1f=$((wallow+(FINTsz*15)))

# so it's e.g.    call $FINT10   for vidBIOS from pmode.

#   Nyuk nyuk nyuk.


...................................................................
/Ha3sm/code/legmeg/FINT

        L FINT
                push DS
                        otheroperandsize; push A
                        zero A
                        = A to CR0
cell=2
                                pull A
                                pushflags
                                ab   0xea
                                aq   0                  ; L eartag
                        loadmachinestatusdual 1
                        ab 0xea
                        ad  ring0CS
                        ad  0x10        ; L ring0CS
cell=4
                pull DS
        return ; L endFINT




# Fakin' Bacon.
# Presume an rmode-useable pmode effective [E]IP, SP, and effective DS
#       offset of 0.
# core regs, flags and ES clobberable by BIOS

        ## indented for various state changes.
                ## LMSW will not switch back to Real Address Mode.
                # using it saves push/pull A
                # For a fancier (paged) OS use CR0 and push/pull A


....................................................................
/Ha3sm/code/legmeg/IRQup

cell=2
        L IRQup
                push DS
                push ES
                        loadmachinestatusdual 1
                        ab   0xea
                        ad   $ring0cs   0x10 ; L ring0cs
cell=4
                        push A
                                = 0x18 to A
                                = A to DS
                                = A to ES
                        pull A
                        submit 0 ;                      L pigname
                        otheroperandsize ; push A
                                zero A
                                = A  to CR0
cell=2
                        pull A
                pull ES
                pull DS
        return  ; L endIRQup
cell=4



/////////////////////////////

The osimplay word for disable-interrupts is nosurprises. From what I can
see at this point FINTs and IRQups don't need it.

call FINT10    etc. is for ring 0 only, possibly prepped with small pmode
segments.

Rick Hohensee

