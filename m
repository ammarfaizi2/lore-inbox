Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129034AbQKEF4D>; Sun, 5 Nov 2000 00:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbQKEFzx>; Sun, 5 Nov 2000 00:55:53 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:36875 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129034AbQKEFzk>; Sun, 5 Nov 2000 00:55:40 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
cc: Andi Kleen <ak@suse.de>, kanoj@google.engr.sgi.com
Message-ID: <CA25698E.002082E9.00@d73mta05.au.ibm.com>
Date: Sun, 5 Nov 2000 11:21:05 +0530
Subject: Oddness in i_shared_lock and page_table_lock nesting hierarchies ?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The vma list lock  can nest with i_shared_lock, as per Kanoj Sarcar's
   note on mem-mgmt locks (Documentation/vm/locking), and currently
   vma list lock == mm->page_table_lock.
   But there appears to be some inconsistency in the hierarchy of these
   2 locks.  (By vma list lock I mean vmlist_access/modify_lock(s) )

   Looking at mmap code, it appears that the vma list lock
   i.e. page_table_lock right now,  is to be acquired first
   (e.g insert_vm_struct which acquires i_shared_lock internally,
   is called under the page_table_lock/vma list lock).
   Elsewhere in madvise too, I see a similar hierarchy.
   In the unmap code, care has been taken not to have these locks
   acquired simultaneously.

   However, in the vmtruncate code, it looks like the hierarchy is
reversed.
  There, the i_shared_lock is acquired, in order to traverse the i_mmap
list
   and inside the loop it calls zap_page_range, which aquires the
   page_table_lock.

  This is odd. Isn't there a possibility of a deadlock if mmap and
truncation
   for the same file happen simultaneously (on an SMP) ?

  I'm wondering if this could be a side effect of the doubling up of the
  page_table_lock as a vma list lock ?

  Or have I missed something ?

  [I have checked upto  2.4-test10-pre5 ]

  I had put this query up on linux-mm, as part of a much larger mail, but
  didn't get any response yet, so I thought of putting up a more focussed
  query this time.

  Regards
  Suparna

  Suparna Bhattacharya
  Systems Software Group, IBM Global Services, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525


>List:     linux-mm
>Subject:  Re: Updated Linux 2.4 Status/TODO List (from the ALS show)
>From:     Kanoj Sarcar <kanoj@google.engr.sgi.com>
>Date:     2000-10-13 18:19:06
>[Download message RAW]

>>
>>
>> On Thu, 12 Oct 2000, David S. Miller wrote:
>> >
>> >    page_table_lock is supposed to protect normal page table activity
(like
>> >    what's done in page fault handler) from swapping out.
>> >    However, grabbing this lock in swap-out code is completely missing!
>> >
>> > Audrey, vmlist_access_{un,}lock == unlocking/locking page_table_lock.
>>
>> Yeah, it's an easy mistake to make.
>>
>> I've made it myself - grepping for page_table_lock and coming up empty
in
>> places where I expected it to be.
>>
>> In fact, if somebody sends me patches to remove the
"vmlist_access_lock()"
>> stuff completely, and replace them with explicit page_table_lock things,
>> I'll apply it pretty much immediately. I don't like information hiding,
>> and right now that's the only thing that the vmlist_access_lock() stuff
is
>> doing.

>Linus,
>
>I came up with the vmlist_access_lock/vmlist_modify_lock names early in
>2.3. The reasoning behind that was that in most places where the "vmlist
>lock" was being taken was to protect the vmlist chain, vma_t fields or
>mm_struct fields. The fact that implementation wise this lock could be
>the same as page_table_lock was a good idea that you suggested.
>
>Nevertheless, the name was chosen to indicate what type of things it was
>guarding. For example, in the future, you might actually have a different
>(possibly sleeping) lock to guard the vmachain etc, but still have a
>spin lock for the page_table_lock (No, I don't want to be drawn into a
>discussion of why this might be needed right now). Some of this is
>mentioned in Documentation/vm/locking.
>
>Just thought I would mention, in case you don't recollect some of this
>history. Of course, I understand the "information hiding" part.
>
>Kanoj
>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
