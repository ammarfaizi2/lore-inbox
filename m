Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWHKWiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWHKWiX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 18:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWHKWiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 18:38:23 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:64664 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751223AbWHKWiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 18:38:23 -0400
Message-ID: <44DD072C.2040402@free.fr>
Date: Sat, 12 Aug 2006 00:39:40 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.4) Gecko/20060405 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc3-mm2 - ext3 locking issue?
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <200608091906.k79J6Zrc009211@turing-police.cc.vt.edu> <20060809130151.f1ff09eb.akpm@osdl.org>            <200608092043.k79KhKdt012789@turing-police.cc.vt.edu> <200608100332.k7A3Wvck009169@turing-police.cc.vt.edu> <44DB1AF6.2020101@gmail.com>
In-Reply-To: <44DB1AF6.2020101@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10.08.2006 13:40, Jiri Slaby a écrit :
> Valdis.Kletnieks@vt.edu wrote:
>> On Wed, 09 Aug 2006 16:43:20 EDT, Valdis.Kletnieks@vt.edu said:
>>
>>>> Usually this means that there's an IO request in flight and it got lost
>>>> somewhere.  Device driver bug, IO scheduler bug, etc.  Conceivably a
>>>> lost interrupt (hardware bug, PCI setup bug, etc).
>>
>>> Aug  9 14:30:24 turing-police kernel: [ 3535.720000] end_request: I/O
>>> error, dev fd0, sector 0
>>
>> Red herring.  yum just wedged again, this time with no reference to
>> floppy drive.
>> Same traceback.  Anybody have anything to suggest before I start playing
>> hunt-the-wumpus with a -mm bisection?
> 
> Hmm, I have the accurately same problem...
> yum + CFQ + BLK_DEV_PIIX + nothing odd in dmesg
> 
> [ 3438.574864] yum           D 00000000     0 21659   3838 (NOTLB)
> [ 3438.575098]        e5c09d24 00000001 c180f5a8 00000000 e5c09ce0
> c01683e8 fe37c0bc 000002c4
> [ 3438.575388]        00001000 00000001 c18fbbd0 0023001f 00000007
> f26cc560 c1913560 fe4166d5
> [ 3438.575713]        000002c4 0009a619 00000001 f26cc66c c180ec40
> c04ff140 e5c09d14 c01fad44
> [ 3438.576039] Call Trace:
> [ 3438.576113]  [<c0373d3b>] io_schedule+0x26/0x30
> [ 3438.576187]  [<c014653c>] sync_page+0x39/0x45
> [ 3438.576260]  [<c0374401>] __wait_on_bit_lock+0x41/0x64
> [ 3438.576333]  [<c01464ef>] __lock_page+0x57/0x5f
> [ 3438.576405]  [<c014f5f2>] truncate_inode_pages_range+0x1b6/0x304
> [ 3438.576480]  [<c014f76f>] truncate_inode_pages+0x2f/0x40
> [ 3438.576553]  [<c01a7bc4>] ext3_delete_inode+0x29/0xf7
> [ 3438.576627]  [<c017f26b>] generic_delete_inode+0x65/0xe7
> [ 3438.576701]  [<c017f3aa>] generic_drop_inode+0xbd/0x173
> [ 3438.576774]  [<c017ed25>] iput+0x6b/0x7b
> [ 3438.576846]  [<c017cc57>] dentry_iput+0x68/0xb3
> [ 3438.576919]  [<c017d99e>] dput+0x4f/0x19f
> [ 3438.576990]  [<c0176164>] sys_renameat+0x1e0/0x212
> [ 3438.577063]  [<c01761be>] sys_rename+0x28/0x2a
> [ 3438.577135]  [<c01030fb>] syscall_call+0x7/0xb
> 
> regards,

Same problem here, with urpmi: 

urpmi         D CAC9EAA0  6112 29146  30655                     (NOTLB)
       c813dda0 c0291e70 00000001 cac9eaa0 fe7d7800 000008ad 00000000 cac9ebac 
       c813ddd4 c1404e00 07efea00 00000005 c813ddd4 c813ddd4 c1404e00 c813dda8 
       c028fb6b c813ddb0 c01390ed c813ddc8 c02902ea c01390b7 c813ddd4 00000000 
Call Trace:
 [<c028fb6b>] io_schedule+0xe/0x16
 [<c01390ed>] sync_page+0x36/0x3a
 [<c02902ea>] __wait_on_bit_lock+0x30/0x58
 [<c01390a3>] __lock_page+0x51/0x59
 [<c01403f4>] truncate_inode_pages_range+0x1f8/0x24a
 [<c0140452>] truncate_inode_pages+0xc/0x12
 [<c018a22a>] ext3_delete_inode+0x16/0xc0
 [<c0168e93>] generic_delete_inode+0x61/0xcf
 [<c0168f13>] generic_drop_inode+0x12/0x13e
 [<c0168994>] iput+0x67/0x6a
 [<c0166bab>] dentry_iput+0x7c/0x97
 [<c016792d>] dput+0x152/0x16b
 [<c0160fe5>] sys_renameat+0x17a/0x1dd
 [<c016105a>] sys_rename+0x12/0x14
 [<c0102c39>] sysenter_past_esp+0x56/0x8d

This is 2.6.18-rc3-mm2 + 6 hot-fixes. CFQ scheduler. The RPM DB is located on /var which is an ext3 FS. 

I think I broke my RPM db :-(.
~~
laurent
