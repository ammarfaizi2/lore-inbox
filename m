Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbUKPBLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUKPBLI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 20:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbUKPBLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 20:11:08 -0500
Received: from smtp.wp.pl ([212.77.101.160]:41138 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S261731AbUKPBKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 20:10:46 -0500
Date: Tue, 16 Nov 2004 02:11:00 +0100
From: Marek Szuba <scriptkiddie@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: Oopses / ReiserFS superblock corruption with 2.6.9
Message-Id: <20041116021100.09d08af3.scriptkiddie@wp.pl>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__16_Nov_2004_02_11_00_+0100_w3ixwS2W68gP6n_D"
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO AS1=NO(Body=1 Fuz1=1 Fuz2=1) AS2=YES(1.000000) AS3=NO AS4=NO                         
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__16_Nov_2004_02_11_00_+0100_w3ixwS2W68gP6n_D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello again,

During two weeks of running 2.6.9 I was hit by two oopses, one of them
with rather annoying and potentially disastrous consequences. I have to
say I'm rather disappointed with this, having not seen an oops for
almost a year... Anyhow, here's what happened:

1. The first oops occurred when I attempted to log in under X (X.org
6.8). The WM (blackbox) started successfully, but when Esetroot tried to
place the background image in place, the X server crashed and I got
returned to the wdm prompt - a new one though, as it was located on the
8th console rather than on the 7th. The problem was reproducible and
only went away after I'd rebooted the box. Here is the error message:

Unable to handle kernel paging request at virtual address 02014742
 printing eip:
c0164823
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: mga parport_pc lp parport ohci1394 ieee1394
emu10k1_gp snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device
snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd soundcore
hpt366 wacom joydev usbhid uhci_hcd usbcore evdev 8139too mii crc32
ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables w83781d
eeprom i2c_sensor i2c_isa i2c_piix4 i2c_core analog gameport rtc
nls_iso8859_2 nls_cp852 vfat fat nls_base
CPU:    0
EIP:    0060:[poll_freewait+35/80]    Not tainted VLI
EFLAGS: 00013212   (2.6.9)
EIP is at poll_freewait+0x23/0x50
eax: 00000000   ebx: 0201472a   ecx: c14fb260   edx: c150f1f8
esi: 000f0008   edi: 000f0000   ebp: 00020000   esp: ecf69ee0
ds: 007b   es: 007b   ss: 0068
Process X (pid: 1958, threadinfo=ecf68000 task=ef55faa0)
Stack: 00000000 00000000 00000012 c0164bcf ecf69f40 00000000 00000000
00000000
       00020000 00000345 0003f80a 00000000 00000000 0003f80a ecf68000
ef7f7124
       ef7f7104 ef7f70e4 ef7f7184 ef7f7164 ef7f7144 0001c7d3 00000001
00000000
Call Trace:
 [do_select+431/720] do_select+0x1af/0x2d0
 [__pollwait+0/208] __pollwait+0x0/0xd0
 [sys_select+763/1328] sys_select+0x2fb/0x530
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: c3 8d b4 26 00 00 00 00 57 56 53 8b 44 24 10 8b 78 04 85 ff 74 3a
89 f6 8b 5f 04 8d 77 08 8d 76 00 8d bc 27 00 00 00 00 83 eb 1c <8b> 43
18 8d 53 04 e8 42 18 fb ff 8b 03 e8 cb d9 fe ff 39 f3 77


2. The second error manifested itself in that I couldn't get any
programs to run all of a sudden. While at first there were only ReiserFS
warnings on the debug console, eventually one of the programs (a shell
script, to be exact) threw a "kernel BUG" error in preempt and requested
me to reboot. The relevant snipped of the log is attached to this
message in bzip2-compressed form to conserve bandwidth.

After the reboot things got even more interesting! The system would go
through almost the whole booting procedure only to generate a
ReiserFS-related oops (which I cannot quote because it didn't get logged
anywhere), hang and become completely unresponsive the moment it tried
to access the gpm executable, located on the same partition the
aforementioned filesystem warnings referred to; again the problem was
reproducible, but didn't go away after shutting the machine down for
some time.

Having launched memtest on the machine to check if the memory chips I
had installed a few weeks earlier weren't the source of the problem
despite having been thoroughly tested with that tool just after the
installation (and once again they came out clean), I brought the system
up with a rescue disc and launched reiserfsck on all partitions. Hda6
came out clean! No such luck with the root partition though - I got told
immediately that the superblock is corrupted, of which I got a quick
glance by running df (I only roughly counted the digits, but even so I
could see my 2 GB on that partition magically expanded into at least
*tens of terabytes*)... Luckily it seems the data itself was intact as
everything went back to seemingly normal after rebuilding the
superblock, not to mention I was able to tar the contents of the whole
partition in the first place.

All said and written, I went back to 2.6.7 for the time being - its
security flaws don't bother me much (the important boxes still run 2.4,
just in case) and it was the last 2.6 kernel which didn't offer me
unwanted surprises once in a while. To think of such things happening in
a supposedly stable kernel... tsk, tsk! Of course I am aware that 2.4.9
is said to have been a much greater mess; still, somehow the last
problems I had with that branch were before 2.4.0 (even the famous
"don't use" release managed to run on one of my boxes for a full day,
not to mention compiling the next version) and I constantly get hit with
2.6.x problems (AFAIR the first version I was actually able to use on a
regular basis was 2.6.4). 

Anyway, hopefully the information I've provided will be useful in
debugging the problem. If you need any more data, please let me know.

Best regards,
Marek

--Multipart=_Tue__16_Nov_2004_02_11_00_+0100_w3ixwS2W68gP6n_D
Content-Type: application/octet-stream;
 name="reiserfs.error.bz2"
Content-Disposition: attachment;
 filename="reiserfs.error.bz2"
Content-Transfer-Encoding: base64

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
4u5IpwoSF7dAeGA=

--Multipart=_Tue__16_Nov_2004_02_11_00_+0100_w3ixwS2W68gP6n_D--
