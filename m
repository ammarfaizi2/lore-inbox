Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753180AbVHHBES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbVHHBES (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 21:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbVHHBES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 21:04:18 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:34061 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1753180AbVHHBER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 21:04:17 -0400
Message-ID: <42F6AF8E.60107@vmware.com>
Date: Sun, 07 Aug 2005 18:04:14 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel@vger.kernel.org, Pratap Subrahmanyam <pratap@vmware.com>
Subject: Re: [PATCH] abstract out bits of ldt.c
References: <372830000.1123456808@[10.10.2.4]> <20050807234411.GE7991@shell0.pdx.osdl.net> <374910000.1123459025@[10.10.2.4]> <20050807174129.20c7202f.akpm@osdl.org> <20050808004645.GT7762@shell0.pdx.osdl.net>
In-Reply-To: <20050808004645.GT7762@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Aug 2005 01:04:14.0015 (UTC) FILETIME=[17C5C4F0:01C59BB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>* Andrew Morton (akpm@osdl.org) wrote:
>  
>
>>"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>>    
>>
>>>xen_make_pages_readonly / xen_make_pages_writable ?
>>>      
>>>
>>Well we don't want to assume "xen" at this stage.  We're faced with a
>>choice at present: to make the linux->hypervisor interface be some
>>xen-specific and xen-controlled thing, or to make it a more formal and
>>controlled kernel interface which talks to a generic hypervisor rather than
>>assuming it's Xen down there.
>>    
>>
>
>No, definietly not.  Xen is not appropriate global namespace.  Also,
>it's not about pages at this point, it's about ldt handling.
>  
>

I like these patches.  They greatly simplify a lot of the work I had 
anticipated was necessary for Xen.  I.e. - LDT / GDT accessors are not 
needed for most updates, only updates to live descriptor table entries 
(for GDT this is TLS, LDT, TSS?, entries and there is 1 LDT update case).

BTW, Martin, did you see my ldt-accessors patch?  It also encapsulates 
that 1 LDT update case you show here, just named differently.

Yours:

+static inline int install_ldt_entry (__u32 *lp, __u32 entry_1, __u32 entry_2)
+{
+	*lp     = entry_1;
+	*(lp+1) = entry_2;
+	return 0;
+}

Mine:

+static inline void write_ldt_entry(void *ldt, int entry, __u32 entry_a, __u32 entry_b)
+{
+	__u32 *lp = (__u32 *)((char *)ldt + entry*8);
+	*lp = entry_a;
+	*(lp+1) = entry_b;
+}


They both work, but mine does not assume page aligned LDTs (necessary to 
extract entry number).  This is moot right now because LDTs are page 
aligned anyway in Linux.  I actually don't care which one we use, but it 
might be even nicer if we got one with C type checking (struct 
desc_struct for ldt).

Does Xen assume page aligned descriptor tables?  I assume from this 
patch and snippets I have gathered from others, that is a yes, and other 
things here imply that DT pages are not shadowed.  If so, Xen itself 
must have live segments in the GDT pages, so how do you allocate space 
for the per-CPU GDT pages on SMP?


>>As long as it doesn't hamper performance or general code sanity, I think it
>>would be better to make this a well-defined and controlled Linux interface.
>>Some of the code to do that is starting to accumulate in -mm.  Everyone
>>needs to sit down, take a look at the patches and the proposal and work out
>>if this is the way to proceed.
>>    
>>
>
>We're doing that, but it's splintered and coming in from different angles.
>It'd be better to get the story straight then submit patches, IMO.
>  
>

I think introducing mach-xen headers is a bit premature though - lets 
get the interface nailed down first so that the hypervisor developers 
have time to settle the include/asm-i386/mach-xxx files without dealing 
unneeded churn onto the maintainers.

Zach
