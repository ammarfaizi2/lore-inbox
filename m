Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286766AbRL1GZa>; Fri, 28 Dec 2001 01:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286765AbRL1GZV>; Fri, 28 Dec 2001 01:25:21 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:54427 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S286759AbRL1GZC>; Fri, 28 Dec 2001 01:25:02 -0500
Date: Fri, 28 Dec 2001 08:23:43 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG and Kernel Panic on 2.5.2-pre1 with loop and cdrom
In-Reply-To: <Pine.LNX.4.33.0112262029370.28333-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0112280822130.18421-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the floppy case with some debugging stuff put in. My kernel log is first, orignal
oops second and decoded oops last. Triggered with mount /dev/fd0 /floppy -o loop.
The ksymoops was run on the machine *right* after the oops (it was still
alive). If you want me to track down where the bh->b_size and nr_sectors
began to differ i can put extra checks further down.

Thanks,
	Zwane Mwaikambo

Dec 31 02:09:27 mondecino kernel: end_bio_bh_io_sync: nr_sectors=0 bh->b_size=2 <== the values before the BUG check
Dec 31 02:09:27 mondecino kernel: kernel BUG at ll_rw_blk.c:1367!
Dec 31 02:09:27 mondecino kernel: invalid operand: 0000
Dec 31 02:09:27 mondecino kernel: CPU:    0
Dec 31 02:09:27 mondecino kernel: EIP:    0010:[end_bio_bh_io_sync+77/112]    Not tainted
Dec 31 02:09:27 mondecino kernel: EIP:    0010:[<c020c08d>]    Not tainted
Dec 31 02:09:27 mondecino kernel: EFLAGS: 00010282
Dec 31 02:09:27 mondecino kernel: eax: 00000020   ebx: c8a92384   ecx: c0304d24   edx: 00002b24
Dec 31 02:09:27 mondecino kernel: esi: 00000000   edi: cb6fcc64   ebp: 00000000   esp: c8bfbf88
Dec 31 02:09:27 mondecino kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 02:09:27 mondecino kernel: Process loop0 (pid: 727, stackpage=c8bfb000)
Dec 31 02:09:27 mondecino kernel: Stack: c02e1c63 00000557 cb6fcc64 caf4ac24 c9116000 c014dd33 cb6fcc64 00000000
Dec 31 02:09:27 mondecino kernel:        cc9171f8 cb6fcc64 00000001 00000000 cc9187c8 cc91879d 00000000 c9116000
Dec 31 02:09:27 mondecino kernel:        caf4ac24 cb6fcc64 c8fcbf30 00000000 00000000 00000000 00000f00 c8fcbf30
Dec 31 02:09:27 mondecino kernel: Call Trace: [bio_endio+35/48] [sound:num_midis_Rsmp_a1eae7cf+815152/51255793] [sound:nu
m_midis_Rsmp_a1eae7cf+820736/51250209] [sound:num_midis_Rsmp_a1eae7cf+820693/51250252] [kernel_thread+38/48]
Dec 31 02:09:27 mondecino kernel: Call Trace: [<c014dd33>] [<cc9171f8>] [<cc9187c8>] [<cc91879d>] [<c0107286>]
Dec 31 02:09:27 mondecino kernel:    [sound:num_midis_Rsmp_a1eae7cf+814520/51256425]
Dec 31 02:09:27 mondecino kernel:    [<cc916f80>]
Dec 31 02:09:27 mondecino kernel:
Dec 31 02:09:27 mondecino kernel: Code: 0f 0b 5e 58 8b 47 0c 83 e0 01 50 53 ff 53 34 57 e8 8e 14 f4

invalid operand: 0000
CPU:    0
EIP:    0010:[<c020c08d>]    Not tainted
EFLAGS: 00010282
eax: 00000020   ebx: c8a92384   ecx: c0304d24   edx: 00002b24
esi: 00000000   edi: cb6fcc64   ebp: 00000000   esp: c8bfbf88
ds: 0018   es: 0018   ss: 0018
Process loop0 (pid: 727, stackpage=c8bfb000)
Stack: c02e1c63 00000557 cb6fcc64 caf4ac24 c9116000 c014dd33 cb6fcc64 00000000
       cc9171f8 cb6fcc64 00000001 00000000 cc9187c8 cc91879d 00000000 c9116000
       caf4ac24 cb6fcc64 c8fcbf30 00000000 00000000 00000000 00000f00 c8fcbf30
Call Trace: [<c014dd33>] [<cc9171f8>] [<cc9187c8>] [<cc91879d>] [<c0107286>]
   [<cc916f80>]

>>EIP; c020c08d <end_bio_bh_io_sync+4d/70>   <=====
Trace; c014dd33 <bio_endio+23/30>
Trace; cc9171f8 <[loop]loop_thread+278/2d0>
Trace; cc9187c8 <[loop].text.end+689/8a1>
Trace; cc91879d <[loop].text.end+65e/8a1>
Trace; c0107286 <kernel_thread+26/30>
Trace; cc916f80 <[loop]loop_thread+0/2d0>
Code;  c020c08d <end_bio_bh_io_sync+4d/70>
00000000 <_EIP>:
Code;  c020c08d <end_bio_bh_io_sync+4d/70>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c020c08f <end_bio_bh_io_sync+4f/70>
   2:   5e                        pop    %esi
Code;  c020c090 <end_bio_bh_io_sync+50/70>
   3:   58                        pop    %eax
Code;  c020c091 <end_bio_bh_io_sync+51/70>
   4:   8b 47 0c                  mov    0xc(%edi),%eax
Code;  c020c094 <end_bio_bh_io_sync+54/70>
   7:   83 e0 01                  and    $0x1,%eax
Code;  c020c097 <end_bio_bh_io_sync+57/70>
   a:   50                        push   %eax
Code;  c020c098 <end_bio_bh_io_sync+58/70>
   b:   53                        push   %ebx
Code;  c020c099 <end_bio_bh_io_sync+59/70>
   c:   ff 53 34                  call   *0x34(%ebx)
Code;  c020c09c <end_bio_bh_io_sync+5c/70>
   f:   57                        push   %edi
Code;  c020c09d <end_bio_bh_io_sync+5d/70>
  10:   e8 8e 14 f4 00            call   f414a3 <_EIP+0xf414a3> c114d530 <_end+d6c100/c444c30>


