Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbTFDPyS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 11:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTFDPyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 11:54:18 -0400
Received: from dm4-176.slc.aros.net ([66.219.220.176]:967 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S263558AbTFDPyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 11:54:01 -0400
Message-ID: <3EDE193D.8070106@aros.net>
Date: Wed, 04 Jun 2003 10:07:25 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: 2.5.70 add_disk(disk) re-registering disk->queue->elevator.kobj
 (bug?!)
References: <3EDCEA14.2000407@aros.net> <20030603120717.66012855.akpm@digeo.com> <3EDD3D5F.3010509@aros.net> <20030603180002.2a0b4402.akpm@digeo.com> <20030604010613.GG6754@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030604010613.GG6754@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

allviro@parcelfarce.linux.theplanet.co.uk wrote:

>. . .
>... on top of that, we have queues with no gendisk ever registered.
>SCSI tapes, for one things.
>  
>
This may be unrelated but I think not... kobject refcounting for the 
elevators seems wrong in the current implementation if we're saying that 
in fact the request_queue should be sharable by zero or more devices. 
Here's extra debugging output from the nbd module I've been hacking on 
that's the result of doing an rmmod operation on the module. Note the 
BUG notice and the values of "q.e.ref#" that precede the BUG. "q.e.ref" 
is just the value of atomic_read(&disk->queue->elevator.kobj.refcount)). 
Running through zero as we go through calling del_gendisk(disk) for each 
disk belonging to each nbd_devs[] just seems wrong but this is what 
happens when the request_queue is shared by all the nbd_devs:

Jun  2 23:09:36 cyprus kernel: nbd: nbd_exit called.
Jun  2 23:09:36 cyprus kernel: nb0: calling del_gendisk(d56f1dc0): 43 
0-0 ref#=4 q=e3268560 q.e.ref#=2
Jun  2 23:09:36 cyprus kernel: nb1: calling del_gendisk(d56f1cc0): 43 
1-1 ref#=4 q=e3268560 q.e.ref#=0
Jun  2 23:09:36 cyprus kernel: nb2: calling del_gendisk(d56f3c80): 43 
2-2 ref#=4 q=e3268560 q.e.ref#=-2
Jun  2 23:09:36 cyprus kernel: nb3: calling del_gendisk(d56f1ac0): 43 
3-3 ref#=4 q=e3268560 q.e.ref#=-4
Jun  2 23:09:36 cyprus kernel: nb4: calling del_gendisk(d56f15c0): 43 
4-4 ref#=4 q=e3268560 q.e.ref#=-6
Jun  2 23:09:36 cyprus kernel: nb5: calling del_gendisk(d56f16c0): 43 
5-5 ref#=4 q=e3268560 q.e.ref#=-8
Jun  2 23:09:36 cyprus kernel: nb6: calling del_gendisk(d56f3980): 43 
6-6 ref#=4 q=e3268560 q.e.ref#=-10
Jun  2 23:09:36 cyprus kernel: ------------[ cut here ]------------
Jun  2 23:09:36 cyprus kernel: kernel BUG at include/linux/dcache.h:271!
Jun  2 23:09:36 cyprus kernel: invalid operand: 0000 [#1]
Jun  2 23:09:36 cyprus kernel: CPU:    0
Jun  2 23:09:36 cyprus kernel: EIP:    0060:[<c0176b1d>]    Tainted: GF
Jun  2 23:09:36 cyprus kernel: EFLAGS: 00210246
Jun  2 23:09:36 cyprus kernel: EIP is at sysfs_remove_dir+0x1d/0x13f
Jun  2 23:09:36 cyprus kernel: eax: 00000000   ebx: e32685a4   ecx: 
c027a0a0   edx: 00000000
Jun  2 23:09:36 cyprus kernel: esi: 00000006   edi: d5cad5c0   ebp: 
d8eadec0   esp: d8eadea8
Jun  2 23:09:36 cyprus kernel: ds: 007b   es: 007b   ss: 0068
Jun  2 23:09:36 cyprus kernel: Process rmmod (pid: 1732, 
threadinfo=d8eac000 task=d6224d80)
Jun  2 23:09:36 cyprus kernel: Stack: d5cb9340 dfd6fbc0 dfd6fbe8 
e32685a4 00000006 d56f3a48 d8eaded8 c0204e53
Jun  2 23:09:36 cyprus kernel:        e32685a4 c047e740 e32685a4 
e32685a4 d8eadee8 c0204e94 e32685a4 d56f3980
Jun  2 23:09:36 cyprus kernel:        d8eadef8 c0275eae e32685a4 
d56f3980 d8eadf0c c0279bd4 d56f3980 d56f3980
Jun  2 23:09:36 cyprus kernel: Call Trace:
Jun  2 23:09:36 cyprus kernel:  [<e32685a4>] nbd_queue+0x44/0x14c [nbd]
Jun  2 23:09:36 cyprus kernel:  [<c0204e53>] kobject_del+0x43/0x70
Jun  2 23:09:36 cyprus kernel:  [<e32685a4>] nbd_queue+0x44/0x14c [nbd]
Jun  2 23:09:36 cyprus last message repeated 2 times
Jun  2 23:09:36 cyprus kernel:  [<c0204e94>] kobject_unregister+0x14/0x20
Jun  2 23:09:36 cyprus kernel:  [<e32685a4>] nbd_queue+0x44/0x14c [nbd]
Jun  2 23:09:36 cyprus kernel:  [<c0275eae>] elv_unregister_queue+0x1e/0x40
Jun  2 23:09:36 cyprus kernel:  [<e32685a4>] nbd_queue+0x44/0x14c [nbd]
Jun  2 23:09:36 cyprus kernel:  [<c0279bd4>] unlink_gendisk+0x14/0x40
Jun  2 23:09:36 cyprus kernel:  [<c0175951>] del_gendisk+0x61/0x110
Jun  2 23:09:36 cyprus kernel:  [<e32617a4>] +0x644/0x7400 [nbd]
Jun  2 23:09:36 cyprus kernel:  [<e325efec>] nbd_exit+0x7c/0x157 [nbd]
Jun  2 23:09:36 cyprus kernel:  [<e3268560>] nbd_queue+0x0/0x14c [nbd]
Jun  2 23:09:36 cyprus kernel:  [<e3268800>] +0x0/0x140 [nbd]
Jun  2 23:09:36 cyprus kernel:  [<c012c30e>] sys_delete_module+0x12e/0x170
Jun  2 23:09:36 cyprus kernel:  [<e3268800>] +0x0/0x140 [nbd]
Jun  2 23:09:36 cyprus kernel:  [<c010c73c>] do_IRQ+0xcc/0xe0
Jun  2 23:09:36 cyprus kernel:  [<c010ac4d>] sysenter_past_esp+0x52/0x71
Jun  2 23:09:36 cyprus kernel:
Jun  2 23:09:36 cyprus kernel: Code: 0f 0b 0f 01 db 9a 3c c0 ff 07 85 ff 
0f 84 08 01 00 00 8b 47

Now if the whole block system has gotten redesigned to the point where 
each request_queue could be run through in multi-threaded fassion such 
that waiting within the queue handling q->request_fn won't block other 
running q->request_fn's then it makes sense in some block device driver 
cases to use a request_queue & lock per device but I'm still concerned 
by the direction of parenting of associated kobjects between gen_disk's 
and request_queue.elevator's. Should gen_disk's be the parent's of 
elevator's or the other way around? Is it ever the case that a driver 
needs multiple elevators for the same gen_disk? Seems like allviro is 
establishing that some drivers need multiple gen_disk's to use the same 
elevator.

Looking forward to more direction on this. Thanks!!!

