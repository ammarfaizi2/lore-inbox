Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWILItT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWILItT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWILItS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:49:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:15142 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751352AbWILItR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:49:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:message-id;
        b=II6UXHoku1BM6cIDpZHVtBIqHALHmx5aSM10iCEyur/slH+yLz+eUoSICpkp/s5F5c8VgIahBxX2Yz4yo0cLR17Q2TnW/qPYUgNlxOo/yjAnfp0Z+eJFCcwv5Stxtx31PNIR+amJ58wGNeoEKMd0x8dXIwQ+5VEY6XAqDykKDqs=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org
Subject: MSI K9N Neo: crash under heavy IDE read
Date: Tue, 12 Sep 2006 10:46:24 +0200
User-Agent: KMail/1.8.2
Cc: Dmytro_Puhach@cz.ibm.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gPnBFk2R9AlKn0Z"
Message-Id: <200609121046.24610.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_gPnBFk2R9AlKn0Z
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I bought new Athlon46 mobo with AM2 socket and recently
I noticed that copying large amounts of data reliably
crashes 2.6.17.11 64-bit on it.

memtest runs ok on this machine overnight.
Machine is not overclocked.

Copying movies from SATA drive to PATA drive oopses
after few gigabytes transferred. Creating iso image
with mkisofs (done entirely on PATA drive, no SATA attached)
does the same.

After some testing I found ou that rw load crashes
machine rather fast, while read load usually runs for several
minutes before crash. Setting udma4 or udma3 instead of udma5
doesn't help. Pity I don't have my own SATA drive to run tests
with it, ran most of the tests on PATA drive.

rw loads crashed twice on the same instruction, movl (%rdx), %eax
in fs/mpage.o, and I tracked it down to corresponding C line:

general protection fault: 0000 [1] PREEMPT
CPU 0
Modules linked in: nls_koi8_r nls_cp866 snd_pcm_oss snd_mixer_oss snd_hda_intel snd_hda_codec snd_pcm snd_timer snd soundcore
 snd_page_alloc ehci_hcd usb_storage usbcore nfsd exportfs autofs4 ip_conntrack_irc ip_conntrack_ftp ip_conntrack
Pid: 3396, comm: sync Not tainted 2.6.17.11_64 #1
RIP: 0010:[<ffffffff8018ff5b>] <ffffffff8018ff5b>{__mpage_writepage+206}
RSP: 0000:ffff810029119b08  EFLAGS: 00010287
RAX: 0000000000000000 RBX: ffff8100011174d8 RCX: ffff81007f744440
RDX: ffff010004fccb50 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff810029119c58 R08: ffff810004fccaf0 R09: ffff810029119ea8
R10: 0000000000000000 R11: ffff810001117468 R12: ffff8100011174d8
R13: 0000000000000008 R14: ffffffff801fcef1 R15: ffff81004c85e6c0
FS:  0000000000000000(0000) GS:ffffffff806b4000(0000) knlGS:00000000f7e09ba0
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 000000000806a40f CR3: 0000000041824000 CR4: 00000000000006e0
Process sync (pid: 3396, threadinfo ffff810029118000, task ffff81007d8c4b20)
Stack: ffff810029119ea8 ffff810029119d64 ffff810029119d58 ffffffff801fce1f
       0000000900000008 ffff8100458e4848 ffff8100458e4700 0000000800000035
       ffff810029119bc8 ffff81007f744440
Call Trace: <ffffffff801fce1f>{fat_get_block+0} <ffffffff801fcef1>{fat_writepage+0}
       <ffffffff80190c8c>{mpage_writepages+561} <ffffffff801fcef1>{fat_writepage+0}
       <ffffffff801fce1f>{fat_get_block+0} <ffffffff801fceda>{fat_writepages+16}
       <ffffffff8015192a>{do_writepages+40} <ffffffff8018f1b0>{__writeback_single_inode+485}
       <ffffffff8018f65e>{sync_sb_inodes+473} <ffffffff8018f7f7>{sync_inodes_sb+142}
       <ffffffff8018f8c5>{__sync_inodes+158} <ffffffff8018f956>{sync_inodes+25}
       <ffffffff8016ee0a>{do_sync+26} <ffffffff8016ee57>{sys_sync+14}
       <ffffffff8011b12e>{ia32_sysret+0}

Code: 8b 02 a8 04 74 0a 0f 0b 68 12 ae 4c 80 c2 e9 01 8b 02 a8 20
RIP <ffffffff8018ff5b>{__mpage_writepage+206} RSP <ffff810029119b08>

objdump -d:
     170:       4c 89 c2                mov    %r8,%rdx
==>     173:    8b 02                   mov    (%rdx),%eax
     175:       a8 04                   test   $0x4,%al
     177:       74 0a                   je     183 <__mpage_writepage+0xde>
     179:       0f 0b                   ud2a

mpage.s:
        movq    $0, -232(%rbp)  #, boundary_block
        movq    $0, -224(%rbp)  #, boundary_bdev
        movq    %r8, %rdx       # head, bh
.L19:
==>     movl    (%rdx), %eax    #* bh, D.16458
/*
Corresponding part of mpage.c:
        if (page_has_buffers(page)) {
                struct buffer_head *head = page_buffers(page);
                struct buffer_head *bh = head;
                /* If they're all mapped and dirty, do it */
                page_block = 0;
                do {
asm("#just before movl (%rdx), %eax");
                        BUG_ON(buffer_locked(bh));
                        if (!buffer_mapped(bh)) {
*/
        testb   $4, %al #, D.16458
        je      .L20    #,


However I'm afraid it may be not useful, because read
load tests crash in random places. Reads are done by cat >/dev/null.
A few assorted traces (written down by hand):

unable to handle kernel paging request at ffffa5007fdff6c0
RIP: free_block+140

GP at reiserfs_releasepage+103

unable to handle kernel paging request at ffff81001a7289c0
RIP: ffff81001a7289c0 (so it jumped into nirvana...)
trace: sys_read+71 ia32_sysret+0
comm: cat

NULL deref 00000011 at __generic_file_aio_read+275

Hardware info:
AMD Athlon64 socket AM2 @ 1800MHz
RAM DDRII 2 Gb
lspci:
00:00.0 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a1)
00:01.0 ISA bridge: nVidia Corporation MCP55 LPC Bridge (rev a2)
00:01.1 SMBus: nVidia Corporation MCP55 SMBus (rev a2)
00:01.2 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a2)
00:02.0 USB Controller: nVidia Corporation MCP55 USB Controller (rev a1)
00:02.1 USB Controller: nVidia Corporation MCP55 USB Controller (rev a2)
00:04.0 IDE interface: nVidia Corporation MCP55 IDE (rev a1)
00:05.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
00:05.1 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
00:06.0 PCI bridge: nVidia Corporation MCP55 PCI bridge (rev a2)
00:06.1 Audio device: nVidia Corporation MCP55 High Definition Audio (rev a2)
00:08.0 Bridge: nVidia Corporation MCP55 Ethernet (rev a2)
00:0b.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a2)
00:0c.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a2)
00:0d.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a2)
00:0e.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a2)
00:0f.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a2)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
06:00.0 VGA compatible controller: ATI Technologies Inc RV370 [Sapphire X550 Silent]
06:00.1 Display controller: ATI Technologies Inc RV370 secondary [Sapphire X550 Silent]

hdparm (switched into udma3 by hand. usually it is in udma5):
/dev/hda:
 Model=WDC WD2500JB-55GVC0, FwRev=08.02D08, SerialNo=WD-WCAL78337950
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=74
 BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 *udma3 udma4 udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:
 * signifies the current active mode

Compressed dmesg and lspci -vvvxxx attached.
--
vda

--Boundary-00=_gPnBFk2R9AlKn0Z
Content-Type: application/x-bzip2;
  name="dmesg.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="dmesg.bz2"

QlpoOTFBWSZTWYnKQkYACjr/gH2UAARe////f///3r////BgFX3Hfeeevce7a5JsAN2uuttute22
16Xe1XnkqS7Gie2KpIaMQiCqXWJRSgIVW2gZITTQI00YJqMCY0k8mmp6nqJ7UjyE9Gp6hpoaNGQ0
GRGoxNDUyZFT2mjIp4p6nlM1BgGo8oHqAAAAGhPU0QUwCaemVA0/Kg0AA9QaAAAZA0AEiIQJpoTJ
k1TyI0yPUepkaaARpkeppk9Rso0NA2oOBoNMhpo0MIGQ0MEaGmTRoBkGIAA0EiQmmk00aCYgJ6Rl
J6Yo09Qep6nqPUDyjRtIAAaOSSWXohANoS/PshLmil0I6QPD6O7llXDVlJg2LfVfhNC0N3AzZQ6+
lUiZR/USocIfZCGVjOFP16rR4VjLHFUbeDRofir+eI0Z6ZwnGmP5qJDurwR87z6crv5VGjgbCqkU
IMjSr3OVoxoIvPasu48pSW1tM8vC/3UxJJJLVhzAdSYY646btC6XOWwaAj9q2J5rhZhZyMg21sIf
Fi1LMljda32bpGgJ7NZMnY4mPhCPR8Pq+n3/pnt36bwGxQDDeM2iX6Xk6WfMDPhz2eBy6YrkQgJA
lUBOPzAhaM0+3IGb57TDqO3PD74YfIXpxg6xv4LZqUxNGnampBgJAqfiRygrcuvtneUJrl4D6+uA
/7+mch4PAZT1cLfHMOftn9HSkNttt2qS2222222jv6dh/Xkjh+CXp+NGeP9FC2r9R5PE1YMyrmGY
O3Ws1F4Q1KteR5xS0yecmvJUQpYPPgK6gLexXRVs7ziBa2dSp4wK95durX3AeA5erTLfoYIjrsjt
bTgiDDRkSFXcSFWJI31nH7F5NgPEqumHeVfS+Lre5JMqgHxHPpIE9xpa1QhRXco/g0qr1WBY+hr5
rMIkfOSUmNwagrG9EgvyZfXS+n17m1Ikdxfw3KL3cQFSDsu3oaNvbRZCDy0j1Nzulp5CR7msjYmE
vu9bRI2T5bbGDrN6/slYKenDL4KOWdxsmiehTod575Bs2iih3j9GLbdlXT1XhhujFPqADo6pC8xW
TBNjaJp1IiD0wZC68sd58htFa8j1V5/9oFRohv6FkABwvUM5PWOBxBY77Nyx6WuHt4eQ+YoBqN+a
Xr3510XgXvDKBHs3peNHPmbA3W3HgBFX8urE95ekgHU6IKJoPGr7bwi7Wl4zbqgI6o7NaYWxVPjh
XrncnVCTCsyT4VFlM9B5Q4eTclLwHdQFlr6n9c2AuObc6KZGPtw12rghHMBzKmJameNkY9Vje/HE
C1RiBbVXHceykB9YrgMU9HuqpbvxKBGYEIRukmA2r10KrZWyyBMFolqXdAuE86TEQVuheeNIVY23
7LYcZfRSkNIVVw+7l046b9wiaeyqxNvJo/Jz6lB51UjuVSPOmHsYwwYVjbgt+jOmOfSeJmjvFGCW
ihq5+BEvE38JcPB8aaDkZlnbtpmg2BvdD0hfru1r+eK5+MXgxXsXb692PmPQEvt5W2v0H4cXpufG
uhGKYQJFSxmmSjpDkq3YDgivva/Tmr6IPM4i8axHnk+7JZ/ruDsHMBGAnWnN5sQ04JsmGHziK837
+GG6BOBu4Rjqg878Org3j4yGDBcnQ6smfpKrtXsgWxNDQBDTjID+ZYhpJqRjioYwVme/TcOOVvHV
ztqQzZ11Bxe7+ie7TNlbDbXNEpPb1kcCFEKVet+Bhm83lx8x6u4DwQ40HggTN1H2MAeNio0CICTr
CEAFiECbHutK0aFKQ3/xXy5wxPRyvBttHl2OC0c/AgC6/rtBaiBEAFqzaOnNIR+sjw94i0fz4Sbx
FRXN8Y8RIGSjDWjqhj1LpEbv6Wzdkab7ImuBHRciOYwTloMpXBZCyHCt8q7JxOQWAZY6BxZW0gc+
+2fvB7fUM6HM6yXv8hAu48WMLYmzESIBSogKh8ezl0OfJ8VuxPPuDOGiB4eTy1zZWQwRL+Xjk3R/
vNKPhKrLpToZ8Yxj8EbukOcgdYkx12UmSpaet7tIK3t1BqZGxYv1pZUl1tO6c59+EXsw9XGl6aAc
kTyAXF5zulZR54OncdmzKNfYBWFBCoT94vISD6+kXXPfe4p4Hltzn8+CnnTAxZAwnpuhI8tNTOX3
+cGnEKBg4ZY+MU82kC4mDB+7/AiFmqr0S05XyatIy5UiqnsFe62l7GhIJ5QHvts1vbtrEi8EUmr9
ZormVUJJAoqd1HDda1/DJLkf6bgAVykMJZ43fPuoiML5uqSNMbBMfBGgsxQ1tQ9l2xL6mBeMCtuN
qsOjVysVHTJ6dVJTFOwPGn+f0cIyXKyA01NMTnGBgRMjQz3pailVBWtFFFOMnvrRpGeXj8uo33iF
qlOHuKHZ3eBlv0HtEdjL+WxvRCqm2L4M+LNzUKcAE23DI1Ec6xfy+1LIpNpDUsB0ndr14NSm4I6U
RShYi5uhaIiLSN8SWjbCjRa7M+h/k9/XSqOHZX0aTGrryJJh2yn1ogh5cypMieAeSCjXwRipvyM5
rEFsPnJSWLbUbISWpNCbS8jAkhnQdBllMrqJViKpV856y1rVuqU0byEjvpd568vJBZgoN3IBhnGN
8Gn2TRJOvtSK7YZwc9bogaELVYjftp1fFzSDNlkF5CFQV6cIUWhCtQNCa8/TBdPGvGSlo695wK5X
eI90HXxupt8evc1PrfEw1ixdyIMuKwwGxKMUAmtYQq0ExDWZxouKOgoeRnmAY2B5jAvos+C2Co1l
xI3UtJvrWVVNZQyVhmyaQc+2HMguKK6uuROt9bx5DvCp3jJs3FFjL8SpF7ysjWs4QyjJVQkZSQ2c
rVzA7Ud+lnf3ummFNMiFuda9C9VbII9xAjW3Y9olmsV5eUbU1FL5TqcTC5Ons3oPo1xzWSmShiEB
pFNWsWcTTN8WGlYAubhGBEvZJKosOc442um9F135IIvxauTAs46MRnOIWq+DOKsVGzZVC2A3g7xB
yWZuOrVG8Xa+9JkCfeF2yijSH0Qs20DF2OBHP0ABhcLc2Vik3QRsdtNKg78iFB6EOHzHvwcZKgYC
A8Pdbstg9HZApZeUrCwqRBUGSN3E4d1nbGgpRQe+S9vYsOWDiBJLAhHf2RcAQK5JQsjgQ9Jps6Ai
l0PkhqHjkzabKvGVzMLnOwUu9dw41EAWzlKU9RAEftGwV1164Vyuu2AZS6AMMs9MZDvhSj2tqe/t
9CSML5IVYok3YBZAx9fbROwS+2icj46KhkCD67x/h3fIv/cezHH1e9BAHk82XH5DM7kSgBrQ8mDT
YeMHuf119w19SEkyYcx0YSZtv+ITYzEp8T5TbBszAZLfV8l3r/EtoNY82/JGLOzV8v7YiM8ELFh9
bbbbb202Y68UrF420vviDoD6TqhFn1evz7EvXZa0PJfkOQpQkAWvppuCEOEIDKrWnTnsuWIVCo02
MYWn0yv+GeljM11tfKLgsX4H03eM+ko0ROvdObgwbKyfc93RWbxo8vUEbkPwncHFLj0CYaHvvuR5
hYmAz54JWiwuq9F/EaN/5kB0Ixw08kmawZfvOgpF5ZMPm9/hoJ9VYZNiDoD2YQ9iTIqAENjdIKST
NEwJbYmIbE2hA2NA2Nso0KVWeJq7f3FigFWBe+YlHZIowDikG1V4lP9lwXg0xoA3G2PZ7R7j3R5J
ys17mNiOBvsHvFIM/FRJEoFemU9p6nuojKaCMDwaq8gTfeUlm7aKCTJgoTUoTYRcXAsh805xHvVr
XPRnMmjHXs9O4ounYbQmjFokSCivTkj0QFBvzqfkGl4DW3nUU1POA6SqJiWkVQwrw8CDy7oLzfLl
lvjeVRg5XlwINFUuyBI5VYwQDSIqHGv40og2JYR8Dp8EPTJGB36pWG3fxEB2hzLjkkPbUvPRyR5A
7kpMqrgxEA9Tml22khoB/MxE8AyYiFL4jcBC7hB493SlMDxOlLv08De80WS5bV3Y46A5Bz4TNLbQ
cgZkjYiRt7qGf5mKIKAoFgjw6fb1B0dfSlJUNiDbhBodLXAlKzNdbEtpsMtoTOIXR1vfnviVt1kf
t57zZv6voQd3mjZSAgF6JyETHe+qupS0Gg29GmLwxydzEhzrUUo/5yrIuSktB3VD50v/JTD2+/43
huJExwfS2N/oQ/sPqDkud8UQ2vO/T5vQ+9aKjtSS5hAlcwRCIx2Ja6Jaz5kNtAocQZctDBXC4Bsu
PrH8RkHRkvoLjdItRr6VE/k/RVToZucGLgvtCLw20RjOLt9ndx3GCe9DVcsIBlln7C5JUp9UEn0n
l3roMlhndXGgUPuyzVxU4NLW1msFVJZJWa8wHNEo1XbWCedpQj17s8TUG6F57JBYOg6cyB/f4B7e
rBEmXNQn3kkJoPqfTMWfJ+tP2kMwaAtZnSUk42CO02G8siRUDBfSM0JiDvSJZNahtwm2TVOCs1cI
quygSzBkcitp2RBdOc3BGcIh/jN9gs6IerZFWDDRCK5WkGgZMMQqphMIDU/YQNN7GlDQcwyiWc4h
g0VahpQ1DhOCISgHMQADaXAw4LFqncWwRyBB5JVwtrVFgt63u8YwbMk1FovtD30nQRac1vIBHJlk
UGKOMQCWHQEzroahBIdaYiEXhWU18wcUNUboOgDC52CLWqPitpelEvLblUVBUoiwxZhASjV7caWu
y151tfYuKK6mAxTj1mBQNvduOc0TkXFBqFjlviLtJ0Jtu0Jf0Zk0j8WuG/UgvsFFG9TM5bIG6mmU
qawTYv8EUCqwUBOFqFLmit4VbiJXTEQ0lSlta2FQ0mgVjTyFBTgba47rgW1GBlCAkiFKqg1g/ovn
omLf7eK+d7N6xOqQr0F92S4RRL5sqFXhGtV844JhwdJTk0iEx1FXFAWBSGcASlozX9z21wExAZR9
jQMyVL0HRmc3fWcIho6BqOaJZs3CPbaKrt8XHCuRu37NjZxM7meF41vLxF/cTfcYh1wCJITzr3lt
95oPj9zhSCeyPPN3lkg7dS3ov9RURPi/L5RtlE4O5B+uZf8/Rs6g0H3WiYzsYm3Tuclc0uf0QtgZ
+DjoqukGeVgJsBDZ2eLhamfcFAMYFIuayE7XbUBpuYXdsuYXxgX1qGYeJtbDzAmEjWSuGDBUYtjA
bSbFwTbY7CXytFho89LqXyqqiMF89aUsFifGTU18+CvR0Hd19mvfisuvxoBtY5OdRwaoLhu9Th3l
Eh7aClKnRmbVRU2Bu6uvZQ+FztRccbA2JRw4dJfgIMkXO10q7pxZnT4ych4TFKMDucvYbb5r34QW
AwcUVKqtLD+TMbS86BURIOg81BUVFroFi8xBMTYwZUnwy3dVAYMGutbJomI5iF5aCRrOtFK8kBTe
clR7pFGPkjaEgOMG1pG5LBG//uKDl0eVhePteKBfD+EBCk933qSF1veJK07baivpeUwj2c90lVu6
Ahewm2mdlyJU1hOZKNFEqasS8thIjz4e5jL44aOIBDKjAC9Ylm05UJ+RVDU5Hb5lFb3AZ9rB4ugT
YLQFHqiOMBLBADryV550pmM5vMzjffpOdpI479IW5K0DxZRkeriHyMDVr4+BIxDZAg3hwC8JC2cg
GgU4UlHCwbALCh1QyaqYDwgy9kpgqOWvvmhJptcBNoC/iUF91+1WaVgqgzV9giIIUMmU5EFkMTGW
UD2aX0CgCCqLRL9RxsTA6E0AVuxZuw0jq+saKdwWFZSayaIHfgxlkXA0ANTxKJXId1BdyOYj6mXW
iKthdKgnPvnMYbQ8cKExcXejqV/BwuW8Rcoww99rssEY+rSQEm0u9vWXjQsrQ2jLZCVUfcX1wF+c
FrsJJspbY8fyZwnmWKFlrsm/ALxy618ZLtFuDI4h5QoloWeOC0JrvdumDcWajdttDXKA810dCK60
sZ+3J459wiaVRySe8T6r0xBmMPac9XfrGyOrAs1qlH9vD9JQnhh6n2YEU6iFHVKfhoDaouNRVQS0
KZLfdCX0WzqgDWh47BYmSxSDmzNSwYMbYx3RDGNDaSbDTNQAuo9I5qZfIR2G3stgM4jCLrIchEEk
7LHECbEnTQd5cIL74WT3PvQzqU+LnM6NIF7Usha/K22LFLgtd4XkBpD2DTahI2CJhQy7UOyNuS16
iiKz+2wloWGaERAvUMQEPgNCmpK9iGmSVbCAgRjNtHUHhnSkQF15mgw8h/UCGkO9rtTuL57Va67/
UL2SdKy0QOUJY2II2ynhpLlg0Eu9bbp4VlykLFIVg3B14wFZBjcbeqyJWT1ZCReEIK6O9IfmYWLu
kNmzyqjbTTT1os02mnvvFO6CM4k0UKZggzGjxdWClVS1CeCAlwRh8U9jPZKjtF+UteZZeh8FRHbL
vmRioJDaWd6wKStl1zpFrMaKXYX2q5sYPBbA8cL5GAWKj0ALIDE6hzGL4BQWE7XyWHEtmOLSLAVE
DdoQEpIN4jnXBFgwfTIbWi/fXhYzSWlaM8qzSnDmglESDUmDbDJ4XiLhhsRuvImyL4zNcCGYyCl6
tVaxja4okZBxYvAeLC8VZRxTPi48subwQb6gIX+4uZAwQ0wfegYQFO4e1QQIzCQMDiSLLhnAt4po
WRmXJHpNPUMvMUmeq/TmQyilBYJEZCiiBgiI9ckemYTYgcuiFIYCYbCDnh2MG0Jt/lQhehoGQW9N
MuhEQdD4J80E6FJrSr6QSRNdPNisI7g3gs1/8XckU4UJCJykJGA=

--Boundary-00=_gPnBFk2R9AlKn0Z
Content-Type: application/x-bzip2;
  name="lspci-vvvxxx.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="lspci-vvvxxx.bz2"

QlpoOTFBWSZTWZ94DgUAJlffgGw0SG//9z/v/8o/79/wYBf++19AU5MF7UgAUapddaacc1R7Mq9T
yMNEIyU0UJdvdcDQb0y41AXo7gaUFKowio1NKn6k9PU8qDanqbR5FHpAepoMamgBoaPUAJEICCJF
PFDRoA0GgZGgGRoANBw00yMRhNMBDAJphGCYmQ0yNDQCTUSGpqeiJqHqYTQAAAGgAAAAmqUgJiZC
ZGISaeptGhJ6jZTZDIhpo2k8SCJIQIAImVNhMpgExAANGIGjTR2E/AypuqW6WSLBlCwYnQTsrxV0
3BMxwk/cjQxhssKAjRVWSuXbkk0+vTH36rITgluWDJAvHdHDCvAxxjIpfDdHcqUDV1TpRclqqBBO
6pZAPsjPMQUWDA7KiymByXfFFqQpAOxgnKI1Kj/SCVATEMe3TPGVshbRCHOgSxNYIdIiZwzIISFo
AQg5wX0CcUWkOZ50PVLwfA+br9/3/fi4x+JA1RPCCcRiKfb3ChL3pe0CQkWoC4gl4J2iF4eMEPRE
E3REPGKrnDJIpIkgDtEJJFT7oaRQ8oID5RGRBeECETOAZQDKK1B1gOUENM6QM4qLis2G7JJxBmrC
aMUimwwPEhC0MJFHYgg7oKCYxQIGcQaCCpjFALuiAlQ2iBaCgGkU12pQiRE0wVzytMEsrJa2FWzA
ZkqsyasAbcKrbljC1WU3YjVlK34D+0QDOIhuJqkCoIvEgBlBVNYgYiCBeCrzBQJIQWEgpDeUmUha
Ga0QuGrJFkChFQ3qUgCgWzA5E6rqDEwtFSUzRgFoSGzCbMWBlgbpOSAobJIpOtJMMw4QFOCtmwWR
YKHTFS2QwyFcULKEEBYDBYWrCmIw1SonCG91bhgFRUuQeEE1OFCZQQNopuIl4DnHNrLSph0xDcPG
t2oTtAmymq8wlxmEBQwm6ChMDM5hR2JYMDVIMYBrvWzBUzsPD52y5ZBV9WvFhsKbaV4mQYiii05Q
Qq6nRtLZFhRGcJNUJbTNBC3saTrB0C5QZZszhqGaKYshwJo1to0mxgltp1UnAVCDLXTVmjhieb5o
IYWa2mLWKkRTBEsbBYYkcM21ZgtJNAeWgzvHO54mC1xLLswNtK7WrELV77pLq8CWkkrI1wFIYufM
zOdUFaBxh6TkqISi3TLWMPbZg055IFA2FxmnMWzVNJss0NhDlok8zN2cSXRemdxDLjtaELDtUJjN
PrquiguMz3ApYEs27sp8R05fcYu3rJRonmd48d9eeeDrRLCNmrTRZHh9SXaMs7vAWxjVIlBqDAw1
iDB5iHKGrlws7UqHy1soUJ+CA2MWHCHDj7IHOrGLBdHTKYSMOjFyfHi6J0/G51VnlrbXljF+9wU0
FwZEEomB879ESZ0jMiiYeHJIIyWOcMBSmaiUb78ueTLqbvHUysRiKJhMfm/4MWtERduyEcnHVQdv
acuY8g8ZI8DpJNenNiQu03zaDF5vDp2BkccV6O1uB12ipFyD3PGSKPdD6kqvVJHcMatpRl0x2CZ2
v3b0aRK4VYhtM4DzG9A60F8Yth74iTgJXrZakvPZqTOVitkHLWNIR6I13ZIyIbBOEr5H34siEK7l
62hqQtNYA81IBqy7l+09Uz24vmQ6tCSPXv2I3Ryzl9PrEbYdNBkpGDXBW7Vxxmsenr6LPWonu8bS
fkQC9iSO6ZHpgVwwndhCNn8+ly8GJGDkqfAp+nt/jp9eZ9dl5qtw3jqWKrng4jB9Mv8+4Og47+kr
y/emoJuirbPLLPdvFDK5lsBXU9SQ8RDIbWenIcTmnfgGJJnGFYsVBQGRyN6mgmoUpWBouOw91YK2
VzNhYrMFpPG3D8L+e2W7u5/ruVxRnd2PdLQ1MoBCLBHwPVYGymhjTmjV0XQ6jYx7aT2+9NFU8QoL
7GKH1TSYEzT5YW8fkKYLBBGT10Mf3KJEkc+aUlVDkzrTZ7mYnJDhEgHuhWl0ITrv+Ldf4bF7PpHU
GtU89FPMIvrsPTlOOiGflZOsMi5ixR7FrLzL1t145LKHdM8wTMQKUB967D30L7WC5xjqUtWgrk+C
q8sCyGg+B39+yJCzpe51KPEqJfESp+qyHyBlr6mtauLl5KgWYoKKxJM2fGd291qnMwZ05dU+dyPI
yeu0NarxllXrGmk8q+GZapxybzJ0q4j4BchiP2T9lmWM90/FfMoJ5SpINRm5T6lCyfgpdPt6dhM7
D3U6S+Cr/NO6XfVwq2S5Ve4+4thrD3Y+j0/HrmMxi+MvQB6FgEWCQYMhE6Cdi8ld2WmhWCy0zHpr
mLULKTlL00+A6S8BfmOI/pTfOqLQvJeSbIuZdYvy+mZFxR6y3z8RexeZ2HRdpYHm9YmVXzKUUi0H
yDoEoprMcbfH5bL82npylTdtti1TNTAnrBTeFKD8WSTVPng/0S7hUxAFKiO0RVzgKF4BBgptMzGT
IprsEbMQ4YiNMotME6YRPfkRW3ATZZZYFmSVOWdAgVBUBxFBxMoIg1ACQoZlRmKouqsWYpXPKMyD
XABMoppFhBGRR5UFCCawSorHetEktAEZhqDqklIckBSAsBogA/TRRIboIboDZIyKqYiWiS6gLsgI
w6ca3lgawQDCTDJMiAYScmk4QO9PfHEEl7QZCS0nMLrhlILoYWay0rsR27sV+5xWhiswli6Ezto4
YRFYqJhA2IlgtdOFhlO7SbKaS5ZsybaUcJKYKA7NEWkDRh3h5s2xQLFNWkqDFmoymZugOEJhWQBH
aiUrUINDDk7tiCAL1oUw5IGsNKkz+Tqr9ZQlK/YrXMhsu2iV0o7R3BAkFek59u2OmETSHOI9oppB
O0EsutEjsQiQNYacwO62GliHUSKDZUUIrtuzsF1FAAPrxY3b88zGaKOg5j9TEAK6v48b4PCOBERz
/wVfC0UkblGCoYMGJhofGuD/MFOA0t8hVDmc2+aQ8KwouDBmFgRsQBhakGiilAoo0LImcFOoML7u
Njx5C70KDo9uT5viDzTwX0AHsEuhLtAe0AtnTzbnhgZ57OxSZlX7meueIrjmMazXWuUYGC2RG6zb
XFIvzmdbhZ3cO97s8a7geG7eoq/Grb8TN0qMztDvgdzKPFkc46v4o5I5v0F84KvF9bEa2cnkDwZ1
0gOM2R13xkI7cpU5aphONk361E5EqHEQ6xesQkAoZUZBahW4e6uKiSD142EmlLXGl7SxF6RCjtRe
W7QoJBdYlROYROsALZ2wqlO2qLFnFBnt4uaw3SzpgKulWRBM3UloLzhWe+eCCF6E6mCqNUUnGc5n
YKKfNGiIEe4KPgs3+hUvZALxfCCtkgFJB8Qi2eaUlQQndSG5Awohzg0KOGcALfld2MONJaF92lBO
OWOhNrhhvmiTS94S3e1rnc7llbC9kaIgb1KOQp5d1ShqIm6P9e4c1LDeJ8oIWQgE57hI2MSv5gRT
RVQizVOB0VVYtfHLlmaL04qlBwUg/AQXmrBIrv3BodvPv4l7yAed65+9jJJUG8OpNIO1r4mhiiR2
RK9G1OgcAC+enToqehMlNkiLSEUWvKKKD3LQ2wfKCVAiuDlgeB94mbMkwRccreSBkYeEDZS5O/JU
4oaDskw/wQPwLBYwRTgcpu5dKV5QxAPVFqFoGqmgrwVNkpB6z2hQUgmRv6bKkohC6ZkK75I9OVDX
hVWlYbYyD3pOCprYRO6QDLEs7JYedI80c+kWdeqICPZJ4RpECvMeT02z24sl1mpP7AxFh4HHcYDw
CRngokvz1pYTqqdQMhXE58e6depwTINORpx6+Uv0vvQ7O3ly5NfYLVqm7JfSq0RHdLrL7ZagkMQ0
fCSEiQY33H0/Sc1VVTr9iSJVy95T5UbFaxvNCkCjWi5JEhN4kBFprAmOPAgJ0RAzTZXRBoZJJJJJ
M1aEJyQ6lSgI7S1Xb+KkkMx2OcIVIKie2F+CNX9pZW2sVbax30nXSaWybbJoL5R+NrVaha4n2DRN
BZJ0n8x8gtQ+YYv6VZLDFlWSxK+utBf/CyFwrKr/StKHb2w6CxFrFsl9g9sLTpi1iyk0H+off3a5
/2vVYcBumuS/IWK+6bLRNdWR83uh9EdlS+ECI/y3wof9qm8pAsHUFdtVV6Hyi0I6pktYsqvULJsX
nfbRae787VWvuVe/dHQWUNuJVxmN9WSwleOjjV3ErS2SflNZqvbXmLQ1iyLcMuloNGDKegWC9hdU
VoLE2a7rFuFpbHsypfmLnaQ3c1ToQPEqVKgGU6DhkT/KeyDkTl00iog47Cso1E9zJtPdKglaJPQh
VQ2USa9J4AshOhNok09OscPAcc+De3E9UhukX7Jlsoh5oNSBKltWYr2KkwQnIAlwib4kHSKO1Ayo
P0691eR7tVXKrZLaPtGF8a3DSXtH41s5cNf7UV9V0L2RPi5TJ2C/8pN8naDpEuHkQLhuuEKlLRQ3
Vp7/dncTOT1OiZbL1wt209tuqt/T7FT2F2RLQkUIZijvE+lT22UT8R+BRDNQKF575Dl0ony0+74b
lQMi1ieRu758xm9G+eLdVSCGQjv1Mi6+0YvRZ2xwcq+TVXmq1nF94snaN+hlkrjRU5+RnXXynOXx
hO03CwemNRC1wPyK6dC5q4ZfpngLFbm88S1RfvmJbe6h8U871fIW+vD+xkc8nZmenP7m6LwtmF4a
N8uVp4fP6tr6DXPAwjl3p0z6t/iLz8vDbXYLtsMuI9MvOeBNk8Ju709s94v1P4ts1nGXKuMtN/Ve
Sr0fD90nhK6xw+gXFMF2DE+dZmLLULBwHXeesWhpf5GqTVXo0j2ZF8Q/XcqyJ0nCq5S49x7oHkJh
A8Re4XR+OHsIleqY9VwsYr34BLk7EyZAgmv51YLQxkfjm9DiCbwqVRM6MofH6YtBuhlU9YB60ywp
7lT3YU0IBJIF6ej9ype0AT58uCBmjdQetCVFt/pPlC48eETyyip8wOq7xICEV7WMCMxIVlGriAca
xDSTCHMrgqb7kQKaBrWNZL+SrhbInpp/180vVl3xN8/2ulXwOc+WV8xrF1eTZdfOnyjI0laYW+19
vv5pcrlE8+k6uEq1jWnj51WC2TyH7ht9M9G0cpXnimRdQ2y1eu0LvNIn2DjtlvjvrVSvaMF2rdN4
1DDS0JtJaLMZK+hNDSNarK+4DqrSnkJgdFP2GA1VLiGSxbdjK9yn4J1uMvaL/CdI4XGqt7kjgVac
a5VaaF2F/Kd81U9DKmgwvFptQ0kuFwspdcgAhDCpoqeKB4jqmELVqJWDzJ8dd46cqv4DinbU5CyJ
/Xq8BfdyvVVgvi4qs1Dfche21ZVwWk/rT66vvrJbTcWJXULJgsrSFnl+/Z2C8r0ToXUPfoslyVcG
x/740Zhk2zrnBbaesa6cyrVXZVsVe6ByVugFgUNCK8RCFRBgNy53gaDReMZLSWuK9w2RNId2yWcU
1zgN+o+omzVsk4C41lJ4pkm6docWNlTaBSDorqJqJFMKIZDZORWwbqTLdLyVNqr5y1TnVwtyagZK
lCOYugQQ6fxDLMUZIC9vYPE5hdnUVahwluit84zlHG6S/SW+V39Y9Po9MVpDSreN6ryrl2jVK2Uc
zvHfOXXJr5TvVarFlM5i+PuT4xc5B/xdyRThQkJ94DgU

--Boundary-00=_gPnBFk2R9AlKn0Z--
