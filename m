Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbTJFRie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbTJFRie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:38:34 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:5505 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261515AbTJFRic convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:38:32 -0400
Importance: Low
MIME-Version: 1.0
Sensitivity: 
To: Greg KH <greg@kroah.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 0/6] Backing Store for sysfs
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Message-ID: <OF6873DDE8.877C0EE8-ONC1256DB7.005F0935-C1256DB7.0060DEDC@de.ibm.com>
Date: Mon, 6 Oct 2003 19:38:06 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/10/2003 19:38:09,
	Serialize complete at 06/10/2003 19:38:09
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> On Mon, Oct 06, 2003 at 02:29:15PM +0530, Maneesh Soni wrote:
>> 
>> 2.6.0-test6          With patches.
>> -----------------
>> dentry_cache (active)                2520                    2544
>> inode_cache (active)         1058                    1050
>> LowFree                      875032 KB               874748 KB
> 
> So with these patches we actually eat up more LowFree if all sysfs
> entries are searched, and make the dentry_cache bigger?  That's not good
> :(
[...]
> information for that kobject.  So I don't see any savings in these
> patches, do you?

I do. As stated earlier, with 20000 devices on a S390 guest I have around 
350MB slab memory after rebooting. 
With this patch, the slab memory reduces to 60MB. 
This becomes even more nasty as the kernel crashes during bootup if I only 
spend 256M for this guest: (happens with the current sysfs, not with this 
patch)

fixpoint divide exception: 0009 ¬#1| 
CPU:    0    Not tainted 
Process cio/0 (pid: 18, task: 000000000b84a810, ksp: 000000000b81f0a8) 
Krnl PSW : 0700000180000000 0000000000066aa2 
Krnl GPRS: 000000000000245e 0000000000000000 0000000000000000 
0000000000000000 
           00000000003b5110 0000000000000000 0000000000000000 
000000000030c008 
           0000000000000044 0000000000000020 000000000030be00 
00000000009fb8b0 
           00000000009fb880 00000000002b12b0 00000000000668f0 
000000000b81f0a8 
Krnl ACRS: 00000000 00000000 00000000 00000000 
           00000000 00000000 00000000 00000000 
           00000000 00000000 00000000 00000000 
           00000000 00000000 00000000 00000000 
Krnl Code: eb 13 00 3f 00 0c b9 08 00 13 58 40 a4 04 a7 28 00 64 8a 20 
Call Trace: 
 ¬<00000000000671c2>| shrink_zone+0x9e/0xc4 
 ¬<00000000000672c2>| shrink_caches+0xda/0xf4 
 ¬<00000000000673ae>| try_to_free_pages+0xd2/0x1b4 
 ¬<000000000005d812>| __alloc_pages+0x2aa/0x48c 
 ¬<000000000005da42>| __get_free_pages+0x4e/0x8c 
 ¬<0000000000061bfa>| cache_grow+0x116/0x40c 
 ¬<00000000000620ec>| cache_alloc_refill+0x1fc/0x328 
 ¬<000000000006258a>| kmem_cache_alloc+0xa2/0xb0 
 ¬<000000000009e094>| alloc_inode+0x1bc/0x1c0 
 ¬<000000000009ee40>| new_inode+0x20/0xb0 
 ¬<00000000000c50bc>| sysfs_new_inode+0x2c/0xb4 
 ¬<00000000000c519a>| sysfs_create+0x56/0xe0 
 ¬<00000000000c5bba>| sysfs_add_file+0xd2/0xf8 
 ¬<00000000000c6dce>| create_files+0x3e/0x84 
 ¬<00000000000c6e80>| sysfs_create_group+0x6c/0xe4 
 ¬<000000000016a508>| io_subchannel_register+0x54/0xec 
 ¬<000000000004b5ce>| worker_thread+0x21e/0x31c 
 ¬<0000000000019b68>| kernel_thread_starter+0x14/0x1c 

I agree that this patch is still borked, even some of the s390 device dont 
work. Nevertheless,  the idea to make this dentry/inode-cache memory 
freeable is good. I dont know why, but each device currently each device 
eats much more slab memory than a pagesize.
As far as I understood the mail of Dipankar, his patch is more a 
proof-of-concept not a mergable patch. If we find another solution to 
reduce the memory consumption of sysfs, I would be happy to accept 
different ideas.

cheers Christian

-- 
Mit freundlichen Grüßen / Best Regards

Christian Bornträger
IBM Deutschland Entwicklung GmbH
eServer SW  System Evaluation + Test
email: CBORNTRA@de.ibm.com
Tel +49  7031 16 1975

