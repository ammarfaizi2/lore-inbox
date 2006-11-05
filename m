Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422771AbWKEWsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422771AbWKEWsN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 17:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422773AbWKEWsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 17:48:12 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:54669 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1422771AbWKEWsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 17:48:12 -0500
Message-ID: <454E6A2A.5070002@vmware.com>
Date: Sun, 05 Nov 2006 14:48:10 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com>  <200611050641.14724.ak@suse.de> <454D9A75.7010204@vmware.com>  <200611051801.18277.ak@suse.de>  <Pine.LNX.4.64.0611050920220.25218@g5.osdl.org> <1162748079.3160.102.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0611050944380.25218@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611050944380.25218@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sun, 5 Nov 2006, Arjan van de Ven wrote:
>   
>> actually lockdep is pretty good at finding this type of bug IMMEDIATELY
>> even without the actual race triggering ;)
>>     
>
> Ehh. Last time this happened, lockdep didn't find _squat_. 
>
> This was when NT and AC leaked across context switches, because the 
> context switching had removed the "expensive" save/restore.
>   

Owning up to being the one who introduced the thing.  Actually, it was a 
pretty nice win for native, and a huge win for paravirtualization; 
calling out to two helper functions for save / restore flags while 
shuffling the stack is just awfully bad during such a critical region.  
If you look back all the way to 2.4 kernel series, there was no save / 
restore flags, and it didn't look like there ever was.  Somewhere during 
2.5 development, it migrated in as an unchangelogged fix, and I was able 
to dig up an email thread and reason that IOPL was leaking.  Course, 
instead of thinking it all the way through, I thought the precedent of 
having no eflags switching would be good enough with an explicit IOPL 
switch.  Then nasty AC / NT raised their heads. 

ID can be a problem as well; system calls during a code region which is 
testing for a Pentium by toggling the ID bit (perhaps from a printf() 
libc call) can cause the ID bit to leak onto another process or get 
lost. causing CPUID detection to fail.

I like Chuck's new set_eflags() since it fixes all this in a way we 
don't have to reason about heavily.  Also, moving it to C code instead 
of the assembler path is more maintainable.  IMHO, the assembler task 
switch should switch the stack, which you can't do in C, and that is 
it.  Everything else can be nicely packaged above it, including the 
get_eflags().

Zach
