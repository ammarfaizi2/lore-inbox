Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161091AbWJKQBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbWJKQBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbWJKQBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:01:14 -0400
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.233]:44476
	"EHLO saville.com") by vger.kernel.org with ESMTP id S1161091AbWJKQBM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:01:12 -0400
Message-ID: <452D154B.5000008@saville.com>
Date: Wed, 11 Oct 2006 09:01:15 -0700
From: Wink Saville <wink@saville.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Divide by zero in 2.6.19-rc1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On my system, a Core 2 Duo and an Nvidia 7600 GT KO, a divide by zero exception
occurs when I enable the frame buffer. The error occurs in the routine nvGetClocks of ./drivers/video/nvidia/nv_hw.c executing the following sequence:

static void nvGetClocks(struct nvidia_par *par, unsigned int *MClk,
           unsigned int *NVClk)
{
   unsigned int pll, N, M, MB, NB, P, p4020;
   char buf[200];

   if (par->Architecture >= NV_ARCH_40) {
       pll = NV_RD32(par->PMC, 0x4020);
       p4020 = pll;
       P = (pll >> 16) & 0x03;
       pll = NV_RD32(par->PMC, 0x4024);
       M = pll & 0xFF;
       N = (pll >> 8) & 0xFF;
       MB = (pll >> 16) & 0xFF;
       NB = (pll >> 24) & 0xFF;
       snprintf(buf, sizeof(buf),
                "\r\nnvGetClocks: arch=%d p4020=0x%08x p4024=0x%08x M=%d N=%d MB=%d NB=%d P=%d",
                par->Architecture, p4020, pll, M, N, MB, NB, P);
       LLDB_WRSTR(buf);
       *MClk = ((N * NB * par->CrystalFreqKHz) / (M * MB)) >> P;

And the LLDB_WRSTR I added prints:

  nvGetClocks: arch=64 p4020=0xa4301000 p4024=0x00005303 M=3 N=83 MB=0 NB=0 P=0

As can be seen MB is 0 hence the exception. It appears my hardware is not
properly supported or that I have an incorrect config file. Below is a log,
config and diff. The diff is against a clone of 2.6.19-rc1 as of 10/8/2006.

For some history see here http://lkml.org/lkml/2006/10/8/23 and Andrew Morton
and here http://marc.theaimsgroup.com/?t=116028747200001&r=1&w=2

Thanks,

Wink Saville

<log>
[    0.000000] Linux version 2.6.19-rc1-w8 (wink@winkc2d1) (gcc
version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #4 SMP Sun Oct 8 10:13:36 PDT 2006
[    0.000000] Command line: root=/dev/sda2 ro splash initcall_debug console=tty0 console=ttyS0,115200n8 loglevel=7
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007ff80000 (usable)
[    0.000000]  BIOS-e820: 000000007ff80000 - 000000007ff8e000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007ff8e000 - 000000007ffe0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007ffe0000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.3 present.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   524160
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e4000
[    0.000000] Nosave address range: 00000000000e4000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:7fb00000)
[    0.000000] PERCPU: Allocating 34048 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 515368
[    0.000000] Kernel command line: root=/dev/sda2 ro splash initcall_debug console=tty0 console=ttyS0,115200n8 loglevel=7
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   38.700028] Console: colour VGA+ 80x25
[   38.965705] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   38.973543] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   38.981260] Checking aperture...
[   39.006736] Memory: 2058136k/2096640k available (3833k kernel code, 38088k reserved, 1431k data, 232k init)
[   39.093936] Calibrating delay using timer specific routine.. 4811.84 BogoMIPS (lpj=9623690)
[   39.102578] Mount-cache hash table entries: 256
[   39.107335] CPU: L1 I cache: 32K, L1 D cache: 32K
[   39.112197] CPU: L2 cache: 4096K
[   39.115543] using mwait in idle threads.
[   39.119581] CPU: Physical Processor ID: 0
[   39.123705] CPU: Processor Core ID: 0
[   39.127489] CPU0: Thermal monitoring enabled (TM2)
[   39.132403] Freeing SMP alternatives: 40k freed
[   39.137065] ACPI: Core revision 20060707
[   39.198053] Using local APIC timer interrupts.
[   39.255587] result 10208419
[   39.258499] Detected 10.208 MHz APIC timer.
[   39.265635] Booting processor 1/2 APIC 0x1
[   39.280372] Initializing CPU#1
[   39.357366] Calibrating delay using timer specific routine.. 4808.57 BogoMIPS (lpj=9617148)
[   39.357371] CPU: L1 I cache: 32K, L1 D cache: 32K
[   39.357373] CPU: L2 cache: 4096K
[   39.357375] CPU: Physical Processor ID: 0
[   39.357376] CPU: Processor Core ID: 1
[   39.357380] CPU1: Thermal monitoring enabled (TM2)
[   39.357382] Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
[   39.361374] Brought up 2 CPUs
[   39.403894] testing NMI watchdog ... OK.
[   39.447916] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
[   39.454208] time.c: Detected 2404.211 MHz processor.
[   39.498905] migration_cost=19
[   39.502329] Calling initcall 0xffffffff80748822: cpufreq_tsc+0x0/0x6a()
[   39.509142] Calling initcall 0xffffffff8074cbb7: init_smp_flush+0x0/0x53()
[   39.516215] Calling initcall 0xffffffff80752fa1: init_elf32_binfmt+0x0/0xc()
[   39.523460] Calling initcall 0xffffffff807546fa: helper_init+0x0/0x2e()
[   39.530281] Calling initcall 0xffffffff807549c2: pm_init+0x0/0x27()
[   39.536746] Calling initcall 0xffffffff80754de9: ksysfs_init+0x0/0x27()
[   39.543560] Calling initcall 0xffffffff80756f88: filelock_init+0x0/0x2e()
[   39.550551] Calling initcall 0xffffffff807579a5: init_misc_binfmt+0x0/0x35()
[   39.557800] Calling initcall 0xffffffff807579da: init_script_binfmt+0x0/0xc()
[   39.565124] Calling initcall 0xffffffff807579e6: init_elf_binfmt+0x0/0xc()
[   39.572190] Calling initcall 0xffffffff80761e95: init_cpufreq_transition_notifier_list+0x0/0x11()
[   39.581356] Calling initcall 0xffffffff80763a90: sock_init+0x0/0x57()
[   39.588003] Calling initcall 0xffffffff80764160: netlink_proto_init+0x0/0x164()
[   39.595611] NET: Registered protocol family 16
[   39.600173] Calling initcall 0xffffffff8075a0d7: kobject_uevent_init+0x0/0x39()
[   39.607776] Calling initcall 0xffffffff8075a204: pcibus_class_init+0x0/0xc()
[   39.615023] Calling initcall 0xffffffff8075a9e7: pci_driver_init+0x0/0xc()
[   39.622100] Calling initcall 0xffffffff8075c277: dock_init+0x0/0x46()
[   39.628787] Calling initcall 0xffffffff8075d288: tty_class_init+0x0/0x27()
[   39.635857] Calling initcall 0xffffffff8075db59: vtconsole_class_init+0x0/0xb5()
[   39.643588] Calling initcall 0xffffffff8075ab27: acpi_pci_init+0x0/0x2d()
[   39.650580] ACPI: bus type pci registered
[   39.654700] Calling initcall 0xffffffff8075bb21: init_acpi_device_notify+0x0/0x48()
[   39.662653] Calling initcall 0xffffffff80762a75: pci_access_init+0x0/0x3c()
[   39.669826] PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
[   39.676374] PCI: Not using MMCONFIG.
[   39.680063] PCI: Using configuration type 1
[   39.684362] Calling initcall 0xffffffff80751790: topology_init+0x0/0x2f()
[   39.691381] Calling initcall 0xffffffff807544ea: param_sysfs_init+0x0/0x187()
[   39.699744] Calling initcall 0xffffffff80245a51: pm_sysrq_init+0x0/0x17()
[   39.706739] Calling initcall 0xffffffff80757604: init_bio+0x0/0xff()
[   39.713338] Calling initcall 0xffffffff80759fc9: genhd_device_init+0x0/0x4d()
[   39.720700] Calling initcall 0xffffffff8075ab54: fbmem_init+0x0/0x92()
[   39.727435] Calling initcall 0xffffffff8075b93d: acpi_init+0x0/0x1e4()
[   39.742465] ACPI: Interpreter enabled
[   39.746617] ACPI: Using IOAPIC for interrupt routing
[   39.751736] Calling initcall 0xffffffff8075bc4c: acpi_ec_init+0x0/0x60()
[   39.758634] Calling initcall 0xffffffff8075c536: acpi_pci_root_init+0x0/0x27()
[   39.766155] Calling initcall 0xffffffff8075c622: acpi_pci_link_init+0x0/0x46()
[   39.773671] Calling initcall 0xffffffff8075c702: acpi_power_init+0x0/0x76()
[   39.780832] Calling initcall 0xffffffff8075c899: acpi_system_init+0x0/0xbd()
[   39.788079] Calling initcall 0xffffffff8075c956: acpi_event_init+0x0/0x3c()
[   39.795247] Calling initcall 0xffffffff8075c992: acpi_scan_init+0x0/0x1a5()
[   39.803211] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   39.809750] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   39.816340] PCI: Transparent bridge - 0000:00:1e.0
[   39.828402] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   39.836278] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[   39.844147] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
[   39.852014] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   39.859882] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   39.867752] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   39.875621] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[   39.887412] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 *6 7 10 11 12 14 15)
[   39.895159] Calling initcall 0xffffffff8075cca4: acpi_cm_sbs_init+0x0/0x3()
[   39.902311] Calling initcall 0xffffffff8075cca7: pnp_init+0x0/0x1e()
[   39.908858] Linux Plug and Play Support v0.97 (c) Adam Belay
[   39.914628] Calling initcall 0xffffffff8075ce08: pnpacpi_init+0x0/0x69()
[   39.921536] pnp: PnP ACPI init
[   39.927003] pnp: PnP ACPI: found 13 devices
[   39.931304] Calling initcall 0xffffffff8075d89f: misc_init+0x0/0x7d()
[   39.937954] Calling initcall 0xffffffff804988d0: cn_init+0x0/0xc8()
[   39.944441] Calling initcall 0xffffffff80760a72: init_scsi+0x0/0x82()
[   39.951173] SCSI subsystem initialized
[   39.955040] Calling initcall 0xffffffff807610f9: usb_init+0x0/0x103()
[   39.961716] usbcore: registered new interface driver usbfs
[   39.967338] usbcore: registered new interface driver hub
[   39.972789] usbcore: registered new device driver usb
[   39.977949] Calling initcall 0xffffffff80761437: serio_init+0x0/0xbc()
[   39.984694] Calling initcall 0xffffffff80761982: input_init+0x0/0x11b()
[   39.991508] Calling initcall 0xffffffff80761d69: rtc_init+0x0/0x3f()
[   39.998061] Calling initcall 0xffffffff80761da8: rtc_sysfs_init+0x0/0xc()
[   40.005434] Calling initcall 0xffffffff80761db4: rtc_proc_init+0x0/0xc()
[   40.012328] Calling initcall 0xffffffff80761dc0: rtc_dev_init+0x0/0xa4()
[   40.019229] Calling initcall 0xffffffff80761e64: i2c_init+0x0/0x31()
[   40.025815] Calling initcall 0xffffffff80762509: dma_bus_init+0x0/0x2a()
[   40.032712] Calling initcall 0xffffffff80762ab1: pci_acpi_init+0x0/0xa4()
[   40.039695] PCI: Using ACPI for IRQ routing
[   40.043991] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   40.052454] Calling initcall 0xffffffff80762b55: pci_legacy_init+0x0/0x120()
[   40.059698] Calling initcall 0xffffffff80762fe4: pcibios_irq_init+0x0/0x49b()
[   40.067024] Calling initcall 0xffffffff8076347f: pcibios_init+0x0/0x66()
[   40.073981] Calling initcall 0xffffffff80763b3c: proto_init+0x0/0x33()
[   40.080705] Calling initcall 0xffffffff80763c81: net_dev_init+0x0/0x22b()
[   40.087696] Calling initcall 0xffffffff807642c4: genl_init+0x0/0xa6()
[   40.094335] Calling initcall 0xffffffff8074890a: late_hpet_init+0x0/0xb2()
[   40.101415] Calling initcall 0xffffffff8074b411: pci_iommu_init+0x0/0xf()
[   40.108407] PCI-GART: No AMD northbridge found.
[   40.113050] Calling initcall 0xffffffff80756f1e: init_pipe_fs+0x0/0x40()
[   40.119951] Calling initcall 0xffffffff8075cb71: acpi_motherboard_init+0x0/0x133()
[   40.128392] Calling initcall 0xffffffff8075cda9: pnp_system_init+0x0/0xc()
[   40.135482] pnp: 00:06: ioport range 0x290-0x297 has been reserved
[   40.141784] Calling initcall 0xffffffff8075d1a2: chr_dev_init+0x0/0x82()
[   40.148847] Calling initcall 0xffffffff8075f813: firmware_class_init+0x0/0x68()
[   40.156460] Calling initcall 0xffffffff80761f39: cpufreq_gov_performance_init+0x0/0xc()
[   40.164758] Calling initcall 0xffffffff80761f51: cpufreq_gov_userspace_init+0x0/0x1c()
[   40.172965] Calling initcall 0xffffffff80762541: pcibios_assign_resources+0x0/0x81()
[   40.181014] PCI: Bridge: 0000:00:01.0
[   40.184791]   IO window: c000-cfff
[   40.188312]   MEM window: faa00000-feafffff
[   40.192609]   PREFETCH window: cff00000-efefffff
[   40.197339] PCI: Bridge: 0000:00:1c.0
[   40.201116]   IO window: disabled.
[   40.204637]   MEM window: disabled.
[   40.208244]   PREFETCH window: cfe00000-cfefffff
[   40.212976] PCI: Bridge: 0000:00:1c.3
[   40.216752]   IO window: b000-bfff
[   40.220274]   MEM window: fa900000-fa9fffff
[   40.224572]   PREFETCH window: disabled.
[   40.228610] PCI: Bridge: 0000:00:1c.4
[   40.232387]   IO window: a000-afff
[   40.235909]   MEM window: fa800000-fa8fffff
[   40.240205]   PREFETCH window: disabled.
[   40.244245] PCI: Bridge: 0000:00:1e.0
[   40.248022]   IO window: disabled.
[   40.251544]   MEM window: fa700000-fa7fffff
[   40.255842]   PREFETCH window: disabled.
[   40.260277] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[   40.267936] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
[   40.275598] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[   40.283258] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 16
[   40.290917] Calling initcall 0xffffffff80764bad: inet_init+0x0/0x3cb()
[   40.297652] NET: Registered protocol family 2
[   40.325140] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   40.332523] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[   40.341765] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   40.349185] TCP: Hash tables configured (established 262144 bind 65536)
[   40.355903] TCP reno registered
[   40.359204] Calling initcall 0xffffffff8020cd31: time_init_device+0x0/0x22()
[   40.366529] Calling initcall 0xffffffff80749b41: init_timer_sysfs+0x0/0x22()
[   40.373802] Calling initcall 0xffffffff80749b21: i8259A_init_sysfs+0x0/0x20()
[   40.381157] Calling initcall 0xffffffff8074a039: vsyscall_init+0x0/0x98()
[   40.388150] Calling initcall 0xffffffff8074a605: sbf_init+0x0/0xd0()
[   40.394698] Calling initcall 0xffffffff8074b1a4: i8237A_init_sysfs+0x0/0x20()
[   40.402053] Calling initcall 0xffffffff8074b611: mce_init_device+0x0/0x148()
[   40.409367] Calling initcall 0xffffffff8074b52f: periodic_mcheck_init+0x0/0x24()
[   40.417061] Calling initcall 0xffffffff8074b7ca: thermal_throttle_init_device+0x0/0x49()
[   40.425449] Calling initcall 0xffffffff8074bbfa: threshold_init_device+0x0/0x30c()
[   40.433309] Calling initcall 0xffffffff8074c99f: msr_init+0x0/0x10c()
[   40.439987] Calling initcall 0xffffffff8074caab: cpuid_init+0x0/0x10c()
[   40.446838] Calling initcall 0xffffffff8074dcae: init_lapic_sysfs+0x0/0x31()
[   40.454101] Calling initcall 0xffffffff8074e870: ioapic_init_sysfs+0x0/0xa7()
[   40.461457] Calling initcall 0xffffffff80751649: audit_classes_init+0x0/0x8a()
[   40.468974] Calling initcall 0xffffffff80752139: cache_sysfs_init+0x0/0x46()
[   40.476386] Calling initcall 0xffffffff807523cd: x8664_sysctl_init+0x0/0x16()
[   40.483727] Calling initcall 0xffffffff80752c81: aes_init+0x0/0x320()
[   40.490384] Calling initcall 0xffffffff80752fad: ia32_binfmt_init+0x0/0x18()
[   40.497633] Calling initcall 0xffffffff80752fc5: init_syscall32+0x0/0x59()
[   40.504707] Calling initcall 0xffffffff8075301e: init_aout_binfmt+0x0/0xc()
[   40.511864] Calling initcall 0xffffffff80753a91: create_proc_profile+0x0/0x258()
[   40.519958] Calling initcall 0xffffffff80753e4d: ioresources_init+0x0/0x40()
[   40.527207] Calling initcall 0xffffffff80753f7b: timekeeping_init_device+0x0/0x20()
[   40.535179] Calling initcall 0xffffffff807541b8: uid_cache_init+0x0/0x88()
[   40.542269] Calling initcall 0xffffffff80754671: init_posix_timers+0x0/0x89()
[   40.549605] Calling initcall 0xffffffff80754728: init_posix_cpu_timers+0x0/0x5e()
[   40.557386] Calling initcall 0xffffffff807547f6: latency_init+0x0/0x22()
[   40.564286] Calling initcall 0xffffffff80754825: init_clocksource_sysfs+0x0/0x50()
[   40.572168] Calling initcall 0xffffffff807548fd: init_jiffies_clocksource+0x0/0xc()
[   40.580120] Calling initcall 0xffffffff80754909: init+0x0/0x63()
[   40.586330] Calling initcall 0xffffffff8075496c: proc_dma_init+0x0/0x22()
[   40.593317] Calling initcall 0xffffffff80241fb3: percpu_modinit+0x0/0x73()
[   40.600389] Calling initcall 0xffffffff8075499d: kallsyms_init+0x0/0x25()
[   40.607368] Calling initcall 0xffffffff807549e9: crash_notes_memory_init+0x0/0x3c()
[   40.615317] Calling initcall 0xffffffff80754b57: ikconfig_init+0x0/0x3b()
[   40.622304] Calling initcall 0xffffffff80754c01: audit_init+0x0/0x116()
[   40.629117] audit: initializing netlink socket (disabled)
[   40.634631] audit(1160327843.480:1): initialized
[   40.639362] Calling initcall 0xffffffff80754d96: init_kprobes+0x0/0x53()
[   40.646266] Calling initcall 0xffffffff80755e81: init_per_zone_pages_min+0x0/0x3e()
[   40.654222] Calling initcall 0xffffffff80756767: pdflush_init+0x0/0x13()
[   40.661141] Calling initcall 0xffffffff80756795: kswapd_init+0x0/0x1a()
[   40.667970] Calling initcall 0xffffffff807567af: setup_vmstat+0x0/0x16()
[   40.674865] Calling initcall 0xffffffff80756823: procswaps_init+0x0/0x23()
[   40.681937] Calling initcall 0xffffffff80756846: init_tmpfs+0x0/0xc0()
[   40.688666] Calling initcall 0xffffffff80756906: cpucache_init+0x0/0x2f()
[   40.695653] Calling initcall 0xffffffff80756f5e: fasync_init+0x0/0x2a()
[   40.702469] Calling initcall 0xffffffff80757553: aio_setup+0x0/0x64()
[   40.709131] Calling initcall 0xffffffff8075777b: inotify_setup+0x0/0xd()
[   40.716027] Calling initcall 0xffffffff80757788: inotify_user_setup+0x0/0xbb()
[   40.723558] Calling initcall 0xffffffff80757843: eventpoll_init+0x0/0xd0()
[   40.730639] Calling initcall 0xffffffff80757913: init_sys32_ioctl+0x0/0x92()
[   40.737893] Calling initcall 0xffffffff807579f2: init_mbcache+0x0/0x1d()
[   40.744788] Calling initcall 0xffffffff80757a0f: dquot_init+0x0/0xe9()
[   40.751507] VFS: Disk quotas dquot_6.5.1
[   40.755558] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   40.762107] Calling initcall 0xffffffff80757af8: dnotify_init+0x0/0x2a()
[   40.769443] Calling initcall 0xffffffff80757f71: configfs_init+0x0/0x91()
[   40.776436] Calling initcall 0xffffffff80758002: init_devpts_fs+0x0/0x33()
[   40.783507] Calling initcall 0xffffffff80758035: init_reiserfs_fs+0x0/0x8e()
[   40.790755] Calling initcall 0xffffffff807581d9: init_ext3_fs+0x0/0x63()
[   40.797660] Calling initcall 0xffffffff807582e8: journal_init+0x0/0xbb()
[   40.804573] Calling initcall 0xffffffff807583a3: init_ext2_fs+0x0/0x63()
[   40.811480] Calling initcall 0xffffffff80758438: init_cramfs_fs+0x0/0x27()
[   40.818556] Calling initcall 0xffffffff8075845f: init_ramfs_fs+0x0/0xc()
[   40.825452] Calling initcall 0xffffffff807584ac: init_fat_fs+0x0/0x48()
[   40.832265] Calling initcall 0xffffffff807584f4: init_msdos_fs+0x0/0xc()
[   40.839159] Calling initcall 0xffffffff80758500: init_vfat_fs+0x0/0xc()
[   40.845966] Calling initcall 0xffffffff8075850c: init_iso9660_fs+0x0/0x65()
[   40.853130] Calling initcall 0xffffffff80758695: init_nfs_fs+0x0/0xbe()
[   40.859973] Calling initcall 0xffffffff807588ff: init_nfsd+0x0/0xa3()
[   40.866607] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   40.873189] Calling initcall 0xffffffff807589a2: init_nlm+0x0/0x21()
[   40.879747] Calling initcall 0xffffffff807589c3: init_nls_ascii+0x0/0xc()
[   40.886729] Calling initcall 0xffffffff807589cf: init_nls_utf8+0x0/0x1f()
[   40.893708] Calling initcall 0xffffffff807589ee: init_smb_fs+0x0/0x65()
[   40.900522] Calling initcall 0xffffffff80758a53: init_cifs+0x0/0x4f8()
[   40.907301] Calling initcall 0xffffffff80758f4b: init_romfs_fs+0x0/0x53()
[   40.914286] Calling initcall 0xffffffff80758f9e: init_autofs_fs+0x0/0xc()
[   40.921270] Calling initcall 0xffffffff80758faa: init_autofs4_fs+0x0/0xc()
[   40.928342] initcall at 0xffffffff80758faa: init_autofs4_fs+0x0/0xc(): returned with error code -16
[   40.940275] Calling initcall 0xffffffff80759005: fuse_init+0x0/0x10a()
[   40.946994] fuse init (API version 7.7)
[   40.950983] Calling initcall 0xffffffff8075911b: init_udf_fs+0x0/0x53()
[   40.957801] Calling initcall 0xffffffff8075916e: init_jfs_fs+0x0/0x1c7()
[   40.964708] JFS: nTxBlock = 8192, nTxLock = 65536
[   40.972792] Calling initcall 0xffffffff8075948e: init_xfs_fs+0x0/0x115()
[   40.979691] SGI XFS with ACLs, large block/inode numbers, no debug enabled
[   40.986819] SGI XFS Quota Management subsystem
[   40.991383] Calling initcall 0xffffffff807595a3: ipc_init+0x0/0x14()
[   40.997934] Calling initcall 0xffffffff807597e7: init_mqueue_fs+0x0/0xcd()
[   41.005030] Calling initcall 0xffffffff80759a0e: key_proc_init+0x0/0x52()
[   41.012016] Calling initcall 0xffffffff80759a60: crypto_algapi_init+0x0/0xa()
[   41.019349] Calling initcall 0xffffffff80759a8a: cryptomgr_init+0x0/0xc()
[   41.026751] Calling initcall 0xffffffff80759a96: hmac_module_init+0x0/0xc()
[   41.033903] Calling initcall 0xffffffff80759aa2: init+0x0/0x53()
[   41.040105] Calling initcall 0xffffffff80759af5: init+0x0/0xc()
[   41.046225] Calling initcall 0xffffffff80759b01: init+0x0/0xc()
[   41.052339] Calling initcall 0xffffffff80759b0d: init+0x0/0xc()
[   41.058454] Calling initcall 0xffffffff80759b19: init+0x0/0x35()
[   41.064664] Calling initcall 0xffffffff80759b4e: aes_init+0x0/0x322()
[   41.071319] Calling initcall 0xffffffff80759e70: init+0x0/0xc()
[   41.077436] Calling initcall 0xffffffff8075a016: noop_init+0x0/0xc()
[   41.083990] io scheduler noop registered
[   41.088072] Calling initcall 0xffffffff8075a022: as_init+0x0/0xc()
[   41.094452] io scheduler anticipatory registered (default)
[   41.100136] Calling initcall 0xffffffff8075a02e: deadline_init+0x0/0xc()
[   41.107035] io scheduler deadline registered
[   41.111462] Calling initcall 0xffffffff8075a03a: cfq_init+0x0/0x9d()
[   41.118017] io scheduler cfq registered
[   41.122004] Calling initcall 0xffffffff80429db3: pci_init+0x0/0x2b()
[   41.130429] Calling initcall 0xffffffff8075a9f3: pci_sysfs_init+0x0/0x34()
[   41.137551] Calling initcall 0xffffffff8075aa27: pci_proc_init+0x0/0x68()
[   41.144550] Calling initcall 0xffffffff8075aa8f: pcie_portdrv_init+0x0/0x3b()
[   41.151969] assign_interrupt_mode Found MSI capability
[   41.157341] assign_interrupt_mode Found MSI capability
[   41.162744] assign_interrupt_mode Found MSI capability
[   41.168121] assign_interrupt_mode Found MSI capability
[   41.173464] Calling initcall 0xffffffff8075aaca: aer_service_init+0x0/0xc()
[   41.180636] Calling initcall 0xffffffff8075aeb0: fb_console_init+0x0/0x110()
[   41.187894] Calling initcall 0xffffffff80440aea: nvidiafb_init+0x0/0x22a()
[   41.194995] ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[   41.202657] nvidiafb: Device ID: 10de0391
[   41.221616] nvidiafb: CRTC0 analog found
[   41.241421] nvidiafb: CRTC1 analog not found
[   41.261958] nvidiafb: EDID found from BUS1
[   41.380769] nvidiafb: EDID found from BUS2
[   41.384985] nvidiafb: CRTC 0 appears to have a CRT attached
[   41.390665] nvidiafb: Using CRT on CRTC 0

nvGetClocks: arch=64 p4020=0xa4301000 p4024=0x00005303 M=3 N=83 MB=0 NB=0 P=0
</log>

<config>
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.19-rc1
# Sun Oct  8 09:20:42 2006
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_ZONE_DMA32=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_DMI=y
CONFIG_AUDIT_ARCH=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION="-w8"
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_IPC_NS is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_UTS_NS is not set
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_CPUSETS=y
CONFIG_RELAY=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
CONFIG_BLOCK=y
CONFIG_LBD=y
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VSMP is not set
# CONFIG_MK8 is not set
CONFIG_MPSC=y
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=128
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_INTERNODE_CACHE_BYTES=128
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_HT=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
# CONFIG_MTRR is not set
CONFIG_SMP=y
# CONFIG_SCHED_SMT is not set
CONFIG_SCHED_MC=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_BKL=y
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_RESOURCES_64BIT=y
CONFIG_NR_CPUS=4
# CONFIG_HOTPLUG_CPU is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
CONFIG_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x200000
CONFIG_SECCOMP=y
# CONFIG_CC_STACKPROTECTOR is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# CONFIG_REORDER is not set
CONFIG_K8_NB=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y
CONFIG_GENERIC_PENDING_IRQ=y

#
# Power management options
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set
# CONFIG_PM_SYSFS_DEPRECATED is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_HOTKEY=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_SBS is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_CPU_FREQ_DEBUG=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_POWERNOW_K8 is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
CONFIG_X86_ACPI_CPUFREQ=y

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCI_MSI=y
# CONFIG_PCI_MULTITHREAD_PROBE is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_HT_IRQ=y

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
CONFIG_NETWORK_SECMARK=y
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=y
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_TCPPROBE is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
CONFIG_BLK_DEV_INITRD=y
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIIMAGE=y
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
CONFIG_SCSI_EATA=y
CONFIG_SCSI_EATA_TAGGED_QUEUE=y
CONFIG_SCSI_EATA_LINKED_COMMANDS=y
CONFIG_SCSI_EATA_MAX_TAGS=16
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set

#
# Serial ATA (prod) and Parallel ATA (experimental) drivers
#
CONFIG_ATA=y
CONFIG_SATA_AHCI=y
# CONFIG_SATA_SVW is not set
CONFIG_ATA_PIIX=y
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
CONFIG_SATA_PROMISE=y
# CONFIG_SATA_SX4 is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set
CONFIG_SATA_INTEL_COMBINED=y
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_ATA_GENERIC=y
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT821X is not set
CONFIG_PATA_JMICRON=y
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_MPIIX=y
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
CONFIG_SKY2=y
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=y
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_XTKBD=y
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=y
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=y

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_CHARDEV is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set
# CONFIG_TIFM_CORE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_USB_DABUSB is not set

#
# Graphics support
#
CONFIG_FIRMWARE_EDID=y
CONFIG_FB=y
# CONFIG_FB_DDC is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_VIDEO_SELECT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
# CONFIG_LOGO is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_TOUCHSCREEN is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set
# CONFIG_USB_TRANCEVIBRATOR is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
# CONFIG_EDAC is not set

#
# Real Time Clock
#
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set

#
# RTC drivers
#
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_TEST is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# DMA Engine support
#
CONFIG_DMA_ENGINE=y

#
# DMA Clients
#
CONFIG_NET_DMA=y

#
# DMA Devices
#
CONFIG_INTEL_IOATDMA=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_SECURITY is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
CONFIG_CONFIGFS_FS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=y
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
# CONFIG_ACORN_PARTITION_EESOX is not set
CONFIG_ACORN_PARTITION_ICS=y
# CONFIG_ACORN_PARTITION_ADFS is not set
# CONFIG_ACORN_PARTITION_POWERTEC is not set
CONFIG_ACORN_PARTITION_RISCIX=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# Instrumentation Support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=y
CONFIG_KPROBES=y

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_PRINTK_TIME=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=15
# CONFIG_DETECT_SOFTLOCKUP is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_UNWIND_INFO is not set
CONFIG_FORCED_INLINING=y
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_LKDTM is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_IOMMU_DEBUG is not set
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_DEBUG_PROC_KEYS=y
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_ECB is not set
# CONFIG_CRYPTO_CBC is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#

#
# Library routines
#
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC32=y
CONFIG_LIBCRC32C=y
CONFIG_ZLIB_INFLATE=y
CONFIG_PLIST=y
</config>

<diff>
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index e34bd03..60df916 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2247,6 +2247,22 @@ static void serial8250_console_putchar(s
   serial_out(up, UART_TX, ch);
}

+void lldb_wrch(int port_idx, char ch)
+{
+    serial8250_console_putchar((struct uart_port *)&serial8250_ports[port_idx], ch);
+}
+EXPORT_SYMBOL(lldb_wrch);
+
+void lldb_wrstr(int port_idx, const char *str)
+{
+    int    ch;
+
+    while((ch = *str++)) {
+        lldb_wrch(port_idx, ch);   +    }
+}
+EXPORT_SYMBOL(lldb_wrstr);
+
/*
*    Print a string to the serial port trying not to disturb
*    any possible real use of the port...
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index daaa486..7a43020 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -701,7 +701,6 @@ config FB_NVIDIA
   depends on FB && PCI
   select I2C_ALGOBIT if FB_NVIDIA_I2C
   select I2C if FB_NVIDIA_I2C
-    select FB_DDC if FB_NVIDIA_I2C
   select FB_MODE_HELPERS
   select FB_CFB_FILLRECT
   select FB_CFB_COPYAREA
diff --git a/drivers/video/nvidia/nv_hw.c b/drivers/video/nvidia/nv_hw.c
index 9ed640d..c075516 100644
--- a/drivers/video/nvidia/nv_hw.c
+++ b/drivers/video/nvidia/nv_hw.c
@@ -54,6 +54,8 @@ #include "nv_type.h"
#include "nv_local.h"
#include "nv_proto.h"

+#include <linux/lldb.h>
+
void NVLockUnlock(struct nvidia_par *par, int Lock)
{
   u8 cr11;
@@ -141,16 +143,21 @@ typedef struct {
static void nvGetClocks(struct nvidia_par *par, unsigned int *MClk,
           unsigned int *NVClk)
{
-    unsigned int pll, N, M, MB, NB, P;
+    unsigned int pll, N, M, MB, NB, P, p4020;
+    char buf[200];

   if (par->Architecture >= NV_ARCH_40) {
       pll = NV_RD32(par->PMC, 0x4020);
+        p4020 = pll;
       P = (pll >> 16) & 0x03;
       pll = NV_RD32(par->PMC, 0x4024);
       M = pll & 0xFF;
       N = (pll >> 8) & 0xFF;
       MB = (pll >> 16) & 0xFF;
       NB = (pll >> 24) & 0xFF;
+        snprintf(buf, sizeof(buf), "\r\nnvGetClocks: arch=%d p4020=0x%08x p4024=0x%08x M=%d N=%d MB=%d NB=%d P=%d",
+                       par->Architecture, p4020, pll, M, N, MB, NB, P);
+        LLDB_WRSTR(buf);
       *MClk = ((N * NB * par->CrystalFreqKHz) / (M * MB)) >> P;

       pll = NV_RD32(par->PMC, 0x4000);
diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
index e48de3c..19eef3a 100644
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -160,12 +160,51 @@ void nvidia_delete_i2c_busses(struct nvi

}

+static u8 *nvidia_do_probe_i2c_edid(struct nvidia_i2c_chan *chan)
+{
+    u8 start = 0x0;
+    struct i2c_msg msgs[] = {
+        {
+         .addr = 0x50,
+         .len = 1,
+         .buf = &start,
+         }, {
+             .addr = 0x50,
+             .flags = I2C_M_RD,
+             .len = EDID_LENGTH,
+             },
+    };
+    u8 *buf;
+
+    if (!chan->par)
+        return NULL;
+
+    buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
+    if (!buf) {
+        dev_warn(&chan->par->pci_dev->dev, "Out of memory!\n");
+        return NULL;
+    }
+    msgs[1].buf = buf;
+
+    if (i2c_transfer(&chan->adapter, msgs, 2) == 2)
+        return buf;
+    dev_dbg(&chan->par->pci_dev->dev, "Unable to read EDID block.\n");
+    kfree(buf);
+    return NULL;
+}
+
int nvidia_probe_i2c_connector(struct fb_info *info, int conn, u8 **out_edid)
{
   struct nvidia_par *par = info->par;
-    u8 *edid;
-
-    edid = fb_ddc_read(&par->chan[conn - 1].adapter);
+    u8 *edid = NULL;
+    int i;
+
+    for (i = 0; i < 3; i++) {
+        /* Do the real work */
+        edid = nvidia_do_probe_i2c_edid(&par->chan[conn - 1]);
+        if (edid)
+            break;
+    }

   if (!edid && conn == 1) {
       /* try to get from firmware */
diff --git a/include/linux/lldb.h b/include/linux/lldb.h
new file mode 100644
index 0000000..728b990
--- /dev/null
+++ b/include/linux/lldb.h
@@ -0,0 +1,19 @@
+/*
+ *  include/linux/lldb.h
+ *
+ * Low Level Debug capability.
+ * An implementation is in 8250.c which writes directly to a serial port.
+ *
+ * (C) Copyright 2006 Wink Saville
+ * + * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2
+ */
+
+extern void lldb_wrch(int port_idx, char ch);
+extern void lldb_wrstr(int port_idx, const char * str);
+
+#define LLDB_WRCH(ch)        lldb_wrch(0, ch)
+#define LLDB_WRSTR(str)     lldb_wrstr(0, str)
+
</diff>

