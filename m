Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbUBVRk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 12:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUBVRk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 12:40:29 -0500
Received: from village.ehouse.ru ([193.111.92.18]:2320 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261709AbUBVRkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 12:40:06 -0500
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1 IO lockup on SMP systems
Date: Sun, 22 Feb 2004 20:39:58 +0300
User-Agent: KMail/1.6
Cc: "Sergey S. Kostyliov" <rathamahata@php4.ru>, linux-kernel@vger.kernel.org,
       anton@megashop.ru
References: <200401311940.28078.rathamahata@php4.ru> <200402211945.21837.rathamahata@php4.ru> <20040221113044.7deb60b9.akpm@osdl.org>
In-Reply-To: <20040221113044.7deb60b9.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402222039.58702.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 February 2004 22:30, Andrew Morton wrote:
> "Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
> > Hello Andrew,
> >
> > On Sunday 01 February 2004 03:17, Andrew Morton wrote:
> > > "Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
> > > > I had experienced a lockups on three of my servers with 2.6.1. It
> > > > doesn't look like a deadlock, the box is still pingable and all tcp
> > > > ports which were in listen state before a lockup are remains in
> > > > listen state, but I can't get any data from this ports. According to
> > > > sar(1) systems had not been overloaded right before a lockup. And
> > > > there is no log entries in all user services logs for almost 10 hours
> > > > after lockup.
> > >
> > > Please ensure that CONFIG_KALLSYMS is enabled, then generate an
> > > all-tasks backtrace or a locked machine with sysrq-T or `echo t >
> > > /proc/sysrq-trigger'.  Then send us the resulting trace.
> >
> > I've just reproduced this lockup with 2.6.3.
> >
> > > You may need a serial console to be able to capture all the output.
> > >
> > > Also, it would be useful to know what sort of load the machines are
> > > under, and what filesystems are in use.
> >
> > The machine is a http server. The main applications are:
> > 1) apache 1.3 which serves php pages (mod_php):
> > 	 15.3 requests/sec - 111.9 kB/second - 7.3 kB/request
> > 	 54 requests currently being processed, 19 idle servers
> > 2) mysql:
> > 	Threads: 19  Questions: 26922012  Slow queries: 9799  Opens: 64980
> > 	Flush tables: 1  Open tables: 630  Queries per second avg: 143.547
> >
> > This is an IO bound machine in general. All filesystems are reiserfs.
> >
> > Here is a sysrq-T output obtained from a locked box via serail console:
>
> OK, so everything is stuck trying to allocate memory.  Perhaps you ran out
> of swapspace, or some process has gone berzerk allocating memory.
>
> How much memory does the machine have, and how much swap space?
>
# free
             total       used       free     shared    buffers     cached
Mem:       2073868    2067508       6360          0     232708     897828
-/+ buffers/cache:     936972    1136896
Swap:      1535976       5228    1530748

> I suggest that you run a `vmstat 30' trace on a terminal somewhere, see
> what it says prior to the hangs. 
Ok.We'll try to get it next time.

> Also capture the sysrq-M output after it 
> has hung.
>
This "showmem" && "showreg" have been taken just before
"SysRq: Show State" from previous message.

SysRq : Show Memory
    Mem-info:
    DMA per-cpu:
    cpu 0 hot: low 2, high 6, batch 1
    cpu 0 cold: low 0, high 2, batch 1
    cpu 1 hot: low 2, high 6, batch 1
    cpu 1 cold: low 0, high 2, batch 1
    Normal per-cpu:
    cpu 0 hot: low 32, high 96, batch 16
    cpu 0 cold: low 0, high 32, batch 16
    cpu 1 hot: low 32, high 96, batch 16
    cpu 1 cold: low 0, high 32, batch 16
    HighMem per-cpu:
    cpu 0 hot: low 32, high 96, batch 16
    cpu 0 cold: low 0, high 32, batch 16
    cpu 1 hot: low 32, high 96, batch 16
    cpu 1 cold: low 0, high 32, batch 16

    Free pages:        3172kB (512kB HighMem)
    Active:1783 inactive:87 dirty:0 writeback:0 unstable:0 free:793
    DMA free:1292kB min:16kB low:32kB high:48kB active:3748kB inactive:0kB
    Normal free:1368kB min:936kB low:1872kB high:2808kB active:1368kB 
inactive:356kB
    HighMem free:512kB min:512kB low:1024kB high:1536kB active:2008kB 
inactive:0kB
    DMA: 151*4kB 70*8kB 6*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 
0*2048kB 0*4096kB = B
    Normal: 192*4kB 9*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 
0*1024kB 0*2048kB 0*4096kB B
    HighMem: 0*4kB 2*8kB 3*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 
0*2048kB 0*4096kB =B
    Swap cache: add 1140128, delete 1140063, find 459572/584559, race 145+217
    Free swap:       384364kB
    524288 pages of RAM
    294912 pages of HIGHMEM
    5821 reserved pages
    976 pages shared
    65 pages swap cached


SysRq : Show Regs

Pid: 0, comm:              swapper
EIP: 0060:[<c0106d1c>] CPU: 0
EIP is at default_idle+0x2c/0x40
 EFLAGS: 00000246    Not tainted
 EAX: 00000000 EBX: c02e6000 ECX: c0106cf0 EDX: c02e6000
 ESI: c02e6000 EDI: c0105000 EBP: 0008e000 DS: 007b ES: 007b
 CR0: 8005003b CR2: bffff7e0 CR3: 2d021000 CR4: 00000690
 Call Trace:
  [<c0106dab>] cpu_idle+0x3b/0x50
   [<c02e88e9>] start_kernel+0x179/0x1a0
    [<c02e84a0>] unknown_bootoption+0x0/0x120


> It would be useful to monitor the contents of /proc/vmstat also.
>
> And perhaps keep top running in `sort by memory usage' mode.
ok, we'll try too.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
< on behalf of "Sergey S. Kostyliov" <rathamahata@php4.ru> >

Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
