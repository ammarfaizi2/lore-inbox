Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129547AbQLECJu>; Mon, 4 Dec 2000 21:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130252AbQLECJk>; Mon, 4 Dec 2000 21:09:40 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:50004 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129547AbQLECJV>; Mon, 4 Dec 2000 21:09:21 -0500
Message-ID: <3A2C472B.DBEA9E9@thebarn.com>
Date: Mon, 04 Dec 2000 19:38:52 -0600
From: Russell Cattelan <cattelan@thebarn.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-whipme11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livelock in elevator scheduling
In-Reply-To: <200011210838.RAA27382@asami.proc.flab.fujitsu.co.jp> <20001121112836.B10007@suse.de> <200011211130.UAA27961@asami.proc.flab.fujitsu.co.jp> <20001121123608.F10007@suse.de> <3A2840AB.EE085CAA@thebarn.com> <20001202164234.B31217@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Fri, Dec 01 2000, Russell Cattelan wrote:
> > > If performance is down, then that problem is most likely elsewhere.
> > > I/O limited benchmarking typically thrives on lots of request
> > > latency -- with that comes better throughput for individual threads.
> > >
> > > > Anyway, I'll try your patch.
> >
> > Well this patch does help with the request starvation problem.
> > Unfortunately it has introduced another problem.
> > Running 4 doio programs, on and XFS partion with KIO buf IO turned on.
>
> This looks like a generic aic7xxx problem, and not block related. Since
> you are doing such nice traces, what is the other CPU doing? CPU1
> seems to be stuck grabbing the io_request_lock (for reasons not entirely
> clear from reading the aic7xxx source...)
>

Ok Keith gave me a quick hack to help with the race condition.

Here is the latest set up back traces...
The actually accuracy of these back traces... well?  who knows, but it does
give us something to go on.
It doesn't make much sense to me right now, but I'm guessing the problem is
starting with that do_div error.

I'm going to take a closer look at the scsi_back_merge_fn.
This may  have more to due with our/Chait's kiobuf modifications than
anything else.



XFS (dev: 8/20) mounting with KIOBUFIO
Start mounting filesystem: sd(8,20)
Ending clean XFS mount for filesystem: sd(8,20)
kmem_alloc doing a vmalloc 262144 size & PAGE_SIZE 0 rval=0xe0a10000
Unable to handle kernel NULL pointer dereference at virtual address
00000008
 printing eip:
c019f8b5
*pde = 00000000

Entering kdb (current=0xc1910000, pid 5) on processor 1 Panic: Oops
due to panic @ 0xc019f8b5
eax = 0x00000002 ebx = 0x00000001 ecx = 0x00081478 edx = 0x00000000
esi = 0xc1957da0 edi = 0xc1923ac8 esp = 0xc1911e94 eip = 0xc019f8b5
ebp = 0xc1911e9c xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010046
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc1911e60
[1]kdb> bt
    EBP       EIP         Function(args)
0xc1911e9c 0x00000000c019f8b5 scsi_back_merge_fn_c+0x15 (0xc1923a98,
0xc1957da0, 0xcfb05780, 0x80)
                               kernel .text 0xc0100000 0xc019f8a0
0xc019f98c
0xc1911f2c 0x00000000c016a0df __make_request+0x1af (0xc1923a98, 0x1,
0xcfb05780, 0x0, 0x814)
                               kernel .text 0xc0100000 0xc0169f30
0xc016a8a4
0xc1911f70 0x00000000c016a9c8 generic_make_request+0x124 (0x1, 0xcfb05780,
0x0, 0x0, 0x0)
                               kernel .text 0xc0100000 0xc016a8a4
0xc016aa50
0xc1911fac 0x00000000c016abde ll_rw_block+0x18e (0x1, 0x1, 0xc1911fd0, 0x0)

                               kernel .text 0xc0100000 0xc016aa50
0xc016ac58
0xc1911fd4 0x00000000c0138ed7 flush_dirty_buffers+0x97 (0x0, 0x10f00)
                               kernel .text 0xc0100000 0xc0138e40
0xc0138f24
0xc1911fec 0x00000000c01391ab bdflush+0x8f
                               kernel .text 0xc0100000 0xc013911c
0xc0139260
           0x00000000c0108c9b kernel_thread+0x23
                               kernel .text 0xc0100000 0xc0108c78
0xc0108cb0
[1]kdb> go
Oops: 0000
CPU:    1
EIP:    0010:[<c019f8b5>]
EFLAGS: 00010046
eax: 00000002   ebx: 00000001   ecx: 00081478   edx: 00000000
esi: c1957da0   edi: c1923ac8   ebp: c1911e9c   esp: c1911e94
ds: 0018   es: 0018   ss: 0018
Process kflushd (pid: 5, stackpage=c1911000)
Stack: cfb05780 c1923a98 c1911f2c c016a0df c1923a98 c1957da0 cfb05780
00000080
       00000814 00081478 cfb05780 00000008 00000001 00000200 00000000
c1923ac0
       00000000 0000000e c1910000 c1911efc c010c77e 00000246 00000814
def0e800
Call Trace: [<c016a0df>] [<c010c77e>] [<c010a8c8>] [<c016a9c8>]
[<c016abde>] [<c0138ed7>] [<c01391ab>]
       [<c0108c9b>]
Code: 66 81 7a 08 00 10 0f 47 d8 8b 4a 2c 85 c9 74 19 0f b7 42 08
NMI Watchdog detected LOCKUP on CPU0, registers:
CPU:    0
EIP:    0010:[<c0217a98>]
EFLAGS: 00000086
eax: c01b21ac   ebx: c197b078   ecx: 00000000   edx: 00000012
esi: 00000286   edi: c02f5f94   ebp: c02f5f44   esp: c02f5f38
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02f5000)
Stack: c190fb20 04000001 00000000 c02f5f64 c010c539 00000012 c197b078
c02f5f94
       00000240 c0331a40 00000012 c02f5f8c c010c73d 00000012 c02f5f94
c190fb20
       c0108960 c02f4000 c0108960 c190fb20 00000000 c02f5fc8 c010a8c8
c0108960
Call Trace: [<c010c539>] [<c010c73d>] [<c0108960>] [<c0108960>]
[<c010a8c8>] [<c0108960>] [<c0108960>]
       [<c0100018>] [<c010898f>] [<c0108a02>] [<c0105000>] [<c01001d0>]
Code: 80 3d 64 47 2e c0 00 f3 90 7e f5 e9 1b a7 f9 ff 80 3d 64 e3

Entering kdb (current=0xc02f4000, pid 0) on processor 0 due to WatchDog
Interrupt @ 0xc0217a98
eax = 0xc01b21ac ebx = 0xc197b078 ecx = 0x00000000 edx = 0x00000012
esi = 0x00000286 edi = 0xc02f5f94 esp = 0xc02f5f38 eip = 0xc0217a98
ebp = 0xc02f5f44 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00000086
xds = 0x00000018 xes = 0xc02f0018 origeax = 0xc01b21ac &regs = 0xc02f5f04
[0]kdb> bt
    EBP       EIP         Function(args)
           0x00000000c0217a98 stext_lock+0x43a8
                               kernel .text.lock 0xc02136f0 0xc02136f0
0xc02197c0
0xc02f5f44 0x00000000c01b21c3 do_aic7xxx_isr+0x17 (0x12, 0xc197b078,
0xc02f5f94, 0x240, 0xc0331a40)
                               kernel .text 0xc0100000 0xc01b21ac
0xc01b225c
0xc02f5f64 0x00000000c010c539 handle_IRQ_event+0x4d (0x12, 0xc02f5f94,
0xc190fb20, 0xc0108960, 0xc02f4000)
                               kernel .text 0xc0100000 0xc010c4ec
0xc010c568
0xc02f5f8c 0x00000000c010c73d do_IRQ+0x99 (0xc0108960, 0x0, 0xc02f4000,
0xc02f4000, 0xc0108960)
                               kernel .text 0xc0100000 0xc010c6a4
0xc010c790
           0x00000000c010a8c8 ret_from_intr
                               kernel .text 0xc0100000 0xc010a8c8
0xc010a8e8
Interrupt registers:
eax = 0x00000000 ebx = 0xc0108960 ecx = 0x00000000 edx = 0xc02f4000
esi = 0xc02f4000 edi = 0xc0108960 esp = 0xc02f5fc8 eip = 0xc010898f
ebp = 0xc02f5fc8 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00000246
xds = 0xc0100018 xes = 0xc02f0018 origeax = 0xffffff12 &regs = 0xc02f5f94
           0x00000000c010898f default_idle+0x2f
                               kernel .text 0xc0100000 0xc0108960
0xc0108998
0xc02f5fdc 0x00000000c0108a02 cpu_idle+0x42
                               kernel .text 0xc0100000 0xc01089c0
0xc0108a18
[0]kdb> cpu
Currently on cpu 0
Available cpus: 0, 1
[0]kdb> cpu 1

Entering kdb (current=0xc1910000, pid 5) on processor 1 due to cpu switch
[1]kdb> bt
    EBP       EIP         Function(args)
0xc1911c88 0x00000000c010c387 __global_cli+0xb7
                               kernel .text 0xc0100000 0xc010c2d0
0xc010c424
0xc1911c9c 0x00000000c01793a7 rs_timer+0x37 (0x0)
                               kernel .text 0xc0100000 0xc0179370
0xc017946c
0xc1911cc4 0x00000000c01231b5 timer_bh+0x269 (0xc034de40, 0x20, 0x0)
                               kernel .text 0xc0100000 0xc0122f4c
0xc0123210
0xc1911cd8 0x00000000c0120248 bh_action+0x50 (0x0, 0x3, 0xc033a660)
                               kernel .text 0xc0100000 0xc01201f8
0xc01202a8
0xc1911cf0 0x00000000c012011b tasklet_hi_action+0x4f (0xc033a660, 0x260,
0xc0331a60)
                               kernel .text 0xc0100000 0xc01200cc
0xc0120154
0xc1911d10 0x00000000c011ffad do_softirq+0x5d (0xc1910000, 0xc02dca60)
                               kernel .text 0xc0100000 0xc011ff50
0xc011ffe0
0xc1911d2c 0x00000000c010c77e do_IRQ+0xda (0xc1910000, 0x0, 0x0,
0xc02dca60, 0xc1910000)
                               kernel .text 0xc0100000 0xc010c6a4
0xc010c790
           0x00000000c010a8c8 ret_from_intr
                               kernel .text 0xc0100000 0xc010a8c8
0xc010a8e8
Interrupt registers:
eax = 0xc1910648 ebx = 0xc1910000 ecx = 0x00000000 edx = 0x00000000
esi = 0xc02dca60 edi = 0xc1910000 esp = 0xc1911d68 eip = 0xc011512e
ebp = 0xc1911d70 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00000246
xds = 0xc0330018 xes = 0xc0330018 origeax = 0xffffff13 &regs = 0xc1911d34
[1]more>
           0x00000000c011512e exit_sighand+0x66 (0xc1910000)
                               kernel .text 0xc0100000 0xc01150c8
0xc0115134
0xc1911d88 0x00000000c011eef5 do_exit+0x219 (0xb, 0x0, 0x0, 0xc0114798,
0xc1911e50)
                               kernel .text 0xc0100000 0xc011ecdc
0xc011ef50
0xc1911da0 0x00000000c010aef0 do_divide_error (0xc1911e60, 0x0, 0x1,
0x81478, 0x0)
                               kernel .text 0xc0100000 0xc010aef0
0xc010af90
           0x00000000c010a938 error_code+0x34
                               kernel .text 0xc0100000 0xc010a904
0xc010a940
Interrupt registers:
eax = 0x00000002 ebx = 0x00000001 ecx = 0x00081478 edx = 0x00000000
esi = 0xc1957da0 edi = 0xc1923ac8 esp = 0xc1911e94 eip = 0xc019f8b5
ebp = 0xc1911e9c xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010046
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc1911e60
           0x00000000c019f8b5 scsi_back_merge_fn_c+0x15 (0xc1923a98,
0xc1957da0, 0xcfb05780, 0x80)
                               kernel .text 0xc0100000 0xc019f8a0
0xc019f98c
0xc1911f2c 0x00000000c016a0df __make_request+0x1af (0xc1923a98, 0x1,
0xcfb05780, 0x0, 0x814)
                               kernel .text 0xc0100000 0xc0169f30
0xc016a8a4
0xc1911f70 0x00000000c016a9c8 generic_make_request+0x124 (0x1, 0xcfb05780,
0x0, 0x0, 0x0)
                               kernel .text 0xc0100000 0xc016a8a4
0xc016aa50
0xc1911fac 0x00000000c016abde ll_rw_block+0x18e (0x1, 0x1, 0xc1911fd0, 0x0)

                               kernel .text 0xc0100000 0xc016aa50
0xc016ac58
0xc1911fd4 0x00000000c0138ed7 flush_dirty_buffers+0x97 (0x0, 0x10f00)
                               kernel .text 0xc0100000 0xc0138e40
0xc0138f24
[1]more>
0xc1911fec 0x00000000c01391ab bdflush+0x8f
                               kernel .text 0xc0100000 0xc013911c
0xc0139260
           0x00000000c0108c9b kernel_thread+0x23
                               kernel .text 0xc0100000 0xc0108c78
0xc0108cb0
[1]kdb>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
