Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129081AbQKAI5X>; Wed, 1 Nov 2000 03:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbQKAI5N>; Wed, 1 Nov 2000 03:57:13 -0500
Received: from host213-121-88-34.btopenworld.com ([213.121.88.34]:32504 "EHLO
	gloop.internal") by vger.kernel.org with ESMTP id <S129092AbQKAI5C>;
	Wed, 1 Nov 2000 03:57:02 -0500
Date: Wed, 1 Nov 2000 11:04:33 GMT
From: pete@redbricks.org.uk
Message-Id: <200011011104.LAA00999@gloop.internal>
Subject: 2.4.0-test10 BUG at swap_state.c:60 / 2.2.x getenv() failure
To: linux-kernel@vger.kernel.org
X-Mailer: vimail 0.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are having troubles with a single box, a k6-2 400/64M running
slackware 7.1.

It's in use as an intranet web server that serves some large (3-10M)
files, usually at a slow pace for clients streaming over http.

One unusual feature is that these files are stored on a vfat
filesystem (30G drive, 1 partition, 20G in use) inherited from a
previous win95 incarnation of the web server. Lack of disk space
for intermediate storage precludes swapping it to ext2 in the short
term.

Under the default slackware kernel 2.2.16 we noticed that after 1-4
days operation the hit counter (Count.cgi) would stop working. On
investigation this was traced to a NULL result from a getenv() call.
Once the machine reached that stage, the command "which ls"
segfaulted as it tried to printf("not found in %s", path) where path
was zero as a result of the failed getenv(). Soon after these symptoms
appeared the box became unstable and required a reboot.

I suspected hardware problems, but as the error was consistent over 
a few weeks (always started as getenv() failure) I thought this may be
a kernel problem. I installed 2.2.17 but this didn't improve things.

Under 2.2.17, running su nobody -c updatedb >&/dev/null caused a lot
of errors mentioning dentry caches and slab corruption, that
unfortunately I didn't get details of (sorry). This was after the
machine had been up for about 20 hours. On reboot the same command
worked flawlessly. If it's of interest I can try and reproduce this,
but it seems to take some time for the problem to develop..

I tried patching to 2.2.18pre18 but against the released 2.2.17, which 
didn't seem to work, so I gave that up and moved on to 2.4.0-test10
(instructions on how to patch up to 2.2.18pre18 efficiently would be
appreciated..)

Under 2.4.0-test10 (using egcs-2.91.66 for compiling these, BTW) 
I ran (as root) the memory gobbling perl one-liner:

perl -e 'while(1){$hash{$i++}="1234567890" x 1024 x 1024;print `free`}'

on one terminal and manually looped su nobody -c updatedb >&/dev/null
on another with top on a third, just to see what would happen (I wanted
to see the OOM killer in action :-) This completed successfully a couple
of times, the OOM killer killing the perl process successfully (with
about 2M of swap left out of 128 iirc.)

Third (or so) time round, though, the following appeared on the console.
The machine was dead apart from sysreq, so it's copied by hand. We did
check it over...

 invalid operand: 0000
 CPU:    0
 EIP:    0010:[<c0125f53>]
 EFLAGS: 00010286
 eax: 0000001f   ebx: c1081bec   ecx: 00000000   edx: 00000000
 esi: c1081bec   edi: c39f3f20   ebp: 01e87045   esp: c113fea0
 ds: 0018    es: 0018   ss: 0018
 Process kswapd (pid: 2, stackpage=c113f000)
 Stack: c01cd148 c01cd30f 0000003c 00772100 c012398c c1081bec 00772100 00772100
        45b5d000 c3f89ee0 45b5c000 45c00000 00000000 00772100 c0123b63 c3f89ee0
        c39f3f20 45b5c000 c2e9bd70 00000004 45b5c000 c39f3f20 c3f89ee0 00000004
 Call Trace: [<c01cd148>] [<c01cd30f>] [<c012398c>] [<c0123b63>] [<c0123c10>] [<c0123d5e>] [<c0124bab>]
           [<c0124c62>] [<c01ccb71>] [<c0124d08>] [<c0105000>] [<c010743b>]
 Code:   0f 0b 83 c4 0c 8b 43 18 24 e9 0c 08 89 43 18 8b 44 24 0c 50

After rebooting I found a syslog entry incicating a BUG() call at
swap_state.c line 60. This is here:

void add_to_swap_cache(struct page *page, swp_entry_t entry)
{
        unsigned long flags;

#ifdef SWAP_CACHE_INFO
        swap_cache_add_total++;
#endif
        if (!PageLocked(page))
                BUG();
        if (PageTestandSetSwapCache(page))
                BUG();
        if (page->mapping)
                BUG();  // <<<<<< this is line 60
        flags = page->flags & ~((1 << PG_error) | (1 << PG_dirty) | (1 << PG_referenced));
        page->flags = flags | (1 << PG_uptodate);
        add_to_page_cache_locked(page, &swapper_space, entry.val);
}

Here's the entry from syslog (the system clock is set wrongly, I see):

Nov  2 06:05:19 tunes su[221]: + tty2 root-nobody
Nov  2 06:07:33 tunes kernel: Out of Memory: Killed process 148 (perl).<3>Out of Memory: Killed process 198 (perl).kernel BUG at swap_state.c:60!
Nov  2 06:07:33 tunes kernel: invalid operand: 0000
Nov  2 06:07:33 tunes kernel: CPU:    0
Nov  2 06:07:33 tunes kernel: EIP:    0010:[add_to_swap_cache+103/140]
Nov  2 06:07:33 tunes kernel: EFLAGS: 00010286
Nov  2 06:07:33 tunes kernel: eax: 0000001f   ebx: c1081bec   ecx: 00000000   edx: 00000000
Nov  2 06:07:33 tunes kernel: esi: c1081bec   edi: c39f3f20   ebp: 01e87045   esp: c113fea0
Nov  2 06:07:33 tunes kernel: ds: 0018   es: 0018   ss: 0018
Nov  2 06:07:33 tunes kernel: Process kswapd (pid: 2, stackpage=c113f000)
Nov  2 06:07:33 tunes kernel: Stack: c01cd148 c01cd30f 0000003c 00772100 c012398c c1081bec 00772100 00772100 
Nov  2 06:07:33 tunes kernel:        45b5d000 c3f89ee0 45b5c000 45c00000 00000000 00772100 c0123b63 c3f89ee0 
Nov  2 06:07:33 tunes kernel:        c39f3f20 45b5c000 c2e9bd70 00000004 45b5c000 c39f3f20 c3f89ee0 00000004 
Nov  2 06:07:33 tunes kernel: Call Trace: [tvecs+8320/70904] [tvecs+8775/70904] [try_to_swap_out+568/716] [swap_out_vma+323/440] [swap_out_mm+56/100] [swap_out+290/372] [refill_inactive+279/364] 
Nov  2 06:31:47 tunes syslogd 1.3-3: restart.

ksymoops -K -L, with transcribed data as input gives:

>>EIP; c0125f53 <add_to_swap_cache+67/8c>   <=====
Trace; c01cd148 <tvecs+2080/114f8>
Trace; c01cd30f <tvecs+2247/114f8>
Trace; c012398c <try_to_swap_out+238/2cc>
Trace; c0123b63 <swap_out_vma+143/1b8>
Trace; c0123c10 <swap_out_mm+38/64>
Code;  c0125f53 <add_to_swap_cache+67/8c>
00000000 <_EIP>:
Code;  c0125f53 <add_to_swap_cache+67/8c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0125f55 <add_to_swap_cache+69/8c>
   2:   83 c4 0c                  addl   $0xc,%esp
Code;  c0125f58 <add_to_swap_cache+6c/8c>
   5:   8b 43 18                  movl   0x18(%ebx),%eax
Code;  c0125f5b <add_to_swap_cache+6f/8c>
   8:   24 e9                     andb   $0xe9,%al
Code;  c0125f5d <add_to_swap_cache+71/8c>
   a:   0c 08                     orb    $0x8,%al
Code;  c0125f5f <add_to_swap_cache+73/8c>
   c:   89 43 18                  movl   %eax,0x18(%ebx)
Code;  c0125f62 <add_to_swap_cache+76/8c>
   f:   8b 44 24 0c               movl   0xc(%esp,1),%eax
Code;  c0125f66 <add_to_swap_cache+7a/8c>
  13:   50                        pushl  %eax

I realise this may be a separate problem from the disappearing
environment one, which is what I really want to solve. I hope
the above is some use, and I'm happy to follow suggestions or
provide more info if it helps...

test10 was compiled with CONFIG_MK6=y, no module support and very
little of anything really apart from necessary basics.  I can
supply the .config if this is wanted.

I've run the same version of slackware with the default 2.2.16 kernel
on several other boxes (including a k6-3 450), which have all been
extremely stable. So I suspect that, if it's not a hardware
problem, either a driver for some unusual hardware on the box (but
there's only the two hard drives, the network card, a vga card,
floppy and the mobo/chipset), or the large VFAT fs is somehow
causing memory corruption which has then caused the getenv() failures. 

We're running under test10, so I'll wait and see whether that develops
the missing environment problem in a few days.

Here's some bits from dmesg (under 2.4.0test-10) that summarize the
hardware:

Calibrating delay loop... 799.54 BogoMIPS
Memory: 62564k/65472k available (971k kernel code, 2520k reserved, 79k data, 176k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
CPU: L1 I Cache: 32K  L1 D Cache: 32K (32 bytes/line)
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb3e0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.

[...]

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
hda: IBM-DJAA-31700, ATA DISK drive
hdc: WDC WD307AA, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 3334464 sectors (1707 MB) w/96KiB Cache, CHS=827/64/63
hdc: 60074784 sectors (30758 MB) w/2048KiB Cache, CHS=59598/16/63

[...]

ne2k-pci.c:vpre-1.00e 5/27/99 D. Becker/P. Gortmaker http://cesdis.gsfc.nasa.gov
/linux/drivers/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0xec00, IRQ 5, 00:40:95:46:A0:00.

Thanks for reading,

- Pete.

--
email: pete@redbricks.org.uk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
