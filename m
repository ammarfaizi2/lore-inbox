Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbVAESoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbVAESoe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 13:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVAESoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 13:44:32 -0500
Received: from [207.168.29.180] ([207.168.29.180]:9861 "EHLO jp.mwwireless.net")
	by vger.kernel.org with ESMTP id S262548AbVAESl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 13:41:58 -0500
Message-ID: <41DC34EF.7010507@mvista.com>
Date: Wed, 05 Jan 2005 10:41:51 -0800
From: Steve Longerbeam <stevel@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ray Bryant <raybry@sgi.com>
Cc: Andi Kleen <ak@muc.de>, Hirokazu Takahashi <taka@valinux.co.jp>,
       Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, andrew morton <akpm@osdl.org>
Subject: Re: page migration patchset
References: <41DB35B8.1090803@sgi.com> <m1wtusd3y0.fsf@muc.de> <41DB5CE9.6090505@sgi.com>
In-Reply-To: <41DB5CE9.6090505@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Ray Bryant wrote:

> Andi Kleen wrote:
>
>> Ray Bryant <raybry@sgi.com> writes:
>>
>>
>>> http://sr71.net/patches/2.6.10/2.6.10-mm1-mhp-test7/
>>>
>>> A number of us are interested in using the page migration patchset 
>>> by itself:
>>>
>>> (1)  Myself, for a manual page migration project I am working on.  
>>> (This
>>>      is for migrating jobs from one set of nodes to another under batch
>>>      scheduler control).
>>> (2)  Marcello, for his memory defragmentation work.
>>> (3)  Of course, the memory hotplug project itself.
>>>
>>> (there are probably other "users" that I have not enumerated here).
>>
>>
>>
>> Could you coordinate that with Steve Longerbeam (cc'ed) ?
>> He has a NUMA API extension ready to be merged into -mm* that also
>> does kind of page migration when changing the policies of files.
>>
>> -Andi
>>
>>
> Yes, Steve's patch tries to move page cache pages that are found to be 
> allocated in the "wrong" place.  (See remove_invalid_filemap_page() in 
> his
> patch of 11/02/2004 on lkml).  But if the page is found to be busy, 
> the code
> gives up, as near as I can tell.


correct, my patch is using invalidate_mapping_pages(), which doesn't wait
for a locked pagecache page.

>
> If the page migration patch were merged, Steve could call 
> migrate_onepage(page,node) to move the page to the correct node. even 
> if it
> is busy [hopefully his code can "wait" at that point, I haven't looked 
> into it further to see if that is the case.]


sounds good to me. And it can wait, since remove_invalid_filemap_page() 
is called
at syscall time, so the syscall will just block.

>
> [This is really the page migration patch plus a small patch of
> mine that addss the node argument to migrate_onepage(), and that I 
> hope will
> get merged into the page migration patch shortly]
>
> Other than that, I don't see a big intersection between the two patches.
> Steve, do you see anything else where we need to coordinate?


well, I need to study the page migration patch more (this is the
first time I've heard of it). But it sounds as if my patch and the
page migration patch are complementary.

>
> On the other hand, there is some work to be done wrt memory policies
> and page migration.  For the project I am working on, we need to be able
> to move all of the pages used by a process on one set of nodes to another
> set of nodes.  At some point during this process we will need to update
> the memory policy for that process.  For Steve's patch, we will
> similarly need to update the policy associated with files associated with
> the process, I would think, elsewise new pages will get allocated on the
> old set of nodes, which is something we don't want.  Sounds like some
> new interfaces will have to be developed here.  Does that make sense
> to you, Andi and Steve?


yes.

>
> My personal preference would be to keep as much of this as possible
> under user space control; that is, rather than having a big autonomous
> system call that migrates pages and then updates policy information,
> I'd prefer to split the work into several smaller system calls that
> are issued by a user space program responsible for coordinating the
> process migration as a series of steps, e. g.:
>
> (1)  suspend the process via SIGSTOP
> (2)  update the mempolicy information
> (3)  migrate the process's pages
> (4)  migrate the process to the new cpu via set_schedaffinity()
> (5)  resume the process via SIGCONT
>

steps 2 and 3 can be accomplished by a call to mbind() and
specifying MPOL_MF_MOVE. And since mbind() takes an
address range, you could probably migrate pages and change
the policies for all of the process' mappings in a single mbind()
call.

Note that Andrew had to drop my patch from 2.6.10, because
the 4-level page tables feature was re-implemented using a
different interface, which broke my patch. So Andrew asked me
to re-do the patch for inclusion in 2.6.11. That gives us ~2 months
to work on integrating the page migration and NUMA mempolicy
filemap patches.

Ray, btw it is beneficial that I can work with you on this, because I have
no access to true NUMA machines. My testing of the filemap mempolicy
patch has only been on a UP discontiguous memory system. I assume
you've got access to Altix machines at SGI to do testing and benchmarking
of my filemap patch and your migration patches.

Steve

