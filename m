Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272941AbRIMJQa>; Thu, 13 Sep 2001 05:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272942AbRIMJQV>; Thu, 13 Sep 2001 05:16:21 -0400
Received: from [195.66.192.167] ([195.66.192.167]:25359 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S272941AbRIMJQK>; Thu, 13 Sep 2001 05:16:10 -0400
Date: Thu, 13 Sep 2001 12:13:04 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <17613305632.20010913121304@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
CC: heinz@auto.tuwien.ac.at, drebes@inf.ufrgs.br, leo@debian.org
Subject: Stomping on Athlon bug
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Below is a modified printout of lspci -vvvxxx
made on VIA KT133A based mainboard with BIOS version 3R flashed in
(this system is exhibiting Athlon bug) and on the same system
with BIOS version YH (which do not trigger bug).
Each chipset config register which is changed between these two BIOSes
is underlined with carets "^" with programming details immediately below.
Each register is then commented with:
*** 3R BIOS: settings made by 3R BIOS
*** YH BIOS: settings made by YH BIOS
*** TODO: is this relevant and what to do

Anyone interested in trying to pin down the bug might
try to reprogram this chipset along the lines:
    ...
    struct pci_dev *dev;
    dev = pci_find_device(PCI_VENDOR_ID_VIA, 0x0305, NULL);
    if(dev) {
        printk("Trying to stomp on Athlon bug...\n");
        u8 v;
        pci_read_config_byte(dev, 0x52, &v);
        /* set 52.7: Disconnect Enable When STPGNT Detected */
        v |= 0x80;
        pci_write_config_byte(dev, 0x52, v);
        ...
    }
    ...
I'm not sure where exactly this piece of code should go.
Anyway, compile K7 optimized kernel with this fix
and give it a try.
========================================================
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
        Subsystem: ABIT Computer Corp.: Unknown device a401
                
YH 00: 06 11 05 03 06 00 10 22 03 00 00 06 00 00 00 00
3R 00: 06 11 05 03 06 00 10 22 03 00 00 06 00 08 00 00
                                              ^^
Device 0 Offset D - Latency Timer (00h)(RW)
Specifies the latency timer value in PCI bus clocks.
7-3 Guaranteed Time Slice for CPU. default=0
2-0 Reserved (fixed granularity of 8 clks). always read 0
    Bits 2-1 are writeable but read 0 for PCI specification
    compatibility. The programmed value may be read
    back in Offset 75 bits 5-4 (PCI Arbitration 1).
*** 3R BIOS: bits 7-3=00001
*** YH BIOS: bits 7-3=00000
*** TODO: probably does not matter

YH 10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
3R 10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
       ^^^^^^^^^^^
Device 0 Offset 13-10 - Graphics Aperture Base
    (00000008h) (RW)
31-28 Upper Programmable Base Address Bits. default=0
27-20 Lower Programmable Base Address Bits. default=0
    These bits behave as if hardwired to 0 if the
    corresponding Graphics Aperture Size register bit
    (Device 0 Offset 84h) is 0.
    27 26 25 24 23 22 21 20 (This Register)
     7  6  5  4  3  2  1  0 (Gr Aper Size)
    RW RW RW RW RW RW RW RW 1M
    RW RW RW RW RW RW RW  0 2M
    RW RW RW RW RW RW  0  0 4M
    RW RW RW RW RW  0  0  0 8M
    RW RW RW RW  0  0  0  0 16M
    RW RW RW  0  0  0  0  0 32M
    RW RW  0  0  0  0  0  0 64M
    RW  0  0  0  0  0  0  0 128M
     0  0  0  0  0  0  0  0 256M
19-0 Reserved. always reads 00008
    Note: The locations in the address range defined by this
    register are prefetchable.

*** 3R BIOS: addr: E0000000
*** YH BIOS: addr: D0000000
*** TODO: probably does not matter

YH 50: 16 f4 eb
3R 50: 16 f4 6b
             ^^
Device 0 Offset 52 - S2K Timing Control III..................RW
    The contents of this register are preserved during suspend.
    Bits 2-0 have no default value.
7 Disconnect Enable When STPGNT Detected
6 Write to Read Delay. default = 1
5-4 Read to Write Delay. default = 11b
3 1ns Skew Between Even / Odd Clock Group For Data (Strapped
  from MAB3)
    0 Disable (default if no strap on MAB3)
    1 Enable
2-0 Write Data Delay from SYSDC to CPU Data
  Output (WrDataDly)
*** 3R BIOS: bit 7=0
*** YH BIOS: bit 7=1 
*** TODO: try to set bit 7 to 1.

YH 50: .. .. .. b4 06
3R 50: .. .. .. b4 47
                   ^^
Device 0 Offset 54 - BIU Control (RW)
7 SDRAM Self-Refresh When Disconnected
    0 Disable (default)  1 Enable
6 Probe Next Tag State T1 When PCI Master Read
 Cacheing Enabled
    0 Disable (default)  1 Enable
5 S2K Data Input Buffer
    0 Disable (default
)  1 Enable
4 S2K Data Output Enable Timing
    0 1T Setup / Hold (default)  1 1/2T Setup / Hold
3 DRAM Speculative Read for PCI Master Read
 (Before Probe Result is Known)
    0 Disable (default)  1 Enable
2 PCI Master Pipeline Request
    0 Disable (default)  1 Enable
1 PCI-to-CPU / CPU-to-PCI (P2C / C2P)
 Concurrency
    0 Disable (default)  1 Enable
0 Fast Write-to-Read Turnaround
    0 Disable (default)  1 Enable
*** 3R BIOS: enabled 6,2,1,0 bits only.
*** YH BIOS: enabled   2,1   bits only.
*** TODO: try disabling bits 6,0.
    bit 0 is most interesting. Try it first.
    
YH 50: .. .. .. .. .. 00 04 04 00 00 01 02 03 04 04 04
3R 50: .. .. .. .. .. 89 04 04 00 00 01 02 03 04 04 04
                      ^^
Device 0 Offset 55 - Debug (RW)
7-0 Reserved (do not program). default = 0
*** 3R BIOS: non-zero!?
*** YH BIOS: zero.
*** TODO: try to set to 0.

YH 60: 0f 0a 00 20 e4 e4 d4 c4 50 28 65 0d 08 5f 00 00
3R 60: 0f 0a 00 20 e4 e4 d4 00 50 08 65 0d 08 5f 00 00
                                  ^^
Device 0 Offset 69 - DRAM Clock Select (00h) (RW)
7 Reserved. always reads 0
6 DRAM Operating Frequency Faster Than CPU
    0 DRAM Same As or Equal to CPU (default)
    1 DRAM Faster Than CPU by 33 MHz
    Rx68[0] Rx69[6] CPU / DRAM
          0       0 100 / 100
          0       1 100 / 133
          1       0 133 / 133 (default)
          1       1 -reserved-
5 Write Recovery Time For Write With Auto-Precharge
    0 1T (default)  1 2T
4 DRAM Controller Command Register Output
    0 Disable (default)  1 Enable
3 Fast DRAM Precharge for Different Bank
    0 Disable (default)  1 Enable
2 DRAM 4K Page Enable (for 64Mbit DRAM)
    0 Disable (default)  1 Enable
1 DIMM Type
    0 Unbuffered (default)  1 Registered
0 AutoPrecharge on CPU Writeback / TLB Lookup
    0 Disable (default)  1 Enable
*** 3R BIOS: bit 5 is 0
*** YH BIOS: bit 5 is 1
*** TODO: try setting it back to 1

YH 70: d4 88 cc 0c 0e 81 d2 00 01 b4 19 02 00 00 00 00
3R 70: d8 88 cc 0c 0e 81 d2 00 01 b4 19 02 00 00 00 00
       ^^
Device 0 Offset 70 - PCI Buffer Control (00h) (RW)
7 CPU to PCI Post-Write
    0 Disable (default)  1 Enable
6 PCI Master to DRAM Post-Write
    0 Disable (default)  1 Enable
5 Reserved. always reads 0
4 PCI Master to DRAM Prefetch
    0 Enable (default)  1 Disable
3 Enhance CPU-to-PCI Write
    0 Normal operation (default)
    1 Reduce 1 cycle when the CPU-to-PCI buffer
      becomes available after being full (PCI and AGP buses)
2 PCI Master Read Caching
    0 Disable (default)  1 Enable
1 Delay Transaction
    0 Disable (default)  1 Enable
0 Slave Device Stopped Idle Cycle Reduction
    0 Normal Operation (default)
    1 Reduce 1 PCI idle cycle when stopped by a
      slave device (PCI and AGP buses)
*** 3R BIOS: bit 4=1, 3=0
*** YH BIOS: bit 4=0, 3=1
*** TODO: probably doesn't matter

YH a0: 02 c0 20 00 03 02 00 1f 00 00 00 00 2b 12 00 00
3R a0: 02 c0 20 00 03 02 00 1f 00 00 00 00 2f 12 00 00
                                           ^^
Device 0 Offset AC - AGP Control (00h) (RW)
7 Reserved. always reads 0
6 CPU Stall on AGP Command FIFO GART
 Address Request
    0 Disable (default)  1 Enable
5 AGP Read Snoop DRAM Post-Write Buffer
    0 Disable (default)  1 Enable
4 GREQ# Priority Becomes Higher When Arbiter is
 Parked at AGP Master
    0 Disable (default)  1 Enable
3 2X Rate Supported (read also at RxA4[1])
    0 Not supported (default)  1 Supported
2 LPR In-Order Access (Force Fence)
    0 Fence/Flush functions not guaranteed. AGP
      read requests (low/normal priority and
      high priority) may be executed
      before previously issued write requests
      (default)
    1 Force all requests to be executed in order
      (automatically enables Fence/Flush functions).
      Low (i.e., normal) priority AGP read requests
      will never be executed before previously
      issued writes. High priority AGP read requests
      may still be executed prior to previously issued
      write requests as required.
1 AGP Arbitration Parking
    0 Disable (default)
    1 Enable (GGNT# remains asserted until either
      GREQ# de-asserts or data phase ready)
0 AGP to PCI Master or CPU to PCI Turnaround Cycle
    0 2T or 3T Timing (default)
    1 1T Timing
*** 3R BIOS: bit 2=1
*** YH BIOS: bit 2=0
*** TODO: probably doesn't matter
    
YH b0: db 63 02
3R b0: db 63 1a
             ^^
Device 0 Offset B2 - AGP Pad Drive / Delay Control (RW)
7 GD/GBE/GDS, SBA/SBS Control
  1.5V (Bit-1 = 0)
    0 SBA/SBS = no cap (default)
      GD/GBE/GDS = no cap
    1 SBA/SBS = no cap
      GD/GBE/GDS = cap
  3.3V (Bit-1 = 1)
    0 SBA/SBS = cap (default)
      GD/GBE/GDS = no cap
    1 SBA/SBS = cap
      GD/GBE/GDS = cap
6 Reserved. always reads 0
5 S2K Slew Rate Control. strapped from SRASA#
    0 Enable (default)  1 Disable
4 GD[31-16] Staggered Delay
    0 None (default)  1 GD[31:16] delayed by 1 ns
3 Reserved. always reads 0
2 AGP Preamble Control
    0 Disable (default)  1 Enable
1 AGP Voltage
    0 1.5V (default)  1 3.3V
0 GDS Output Delay
    0 None (default)
    1 GDS[1-0] & GDS[1-0]# delayed by 0.4 ns
      (GDS1 & GDS1# will be delayed an additional
      1ns if bit-4 = 1)
*** 3R BIOS: 1A=00011010
*** YH BIOS: 02=00000010
*** TODO: probably doesn't matter

YH b0: .. .. .. 50 31 ff 80 0a 67 00 00 00 00 00 00 00
3R b0: .. .. .. 50 31 ff 80 0b 67 00 00 00 00 00 00 00
                            ^^
Device 0 Offset B7 - S2K Compensation Result 3 (RO)
7-5 Reserved. always reads 0
4-0 S2K Strobe Delay from DLL Counter (Auto)
    default = 0
*** TODO: readonly. doesn't matter

YH f0: 00 00 00 00 00 03 03 00 22 00 00 00 00 00 00 00
3R f0: 00 00 00 00 00 03 03 00 22 00 00 00 00 80 00 00
                                              ^^
Device 0 Offset FD - Back-DoorControl 2 (00h) ........... RW
7-5 Reserved. always reads 0
4-0 Max # of AGP Requests. default = 0
    00000 1 Request
    00001 2 Requests
    00010 3 Requests
    ..... ........
    11111 32 Requests
    (see also RxA7 and RxFC[1])
*** 3R BIOS: 80
*** YH BIOS: 00
*** TODO: probably doesn't matter
    Curious how "always zero" bit 7 happen to become 1
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


