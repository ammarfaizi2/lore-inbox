Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262965AbVCQBOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbVCQBOv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 20:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbVCQBM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 20:12:27 -0500
Received: from web13821.mail.yahoo.com ([66.163.176.53]:52338 "HELO
	web13821.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262940AbVCQBG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 20:06:28 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=WWp8jNghBWeP3UKPjpjkmMYC1ivXAhsxiu0BV6IaJZwBEnfP3c0HVY1b/Kaiiprnxo3I6YVGqdSmm5O5VnJy/x4uCMi5+unzZJ41eLLYxGVMuqOhqnDyE6/LUNPE07X5BWTkHGv9rI4dyc3YTn/K/lIaPZV3nhlwqson0VH4gPo=  ;
Message-ID: <20050317010625.79052.qmail@web13821.mail.yahoo.com>
Date: Wed, 16 Mar 2005 17:06:24 -0800 (PST)
From: G Hertz <gigglehz@yahoo.com>
Subject: get_user_pages() incomplete mapping to be expected?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to be CCed personally on responses, please.

I am in the process of porting a driver from kernel 2.4 to 2.6.  I
noticed that when I switched from using map_user_kiobuf() to 
get_user_pages() that get_user_pages() can and does sometimes provide
only a partial mapping, returning with the number of pages
it succeeded on instead of an error code.  This happens on both
2.6.8 and 2.6.11.3.

The early return only happens in one direction (from memory on a PCI
card to a user-allocated buffer) and not the reverse.  It is due to 
statements such as the following in get_user_pages()

       if (!vma || (vma->vm_flags & VM_IO)
                || !(flags & vma->vm_flags))
            return i ? : -EFAULT;

... and others in the function.

My question is: is this an expected/normal behavior that I should code
to, splitting the operation I want to complete into sections, or does
it indicate a system config problem or bug elsewhere in my code that 
I need to fix?

I have looked at the source to the function in mm/memory.c and 
researched on the web but haven't been able to figure it out.
It appears that the same situation exists in the 2.4 versions of
get_user_pages() but for some reason I never experienced it although
I was I using the function via map_user_kiobuf().

The user's buffersize is about 8MB which doesn't seem exorbitant.  
Is it?

I am concerned that if I code to the incomplete result, I will have
to accept the degenerate case where get_user_pages() only handles
one page at a time and I will have to perform 2026 DMA operations 
instead of the single one I achieve in 2.4, resulting in performance
issues. 

I am puzzled that the operation works in one direction but not the
other, and fails about halfway through (always at 1015 pages out of
2026), regardles of how much memory I have in my system (controlled
via the mem= boot option, the system has 2.0GB of physical RAM in it)
or how many programs I have running.

System info:

Linux localhost 2.6.11.3 #1 SMP Wed Mar 16 13:20:03 PST 2005 i686
Intel(R) Xeon(TM) CPU 2.80GHz unknown GNU/Linux

# cat /proc/meminfo
MemTotal:       705876 kB
MemFree:          9248 kB
Buffers:          9388 kB
Cached:         535572 kB
SwapCached:          0 kB
Active:         171092 kB
Inactive:       485232 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       705876 kB
LowFree:          9248 kB
SwapTotal:     1124508 kB
SwapFree:      1123916 kB
Dirty:              52 kB
Writeback:           0 kB
Mapped:         165332 kB
Slab:            18528 kB
CommitLimit:   1477444 kB
Committed_AS:   189412 kB
PageTables:       1596 kB
VmallocTotal:   311288 kB
VmallocUsed:    272308 kB
VmallocChunk:    36852 kB

Thank you for any guidance.

Shaun


