Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVDCRGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVDCRGE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 13:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVDCRGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 13:06:04 -0400
Received: from 213-0-209-195.dialup.nuria.telefonica-data.net ([213.0.209.195]:34195
	"EHLO dardhal.24x7linux.com") by vger.kernel.org with ESMTP
	id S261818AbVDCRFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 13:05:48 -0400
Date: Sun, 3 Apr 2005 19:05:59 +0200
From: Jose Luis Domingo Lopez <video4linux@24x7linux.com>
To: video4linux-list@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6.12-rc-bk5] Avermedia TV/Phone98 remote control problem (input layer)
Message-ID: <20050403170559.GA7475@localhost>
Mail-Followup-To: video4linux-list@redhat.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all:

I am trying to make my Avermedia TV/Phone 98 remote control work with
linux kernel 2.6.x input layer support (driver ir-kbd-gpio). Module bttv
detects the remote ("bttv0: add subdevice "remote0"), and "ir-kbd-gpio"
makes the remote control show under /proc/bus/input/devices:

I: Bus=0001 Vendor=1461 Product=0001 Version=0001
N: Name="bttv IR (card=41)"
P: Phys=pci-0000:00:0b.0/ir0
H: Handlers=kbd event3 
B: EV=100003 
B: KEY=fc304 80100040 0 0 30000 0 2008000 82 1 9e0000 7bb80 0 0 

I tried Gerd's input layer utilities "input-20040421-115547.tar.gz" to
check if everything was working ok. "lsinput" shows the following:
/dev/input/event3
   bustype : BUS_PCI
   vendor  : 0x1461
   product : 0x1
   version : 1
   name    : "bttv IR (card=41)"
   phys    : "pci-0000:00:0b.0/ir0"
   bits ev : EV_SYN EV_KEY EV_REP

Then I tried "input-events" to check if keypresses in the remote where
detected OK. I get a neverending flow of "ghost" keypresses, because I
didn't touch any key at that time:
waiting for events
11:30:11.198718: EV_KEY KEY_KP0 pressed
11:30:11.198719: EV_SYN code=0 value=0
11:30:11.231712: EV_KEY KEY_KP0 pressed
11:30:11.231714: EV_SYN code=0 value=0
11:30:11.264705: EV_KEY KEY_KP0 pressed
...

Damnit!. So next I unloaded "ir-kbd-gpio", and loaded it again passing the
(undocumented) "debug" parameter to it (modprobe ir-kbd-gpio debug=1), and
the following shows in the logs. Checking the sources at
"drivers/media/video/ir-kbd-gpio.c" it seems that the key supposedly being
pressed is KEY_KP0 from "ir_codes_avermedia", exactly code 34 as shown below:
kernel: ir-kbd-gpio: ir-kbd-gpio: irq gpio=0x8d77c5 code=34 | poll down
kernel: ir-kbd-gpio: bttv IR (card=41) detected at pci-0000:00:0b.0/ir0

Just for completeness, here is the "lspci" output for the PCI device
"associated" to the remote:
0000:00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)

I also tried reading from the input device with "lircd" version 0.7.0 with
support for "devinput", and the same happens. However, this time the "key
code" detected was another one, but this happened after a reboot.

I compiled a 2.4.26 kernel with lirc 0.7.1-pre3 lirc-dev and lirc-gpio
kernel module, and version 0.7.1-pre2 lirc userspace, and it works.

Comparing the sources of "lirc-gpio" in lirc-0.7.1-pre3" and linux kernel
2.6.12-rc1-bk5 "ir-kbd-gpio.c" I see a possible cause for the problem.
Under 2.4.26 the card is detected as "id=0x11461", and under
2.6.12-rc1-bk5 it is detected as "PCI subsystem ID is 1461:0001". It seems
to me that both are the same.

For 2.4.26 this assigns the card's remote the following configuration
(file lirc_gpio.c). The second line I understand describes newer versions
of the same card (mine is from year 1999):
    bttv_id          card_id     gpio_mask   gpio_enable   gpio_lock_mask  gpio_xor_mask soft_gap  sample_rate  code_length 
{BTTV_AVPHONE98,     0x00011461, 0x003b8000, 0x00004000,   0x0800000,      0x00800000,   0,        10,          0}
{BTTV_AVPHONE98,     0x00031461, 0x00f88000,          0,   0x0010000,      0x00010000,   0,        10,          32}

For 2.6.12-rc1-bk5, any card that is recognized as BTTV_AVERMEDIA,
BTTV_AVPHONE98 or BTTV_AVERMEDIA98, gets assigned the _same_ configuration 
(file drivers/media/video/ir-kbd-gpio.c starting at line 313):
ir_codes         = ir_codes_avermedia;
ir->mask_keycode = 0xf88000;
ir->mask_keydown = 0x010000;
ir->polling = 50; // ms
						 
I am no expert at lirc kernel internals, nor at input layer in kernels
2.6.x, but maybe the problem with my remote comes from being "initialized"
with a generic parameter set that doesn't work at all for it. My knowledge
doesn't go much further, so I thank any additional help to fix this issue.

Greetings,

- -- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.10-rc3)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCUCJ3ao1/w/yPYI0RAuzjAJ4grc8aiFlpN8WtkrgJGZRbPXO3PQCfaWus
DcVUyPVVeKVxOCrREkd4WAI=
=LmCk
-----END PGP SIGNATURE-----
