Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbTFQMDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 08:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264695AbTFQMDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 08:03:51 -0400
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:22684 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264692AbTFQMDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 08:03:46 -0400
Message-ID: <3EEF0770.4030903@winux.com>
Date: Tue, 17 Jun 2003 08:20:00 -0400
From: Larry Auton <lkml@winux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: direct i/o problem with 2.4.21
References: <16110.17820.740483.866151@eagle.skarven.net> <20030617005916.GP1571@dualathlon.random>
In-Reply-To: <20030617005916.GP1571@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Mon, Jun 16, 2003 at 06:33:00PM -0400, Larry Auton wrote:
> 
>>>Message-ID: <16107.26375.67524.817817@nv.winux.com>
>>>Date:   Sat, 14 Jun 2003 14:18:47 -0400
>>>To:     linux-kernel@vger.kernel.org
>>>From:   Larry Auton <lkml@winux.com>
>>>Subject: direct i/o problem with 2.4.20 and 2.4.21rc7
>>>
>>>I have an application that requires direct i/o to thousands of files.
>>>On 2.4.19 the open's would eventually fail (at around 7200 files).
>>>On 2.4.20 and 2.4.21rc7 the machine hangs.
>>>
>>>Here's a sample program to do the deed:
>>>
>>>    wget http://www.skarven.net/lda/crashme.c
>>>    cc -o crashme crashme.c     # compile it
>>>    ./crashme 4000              # OK
>>>    ./crashme 9999              # CRASH
>>>
>>>It's a little obfuscated to eliminate the need for root privileges to
>>>mess with rlimit. It simply opens a bunch of files with O_DIRECT and,
>>>when enough files are open, the system will hang.
>>>
>>>The system hangs when '/proc/slabinfo' reports that 'kiobuf' reaches 
>>>just over 7230 active objects. I don't believe that this problem is
>>>specific to any particular file system as the failure occurs when
>>>using both ext2 and reiserfs.
>>>
>>>Larry Auton
>>
>>The hang I reported on 2.4.21rc7 persists in the released version 2.4.21.
> 
> 
> can you try to reproduce with 2.4.21rc8aa1? (you can apply my full patch
> to 21 final too of course since rc8 is the same as final) The fix for
> this that also fixes the performance problem with rawio from the same
> file but multiple fd is already in tree since several months, we should
> push it into mainline ASAP. The basic idea of the patch that moves the
> bh allocation flood down to the slab to take advantage of a shared
> shrinkable cache was developed at intel AFIK.
> 
> the single patch is this but I doubt it would apply cleanly as 90% of
> the other patches:
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc8aa1/9996_kiobuf-slab-1
> 
> so you can make a quick test with the full 2.4.21rc8aa1.gz applied.
> 
> as for the hang, that's because the vm in mainline probably isn't
> capable of returning -ENOMEM from syscalls under a zone normal shortage
> (previously it wouldn't touch the vm side because it used vmalloc that
> returns -ENOMEM w/o entering the VM). With the vm in my tree you
> shouldn't experience hangs even w/o the fix for the kiobuf bh flood
> allocation patch applied.
> 
> Andrea

Problem solved.  I after applying patch

http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc8aa1.bz2 


to the vanilla linux-2.4.21, both the "crashme" program and my genuine 
application run as intended.  The machine is stable.  Here's a line from 
/proc/slabinfo showing the small, well-managed kiobuf allocation:

kiobuf 168 168 68 3 3 1 : 168 168 3 0 0 : 252 126 : 756227 6 756230 0

This state reflects my application using direct i/o to over 8300 files.

Well done!  Many thanks.

