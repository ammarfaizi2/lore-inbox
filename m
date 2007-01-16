Return-Path: <linux-kernel-owner+w=401wt.eu-S1750741AbXAPSWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbXAPSWs (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbXAPSWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:22:48 -0500
Received: from mx6.mail.ru ([194.67.23.26]:18204 "EHLO mx6.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbXAPSWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:22:47 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-usb-devel@lists.sourceforge.net
Subject: 2.6.20-rc5:  BUG: lock held at task exit time! (pm_mutex){--..}, at: [<c013bfff>] enter_state+0x3f/0x170
Date: Tue, 16 Jan 2007 21:22:39 +0300
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701162122.42581.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have Toshiba Portege 4000 that almost always hangs dead resuming from STR. 
This was better before 2.6.18, since then STR is unusable. Sometimes it 
manages to resume; yesterday I got on console and in dmesg:

=====================================
[ BUG: lock held at task exit time! ]
- -------------------------------------
echo/28793 is exiting with locks still held!
1 lock held by echo/28793:
 #0:  (pm_mutex){--..}, at: [<c013bfff>] enter_state+0x3f/0x170

stack backtrace:
 [<c0103fea>] show_trace_log_lvl+0x1a/0x30
 [<c01045f2>] show_trace+0x12/0x20
 [<c01046a6>] dump_stack+0x16/0x20
 [<c0132377>] debug_check_no_locks_held+0x87/0x90
 [<c011c8bb>] do_exit+0x4db/0x820
 [<c011cc29>] do_group_exit+0x29/0x70
 [<c011cc7f>] sys_exit_group+0xf/0x20
 [<c010300e>] sysenter_past_esp+0x5f/0x99
 =======================

I have a bug report about resume issue but I may have wrongly attributed it to 
ACPI: http://bugzilla.kernel.org/show_bug.cgi?id=7499

echo mentioned here comes from "echo ... > /sys/power/state"

I have been suspecting ACPI because another permanent bug I have is lockup 
using acpi_cpufreq and ondemand governor ... but it may be red herring 
(although it is annoying).

{pts/0}% lspci
00:00.0 Host bridge: ALi Corporation M1644/M1644T Northbridge+Trident (rev 01)
00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 01)
00:07.0 ISA bridge: ALi Corporation M1533/M1535 PCI to ISA Bridge [Aladdin 
IV/V/V+]
00:08.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
00:0a.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] 
(rev 08)
00:10.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 01)
00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus 
Bridge with ZV Support (rev 32)
00:11.1 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus 
Bridge with ZV Support (rev 32)
00:12.0 System peripheral: Toshiba America Info Systems SD TypA Controller 
(rev 03)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade XPAi1 (rev 
82)

{pts/0}% lsmod
Module                  Size  Used by
snd_seq_dummy           3556  0
snd_seq_oss            32176  0
snd_seq_midi_event      7496  1 snd_seq_oss
snd_seq                50808  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          8180  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            43168  0
snd_mixer_oss          16104  1 snd_pcm_oss
snd_ali5451            23644  0
snd_ac97_codec         97116  1 snd_ali5451
snd_pcm                79564  3 snd_pcm_oss,snd_ali5451,snd_ac97_codec
snd_timer              23164  2 snd_seq,snd_pcm
snd_page_alloc          9832  1 snd_pcm
snd                    53956  9 
snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_ali5451,snd_ac97_codec,snd_pcm,snd_timer
soundcore               7776  1 snd
e100                   35968  0
mii                     5472  1 e100
nls_iso8859_1           3968  0
nls_cp866               5056  0
vfat                   12672  0
fat                    52436  1 vfat
sg                     35716  0
usb_storage            78816  0
bluetooth              54916  0
autofs4                21524  0
af_packet              21872  4
ac97_bus                2496  1 snd_ac97_codec
smsc_ircc2             17828  0
irnet                  24532  0
ppp_generic            29188  1 irnet
slhc                    6624  1 ppp_generic
irtty_sir               6016  0
sir_dev                14476  1 irtty_sir
ircomm_tty             24784  0
ircomm                 13828  1 ircomm_tty
irda                  119528  5 smsc_ircc2,irnet,sir_dev,ircomm_tty,ircomm
crc_ccitt               1984  1 irda
binfmt_misc            12072  1
loop                   16504  0
dm_mod                 58452  0
video                  15460  0
toshiba_acpi            6328  0
backlight               6176  1 toshiba_acpi
thermal                13704  0
sbs                    14840  0
processor              23372  1 thermal
i2c_ec                  4704  1 sbs
i2c_core               22608  1 i2c_ec
fan                     4516  0
container               4160  0
button                  7632  0
battery                 9604  0
ac                      4900  0
wlags49_h1_cs         181844  1
pcmcia                 38496  1 wlags49_h1_cs
firmware_class          9728  1 pcmcia
yenta_socket           26764  5
tsdev                   7648  0
mousedev               11752  1
evdev                   9952  2
rsrc_nonstatic         11456  1 yenta_socket
pcmcia_core            40344  3 pcmcia,yenta_socket,rsrc_nonstatic
ali_agp                 6976  1
agpgart                32068  1 ali_agp
nvram                   8904  0
toshiba                 4472  0
psmouse                38472  0
ohci_hcd               21356  0
usbcore               136560  3 usb_storage,ohci_hcd
sr_mod                 17412  0
reiserfs              248108  1
sd_mod                 20448  3
pata_ali               12012  2
libata                108348  1 pata_ali
scsi_mod              141032  5 sg,usb_storage,sr_mod,sd_mod,libata
atkbd                  17656  0
libps2                  7240  2 psmouse,atkbd
i8042                  19160  0
serio                  17240  5 psmouse,atkbd,i8042
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFrRfyR6LMutpd94wRAlIdAJwN8RIR8V35U0xIJtxfVtUmt04R2wCgx95W
GU0yt1WyY896Zy7NwwMDwNI=
=ea9j
-----END PGP SIGNATURE-----
