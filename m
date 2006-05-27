Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWE0IGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWE0IGm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 04:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWE0IGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 04:06:42 -0400
Received: from mx6.mail.ru ([194.67.23.26]:34858 "EHLO mx6.mail.ru")
	by vger.kernel.org with ESMTP id S1751441AbWE0IGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 04:06:41 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: gcc-4.1.1/kernel 2.6.16.18 - miscompiled external module (old parameter not found)
User-Agent: KMail/1.9.1
Content-Disposition: inline
Date: Sat, 27 May 2006 12:06:33 +0400
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200605271206.34427.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

After recompilation with new compiler of wifi driver I got:

wlags49_h1_cs: falsely claims to have parameter channel
wlags49_h1_cs: falsely claims to have parameter channel
wlags49_h1_cs: falsely claims to have parameter channel
wlags49_h1_cs: falsely claims to have parameter channel

The module is ported from Agere sources and is using old style MODULE_PARAM & 
Co. The relevant part looks like:

static p_char  *network_name            = PARM_DEFAULT_SSID;
static p_u8     channel                 = PARM_DEFAULT_CHANNEL;
static p_u8     distance_between_aps    = PARM_DEFAULT_SYSTEM_SCALE;
static p_u8     transmit_rate           = PARM_DEFAULT_TX_RATE;
static p_u16    medium_reservation      = PARM_DEFAULT_RTS_THRESHOLD;
static p_char  *microwave_robustness    = 
PARM_DEFAULT_MICROWAVE_ROBUSTNESS_STR;
...
MODULE_PARM(network_name,           "s");
MODULE_PARM_DESC(network_name,           "Network Name (<string>) [ANY]");
MODULE_PARM(channel,                "b");
MODULE_PARM_DESC(channel,                "Channel (0 - 14) [0]");
MODULE_PARM(distance_between_aps,   "b");
MODULE_PARM_DESC(distance_between_aps,   "Distance Between APs (1 - 3) [1]");
MODULE_PARM(transmit_rate,          "b");
MODULE_PARM_DESC(transmit_rate,          "Transmit Rate Control (1 - 7) [3]");
MODULE_PARM(medium_reservation,     "h");
MODULE_PARM_DESC(medium_reservation,     "Medium Reservation (RTS/CTS Fragment 
Length) (256 - 2347) [2347]");
MODULE_PARM(microwave_robustness,   "s");
MODULE_PARM_DESC(microwave_robustness,   "Microwave Oven Robustness Enabled 
(<string> N or Y) [N]");
...

where p_u8 is defined as

include/wireless/wl_internal.h:#define p_u8    __u8

Now, what happens is apparently - only parameters defined as pointer or array 
appear in strtab; no parameter of type 'b' is found:

{pts/1}% objdump -t wlags49_h1_cs.ko | egrep '(microw|channel|network|
distance)'
00000880 l     O .rodata        00000004 network_name
00000884 l     O .rodata        00000004 microwave_robustness
00000000 l     O .modinfo       00000018 __mod_network_nametype241
00000020 l     O .modinfo       00000030 __mod_network_name242
00000050 l     O .modinfo       00000013 __mod_channeltype243
00000080 l     O .modinfo       00000022 __mod_channel244
000000c0 l     O .modinfo       00000020 __mod_distance_between_apstype245
000000e0 l     O .modinfo       0000003b __mod_distance_between_aps246
00000200 l     O .modinfo       00000020 __mod_microwave_robustnesstype251
00000220 l     O .modinfo       00000052 __mod_microwave_robustness252
00000000 g     O __obsparm      00000080 __parm_network_name
00000100 g     O __obsparm      00000080 __parm_distance_between_aps
00000080 g     O __obsparm      00000080 __parm_channel
00000280 g     O __obsparm      00000080 __parm_microwave_robustness

The distribution is Mandriva with gcc-4.1.1-1mdk, stock 2.6.16.18. Full source 
of module is available on request if required. This has been compiled before 
with gcc-4.0 just fine.

- - -andrey

P.S. and yes, I should have fixed obsolete module usage; it is just oo much 
work for somehing used privately only :)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEeAiKR6LMutpd94wRAorrAKC6F29X0Hz4NELUtanr+vtfkUC6iQCaA+j1
i/41mA7TwZ775h8vji7e78I=
=MIy3
-----END PGP SIGNATURE-----
