Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWCXRgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWCXRgO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 12:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWCXRgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 12:36:14 -0500
Received: from adsl-71-140-189-62.dsl.pltn13.pacbell.net ([71.140.189.62]:9434
	"EHLO aexorsyst.com") by vger.kernel.org with ESMTP
	id S1751280AbWCXRgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 12:36:13 -0500
From: "John Z. Bohach" <jzb@aexorsyst.com>
Reply-To: jzb@aexorsyst.com
To: linux-kernel@vger.kernel.org
Subject: mem= causes oops (was Re: BIOS causes (exposes?) modprobe (load_module) kernel oops)
Date: Fri, 24 Mar 2006 09:36:13 -0800
User-Agent: KMail/1.5.2
References: <200603212005.58274.jzb@aexorsyst.com> <200603222126.56720.jzb@aexorsyst.com> <20060322214257.1ef798e5.rdunlap@xenotime.net>
In-Reply-To: <20060322214257.1ef798e5.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603240936.13178.jzb@aexorsyst.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 21:42, Randy.Dunlap wrote:
> > So it seems that the page fault handler is somehow affected by something
> > that the BIOS has/has not done, long after the system has booted and been
> > running, with many page faults under its belt...now I've seen it all...or
> > not.
>
> Sounds like we need to see complete boot logs from both BIOSen boots.
> Can you do that?
>
> I'm just guessing that the memory maps are different, but who knows.

I got something...

Here's the symbolic dump.  I've gotten it to break on the BIOS it
did work on, by adding 512 MB RAM and bringing the total RAM to 1GB.
In fact, it now breaks during boot-up, and doesn't even give me a chance
to modprobe anything.  However, the cmdline is what makes it break/work:

Here it is:

fails with cmdline:

Kernel command line: ro root=/dev/sda1 rootdelay=10 mem=0x200M console=ttyS0,115200n8

works with:

Kernel command line: ro root=/dev/sda1 rootdelay=10 console=ttyS0,115200n8

Note the "mem=" being the differentiator!

So I guess BIOS is off the hook.  Here's a more interesting dump of the new failing
case (with 1 GB RAM, and mem=0x200M on command line).  BTW, note that
mem=0x200M works fine as long as there's only 512 MB in the system.

(And also note that the kernel was built without ACPI (or APM) support).

INIT: version 2.85 booting
INIT: Entering runlevel: 3
Starting system log daemon...
[   39.333210] Unable to handle kernel paging request at virtual address b7c4e000
[   39.340642]  printing eip:
[   39.343414] c013213c
[   39.345653] *pde = 017eb067
[   39.348516] *pte = 00000000
[   39.351379] Oops: 0002 [#1]
[   39.354239] SMP DEBUG_PAGEALLOC
[   39.357476] Modules linked in:
[   39.360615] CPU:    0
[   39.360616] EIP:    0060:[<c013213c>]    Not tainted VLI
[   39.360618] EFLAGS: 00010006   (2.6.14.2) 
[   39.373302] EIP is at free_block+0x41/0xbc
[   39.377501] eax: c1508d40   ebx: dffb6000   ecx: dffb6b80   edx: b7c4e000
[   39.384458] esi: c1508d40   edi: 00000000   ebp: c1505280   esp: c1567ef4
[   39.391413] ds: 007b   es: 007b   ss: 0068
[   39.395622] Process events/0 (pid: 4, threadinfo=c1566000 task=c151fa30)
[   39.402309] Stack: c150aa14 00000003 c150aa00 c1505280 c0132963 c1505280 c150aa14 00000003 
[   39.410930]        00000000 00000000 c1508368 c1508d10 c1508d40 c1505280 c0132a0d c1505280 
[   39.419568]        c150aa00 00000000 00000000 00000002 c15052dc 00000246 c14063e0 c14063e4 
[   39.428186] Call Trace:
[   39.430878]  [<c0132963>] drain_array_locked+0x61/0x8c
[   39.436161]  [<c0132a0d>] cache_reap+0x7f/0x18f
[   39.440823]  [<c011f86a>] worker_thread+0x16f/0x1dd
[   39.445843]  [<c013298e>] cache_reap+0x0/0x18f
[   39.450420]  [<c0110299>] default_wake_function+0x0/0x12
[   39.455879]  [<c0110299>] default_wake_function+0x0/0x12
[   39.461338]  [<c011f6fb>] worker_thread+0x0/0x1dd
[   39.466173]  [<c0122d23>] kthread+0x7c/0xa6
[   39.470472]  [<c0122ca7>] kthread+0x0/0xa6
[   39.474681]  [<c0100ea5>] kernel_thread_helper+0x5/0xb
[   39.479967] Code: 24 18 8b 15 50 ec 31 c0 8b 0c b8 8d 81 00 00 00 40 c1 e8 0c c1 e0 05 8b 5c 02 1c 8b 44 24 20 8b 53  
[   39.499780]  

[42949372.960000] Linux version 2.6.14.2 (root@zeus) (gcc version 3.3.4) #1 SMP Fri Mar 24 08:27:33 PST 2006
[42949372.960000] BIOS-provided physical RAM map:
[42949372.960000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[42949372.960000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[42949372.960000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[42949372.960000]  BIOS-e820: 0000000000100000 - 000000003fe30000 (usable)
[42949372.960000]  BIOS-e820: 000000003fe30000 - 000000003fe40000 (ACPI data)
[42949372.960000]  BIOS-e820: 000000003fe40000 - 000000003ff00000 (ACPI NVS)
[42949372.960000]  BIOS-e820: 000000003ff00000 - 0000000040000000 (reserved)
[42949372.960000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[42949372.960000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[42949372.960000] user-defined physical RAM map:
[42949372.960000]  user: 0000000000000000 - 000000000009fc00 (usable)
[42949372.960000]  user: 000000000009fc00 - 00000000000a0000 (reserved)
[42949372.960000]  user: 00000000000e0000 - 0000000000100000 (reserved)
[42949372.960000]  user: 0000000000100000 - 0000000020000000 (usable)
[42949372.960000] 512MB LOWMEM available.
[42949372.960000] found SMP MP-table at 000ff780
...

Thanks for taking a look...

