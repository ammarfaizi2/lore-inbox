Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUIVTRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUIVTRh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266749AbUIVTRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:17:37 -0400
Received: from dsl254-100-205.nyc1.dsl.speakeasy.net ([216.254.100.205]:62136
	"EHLO memeplex.com") by vger.kernel.org with ESMTP id S266756AbUIVTRZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:17:25 -0400
From: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Consisten kernel hang during heavy TCP connection handling load
Date: Wed, 22 Sep 2004 15:17:15 -0400
Message-ID: <NFBBICMEBHKIKEFBPLMCOEPOIHAA.aathan-linux-kernel-1542@cloakmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have written a pair of applications the server side of which consistently causes my Linux Fedora Core 2 system to become
completely unresponsive; all consoles hang, and it no longer services network connections.

The applications engage in the rapid opening and closing of TCP connections.  The server side is multithreaded (# threads approx 5).
It services the connections by dumping data into them from a file.  The client side reads no data.  The server then receives EAGAIN
from send(...,MSG_NOWAIT) calls, and issues 5ms sleep before resending on any particular TCP connection.  It loops up to 20 times
waiting for the the connection to become unblocked.  The applications are running within GDB, and threads *are* created/destroyed
during the process.

I will change the application to use select() rather than sleeping on a blocked pipe.  However, I don't think it's a "good thing"
that the machine hangs so completely.

I looked for tools to help catch the kernel before it goes la-la (assuming it's the kernel going la-la), but got
frustrated/ran-out-of-time.  E.g., lkcd seems defunct.

If pointed in the right direction, I would be happy to perform further forensics after re-creating the hang.  I am also in the
process of upgrading the kernel to see if that resolves the problem.

Andrew Athan




uname -a:

Linux bbox.memeplex.com 2.6.6-1.435 #1 Mon Jun 14 09:09:07 EDT 2004 i686 i686 i386 GNU/Linux

lsmod:

Module                  Size  Used by
snd_mixer_oss          13824  2
snd_via82xx            20644  3
snd_ac97_codec         54788  1 snd_via82xx
snd_pcm                69256  1 snd_via82xx
snd_timer              17284  1 snd_pcm
snd_page_alloc          8072  2 snd_via82xx,snd_pcm
gameport                3328  1 snd_via82xx
snd_mpu401_uart         4864  1 snd_via82xx
snd_rawmidi            17444  1 snd_mpu401_uart
snd_seq_device          6152  1 snd_rawmidi
snd                    39396  10
snd_mixer_oss,snd_via82xx,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               6112  3 snd
ipt_mark                1408  2
ipt_MARK                1664  14
cls_u32                 5508  2
cls_fw                  3200  2
sch_sfq                 4352  9
sch_htb                18048  1
iptable_mangle          2176  1
ip_tables              13568  3 ipt_mark,ipt_MARK,iptable_mangle
nfsd                  159488  9
exportfs                4224  1 nfsd
lockd                  47816  2 nfsd
parport_pc             19392  1
lp                      8236  0
parport                29640  2 parport_pc,lp
autofs4                12932  0
sunrpc                109924  19 nfsd,lockd
via_rhine              15752  0
mii                     3584  1 via_rhine
floppy                 47440  0
sg                     27680  0
scsi_mod               91984  1 sg
microcode               4768  0
dm_mod                 32800  0
ehci_hcd               22916  0
uhci_hcd               24472  0
button                  4632  0
battery                 6924  0
asus_acpi               8984  0
ac                      3340  0
r128                   85796  2
ipv6                  184672  18
ext3                  103656  2
jbd                    40728  1 ext3


