Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVAaNuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVAaNuv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 08:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVAaNuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 08:50:51 -0500
Received: from 213-35-212-203-dsl.trt.estpak.ee ([213.35.212.203]:29082 "EHLO
	horizon.office") by vger.kernel.org with ESMTP id S261195AbVAaNuL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 08:50:11 -0500
Message-ID: <41FE378F.4050104@vision.ee>
Date: Mon, 31 Jan 2005 15:50:07 +0200
From: Martin Roos <martin@vision.ee>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.9-rc4 crashes on massive memory allocation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

as far as i can analyze, kernel tries to allocate memory but somehow fails to do it, but as opposed to a ENOMEM or some
message alike, a crash follows.

to describe to situation more clearly, i was wise enough to open a webpage with tons of images in my browser, and the browser
started to grab enormous amounts of memory to draw them in. the kernel swapping element seemed to go berserk and after
listening to the harddrive crying out loud for a mere minute, the system freezed and stopped to respond (yes, even the
sysrequests didn't respond anymore).

this is not the first time this has happened :


Part I

machine && kernel information :

kasutaja@martin:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 398.812
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 786.43

kasutaja@martin:~$ cat /proc/modules
nvidia 3460128 12 - Live 0xc8c8e000
snd_pcm_oss 45608 0 - Live 0xc88c8000
snd_mixer_oss 16160 1 snd_pcm_oss, Live 0xc889d000
snd_cmipci 25124 0 - Live 0xc8895000
snd_pcm 79136 2 snd_pcm_oss,snd_cmipci, Live 0xc88a4000
snd_page_alloc 7272 1 snd_pcm, Live 0xc886e000
snd_opl3_lib 7776 1 snd_cmipci, Live 0xc886b000
snd_timer 19168 2 snd_pcm,snd_opl3_lib, Live 0xc8886000
snd_hwdep 6880 1 snd_opl3_lib, Live 0xc884d000
snd_mpu401_uart 5440 1 snd_cmipci, Live 0xc883a000
snd_rawmidi 18400 1 snd_mpu401_uart, Live 0xc8872000
snd_seq_device 6212 2 snd_opl3_lib,snd_rawmidi, Live 0xc8837000
snd 43844 10 snd_pcm_oss,snd_mixer_oss,snd_cmipci,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xc887a000
soundcore 6752 1 snd, Live 0xc8834000
usbhid 22208 0 - Live 0xc8846000
uhci_hcd 28040 0 - Live 0xc883e000
usbcore 97812 4 usbhid,uhci_hcd, Live 0xc8852000
msdos 6816 0 - Live 0xc8831000
msr 2404 0 - Live 0xc8829000
cpuid 2116 0 - Live 0xc882b000

kasutaja@martin:~$ uname -a
Linux martin 2.6.9-rc4 #1 Tue Oct 12 16:18:24 EEST 2004 i686 GNU/Linux

kasutaja@martin:~$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/3.2.3/specs
Configured with: ../src/configure -v --enable-languages=c,c++,java,f77,objc,ada --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-gxx-include-dir=/usr/include/c++/3.2 
--enable-shared --with-system-zlib --enable-nls --without-included-gettext --enable-__cxa_atexit --enable-clocale=gnu --enable-java-gc=boehm --enable-objc-gc i386-linux
Thread model: posix
gcc version 3.2.3 20030415 (Debian prerelease)

kasutaja@martin:~$ cat /proc/meminfo
MemTotal:       126688 kB
MemFree:         32960 kB
Buffers:          1432 kB
Cached:          30368 kB
SwapCached:          0 kB
Active:          65220 kB
Inactive:        16984 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126688 kB
LowFree:         32960 kB
SwapTotal:      157208 kB
SwapFree:       157208 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:          57036 kB
Slab:             5400 kB
Committed_AS:    63884 kB
PageTables:        604 kB
VmallocTotal:   909236 kB
VmallocUsed:     21680 kB
VmallocChunk:   884656 kB

kasutaja@martin:~$ lspci
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: nVidia Corporation NV11DDR [GeForce2 MX 100 DDR/200 DDR] (rev b2)

kasutaja@martin:~$ lsmod
Module                  Size  Used by
nvidia               3460128  12
snd_pcm_oss            45608  0
snd_mixer_oss          16160  1 snd_pcm_oss
snd_cmipci             25124  0
snd_pcm                79136  2 snd_pcm_oss,snd_cmipci
snd_page_alloc          7272  1 snd_pcm
snd_opl3_lib            7776  1 snd_cmipci
snd_timer              19168  2 snd_pcm,snd_opl3_lib
snd_hwdep               6880  1 snd_opl3_lib
snd_mpu401_uart         5440  1 snd_cmipci
snd_rawmidi            18400  1 snd_mpu401_uart
snd_seq_device          6212  2 snd_opl3_lib,snd_rawmidi
snd                    43844  10 snd_pcm_oss,snd_mixer_oss,snd_cmipci,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               6752  1 snd
usbhid                 22208  0
uhci_hcd               28040  0
usbcore                97812  4 usbhid,uhci_hcd
msdos                   6816  0
msr                     2404  0
cpuid                   2116  0


kasutaja@martin:~$ cat /proc/version
Linux version 2.6.9-rc4 (root@martin) (gcc version 3.2.3 20030415 (Debian prerelease)) #1 Tue Oct 12 16:18:24 EEST 2004


Part II
here are the details from the kernel log,
until the first line here, everything was as it normally is (no failures or error messages whatsoever)

Jan 31 15:32:00 martin kernel: swapper: page allocation failure. order:0, mode:0x20
Jan 31 15:32:01 martin kernel:  [__alloc_pages+442/832] __alloc_pages+0x1ba/0x340
Jan 31 15:32:01 martin kernel:  [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
Jan 31 15:32:01 martin kernel:  [kmem_getpages+25/192] kmem_getpages+0x19/0xc0
Jan 31 15:32:01 martin kernel:  [cache_grow+142/272] cache_grow+0x8e/0x110
Jan 31 15:32:01 martin kernel:  [cache_alloc_refill+179/480] cache_alloc_refill+0xb3/0x1e0
Jan 31 15:32:02 martin kernel:  [ip_rcv+767/1024] ip_rcv+0x2ff/0x400
Jan 31 15:32:02 martin kernel:  [__kmalloc+97/112] __kmalloc+0x61/0x70
Jan 31 15:32:02 martin kernel:  [alloc_skb+65/240] alloc_skb+0x41/0xf0
Jan 31 15:32:02 martin kernel:  [rtl8139_rx+248/816] rtl8139_rx+0xf8/0x330
Jan 31 15:32:02 martin kernel:  [pg0+143574195/1069769728] rm_isr+0x13/0x30 [nvidia]
Jan 31 15:32:02 martin kernel:  [rtl8139_poll+66/208] rtl8139_poll+0x42/0xd0
Jan 31 15:32:02 martin kernel:  [net_rx_action+97/224] net_rx_action+0x61/0xe0
Jan 31 15:32:02 martin kernel:  [__do_softirq+124/144] __do_softirq+0x7c/0x90
Jan 31 15:32:02 martin kernel:  [do_softirq+39/48] do_softirq+0x27/0x30
Jan 31 15:32:02 martin kernel:  [do_IRQ+198/224] do_IRQ+0xc6/0xe0
Jan 31 15:32:02 martin kernel:  [default_idle+0/64] default_idle+0x0/0x40
Jan 31 15:32:02 martin kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 31 15:32:02 martin kernel:  [default_idle+0/64] default_idle+0x0/0x40
Jan 31 15:32:02 martin kernel:  [default_idle+36/64] default_idle+0x24/0x40
Jan 31 15:32:02 martin kernel:  [cpu_idle+48/64] cpu_idle+0x30/0x40
Jan 31 15:32:02 martin kernel:  [start_kernel+298/336] start_kernel+0x12a/0x150
Jan 31 15:32:02 martin kernel:  [unknown_bootoption+0/416] unknown_bootoption+0x0/0x1a0
Jan 31 15:32:02 martin kernel: eth0: Memory squeeze, dropping packet.
Jan 31 15:32:02 martin kernel: swapper: page allocation failure. order:0, mode:0x20
Jan 31 15:32:02 martin kernel:  [__alloc_pages+442/832] __alloc_pages+0x1ba/0x340
Jan 31 15:32:02 martin kernel:  [ide_dma_intr+0/176] ide_dma_intr+0x0/0xb0
Jan 31 15:32:02 martin kernel:  [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
Jan 31 15:32:02 martin kernel:  [kmem_getpages+25/192] kmem_getpages+0x19/0xc0
Jan 31 15:32:02 martin kernel:  [cache_grow+142/272] cache_grow+0x8e/0x110
Jan 31 15:32:02 martin kernel:  [cache_alloc_refill+179/480] cache_alloc_refill+0xb3/0x1e0
Jan 31 15:32:02 martin kernel:  [call_console_drivers+144/288] call_console_drivers+0x90/0x120
Jan 31 15:32:02 martin kernel:  [__kmalloc+97/112] __kmalloc+0x61/0x70
Jan 31 15:32:02 martin kernel:  [alloc_skb+65/240] alloc_skb+0x41/0xf0
Jan 31 15:32:02 martin kernel:  [rtl8139_rx+248/816] rtl8139_rx+0xf8/0x330
Jan 31 15:32:02 martin kernel:  [pg0+143574195/1069769728] rm_isr+0x13/0x30 [nvidia]
Jan 31 15:32:02 martin kernel:  [rtl8139_poll+66/208] rtl8139_poll+0x42/0xd0
Jan 31 15:32:02 martin kernel:  [net_rx_action+97/224] net_rx_action+0x61/0xe0
Jan 31 15:32:02 martin kernel:  [__do_softirq+124/144] __do_softirq+0x7c/0x90
Jan 31 15:32:02 martin kernel:  [do_softirq+39/48] do_softirq+0x27/0x30
Jan 31 15:32:02 martin kernel:  [do_IRQ+198/224] do_IRQ+0xc6/0xe0
Jan 31 15:32:02 martin kernel:  [default_idle+0/64] default_idle+0x0/0x40
Jan 31 15:32:02 martin kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 31 15:32:02 martin kernel:  [default_idle+0/64] default_idle+0x0/0x40
Jan 31 15:32:02 martin kernel:  [default_idle+36/64] default_idle+0x24/0x40
Jan 31 15:32:02 martin kernel:  [cpu_idle+48/64] cpu_idle+0x30/0x40
Jan 31 15:32:02 martin kernel:  [start_kernel+298/336] start_kernel+0x12a/0x150
Jan 31 15:32:02 martin kernel:  [unknown_bootoption+0/416] unknown_bootoption+0x0/0x1a0
Jan 31 15:32:02 martin kernel: eth0: Memory squeeze, dropping packet.
Jan 31 15:32:02 martin kernel: swapper: page allocation failure. order:0, mode:0x20
Jan 31 15:32:02 martin kernel:  [__alloc_pages+442/832] __alloc_pages+0x1ba/0x340
Jan 31 15:32:02 martin kernel:  [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
Jan 31 15:32:02 martin kernel:  [kmem_getpages+25/192] kmem_getpages+0x19/0xc0
Jan 31 15:32:02 martin kernel:  [cache_grow+142/272] cache_grow+0x8e/0x110
Jan 31 15:32:02 martin kernel:  [cache_alloc_refill+179/480] cache_alloc_refill+0xb3/0x1e0
Jan 31 15:32:02 martin kernel:  [call_console_drivers+144/288] call_console_drivers+0x90/0x120
Jan 31 15:32:02 martin kernel:  [__kmalloc+97/112] __kmalloc+0x61/0x70
Jan 31 15:32:02 martin kernel:  [alloc_skb+65/240] alloc_skb+0x41/0xf0
Jan 31 15:32:02 martin kernel:  [rtl8139_rx+248/816] rtl8139_rx+0xf8/0x330
Jan 31 15:32:02 martin kernel:  [pg0+143574195/1069769728] rm_isr+0x13/0x30 [nvidia]
Jan 31 15:32:02 martin kernel:  [rtl8139_poll+66/208] rtl8139_poll+0x42/0xd0
Jan 31 15:32:02 martin kernel:  [net_rx_action+97/224] net_rx_action+0x61/0xe0
Jan 31 15:32:02 martin kernel:  [__do_softirq+124/144] __do_softirq+0x7c/0x90
Jan 31 15:32:02 martin kernel:  [do_softirq+39/48] do_softirq+0x27/0x30
Jan 31 15:32:02 martin kernel:  [do_IRQ+198/224] do_IRQ+0xc6/0xe0
Jan 31 15:32:02 martin kernel:  [default_idle+0/64] default_idle+0x0/0x40
Jan 31 15:32:02 martin kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 31 15:32:02 martin kernel:  [default_idle+0/64] default_idle+0x0/0x40
Jan 31 15:32:02 martin kernel:  [default_idle+36/64] default_idle+0x24/0x40
Jan 31 15:32:02 martin kernel:  [cpu_idle+48/64] cpu_idle+0x30/0x40
Jan 31 15:32:02 martin kernel:  [start_kernel+298/336] start_kernel+0x12a/0x150
Jan 31 15:32:02 martin kernel:  [unknown_bootoption+0/416] unknown_bootoption+0x0/0x1a0
Jan 31 15:32:02 martin kernel: eth0: Memory squeeze, dropping packet.
Jan 31 15:32:02 martin kernel: swapper: page allocation failure. order:0, mode:0x20
Jan 31 15:32:02 martin kernel:  [__alloc_pages+442/832] __alloc_pages+0x1ba/0x340
Jan 31 15:32:02 martin kernel:  [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
Jan 31 15:32:02 martin kernel:  [kmem_getpages+25/192] kmem_getpages+0x19/0xc0
Jan 31 15:32:02 martin kernel:  [cache_grow+142/272] cache_grow+0x8e/0x110
Jan 31 15:32:02 martin kernel:  [cache_alloc_refill+179/480] cache_alloc_refill+0xb3/0x1e0
Jan 31 15:32:02 martin kernel:  [call_console_drivers+144/288] call_console_drivers+0x90/0x120
Jan 31 15:32:02 martin kernel:  [__kmalloc+97/112] __kmalloc+0x61/0x70
Jan 31 15:32:02 martin kernel:  [alloc_skb+65/240] alloc_skb+0x41/0xf0
Jan 31 15:32:02 martin kernel:  [rtl8139_rx+248/816] rtl8139_rx+0xf8/0x330
Jan 31 15:32:02 martin kernel:  [pg0+143574195/1069769728] rm_isr+0x13/0x30 [nvidia]
Jan 31 15:32:02 martin kernel:  [rtl8139_poll+66/208] rtl8139_poll+0x42/0xd0
Jan 31 15:32:02 martin kernel:  [net_rx_action+97/224] net_rx_action+0x61/0xe0
Jan 31 15:32:02 martin kernel:  [__do_softirq+124/144] __do_softirq+0x7c/0x90
Jan 31 15:32:02 martin kernel:  [do_softirq+39/48] do_softirq+0x27/0x30
Jan 31 15:32:02 martin kernel:  [do_IRQ+198/224] do_IRQ+0xc6/0xe0
Jan 31 15:32:02 martin kernel:  [default_idle+0/64] default_idle+0x0/0x40
Jan 31 15:32:02 martin kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 31 15:32:02 martin kernel:  [default_idle+0/64] default_idle+0x0/0x40
Jan 31 15:32:02 martin kernel:  [default_idle+36/64] default_idle+0x24/0x40
Jan 31 15:32:02 martin kernel:  [cpu_idle+48/64] cpu_idle+0x30/0x40
Jan 31 15:32:02 martin kernel:  [start_kernel+298/336] start_kernel+0x12a/0x150
Jan 31 15:32:02 martin kernel:  [unknown_bootoption+0/416] unknown_bootoption+0x0/0x1a0
Jan 31 15:32:02 martin kernel: eth0: Memory squeeze, dropping packet.
Jan 31 15:32:02 martin kernel: swapper: page allocation failure. order:0, mode:0x20
Jan 31 15:32:02 martin kernel:  [__alloc_pages+442/832] __alloc_pages+0x1ba/0x340
Jan 31 15:32:02 martin kernel:  [__get_free_pages+31/64] __get_free_pages+0x1f/0x40
Jan 31 15:32:02 martin kernel:  [kmem_getpages+25/192] kmem_getpages+0x19/0xc0
Jan 31 15:32:02 martin kernel:  [cache_grow+142/272] cache_grow+0x8e/0x110
Jan 31 15:32:02 martin kernel:  [cache_alloc_refill+179/480] cache_alloc_refill+0xb3/0x1e0
Jan 31 15:32:02 martin kernel:  [call_console_drivers+144/288] call_console_drivers+0x90/0x120
Jan 31 15:32:02 martin kernel:  [__kmalloc+97/112] __kmalloc+0x61/0x70
Jan 31 15:32:02 martin kernel:  [alloc_skb+65/240] alloc_skb+0x41/0xf0
Jan 31 15:32:02 martin kernel:  [rtl8139_rx+248/816] rtl8139_rx+0xf8/0x330
Jan 31 15:32:02 martin kernel:  [pg0+143574195/1069769728] rm_isr+0x13/0x30 [nvidia]
Jan 31 15:32:02 martin kernel:  [rtl8139_poll+66/208] rtl8139_poll+0x42/0xd0
Jan 31 15:32:02 martin kernel:  [net_rx_action+97/224] net_rx_action+0x61/0xe0
Jan 31 15:32:02 martin kernel:  [__do_softirq+124/144] __do_softirq+0x7c/0x90
Jan 31 15:32:02 martin kernel:  [do_softirq+39/48] do_softirq+0x27/0x30
Jan 31 15:32:02 martin kernel:  [do_IRQ+198/224] do_IRQ+0xc6/0xe0
Jan 31 15:32:02 martin kernel:  [default_idle+0/64] default_idle+0x0/0x40
Jan 31 15:32:02 martin kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 31 15:32:02 martin kernel:  [default_idle+0/64] default_idle+0x0/0x40
Jan 31 15:32:02 martin kernel:  [default_idle+36/64] default_idle+0x24/0x40
Jan 31 15:32:02 martin kernel:  [cpu_idle+48/64] cpu_idle+0x30/0x40
Jan 31 15:32:02 martin kernel:  [start_kernel+298/336] start_kernel+0x12a/0x150
Jan 31 15:32:02 martin kernel:  [unknown_bootoption+0/416] unknown_bootoption+0x0/0x1a0
Jan 31 15:32:02 martin kernel: eth0: Memory squeeze, dropping packet.
Jan 31 15:35:52 martin syslogd 1.4.1#11: restart.


hope that helps.
as for now i'll probably try to get 2.6.10 into my box and see if the problem occurs again.



-- 
######################################
  Martin Roos
  Vision Group OY / Software Developer
  martin (at) vision.ee
  Kontor/Office: +372 7 407 736
  Mobiil/Mobile: +372 55 911 526
