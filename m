Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286758AbRL1GXu>; Fri, 28 Dec 2001 01:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286759AbRL1GXk>; Fri, 28 Dec 2001 01:23:40 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:41627 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S286758AbRL1GX3>; Fri, 28 Dec 2001 01:23:29 -0500
Date: Fri, 28 Dec 2001 08:22:08 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG and Kernel Panic on 2.5.2-pre1 with loop and cdrom
In-Reply-To: <Pine.LNX.4.33.0112262029370.28333-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0112280820040.18421-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok looks like the floppy and the cdrom oops are two different thing entirely.
A newly decoded cdrom oops is at the end. I'm a bit confused here because
it looks like a spinlock magic thing, but then again that spinlock is
_definately_ initialised properly (spin_lock_init)

loop.c
static int loop_end_io_transfer(struct bio *bio, int nr_sectors)
{
	struct loop_device *lo = &loop_dev[MINOR(bio->bi_dev)]; <- evals to loop_dev[0]
	int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
	if (!uptodate || bio_rw(bio) == WRITE) {
		struct bio *rbh = bio->bi_private;
		bio_endio(rbh, uptodate, nr_sectors);
		if (atomic_dec_and_test(&lo->lo_pending))
			up(&lo->lo_bh_mutex);
		loop_put_buffer(bio);
	} else
		loop_add_bio(lo, bio); <==
	return 0;
}

static void loop_add_bio(struct loop_device *lo, struct bio *bio)
{
	unsigned long flags;
	spin_lock_irqsave(&lo->lo_lock, flags);	<== we puke here i think
	if (lo->lo_biotail) {
		lo->lo_biotail->bi_next = bio;
		lo->lo_biotail = bio;
	} else
		lo->lo_bio = lo->lo_biotail = bio;
	spin_unlock_irqrestore(&lo->lo_lock, flags);
	up(&lo->lo_bh_mutex);
}

(gdb) disassemble loop_add_bio
Dump of assembler code for function loop_add_bio:
0x740 <loop_add_bio>:   push   %edi
0x741 <loop_add_bio+1>: push   %esi
0x742 <loop_add_bio+2>: push   %ebx
0x743 <loop_add_bio+3>: mov    0x10(%esp,1),%ebx
0x747 <loop_add_bio+7>: mov    0x14(%esp,1),%esi
0x74b <loop_add_bio+11>:        pushf
0x74c <loop_add_bio+12>:        pop    %edi
0x74d <loop_add_bio+13>:        cli
0x74e <loop_add_bio+14>:        cmpl   $0xdead4ead,0xd0(%ebx)
0x758 <loop_add_bio+24>:        je     0x780 <loop_add_bio+64>
0x75a <loop_add_bio+26>:        push   $0x740
0x75f <loop_add_bio+31>:        push   $0x0
0x764 <loop_add_bio+36>:        call   0x765 <loop_add_bio+37>
0x769 <loop_add_bio+41>:        pop    %edx
0x76a <loop_add_bio+42>:        pop    %ecx
0x76b <loop_add_bio+43>:        push   $0x85
0x770 <loop_add_bio+48>:        push   $0x0
0x775 <loop_add_bio+53>:        call   0x776 <loop_add_bio+54>
0x77a <loop_add_bio+58>:        ud2a   <== we fail at spin_lock_irqsave magic
0x77c <loop_add_bio+60>:        pop    %ecx
0x77d <loop_add_bio+61>:        pop    %eax
0x77e <loop_add_bio+62>:        mov    %esi,%esi
<--snip-->

invalid operand: 0000
CPU:    0
EIP:    0010:[<cc9167da>]    Not tainted
EFLAGS: 00010086
eax: 00000044   ebx: cb18ab00   ecx: c0304d24   edx: 0003a5a9
esi: cb281d24   edi: 00000096   ebp: c156d5d4   esp: c031bc30
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c031b000)
Stack: cc918240 00000085 cb18ab00 cb281d24 00000004 cc9169f7 cb18ab00 cb281d24
       cb281d24 00000004 c014dd33 cb281d24 00000004 c020c56e cb281d24 00000001
       00000004 00000004 00000000 00000008 c031bcc0 20000000 c156d5d4 00000001
Call Trace: [<cc918240>] [<cc9169f7>] [<c014dd33>] [<c020c56e>] [<c021c56b>]
   [<c0223b6e>] [<c014d39d>] [<c014d565>] [<c020c098>] [<c014dd33>] [<c0145794>]
   [<c014d39d>] [<c014d565>] [<c020c098>] [<c014dd33>] [<c01f71e1>] [<cc835198>]
   [<cc83ad45>] [<cc83889a>] [<cc838940>] [<c0223ad0>] [<c02197f2>] [<c010a9ae>]
   [<c010ad09>] [<c0106dd0>] [<c0106dd0>] [<c01e0018>] [<c01ed533>] [<c0106dd0>]
   [<c01ed420>] [<c0106e82>] [<c0105000>]

Code: 0f 0b 59 58 89 f6 f0 fe 8b cc 00 00 00 0f 88 21 19 00 00 8b
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

>>EIP; cc9167da <[loop]loop_add_bio+3a/f0>   <=====
Trace; cc918240 <[loop].text.end+161/861>
Trace; cc9169f7 <[loop]loop_end_io_transfer+77/80>
Trace; c014dd33 <bio_endio+23/30>
Trace; c020c56e <end_that_request_first+19e/2a0>
Trace; c021c56b <__ide_end_request+bb/150>
Trace; c0223b6e <cdrom_read_intr+9e/330>
Trace; c014d39d <bio_destructor+4d/60>
Trace; c014d565 <bio_put+35/40>
Trace; c020c098 <end_bio_bh_io_sync+58/70>
Trace; c014dd33 <bio_endio+23/30>
Trace; c0145794 <mempool_free+104/110>
Trace; c014d39d <bio_destructor+4d/60>
Trace; c014d565 <bio_put+35/40>
Trace; c020c098 <end_bio_bh_io_sync+58/70>
Trace; c014dd33 <bio_endio+23/30>
Trace; c01f71e1 <add_timer_randomness+d1/e0>
Trace; cc835198 <[usb-ohci]roothub_portstatus+28/70>
Trace; cc83ad45 <[usb-ohci].text.end+876/8e1>
Trace; cc83889a <[usb-ohci]rh_send_irq+fa/1a0>
Trace; cc838940 <[usb-ohci]rh_int_timer_do+0/70>
Trace; c0223ad0 <cdrom_read_intr+0/330>
Trace; c02197f2 <ide_intr+162/240>
Trace; c010a9ae <handle_IRQ_event+5e/90>
Trace; c010ad09 <do_IRQ+109/1c0>
Trace; c0106dd0 <default_idle+0/40>
Trace; c0106dd0 <default_idle+0/40>
Trace; c01e0018 <acpi_ps_get_next_walk_op+1a8/1d0>
Trace; c01ed533 <pr_power_idle+113/270>
Trace; c0106dd0 <default_idle+0/40>
Trace; c01ed420 <pr_power_idle+0/270>
Trace; c0106e82 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>
Code;  cc9167da <[loop]loop_add_bio+3a/f0>
00000000 <_EIP>:
Code;  cc9167da <[loop]loop_add_bio+3a/f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  cc9167dc <[loop]loop_add_bio+3c/f0>
   2:   59                        pop    %ecx
Code;  cc9167dd <[loop]loop_add_bio+3d/f0>
   3:   58                        pop    %eax
Code;  cc9167de <[loop]loop_add_bio+3e/f0>
   4:   89 f6                     mov    %esi,%esi
Code;  cc9167e0 <[loop]loop_add_bio+40/f0>
   6:   f0 fe 8b cc 00 00 00      lock decb 0xcc(%ebx)
Code;  cc9167e7 <[loop]loop_add_bio+47/f0>
   d:   0f 88 21 19 00 00         js     1934 <_EIP+0x1934> cc91810e <[loop].text.end+2f/861>
Code;  cc9167ed <[loop]loop_add_bio+4d/f0>
  13:   8b 00                     mov    (%eax),%eax

 <0>Kernel panic: Aiee, killing interrupt handler!


