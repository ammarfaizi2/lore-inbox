Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTFIM0w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 08:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264203AbTFIM0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 08:26:52 -0400
Received: from CPE-203-51-32-18.nsw.bigpond.net.au ([203.51.32.18]:17145 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S263152AbTFIM0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 08:26:50 -0400
Message-ID: <3EE48037.91F46F74@eyal.emu.id.au>
Date: Mon, 09 Jun 2003 22:40:23 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4: usb+scsi+X leads to scsi data corruption
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have spent the last few weeks attempting to identify the combination
that causes data corruption when I write to (or read from) my scsi
DDS2 tape.

So far I found that if I either shut down X (using "nv") or unload
usb (usb-hci+usbcore) then all is clean. The loaded modules when
I see the problem are.

Module                  Size  Used by    Not tainted
usb-uhci               21796   0  (unused)
usbcore                56704   1  [usb-uhci]
bttv                   69696   0  (autoclean)
tuner                   8772   1 
i2c-algo-bit            7180   1  (autoclean) [bttv]
videodev                5664   2  (autoclean) [bttv]
es1371                 27040   0  (autoclean)
ac97_codec             10240   0  (autoclean) [es1371]
gameport                1548   0  (autoclean) [es1371]
soundcore               3588   4  (autoclean) [bttv es1371]
dc395x_trm             47136   0  (autoclean)
st                     27028   0  (autoclean)
scsi_mod               83560   2  (autoclean) [dc395x_trm st]
ipt_limit                960   2  (autoclean)
ipt_LOG                 3200   3  (autoclean)
ipt_state                608   4  (autoclean)
iptable_filter          1760   1  (autoclean)
ip_conntrack_ftp        3808   0  (unused)
ip_conntrack           17324   2  [ipt_state ip_conntrack_ftp]
ip_tables              10752   4  [ipt_limit ipt_LOG ipt_state
iptable_filter]
ide-cd                 27200   0  (autoclean)
cdrom                  29024   0  (autoclean) [ide-cd]
via686a                 8228   0 
eeprom                  3552   0  (unused)
i2c-proc                6368   0  [via686a eeprom]
i2c-isa                 1252   0  (unused)
i2c-viapro              3880   0  (unused)
i2c-core               12960   0  [bttv tuner i2c-algo-bit via686a
eeprom i2c-pr
oc i2c-isa i2c-viapro]
3c509                  10368   1  (autoclean)
nls_iso8859-1           2848   2  (autoclean)
nls_cp437               4384   2  (autoclean)
msdos                   4988   2  (autoclean)
fat                    29880   0  (autoclean) [msdos]
serial                 43808   1  (autoclean)
isa-pnp                28796   0  (autoclean) [3c509 serial]
rtc                     6012   0  (autoclean)
unix                   13892  39  (autoclean)

I did not use to have usb loaded, so I did not have any problems for
until
recently, when I acquired a digital camera that shows up as USB storage.

I do not need to actually have anything connected to the usb system in
order for the problem to show up, I just need to do:

modprobe usb-uhci
mount /proc/bus/usb

Or I can shutdown xdm.

I have confirmed the problem with dozens of runs, this is no fluke. It
shows
up in 2.4.20 vanilla (did not try an older kernel yet) as well as the
later
rc's (up to -rc7).

I get, on average, 100 bad bytes in 400MB of data. The least I saw was 8
and
the most 204 bytes (so far).

The data that gets inserted is not random, and not zeroes. It can be
very short:
     offset    new old
  1: 391353697   2   0
  2: 391353698 241   0
  3: 391353699 211   0
  4: 391353700   5   0

  5: 391353717 100   0
  6: 391353718 241   0
  7: 391353719 211   0
  8: 391353720   5   0
The test file is all zeroes.

Most are bursts of 4-20 bytes, sometime close together, with similar
content repeated.

I can supply any required information - just ask. I put some files
up:
	http://users.bigpond.net.au/eyal/bootup.txt
	http://users.bigpond.net.au/eyal/config.txt
	http://users.bigpond.net.au/eyal/lspci.txt
	http://users.bigpond.net.au/eyal/test7.sh
The last one is the script I run for the test.

Ask for moreif needed.

TIA

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
