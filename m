Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266241AbUF0E7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266241AbUF0E7e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 00:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUF0E7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 00:59:33 -0400
Received: from mproxy.gmail.com ([216.239.56.245]:37111 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266241AbUF0E71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 00:59:27 -0400
Message-ID: <cfe85dfa040626215929dd09ed@mail.gmail.com>
Date: Sat, 26 Jun 2004 22:59:24 -0600
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: supporting PC87366 in scx200*
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi folks,

I recently got a Soekris net4801, which sports an SC-1100 (586 CPU,
with lots of integrated goodies), and a NSC PC87366 SuperIO chip.


Ive hacked at the 2.4.26 version of the scx200 drivers, and have
gotten the code to recognize various hardware bits on the board (ie
new pci.ids entries).  Im writing to solicit advice on how to
restructure my hacks to make it acceptable for inclusion in Linux.  Im
aware that you want 2.6 code, but im hoping youll indulge me a bit til
I get a chance to forward-port it.

1. although the scx200{,_gpio}.c works with the sc-1100 GPIOs (and is
supported in 2.6.7), many of these pins are not usable for GPIO; they
are used in the Soekris board design for mutually exclusive functions.

Instead, the Soekris board provides gpio via the PC87366, which has a
very similar pin design, but which uses a different address-to-pin
mapping; the pin values are mapped in bytes, not long words.

The existing gpio char-dev API will work with these pins, I can extend
the driver instead of creating a separate driver file which is hugely
dependent upon scx200*, however this is my 1st ever attempt to hack at
linux in any way, so Im unsure what would be more palatable to you
all.


Assuming for a moment that extending scx200 to handle pc87366 pins is
better (less lines of new code, no lines of cut-paste boilerplate); I
have some questions:

1.  

The scx200 supports 64 pins (wrt the register assignments), the
pc87366 supports 32 (29 actual pins).  Should these new pins get minor
numbers 64-95 ?  Or should they get a new major # and start from minor
0 ?

With this approach, Ill have to (at minimum) replace the following
with other expressions that work with the new address mapping (also).

/* Definitions to make sure I do the same thing in all functions */
#define __SCx200_GPIO_BANK unsigned bank = index>>5
#define __SCx200_GPIO_IOADDR unsigned short ioaddr = scx200_gpio_base+0x10*bank
#define __SCx200_GPIO_SHADOW long *shadow = scx200_gpio_shadow+bank
#define __SCx200_GPIO_INDEX index &= 31

Additionally, the inline functions that use the above defines;

static inline int scx200_gpio_get(int index) {
static inline int scx200_gpio_current(int index) {
static inline void scx200_gpio_set_high(int index) {
static inline void scx200_gpio_set_low(int index) {
static inline void scx200_gpio_set(int index, int state) {
static inline void scx200_gpio_change(int index) {

(also in include/linux/scx200_gpio.h) would be replaced by actual
functions that are sensitive to the minor numbers.

2.

The PC87366 setup uses index,data io-addrs to programm the chip,
I tried to request_region on these 2 bytes and got an error.
Is this a wrong idea, or just some user error ?

	// reserve the index, data register pair (hardwired to 2e or 4e)
	r = request_region(PC87366_IDX, 2, "pc87366 index, data regs");
	if (!r) {
		printk (KERN_ERR NAME
			": pc87366 I/O resource %x,%d is not free.\n",
			PC87366_IDX, 2);
                // return -EIO;

3.

The comBIOS on the Soekris board sets up the PC87366 GPIO pins at IOaddr 6600.
Is it a bad idea to rely on this ?  I assume so, but for time being I dont
want to try to reprogram it to hard; Id prefer to have some mileage on the
board before I do this.

4.

Im working in 2.4.26.  Im sure youre more interested in 2.6 patches,
I ask your patience while I get up to speed (which may still be a
snails pace compared to you all).  Besides 2.6 is closed to careless
hackers and newbies.

5.

Responses can be off-list if you prefer, tho if theyre flames, Im sure
everyone will want a voyeuristic chuckle (and I dont need to be triple crispy,
double will suffice).  Im not on-list, but can read the archive.
(which I havent done wrt pc87366, having grepped for it in the src)


6.

Also, while Im writing, there are pin capabilities which are not
exposed by the driver; these set.. (well, here are NSCs words)


Offset 08h-0Bh                           GPIEN0 -- GPIO Interrupt
Enable 0 Register (R/W)                           Reset Value:
00000000h
  31:16     Reserved. Must be set to 0.
   15:0     GPIO Power Management Event (PME) Enable. Bits [15:0]
correspond to GPIO15-GPIO0 signals, respectively. Each bit
            allows PME generation by the corresponding GPIO signal.
            0: Disable PME generation.
            1: Enable PME generation.
            Notes: 1) All of the enabled GPIO PMEs are always repor
ted at F1BAR1+I/O Offset 10h[3].
                       2) Any enabled GPIO PME can be selected to
generate an SCI or SMI at F1BAR1+I/O Offset 0Ch[0].
                           If SCI is selected, then the individually
selected GPIO PMEs are globally enabled for SCI generation at
                           F1BAR1+I/O Offset 12h[3] and the status is
repor ted at F1BAR1+I/O Offset 10h[3].
                           If SMI is selected, the individually
selected GPIO PMEs generate an SMI and the status is repor ted at
                           F1BAR0+I/O Offset 00h/02h[0].
Offset 0Ch-0Fh                               GPST0 -- GPIO Status 0
Register (R/W1C)                                Reset Value: 00000000h
  31:16     Reserved. Must be set to 0.
   15:0     GPIO Status. Bits [15:0] correspond to GPIO15-GPIO0
signals, respectively. Each bit repor ts a 1 when hardware detects
            the edge (rising/falling on the GPIO signal) that is
programmed in F0BAR0+I/O Offset 24h[5]. If the corresponding bit in
            F0BAR0+I/O Offset 08h is set, this edge generates a PME.
            0: No active edge detected since the bit was last cleared.
            1: Active edge detected.
            Writing 1 to the Status bit clears it to 0.
            This is the third level of SMI status repor ting to the
second level at F0 Index 87h/F7h[7] and the top level at F1BAR0+I/O
            Offset 00h/02h[0]. Clearing the third level also clears
the second and top levels.
            This is the second level of SCI status repor ting to the
top level at F1BAR1+Offset 10h[3]. The status must be cleared at both
            the this level and the top level (i.e., the top level is
not automatically cleared when a bit in this register is cleared).


Note the 31:16 restrictions - those GPIOs dont have these capabilities,
and is likely (one reason) why Christer didnt add support for them.
That, and he didnt need to use them, and didnt add features he wasnt
going to test.  I dont know yet whether I NEED them, but I thought Id
float it..  It appears that other support work (which doesnt 'fit' in
this driver)
is needed to control the features in those 2 registers ( interrupt routing, etc)
