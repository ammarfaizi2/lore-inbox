Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161183AbWHJLjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161183AbWHJLjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 07:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161184AbWHJLjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 07:39:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:36889 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161183AbWHJLjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 07:39:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=CZkHAKhcBV558hPwSmGcinykBLpvMEZ/EKTsnCgo9Fa02PP/iy5vzU0J4hNxjn/i4XcruqsXugnuryHskieAc2+cBlbddWc/DV+7nUBBl3CJtblyeShEeRCi3Vm8aJR5mnhglV9LQJt3XQPIPa2uAzd0W6bDEh7BYWSONM6U8AM=
Message-ID: <44DB1AF6.2020101@gmail.com>
Date: Thu, 10 Aug 2006 13:39:11 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 - ext3 locking issue?
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <200608091906.k79J6Zrc009211@turing-police.cc.vt.edu> <20060809130151.f1ff09eb.akpm@osdl.org>            <200608092043.k79KhKdt012789@turing-police.cc.vt.edu> <200608100332.k7A3Wvck009169@turing-police.cc.vt.edu>
In-Reply-To: <200608100332.k7A3Wvck009169@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Wed, 09 Aug 2006 16:43:20 EDT, Valdis.Kletnieks@vt.edu said:
> 
>>> Usually this means that there's an IO request in flight and it got lost
>>> somewhere.  Device driver bug, IO scheduler bug, etc.  Conceivably a
>>> lost interrupt (hardware bug, PCI setup bug, etc).
> 
>> Aug  9 14:30:24 turing-police kernel: [ 3535.720000] end_request: I/O error, dev fd0, sector 0
> 
> Red herring.  yum just wedged again, this time with no reference to floppy drive.
> Same traceback.  Anybody have anything to suggest before I start playing
> hunt-the-wumpus with a -mm bisection?

Hmm, I have the accurately same problem...
yum + CFQ + BLK_DEV_PIIX + nothing odd in dmesg

[ 3438.574864] yum           D 00000000     0 21659   3838 
(NOTLB)
[ 3438.575098]        e5c09d24 00000001 c180f5a8 00000000 e5c09ce0 c01683e8 
fe37c0bc 000002c4
[ 3438.575388]        00001000 00000001 c18fbbd0 0023001f 00000007 f26cc560 
c1913560 fe4166d5
[ 3438.575713]        000002c4 0009a619 00000001 f26cc66c c180ec40 c04ff140 
e5c09d14 c01fad44
[ 3438.576039] Call Trace:
[ 3438.576113]  [<c0373d3b>] io_schedule+0x26/0x30
[ 3438.576187]  [<c014653c>] sync_page+0x39/0x45
[ 3438.576260]  [<c0374401>] __wait_on_bit_lock+0x41/0x64
[ 3438.576333]  [<c01464ef>] __lock_page+0x57/0x5f
[ 3438.576405]  [<c014f5f2>] truncate_inode_pages_range+0x1b6/0x304
[ 3438.576480]  [<c014f76f>] truncate_inode_pages+0x2f/0x40
[ 3438.576553]  [<c01a7bc4>] ext3_delete_inode+0x29/0xf7
[ 3438.576627]  [<c017f26b>] generic_delete_inode+0x65/0xe7
[ 3438.576701]  [<c017f3aa>] generic_drop_inode+0xbd/0x173
[ 3438.576774]  [<c017ed25>] iput+0x6b/0x7b
[ 3438.576846]  [<c017cc57>] dentry_iput+0x68/0xb3
[ 3438.576919]  [<c017d99e>] dput+0x4f/0x19f
[ 3438.576990]  [<c0176164>] sys_renameat+0x1e0/0x212
[ 3438.577063]  [<c01761be>] sys_rename+0x28/0x2a
[ 3438.577135]  [<c01030fb>] syscall_call+0x7/0xb

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
