Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTKKRWj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 12:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTKKRWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 12:22:39 -0500
Received: from theendless.org ([216.251.47.14]:27335 "EHLO
	morpheus.theendless.org") by vger.kernel.org with ESMTP
	id S263628AbTKKRWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 12:22:19 -0500
Date: Tue, 11 Nov 2003 12:22:18 -0500 (EST)
From: morpheus <morpheus@theendless.org>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-test9 and IPVS (Kernel OOPS) with sync daemon started.
In-Reply-To: <Pine.LNX.4.44.0311111124100.824-100000@morpheus.theendless.org>
Message-ID: <Pine.LNX.4.44.0311111210230.824-100000@morpheus.theendless.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AMENDMANT:

The box does NOT crash after the slave server has taken over.  It will
continue to function normally UNTIL one of the connections that has had
its state saved sends the next packet.

TEST condition:
1)master and backup directors are up using the sync daemons.
2)telnet connection is made to the farm.
3)i run an ipvsadm -lc on both and see the following:
TCP 02:40  ESTABLISHED 192.168.1.86:34258 192.168.1.240:telnet 192.168.1.243:telnet
(this ensures that the sync is working!)

4) I fail the master server by pulling the ethernet.
5) The backup server takes over, running an ipvsadm -lc gives the same
output as before.
6) I can establish a new telnet session and it will work fine.
7) As soon as I send one more packet on the first telnet session that was
synced over to the now master director (but established on the failed one
previously) the kernel does the OOPS that I detailed below.

Kris


On Tue, 11 Nov 2003, morpheus wrote:

> Hi,
> 	Being my first post to the list I hope all the information
> included is as accurate and detailed as possible.  Feedback is greatly
> appreciated, thanks in advance.
>
> SUMMARY:
> I seem to have found a problem with the linux-2.6.0-test9 kernel and the
> Sync daemon that comes with IPVS.  I can reproduce the problem without
> fail and it produces a kernel OOPS every time.
>
> PROBLEM REPORT:
> The setup is as follows.  2 hardware identical linux machines are
> functioning as directors in an IPVS setup.  One is master and the other
> backup.  I have successfully implemented failover on these servers.
> However, when attempting to use the stateful failover option in ipvsadm
> (IPVS) by running "ipvsadm --start-daemon master" on the master and
> "ipvsadm --start-daemon slave" on the slave and failing the connection
> over, the kernel on the slave machine craps out.  It produces an oops
> which is posted (after processing via ksymoops) below.  It seems to happen
> at the exact moment that the slave machine takes over the virtual ip's
> that the master machine owned, ie. right after gratiuitous arps are sent
> out to make sure everyone knows where the new ips are.  Keep in mind that
> the slave machine does NOT take over the main IP's of the primary
> director, as this may lead to some networking issues which should still
> not cause an OOps.  If I do not enable the sync-daemon (ie. NO stateful
> failover), everything keeps on trudging along as normal.
>
> KERNEL VERSION:
> Linux version 2.6.0-test9 (root@director1) (gcc version 3.2) #1 SMP Sat
> Feb 7 21:38:27 EST 2004
>
> OOPS OUTPUT (ksymoops processed):
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c02d5eac>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> eax: 00000010   ebx: f7022880   ecx: f7022880   edx: 00000010
> esi: 00000000   edi: f76e9d80   ebp: 00000010   esp: c0389d2c
> ds: 007b   es: 007b   ss: 0068
> Stack: c0389d48 c1b41000 00000000 c02c8975 c0353900 c0389d48 f70b500c
> f733be20
>        f77ec680 c0353900 00000036 00000000 00000000 f76e9d80 c0354840
> f7022880
>        c02d9ec5 f76e9d80 00000014 c0389dd0 00000014 c02cd3ad 00000006
> 5601a8c0
>  [<c02c8975>] fib_validate_source+0x1f5/0x296
>  [<c02d9ec5>] tcp_state_transition+0x3f/0x2d6
>  [<c02cd3ad>] ip_vs_conn_in_get+0xad/0x26e
>  [<c02d5882>] ip_vs_dr_xmit+0x0/0x744
>  [<c0297280>] ip_local_deliver_finish+0x0/0x162
>  [<c02d066b>] ip_vs_in+0x185/0x304
>  [<c028e231>] nf_iterate+0x71/0xa6
>  [<c0297280>] ip_local_deliver_finish+0x0/0x162
>  [<c028e535>] nf_hook_slow+0x79/0x124
>  [<c0297280>] ip_local_deliver_finish+0x0/0x162
>  [<c0296d89>] ip_local_deliver+0x1b7/0x1d6
>  [<c0297280>] ip_local_deliver_finish+0x0/0x162
>  [<c0297108>] ip_rcv+0x360/0x4d8
>  [<c028483b>] netif_receive_skb+0x13f/0x17a
>  [<c02848f6>] process_backlog+0x80/0x112
>  [<c0284a02>] net_rx_action+0x7a/0x104
>  [<c01219fb>] do_softirq+0xc3/0xc6
>  [<c010b778>] do_IRQ+0xf6/0x114
>  [<c0106e6e>] default_idle+0x0/0x2e
>  [<c0109af4>] common_interrupt+0x18/0x20
>  [<c0106e6e>] default_idle+0x0/0x2e
>  [<c0106e98>] default_idle+0x2a/0x2e
>  [<c0106f0d>] cpu_idle+0x37/0x40
>  [<c0105000>] _stext+0x0/0x52
>  [<c038a840>] start_kernel+0x194/0x1c2
>  [<c038a406>] unknown_bootoption+0x0/0xfc
> Code: a1 10 00 00 00 c7 44 24 4c 00 00 00 00 88 94 24 88 00 00 00
>
>
> >>EIP; c02d5eac <ip_vs_dr_xmit+62a/744>   <=====
>
> >>ebx; f7022880 <_end+36c18f10/3fbf4690>
> >>ecx; f7022880 <_end+36c18f10/3fbf4690>
> >>edi; f76e9d80 <_end+372e0410/3fbf4690>
> >>esp; c0389d2c <init_thread_union+1d2c/2000>
>
> Code;  c02d5eac <ip_vs_dr_xmit+62a/744>
> 00000000 <_EIP>:
> Code;  c02d5eac <ip_vs_dr_xmit+62a/744>   <=====
>    0:   a1 10 00 00 00            mov    0x10,%eax   <=====
> Code;  c02d5eb1 <ip_vs_dr_xmit+62f/744>
>    5:   c7 44 24 4c 00 00 00      movl   $0x0,0x4c(%esp,1)
> Code;  c02d5eb8 <ip_vs_dr_xmit+636/744>
>    c:   00
> Code;  c02d5eb9 <ip_vs_dr_xmit+637/744>
>    d:   88 94 24 88 00 00 00      mov    %dl,0x88(%esp,1)
>
>  <0>Kernel panic: Fatal exception in interrupt
>
> 1 warning and 1 error issued.  Results may not be reliable.
>
>
> ENVIRONMENT:
> LESSKEY=/etc/lesskey.bin
> MANPATH=/usr/local/man:/usr/share/man:/usr/X11R6/man
> INFODIR=/usr/local/info:/usr/share/info:/usr/info
> NNTPSERVER=news
> HOSTNAME=director2
> XKEYSYMDB=/usr/X11R6/lib/X11/XKeysymDB
> SHELL=/bin/bash
> TERM=xterm
> HOST=director2
> PROFILEREAD=true
> SSH_CLIENT=192.168.1.86 34233 22
> SSH_TTY=/dev/pts/0
> USER=kris
> LS_COLORS=no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31:ex=00;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:
> XNLSPATH=/usr/X11R6/lib/X11/nls
> HOSTTYPE=i386
> PAGER=less
> MINICOM=-c on
> PATH=/usr/sbin:/bin:/usr/bin:/sbin:/usr/X11R6/bin
> MAIL=/var/mail/kris
> CPU=i686
> LC_COLLATE=POSIX
> PWD=/root
> INPUTRC=/etc/inputrc
> LANG=en_US
> TEXINPUTS=:/home/kris/.TeX:/usr/share/doc/.TeX:/usr/doc/.TeX
> HOME=/root
> SHLVL=2
> OSTYPE=linux
> LESS_ADVANCED_PREPROCESSOR=no
> no_proxy=localhost
> LS_OPTIONS=-a -N --color=tty -T 0
> WINDOWMANAGER=/usr/X11R6/bin/kde
> LOGNAME=kris
> MACHTYPE=i686-suse-linux
> LESS=-M -I
> PRINTER=lp
> LESSOPEN=lessopen.sh %s
> INFOPATH=/usr/local/info:/usr/share/info:/usr/info
> LESSCLOSE=lessclose.sh %s %s
> COLORTERM=1
> _=/usr/bin/env
> OLDPWD=/usr/src/linux/Documentation
>
> SOFTWARE:
> The software responsible for failing the machines over and reconfiguring
> the virutal ip's on the backup server is heartbeat.  It is currently
> "beating" on the eth0 interface.  The same interface that is used for
> traffic loadbalancing and access to the internet (ie. the only interface
> on the machine.
>
> ver_linux:
> Linux director2 2.6.0-test9 #1 SMP Sat Feb 7 21:38:27 EST 2004 i686
> unknown
>
> Gnu C                  3.2
> Gnu make               3.79.1
> util-linux             2.11u
> mount                  2.11u
> module-init-tools      implemented
> e2fsprogs              1.28
> xfsprogs               2.2.1
> nfs-utils              1.0.1
> Linux C Library        27 11:31 /lib/libc.so.6
> Dynamic linker (ldd)   2.2.5
> Linux C++ Library      5.0.0
> Procps                 2.0.7
> Net-tools              1.60
> Kbd                    76:
> Sh-utils               2.0
> Modules Loaded
>
>
> CPU (/proc/cpuinfo):
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 8
> model name      : Pentium III (Coppermine)
> stepping        : 10
> cpu MHz         : 1004.570
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 mmx fxsr sse
> bogomips        : 1978.36
>
> processor       : 1
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 8
> model name      : Pentium III (Coppermine)
> stepping        : 10
> cpu MHz         : 1004.570
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 mmx fxsr sse
> bogomips        : 2007.04
>
>
>
> MODULE INFO(/proc/modules):
> N/A
>
> DRIVER/HARDWARE INFO (/proc/ioports, /proc/iomem):
> ioports:
> 0000-001f : dma1
> 0020-0021 : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0080-008f : dma page reg
> 00a0-00a1 : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 02f8-02ff : serial
> 0376-0376 : ide1
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 03f8-03ff : serial
> 0cf8-0cff : PCI conf1
> a400-a4ff : 0000:00:0c.0
> a800-a83f : 0000:00:09.0
>   a800-a83f : eepro100
> b000-b0ff : 0000:00:08.1
> b400-b4ff : 0000:00:08.0
> b800-b83f : 0000:00:07.0
>   b800-b83f : eepro100
> d000-d01f : 0000:00:04.3
> d400-d41f : 0000:00:04.2
> d800-d80f : 0000:00:04.1
>   d800-d807 : ide0
>   d808-d80f : ide1
> e800-e80f : 0000:00:04.4
>
> iomem:
> 00000000-0009ffff : System RAM
> 000a0000-000bffff : Video RAM area
> 000c8000-000c97ff : Extension ROM
> 000f0000-000fffff : System ROM
> 00100000-3fffbfff : System RAM
>   00100000-002e545e : Kernel code
>   002e545f-003875ff : Kernel data
> 3fffc000-3fffefff : ACPI Tables
> 3ffff000-3fffffff : ACPI Non-volatile Storage
> f5000000-f5000fff : 0000:00:0c.0
> f5800000-f581ffff : 0000:00:09.0
> f6000000-f6000fff : 0000:00:09.0
>   f6000000-f6000fff : eepro100
> f6800000-f6801fff : 0000:00:08.1
> f7000000-f70003ff : 0000:00:08.1
> f7800000-f7801fff : 0000:00:08.0
> f8000000-f80003ff : 0000:00:08.0
> f8800000-f88fffff : 0000:00:07.0
> f9000000-f9000fff : 0000:00:07.0
>   f9000000-f9000fff : eepro100
> fa000000-faffffff : 0000:00:0c.0
> fc000000-fdffffff : 0000:00:00.0
> fec00000-fec00fff : reserved
> fee00000-fee00fff : reserved
> ffff0000-ffffffff : reserved
>
>
> PCI INFO (lspci -vvv):
> 00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
> PRO133x] (rev c4)
>         Subsystem: Asustek Computer, Inc.: Unknown device 8038
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
>         Capabilities: [a0] AGP version 2.0
>                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
>                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
> MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 0000e000-0000dfff
>         Memory behind bridge: f9f00000-f9efffff
>         Prefetchable memory behind bridge: fc000000-fbffffff
>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
> (rev 40)
>         Subsystem: Asustek Computer, Inc.: Unknown device 8038
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:04.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master
> IDE (rev 06) (prog-if 8a [Master SecP PriP])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32
>         Region 4: I/O ports at d800 [size=16]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00
> [UHCI])
>         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32, cache line size 08
>         Interrupt: pin D routed to IRQ 21
>         Region 4: I/O ports at d400 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00
> [UHCI])
>         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32, cache line size 08
>         Interrupt: pin D routed to IRQ 21
>         Region 4: I/O ports at d000 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> (rev 40)
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin ? routed to IRQ 9
>         Capabilities: [68] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
> 08)
>         Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (2000ns min, 14000ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 17
>         Region 0: Memory at f9000000 (32-bit, non-prefetchable) [size=4K]
>         Region 1: I/O ports at b800 [size=64]
>         Region 2: Memory at f8800000 (32-bit, non-prefetchable) [size=1M]
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
>
> 00:08.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3
> SCSI Adapter (rev 01)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (4250ns min, 4500ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 19
>         Region 0: I/O ports at b400 [size=256]
>         Region 1: Memory at f8000000 (64-bit, non-prefetchable) [size=1K]
>         Region 3: Memory at f7800000 (64-bit, non-prefetchable) [size=8K]
>         Capabilities: [40] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:08.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3
> SCSI Adapter (rev 01)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (4250ns min, 4500ns max), cache line size 08
>         Interrupt: pin B routed to IRQ 16
>         Region 0: I/O ports at b000 [size=256]
>         Region 1: Memory at f7000000 (64-bit, non-prefetchable) [size=1K]
>         Region 3: Memory at f6800000 (64-bit, non-prefetchable) [size=8K]
>         Capabilities: [40] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
> 0c)
>         Subsystem: Intel Corp. EtherExpress PRO/100 S Desktop Adapter
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (2000ns min, 14000ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 19
>         Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=4K]
>         Region 1: I/O ports at a800 [size=64]
>         Region 2: Memory at f5800000 (32-bit, non-prefetchable)
> [size=128K]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
>
> 00:0c.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro 215GP
> (rev 5c) (prog-if 00 [VGA])
>         Subsystem: ATI Technologies Inc Rage Pro Turbo
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (2000ns min), cache line size 08
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at fa000000 (32-bit, prefetchable) [size=16M]
>         Region 1: I/O ports at a400 [size=256]
>         Region 2: Memory at f5000000 (32-bit, non-prefetchable) [size=4K]
>         Expansion ROM at 000c0000 [disabled] [size=128K]
>
>
>
>
> I think that's about it.... Thanks.
>
>
> Kris
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

