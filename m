Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTLPP4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 10:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTLPP4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 10:56:11 -0500
Received: from moof.zeroth.org ([203.117.131.35]:46858 "EHLO moof.zeroth.org")
	by vger.kernel.org with ESMTP id S261837AbTLPP4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 10:56:04 -0500
Message-ID: <3FDF2AFF.40606@metaparadigm.com>
Date: Tue, 16 Dec 2003 23:55:43 +0800
From: Jamie Clark <jamie@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.5) Gecko/20031108
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Jamie Clark <jclark@metaparadigm.com>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa1 ext3 oops
References: <Pine.LNX.4.44.0312161310570.1533-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0312161310570.1533-100000@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Sorry - I had started another test run after the previous crash (to 
collect more forensics) and have been waiting for the oops. The last one 
took 4 or 5 days. Just now I see I have another crash in the same place 
so I will apply the reversions you suggested and start again.

My apologies - this is slow work. I'm attempting to find a new kernel to 
keep our busy fileserver happy and I've had a spell of bad luck for the 
past month or two. I'll be happy when I get two weeks of uptime with a 
few bonnies running.


Marcelo Tosatti wrote:

>Jamie, 
>
>Did you try the patch I suggested for you to revert  ?
>
>On Thu, 11 Dec 2003, Jamie Clark wrote:
>
>  
>
>>OK, no deadlock yet with 2.4.23aa1 however it oopsed under 
>>ext3_file_write() in __mark_inode_dirty().
>>
>>Just to recap: this test is dual PIII, running several bonnie++ loads on 
>>an ext3+noatime+quota filesystem
>>mounted off
>>
>> From the oops the fault happens on the last instruction of:
>>
>>        movl $0,8(%ebx)
>>        movl $0,4(%edx)
>>        movl 100(%edi),%eax 
>>        movl %edx,4(%eax)    <-- here
>>
>>which appears to be this code in inode.c  [line 221+]
>>
>>                if (!(inode->i_state & (I_LOCK|I_FREEING|I_CLEAR)) &&
>>                    !list_empty(&inode->i_hash)) {
>>                        list_del(&inode->i_list);
>>                        list_add(&inode->i_list, &sb->s_dirty);
>>
>>After a quick browse of the assembler output the zeroing would appear to 
>>be part of the list_del inline, and edi seems to equate to &sb. If I 
>>have read that correctly then the 
>>oops happens at the beginning of
>>the list_add() inline and eax is the head of the s_dirty list - pointing 
>>into oblivion.
>>
>>__mark_inode_dirty() does not appear to take sb_lock before adding to 
>>the s_dirty list. Could that
>>be the culprit?   I'm completely unfamiliar with linux kernel so I might 
>>be way off here.
>>
>>-Jamie
>>
>>Andrea Arcangeli wrote:
>>
>>    
>>
>>>On Tue, Nov 04, 2003 at 07:52:40PM +0800, Jamie Clark wrote:
>>> 
>>>
>>>      
>>>
>>>>I made the quick fix (disabling rq_mergeable) and started the load test.
>>>>Will let it run for a week or so.
>>>>   
>>>>
>>>>        
>>>>
>>>does your later recent email means it deadlocked again even with this
>>>disabled?
>>>
>>>Could you try again with 2.4.23aa1 again just in case?
>>>
>>> 
>>>
>>>      
>>>
>>>>FYI an observation from my last test: the read latency seems to be much
>>>>improved and more consistent under this kernel (2.4.23pre6aa3, before
>>>>the oops and before this fix).  The maximum latency seemed steady over
>>>>the whole test without any of the longish pauses that showed up under
>>>>2.4.19. Quite a difference.
>>>>   
>>>>
>>>>        
>>>>
>>>nice to hear! thanks.
>>> 
>>>
>>>      
>>>
>
>  
>


