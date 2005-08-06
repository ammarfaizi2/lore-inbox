Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263382AbVHFS3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263382AbVHFS3y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 14:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbVHFS3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 14:29:54 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:61967 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S263382AbVHFS3x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 14:29:53 -0400
Message-ID: <42F5016A.2020900@vmware.com>
Date: Sat, 06 Aug 2005 11:28:58 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>, Chris Wright <chrisw@osdl.org>,
       Pratap Subrahmanyam <pratap@vmware.com>
Subject: Re: [PATCH] 8/8 Create MMU 2/3 level accessors in the sub-arch layer
  (i386)
References: <42F46558.9010202@vmware.com.suse.lists.linux.kernel> <p73wtmz1ekk.fsf@bragg.suse.de> <20050806115619.GA1560@infradead.org> <20050806115836.GN8266@wotan.suse.de> <20050806120141.GA1827@infradead.org>
In-Reply-To: <20050806120141.GA1827@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Aug 2005 18:29:40.0953 (UTC) FILETIME=[CF1D6C90:01C59AB4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Sat, Aug 06, 2005 at 01:58:36PM +0200, Andi Kleen wrote:
>  
>
>>>>I think that patch is really ugly - it makes hacking VM on i386
>>>>even more painful than it already is because the convolutes the file
>>>>structure even more. Hope it is not applied.
>>>>        
>>>>
>>>Especially as there's been no user shown for it, similar to all the other
>>>ugly patches from vmware.
>>>      
>>>
>>Well, some of it can be counted as cleanup or even tuning like the excellent
>>switch_to patch. But not that one and some of the more intrusive patches.
>>    
>>
>
>Yeah, I said ugly ones specificly.  There's been some nice previous ones,
>but most in this series (all the move of stuff to subarches) are rather
>horrible and lack lots of explanation.
>  
>

All of my previous patches have been aimed at fixing bugs, improving 
performance, reliability and maintinability of the i386 architecture.  
If you found something that didn't fit one of those categories in my 
previous patches, then it is either not well enough explained or perhaps 
inadvertently slipped through from one of my more radical trees - or it 
could be a bug.

There is a simple explanation for all of this series.  The goal is to 
move all privileged instructions, sensitive instructions, and privilege 
awareness into a layer where it can be overridden by new code without 
disrupting the default architecture.  On x86, there are a lot of 
instructions - popf, iret, sgdt, and others which behave differently 
under different privilege levels, but do not trap.  These architectural 
features must be redefined by any architecture which virtualizes the 
x86, be it Xen, UML, or an alternative approach.  Similarly, certain 
privileged processor data structures (page tables, descriptor tables) 
must be protected and accessed in a different manner if one is to 
utilize the principles of paravirtualization to achieve high performance 
inside of a virtual machine.  I believe this series of patches is one 
almost clean solution to this.  There are obvious problems with the MMU 
patch, and I'm still trying to come up with a way to properly address that.

That said, I am definitely seeking any feedback you have on how to 
achieve this goal while being as clean and maintainable as possible - if 
the Linux community is indeed interested in adopting a 
paravirtualization approach.  Looking from the most general view 
possible, there are a couple of ways to do this in Linux:

1) Create a new architecture.  This is the UML approach, and while it 
has been successful there, it is difficult to maintain closeness to the 
hardware architecture without introducing a maintenance burden.  This 
closeness is desirable if one is to achieve high performance and take 
advantage of more processor specific features.

2) Use the sub-architecture strategy of x86.  This approach has a 
relatively small set of code movement to allow a new virtualized 
sub-architecture to redefine the privileged and sensitive operations of 
the processor, as well as to implement easily defined architectural 
hints which employ higher level virtualization strategies.

3) Use #ifdef'd include/asm-i386 header files.  While workable, this has 
flaws - it is ugly, and it causes the hypervisor header files to sneak 
into include/asm-i386 rather rapidly destroying maintainability for the 
native code.  This has been attempted before, but if someone were to 
send those patches to LKML, I would expect them to be rapidly tarred and 
feathered.

4) Clone entire asm-i386 header files and replace them using an include 
path, potentially in the sub-architecture level.  While this avoids any 
diffs at all to the native asm-i386 headers, it needlessly duplicates a 
lot of code, and this creates a greater maintenance burden for 
somebody.  Who that body is can be determined later, but this creates a 
lot of extra work for that unfortunate person that is wasted time that 
could easily be spent bettering Linux!

5) Use the HAVE_SUBARCH_PTE_ACCESSOR type approach (similar to the way 
generic optimizable PTE operations are defined in asm-generic).  I have 
not yet investigated the feasibility of this type of approach, but it 
seems workable.  At least for the MMU patch, some combination of this 
and other techniques might help make things a lot cleaner.

Do you have ideas?  I'm open to all suggestions here.  The only goal I 
have is to make high performance virtualization support in Linux the 
least disruptive event possible for all parties.  Although I'm a bit 
biased towards i386 from a coding point of view, some of these ideas can 
cross architecture boundaries as well, so I'm open to feedback from all 
parties.

Thanks,
Zach
