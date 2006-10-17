Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWJQXfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWJQXfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 19:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWJQXfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 19:35:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:41591 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751143AbWJQXfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 19:35:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Iaa1VgtX5fg1W1Bzhlfjk3F4zu6+h+/K6Xtgw/jhXNOLr+eFHrEPPLC6dCqIN8fywvowDaBjXkfckLWofbnzLoQCtbiKPo4iMUybIl6J/dPfjaCER7J2uU9hRjCsa0nyKlnR2ZPAFCUtajgNZ6qNIsKVEMye5NtuxwQeSVldUMA=
Message-ID: <28bb77d30610171634l5db9d909v2c4cd12972e9d5@mail.gmail.com>
Date: Tue, 17 Oct 2006 16:34:59 -0700
From: "Steven Truong" <midair77@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Machine Check Exception on dual core Xeon
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all.  I have this node of dual core Xeon 3.2 GHz, 4 Gig of RAM and
kernel 2.16.18 on CentOS 4.3.  I got kernel panic and after setting up
kdump/kexec I was able to capture the kdump core.
I found out this message with crash to analyze the core dump:

HARDWARE ERROR
CPU 0: Machine Check Exception:                4 Bank 3: 0000000000000000
TSC 0
This is not a software problem!
Run through mcelog --ascii to decode and contact your hardware vendor
Kernel panic - not syncing: Uncorrected machine check

 looked into /var/log/mcelog but found nothing there.  Could the
experts here tell me what went wrong with this node?  Hardware?
Heating? If hardware, then what possibly is the component?

Thank you very much for all the helps and hints.

########
I also used kdump2gdb to and gdb to analyze the coredump.  Here is
what I found with this:

[root@node30 kdump2gdb-0.2]# gdb ../linux-2.6.18/vmlinux corefile.kdump
GNU gdb Red Hat Linux (6.3.0.0-1.96rh)

This GDB was configured as "x86_64-redhat-linux-gnu"...Using host
libthread_db library "/lib64/tls/libthread_db.so.1".

#0  0xffffffff80251bc5 in crash_kexec (regs=0x0) at include/asm/kexec.h:64
64                      newregs->rip = (unsigned long)current_text_addr();
(gdb) source modload
(gdb) bt
#0  0xffffffff80251bc5 in crash_kexec (regs=0x0) at include/asm/kexec.h:64
#1  0xffffffff8022f9c8 in panic (
    fmt=0xffffffff80474572 "Uncorrected machine check") at kernel/panic.c:88
#2  0xffffffff802115ef in mce_panic (msg=Variable "msg" is not available.
) at arch/x86_64/kernel/mce.c:139
#3  0x0000000000000000 in ?? ()
(gdb) bt full
#0  0xffffffff80251bc5 in crash_kexec (regs=0x0) at include/asm/kexec.h:64
        fixed_regs = {r15 = 18446744071566738802, r14 = 25800754611264,
  r13 = 18446744071567119040, r12 = 4294967295, rbp = 2304,
  rbx = 18446744071566738802, r11 = 18446744071565359391,
  r10 = 18446744071565359391, r9 = 18446744071568231080,
  r8 = 18446744071567139800, rax = 18446604440481787904,
  rcx = 18446744071567139800, rdx = 18446744071567139800, rsi = 262214,
  rdi = 0, orig_rax = 18446744071566576869, rip = 18446744071564499909,
  cs = 16, eflags = 262214, rsp = 18446744071568231528, ss = 24}
#1  0xffffffff8022f9c8 in panic (
    fmt=0xffffffff80474572 "Uncorrected machine check") at kernel/panic.c:88
        i = -2142812814
        buf = "Uncorrected machine check", '\0' <repeats 998 times>
        args = {{gp_offset = 8, fp_offset = 48,
    overflow_arg_area = 0xffffffff805e0e08,
    reg_save_area = 0xffffffff805e0d48}}
#2  0xffffffff802115ef in mce_panic (msg=Variable "msg" is not available.
) at arch/x86_64/kernel/mce.c:139
        i = Variable "i" is not available.

#################
I then also use crash to analyze this and here what I found out with crash:
     KERNEL: ../linux-2.6.18/vmlinux
    DUMPFILE: ../kdump.core
        CPUS: 4
        DATE: Fri Oct 13 12:58:04 2006
      UPTIME: 02:13:51
LOAD AVERAGE: 1.99, 1.97, 1.81
       TASKS: 82
    NODENAME: node30.nanostellar.com
     RELEASE: 2.6.18
     VERSION: #1 SMP Mon Oct 9 14:42:15 PDT 2006
     MACHINE: x86_64  (3200 Mhz)
      MEMORY: 4.5 GB
       PANIC: ""
         PID: 3418
     COMMAND: "vaspmpi"
        TASK: ffff81010f4f7000  [THREAD_INFO: ffff810111488000]
         CPU: 0
       STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 3418   TASK: ffff81010f4f7000  CPU: 0   COMMAND: "vaspmpi"
 #0 [ffffffff805e0be8] crash_kexec at ffffffff80251bc5
 #1 [ffffffff805e0c20] machine_kexec at ffffffff8021a45e
 #2 [ffffffff805e0c60] crash_kexec at ffffffff80251be1
 #3 [ffffffff805e0ce0] _spin_lock_irqsave at ffffffff8044cce5
 #4 [ffffffff805e0ce8] crash_kexec at ffffffff80251bc5
 #5 [ffffffff805e0d10] bust_spinlocks at ffffffff8021e27a
 #6 [ffffffff805e0d20] panic at ffffffff8022f9c8
 #7 [ffffffff805e0dd0] _spin_trylock at ffffffff8044cc99
 #8 [ffffffff805e0de0] oops_begin at ffffffff8044d4ae
 #9 [ffffffff805e0df0] print_mce at ffffffff80211545
#10 [ffffffff805e0e40] do_machine_check at ffffffff80211967
#11 [ffffffff805e0f50] machine_check at ffffffff8020a96f
    [exception RIP: netif_receive_skb+28]
  RIP: ffffffff803ed137  RSP: ffffffff805dae00  RFLAGS: 00000246
    RAX: ffff810119a12000  RBX: 0000000000000023  RCX: 0000000000000000
    RDX: ffff810119a12580  RSI: ffff810119a12000  RDI: ffff810117f37480
    RBP: ffff810117f37480   R8: 0000000000000000   R9: ffff810115f28012
    R10: 0000000000006000  R11: 00000000000048c4  R12: 0000000000000040
    R13: 000000000000102e  R14: ffff810117f37480  R15: 0000000000000001
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <exception stack> ---
#12 [ffffffff805dae00] netif_receive_skb at ffffffff803ed137
#13 [ffffffff805dae38] e1000_clean_rx_irq at ffffffff880cda58
#14 [ffffffff805daec8] e1000_clean at ffffffff880cd515
#15 [ffffffff805daf08] net_rx_action at ffffffff803ed5d6
#16 [ffffffff805daf38] __do_softirq at ffffffff80235069
#17 [ffffffff805daf68] call_softirq at ffffffff8020a994
#18 [ffffffff805daf80] do_softirq at ffffffff8020be74
#19 [ffffffff805daf90] do_IRQ at ffffffff8020bd19
--- <IRQ stack> ---
#20 [ffff810111489aa0] ret_from_intr at ffffffff80209cb9
    [exception RIP: zone_statistics+64]
    RIP: ffffffff80269139  RSP: ffff81010bba6800  RFLAGS: 00003914
    RAX: ffffffffffffffed  RBX: 000000000c100600  RCX: ffffffff80420f92
    RDX: 0000000000000010  RSI: 0000000000000216  RDI: ffff810111489b28
    RBP: ffff8100dc00a9f0   R8: ffff81010bba6800   R9: 000000001401000a
    R10: 0000000032020014  R11: 0000000000000010  R12: 0000000000000fec
    R13: 0000000000006000  R14: 00000000000048c4  R15: ffff810116c7f0e0
    ORIG_RAX: 0000000000000018  CS: 48c4  SS: ffff810116c7f0e0
WARNING: possibly bogus exception frame
#21 [ffff810111489b50] tcp_transmit_skb at ffffffff8041bfee
#22 [ffff810111489b90] __tcp_push_pending_frames at ffffffff8041d5ee
#23 [ffff810111489ba0] __alloc_pages at ffffffff80263759
#24 [ffff810111489bf0] tcp_sendmsg at ffffffff80412d98
#25 [ffff810111489c70] do_sock_write at ffffffff803e3031
#26 [ffff810111489ca0] sock_writev at ffffffff803e3118
#27 [ffff810111489d00] sock_common_recvmsg at ffffffff803e671b
#28 [ffff810111489d30] sys_semtimedop at ffffffff802d4cb7
#29 [ffff810111489e00] do_sync_read at ffffffff802833b8
#30 [ffff810111489e60] do_readv_writev at ffffffff80283b61
#31 [ffff810111489f40] sys_writev at ffffffff80283dd3
#32 [ffff810111489f80] system_call at ffffffff802097be
    RIP: 000000377b0bea67  RSP: 00007fffc6dc29e0  RFLAGS: 00000207
   RAX: 0000000000000014  RBX: ffffffff802097be  RCX: 000000000002bfc0
    RDX: 0000000000000002  RSI: 00007fffc6dbe3f0  RDI: 0000000000000007
    RBP: 0000000000000fcc   R8: 0000000000000fcc   R9: 0000000000000001
    R10: 00007fffc6dbe54c  R11: 0000000000000246  R12: 0000000000000007
    R13: 00007fffc6dbe3f0  R14: 0000000000000002  R15: 00000000f3c01640
    ORIG_RAX: 0000000000000014  CS: 0033  SS: 002b
crash> dis  ffffffff802097be 10
0xffffffff802097be <system_call+126>:   mov    %rax,0x20(%rsp)
0xffffffff802097c3 <ret_from_sys_call>: mov    $0xfeff,%edi
0xffffffff802097c8 <sysret_check>:      mov    %gs:0x10,%rcx
0xffffffff802097d1 <sysret_check+9>:    sub    $0x1fd8,%rcx
0xffffffff802097d8 <sysret_check+16>:   cli
0xffffffff802097d9 <sysret_check+17>:   mov    0x10(%rcx),%edx
0xffffffff802097dc <sysret_check+20>:   and    %edi,%edx
0xffffffff802097de <sysret_check+22>:
    jne    0xffffffff8020981b <sysret_careful>
0xffffffff802097e0 <sysret_check+24>:   mov    0x50(%rsp),%rcx
0xffffffff802097e5 <sysret_check+29>:   mov    (%rsp),%r11
crash> sESC[ESC[Kdis  ffffffff8041bfee 10
0xffffffff8041bfee <tcp_transmit_skb+1184>:     mov    (%rsp),%rbx
0xffffffff8041bff2 <tcp_transmit_skb+1188>:     testb  $0x10,0x24(%rbx)
0xffffffff8041bff6 <tcp_transmit_skb+1192>:
    je     0xffffffff8041c03e <tcp_transmit_skb+1264>
0xffffffff8041bff8 <tcp_transmit_skb+1194>:     movzbl 0x449(%rbp),%edx
0xffffffff8041bfff <tcp_transmit_skb+1201>:     mov    0xe8(%r13),%rax
0xffffffff8041c006 <tcp_transmit_skb+1208>:     test   %dl,%dl
0xffffffff8041c008 <tcp_transmit_skb+1210>:     movzwl 0x8(%rax),%ecx
0xffffffff8041c00c <tcp_transmit_skb+1214>:
    je     0xffffffff8041c030 <tcp_transmit_skb+1250>
0xffffffff8041c00e <tcp_transmit_skb+1216>:     movzbl %dl,%eax
0xffffffff8041c011 <tcp_transmit_skb+1219>:     cmp    %eax,%ecx
crash> dis ffffffff80209cb9 10
0xffffffff80209cb9 <ret_from_intr>:     cli
0xffffffff80209cba <ret_from_intr+1>:   decl   %gs:0x28
0xffffffff80209cc2 <ret_from_intr+9>:   leaveq
0xffffffff80209cc3 <exit_intr>: mov    %gs:0x10,%rcx
0xffffffff80209ccc <exit_intr+9>:       sub    $0x1fd8,%rcx
0xffffffff80209cd3 <exit_intr+16>:      testl  $0x3,0x58(%rsp)
0xffffffff80209cdb <exit_intr+24>:
    je     0xffffffff80209cef <retint_restore_args>
0xffffffff80209cdd <retint_with_reschedule>:    mov    $0xfe6e,%edi
0xffffffff80209ce2 <retint_check>:      mov    0x10(%rcx),%edx
0xffffffff80209ce5 <retint_check+3>:    and    %edi,%edx
0xffffffff803ed137 <netif_receive_skb+28>:      cmpq   $0x0,0x190(%rax)
0xffffffff803ed13f <netif_receive_skb+36>:
    je     0xffffffff803ed19e <netif_receive_skb+131>
0xffffffff803ed141 <netif_receive_skb+38>:      mov    0x3c8(%rax),%rbx
0xffffffff803ed148 <netif_receive_skb+45>:      xor    %r13d,%r13d
0xffffffff803ed14b <netif_receive_skb+48>:      test   %rbx,%rbx
0xffffffff803ed14e <netif_receive_skb+51>:
    je     0xffffffff803ed19e <netif_receive_skb+131>
0xffffffff803ed150 <netif_receive_skb+53>:      cmpq   $0x0,0x40(%rbx)
0xffffffff803ed155 <netif_receive_skb+58>:
    jne    0xffffffff803ed15d <netif_receive_skb+66>
0xffffffff803ed157 <netif_receive_skb+60>:      cmpl   $0x0,0x20(%rbx)
0xffffffff803ed15b <netif_receive_skb+64>:
    je     0xffffffff803ed19e <netif_receive_skb+131>
crash> dis ffffffff8020a96f 10
0xffffffff8020a96f <machine_check+127>: cli
0xffffffff8020a970 <machine_check+128>:
    jmpq   0xffffffff8044d25b <paranoid_exit1>
0xffffffff8020a975 <machine_check+133>: data16
0xffffffff8020a976 <machine_check+134>: data16
0xffffffff8020a977 <machine_check+135>: nop
0xffffffff8020a978 <call_softirq>:      push   %rbp
0xffffffff8020a979 <call_softirq+1>:    mov    %rsp,%rbp
0xffffffff8020a97c <call_softirq+4>:    incl   %gs:0x28
0xffffffff8020a984 <call_softirq+12>:   cmove  %gs:0x30,%rsp
0xffffffff8020a98e <call_softirq+22>:   push   %rbp
crash> irq

irq: invalid structure member offset: irq_desc_t_handler
     FILE: kernel.c  LINE: 3591  FUNCTION: generic_dump_irq()

[./crash] error trace: 4a1b7d => 4bc279 => 4a1d31 => 4e21f5

  4e21f5: OFFSET_verify+117
  4a1d31: generic_dump_irq+310
  4bc279: x86_64_dump_irq+51
  4a1b7d: cmd_irq+504

irq: invalid structure member offset: irq_desc_t_handler
     FILE: kernel.c  LINE: 3591  FUNCTION: generic_dump_irq()

crash> ps

....
>     0      1   2  ffff81011b4d7000  RU   0.0       0      0  [swapper]
>     0      1   3  ffff81011b54e000  RU   0.0       0      0  [swapper]
....
>  3403   2926   1  ffff81010bbc8000  RU   3.8  467108 181156  vaspmpi
>  3418   3403   0  ffff81010f4f7000  RU   3.8  465896 179272  vaspmpi
   3419   3403   2  ffff81011791c000  IN   0.0  285676    772  vaspmpi

crash> log
Bootdata ok (command line is ro root=/dev/sda3 crashkernel=128M@16M
rhgb quiet)Linux version 2.6.18 (root@node30.nanostellar.com) (gcc
version 3.4.5 20051201 ( Red Hat 3.4.5-2)) #1 SMP Mon Oct 9 14:42:15
PDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009cc00 (usable)
 BIOS-e820: 000000000009cc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ea070 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dffe0000 (usable)
 BIOS-e820: 00000000dffe0000 - 00000000dffef000 (ACPI data)
 BIOS-e820: 00000000dffef000 - 00000000dfff0000 (ACPI NVS)
 BIOS-e820: 00000000dfff0000 - 00000000e0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec86000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f7740
ACPI: RSDT (v001 A M I  OEMRSDT  0x03000529 MSFT 0x00000097) @
0x00000000dffe0000
ACPI: FADT (v002 A M I  OEMFACP  0x03000529 MSFT 0x00000097) @
0x00000000dffe0200
ACPI: MADT (v001 A M I  OEMAPIC  0x03000529 MSFT 0x00000097) @
0x00000000dffe0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x03000529 MSFT 0x00000097) @
0x00000000dffef040
ACPI: DSDT (v001  DVA4G DVA4G007 0x00000007 INTL 0x02002026) @
0x0000000000000000
No NUMA configuration found
Faking a node at 0000000000000000-0000000120000000
Bootmem setup node 0 0000000000000000-0000000120000000
On node 0 totalpages: 1028721
  DMA zone: 2641 pages, LIFO batch:0
  DMA32 zone: 897056 pages, LIFO batch:31
  Normal zone: 129024 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:4 APIC version 20
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x0b] address[0xfec10000] gsi_base[72])
IOAPIC[1]: apic_id 11, version 32, address 0xfec10000, GSI 72-95
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
IOAPIC[2]: apic_id 9, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec80400] gsi_base[48])
IOAPIC[3]: apic_id 10, version 32, address 0xfec80400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at e2000000 (gap: e0000000:1ec00000)
SMP: Allowing 4 CPUs, 0 hotplug CPUs
Built 1 zonelists.  Total pages: 1028721
Kernel command line: ro root=/dev/sda3 crashkernel=128M@16M rhgb quiet
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 3200.201 MHz processor.
Console: colour VGA+ 80x25
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:failed|failed|  ok  |failed|failed|failed|
                 A-B-B-A deadlock:failed|failed|  ok  |failed|failed|failed|
             A-B-B-C-C-A deadlock:failed|failed|  ok  |failed|failed|failed|
             A-B-C-A-B-C deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-B-C-C-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-C-D-B-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-C-D-B-C-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
                    double unlock:  ok  |  ok  |failed|failed|failed|failed|
                  initialize held:failed|failed|failed|failed|failed|failed|
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |failed|
           recursive read-lock #2:             |  ok  |             |failed|
            mixed read-write-lock:             |failed|             |failed|
            mixed write-read-lock:             |failed|             |failed|
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:failed|failed|  ok  |
     soft-irqs-on + irq-safe-A/12:failed|failed|  ok  |
     hard-irqs-on + irq-safe-A/21:failed|failed|  ok  |
     soft-irqs-on + irq-safe-A/21:failed|failed|  ok  |
       sirq-safe-A => hirqs-on/12:failed|failed|  ok  |
       sirq-safe-A => hirqs-on/21:failed|failed|  ok  |
         hard-safe-A + irqs-on/12:failed|failed|  ok  |
         soft-safe-A + irqs-on/12:failed|failed|  ok  |
         hard-safe-A + irqs-on/21:failed|failed|  ok  |
         soft-safe-A + irqs-on/21:failed|failed|  ok  |
 hard-safe-A + unsafe-B #1/123:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/123:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/132:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/132:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/213:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/213:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/231:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/231:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/312:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/312:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/321:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/321:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/123:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/123:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/132:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/132:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/213:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/213:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/231:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/231:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/312:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/312:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/321:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/321:failed|failed|  ok  |
      hard-irq lock-inversion/123:failed|failed|  ok  |
      soft-irq lock-inversion/123:failed|failed|  ok  |
      hard-irq lock-inversion/132:failed|failed|  ok  |
      soft-irq lock-inversion/132:failed|failed|  ok  |
      hard-irq lock-inversion/213:failed|failed|  ok  |
      soft-irq lock-inversion/213:failed|failed|  ok  |
      hard-irq lock-inversion/231:failed|failed|  ok  |
      soft-irq lock-inversion/231:failed|failed|  ok  |
      hard-irq lock-inversion/312:failed|failed|  ok  |
      soft-irq lock-inversion/312:failed|failed|  ok  |
      hard-irq lock-inversion/321:failed|failed|  ok  |
      soft-irq lock-inversion/321:failed|failed|  ok  |
      hard-irq read-recursion/123:  ok  |
      soft-irq read-recursion/123:  ok  |
      hard-irq read-recursion/132:  ok  |
      soft-irq read-recursion/132:  ok  |
      hard-irq read-recursion/213:  ok  |
      soft-irq read-recursion/213:  ok  |
      hard-irq read-recursion/231:  ok  |
      soft-irq read-recursion/231:  ok  |
      hard-irq read-recursion/312:  ok  |
      soft-irq read-recursion/312:  ok  |
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
--------------------------------------------------------
143 out of 218 testcases failed, as expected. |
----------------------------------------------------
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing software IO TLB between 0x9669000 - 0xd669000
Memory: 3910268k/4718592k available (2376k kernel code, 283508k reserved, 1547k
data, 204k init)
Calibrating delay using timer specific routine.. 6405.21 BogoMIPS
(lpj=12810427)Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12500719
Detected 12.500 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/4 APIC 0x6
Initializing CPU#1
Calibrating delay using timer specific routine.. 6400.69 BogoMIPS
(lpj=12801380)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.20GHz stepping 03
SMP alternatives: switching to SMP code
Booting processor 2/4 APIC 0x1
Initializing CPU#2
Calibrating delay using timer specific routine.. 6400.21 BogoMIPS
(lpj=12800421)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU2: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.20GHz stepping 03
SMP alternatives: switching to SMP code
Booting processor 3/4 APIC 0x7
Initializing CPU#3
Calibrating delay using timer specific routine.. 6400.83 BogoMIPS
(lpj=12801661)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU3: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.20GHz stepping 03
Brought up 4 CPUs
testing NMI watchdog ... OK.
migration_cost=5,1301
checking if image is initramfs... it is
Freeing initrd memory: 963k freed
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0500-053f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
Boot video device is 0000:06:02.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:03.0
PM: Adding info for pci:0000:00:1c.0
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1d.1
PM: Adding info for pci:0000:00:1d.4
PM: Adding info for pci:0000:00:1d.5
PM: Adding info for pci:0000:00:1d.7
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.2
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:01:00.2
PM: Adding info for pci:0000:05:01.0
PM: Adding info for pci:0000:05:02.0
PM: Adding info for pci:0000:06:02.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EPA0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EPA0.PXHA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EPA0.PXHB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EPA1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PC._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0a
PM: Adding info for pnp:00:0b
PM: Adding info for pnp:00:0c
PM: Adding info for pnp:00:0d
PM: Adding info for pnp:00:0e
PM: Adding info for pnp:00:0f
pnp: PnP ACPI: found 16 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-GART: No AMD northbridge found.
pnp: 00:0a: ioport range 0x295-0x296 has been reserved
pnp: 00:0a: ioport range 0xb78-0xb7f has been reserved
pnp: 00:0d: ioport range 0x680-0x6ff has been reserved
PCI: Bridge: 0000:01:00.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.0
  IO window: c000-cfff
  MEM window: fc900000-fc9fffff
  PREFETCH window: fc700000-fc7fffff
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: fca00000-feafffff
  PREFETCH window: e2000000-e20fffff
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:01:00.0 to 64
PCI: Setting latency timer of device 0000:01:00.2 to 64
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:03.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
PM: Adding info for platform:pcspkr
audit: initializing netlink socket (disabled)
audit(1160736254.140:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:02.0 to 64
Allocate Port Service[0000:00:02.0:pcie00]
PM: Adding info for pci_express:0000:00:02.0:pcie00
PCI: Setting latency timer of device 0000:00:03.0 to 64
Allocate Port Service[0000:00:03.0:pcie00]
PM: Adding info for pci_express:0000:00:03.0:pcie00
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PM: Adding info for platform:vesafb.0
ACPI: Processor [CPU1] (supports 8 throttling states)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:05: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:06: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
ide1: I/O resource 0x170-0x177 not free.
ide1: ports already in use, skipping probe
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
PM: Adding info for platform:i8042
serio: i8042 AUX port at 0x60,0x64 irq 12
PM: Adding info for serio:serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for serio:serio1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 204k freed
Write protecting the kernel read-only data: 454k
SCSI subsystem initialized
input: AT Translated Set 2 keyboard as /class/input/input0
libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ IDE IDE P0 P1 ]
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xFC00 irq 14
scsi0 : ata_piix
PM: Adding info for No Bus:host0
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFC08 irq 15
scsi1 : ata_piix
PM: Adding info for No Bus:host1
ata2.00: ATA-7, max UDMA/133, 156312576 sectors: LBA48
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
PM: Adding info for No Bus:target1:0:0
  Vendor: ATA       Model: WDC WD800JD-08LS  Rev: 07.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
PM: Adding info for scsi:1:0:0:0
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
sd 1:0:0:0: Attached scsi disk sda
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1160736256.076:2): selinux=0 auid=4294967295
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
FDC 0 is a post-1991 82077
Intel(R) PRO/1000 Network Driver - version 7.1.9-k4-NAPI
Copyright (c) 1999-2006 Intel Corporation.
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:05:01.0[A] -> GSI 74 (level, low) -> IRQ 18
e1000: 0000:05:01.0: e1000_validate_option: Receive Interrupt Delay set to 0
e1000: 0000:05:01.0: e1000_check_options: Interrupt Throttling Rate
(ints/sec) turned off
e1000: 0000:05:01.0: e1000_probe: (PCI:66MHz:32-bit) 00:30:48:83:12:66
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:05:02.0[A] -> GSI 75 (level, low) -> IRQ 19
e1000: 0000:05:02.0: e1000_probe: (PCI:66MHz:32-bit) 00:30:48:83:12:67
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 20
PM: Adding info for No Bus:i2c-0
i6300ESB timer: initialized (0xffffc20000004800). heartbeat=30 sec (nowayout=0)
GSI 21 sharing vector 0xD1 and IRQ 21
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 21, io mem 0xfebffc00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
PM: Adding info for No Bus:usbdev1.1_ep81
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000e800
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev2.1_ep81
GSI 22 sharing vector 0xD9 and IRQ 22
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 22, io base 0x0000ec00
PM: Adding info for usb:usb3
PM: Adding info for No Bus:usbdev3.1_ep00
usb usb3: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev3.1_ep81
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
EXT3 FS on sda3, internal journal
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 5742364k swap on /dev/sda2.  Priority:-1 extents:1 across:5742364k
ip_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
ip_tables: (C) 2000-2006 Netfilter Core Team
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
eth0: no IPv6 routers present

HARDWARE ERROR
CPU 0: Machine Check Exception:                4 Bank 3: 0000000000000000
TSC 0
This is not a software problem!
Run through mcelog --ascii to decode and contact your hardware vendor
Kernel panic - not syncing: Uncorrected machine check

crash> exit

I
