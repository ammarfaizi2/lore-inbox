Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbUKXJ3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbUKXJ3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 04:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbUKXJ3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 04:29:49 -0500
Received: from penguin.cohaesio.net ([212.97.129.34]:34230 "EHLO
	mail.cohaesio.net") by vger.kernel.org with ESMTP id S262559AbUKXJ15
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 04:27:57 -0500
From: Anders Saaby <as@cohaesio.com>
Organization: Cohaesio A/S
To: linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon =?iso-8859-1?q?2=2E8ghz=A0=A04gb=A0ram=A0+smp?=,=?iso-8859-1?q?=A0software=A0raid?=,=?iso-8859-1?q?=A0lvm?=,=?iso-8859-1?q?=A0and=A0xfs?=
Date: Wed, 24 Nov 2004 10:28:11 +0100
User-Agent: KMail/1.7.1
Cc: Phil Dier <phil@dier.us>, Jakob Oestergaard <jakob@unthought.net>,
       Christoph Hellwig <hch@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411241028.11304.as@cohaesio.com>
X-OriginalArrivalTime: 24 Nov 2004 09:27:56.0621 (UTC) FILETIME=[E1AFB7D0:01C4D207]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

I have some hands-on experience with this kind of setop. I am working with a 
fairly similar setup as yours:

Two (UP) Xeon servers each with ~1TB SCSI RAID. Running XFS, exporting via NFS 
on 2.6.8.1. Serving ~18.000 Homedirs. - 24/7 heavy load.

I have seen quite a lot of Oops's on these servers, but now have a stable 
setup.

Here's the highlights:

< 2.6.8.1 (+/- various patches): XFS b0rks after a short period of heavy load. 
(tried several different setups and patches from SGI) 
2.6.8.1 (+/- various patches): SMP+XFS+NFS Oops's after ~1 Hour under heavy 
load.
2.6.8.1 (without patches): UP+XFS+NFS has now been running stable for 56 days, 
06h 24m. :)

I haven't tried 2.6.9 on these servers yet because of the stale filehandles 
issue and have no urge to break a stable setup. I am not 100% sure if the 
issue with weird changes on files which Jakob talked about, is introduced in 
2.6.9, but Im not seeing it on my setup.

- So buttom line - 2.6.8.1 running on a single CPU machine does the trick for 
me. (And who needs a lot of CPU powah on an NFS server? :))

Regarding ext3... This filesystem also seems to be b0rked on at least the 
newer 2.6.x kernels. We have some mailservers which until two days ago Oopsed 
on ext3. These now run XFS and the errors seems to be gone. - Don't get me 
wrong here, I have never seen ext3 Oops's on a low-load server - Only under 
heavy load (and SMP).

Snip of one of the ext3 Oops's (you will see several people here on LKML 
having the same/similar problem):
<SNIP>
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
printing eip:
c018b2f5
*pde = 00000000
Oops: 0002 [#1]
SMP
Modules linked in: nfs e1000 iptable_nat rtc
CPU:    2
EIP:    0060:[<c018b2f5>]    Not tainted VLI
EFLAGS: 00010286   (2.6.9)
EIP is at journal_commit_transaction+0x545/0x11b0
eax: d971826c   ebx: 00000000   ecx: e489eefc   edx: 00000014
esi: d971826c   edi: f7406000   ebp: ea0a6f80   esp: f7407d8c
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 177, threadinfo=f7406000 task=f7df63b0)
Stack: 03afe6b2 c2157478 f7407e40 f7406000 c2157414 00000000 00000000 00000000
       00000000 00000000 e489ebfc cd61056c 000010e8 01c2bf60 c040e020 00000000
       f7406000 0000001e f7407e1c c0412f80 00000008 f7407e5c c01134e3 f7407e1c
Call Trace:
 [<c01134e3>] find_busiest_group+0xf3/0x300
 [<c0113799>] find_busiest_queue+0xa9/0xd0
 [<c0115620>] autoremove_wake_function+0x0/0x40
 [<c0115620>] autoremove_wake_function+0x0/0x40
 [<c018e0e1>] kjournald+0xc1/0x230
 [<c0115620>] autoremove_wake_function+0x0/0x40
 [<c0112ba3>] finish_task_switch+0x33/0x70
 [<c0115620>] autoremove_wake_function+0x0/0x40
 [<c0103ff6>] ret_from_fork+0x6/0x14
 [<c018e000>] commit_timeout+0x0/0x10
 [<c018e020>] kjournald+0x0/0x230
 [<c010253d>] kernel_thread_helper+0x5/0x18
Code: 00 89 f0 e8 5e e1 17 00 83 c4 14 8b 45 18 85 c0 0f 84 49 01 00 00 bf 00 
e0 ff ff 21 e7 89 f6 8d bc 27 00 00 00 00 8b 70 20 8b 1e <f0> ff 43 0c 8b 03 
83 e0 04 74 4e 8b 94 24
 e8 01 00 00 8d 82 c0
</SNIP>

Phil Dier wrote:

> 
> Thanks for the tips, Jakob.
> 
> I *will* be exporting via NFS, so this is definetly good to know. I've
> been looking at using jfs and reiser as well, but some preliminary
> benchmarks suggested that xfs was the best performer for the kind of
> workload that I'm anticipating. I guess xfs is out of the question now,
> as I definetly don't want to deal with weird interactions like that.
> 
> Can anyone speak on the stability of (reiser|jfs|other) with nfs? My
> biggest requirements are online resizing and stability (ext3 online
> resize is still beta IIRC, but I wouldn't be opposed to using it if
> someone could tell me otherwise); speed would be nice, but I'm willing
> to sacrifice speed for the sake of reliability.
> 
> I'm personally using lvm + reiser + nfs without consequence on my
> fileserver at home, but it's not seeing nearly the loads that this box
> is going to see.
> 

-- 
Med venlig hilsen - Best regards - Meilleures salutations

Anders Saaby
Systems Engineer
------------------------------------------------
Cohaesio A/S - Maglebjergvej 5D - DK-2800 Lyngby
Phone: +45 45 880 888 - Fax: +45 45 880 777
Mail: as@cohaesio.com - http://www.cohaesio.com
------------------------------------------------
