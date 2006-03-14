Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWCNDRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWCNDRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 22:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWCNDRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 22:17:10 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:27661 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750798AbWCNDRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 22:17:09 -0500
Message-ID: <44163596.50207@vmware.com>
Date: Mon, 13 Mar 2006 19:16:38 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 3/24] i386 Vmi interface definition
References: <200603131801.k2DI1EAe005650@zach-dev.vmware.com> <20060314003956.GE12807@sorel.sous-sol.org>
In-Reply-To: <20060314003956.GE12807@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Zachary Amsden (zach@vmware.com) wrote:
>   
>> Master definition of VMI interface, including calls, constants, and
>> interface version.
>>     
>
>   
>> +/* VROM call table definitions */
>> +#define VROM_CALL_LEN             32
>> +
>> +typedef struct VROMCallEntry {
>> +   char f[VROM_CALL_LEN];
>> +} VROMCallEntry;
>>     
>
> And the call entry is meant to be handled in whatever mechanism hypervisor
> prefers for its entry points (ABI constraints notwithstanding) as in,
> arbitrary software interrupt, or call gate, etc?  I guess for transparent
> it has to, since those would be local calls.   Quite similar to the
> hypercall entry point that Xen places on the hypercall_page, so easily
> compatible.

See below.

> The document is slightly more descriptive.  The above reserved slots
> are shown as:
>
> 	char		reserved[32];
> 	char		elfHeader[64];
>
> But that's only 3 (0-2).  I think I'm missing some small bit of magic.
>
>   
>> +typedef struct VROMCallTable {
>> +   VROMCallEntry    vromCall[128];           // @ 0x80: ROM calls 4-127
>> +} VROMCallTable;
>>     
>
> That comment eludes me.  Are 0-3 special somehow (IOW, I thought it was
> just 0-2 as per above), and is it suggesting int 0x80?
>   

Yeah, most of this is rather crufty - it is in transition.  We had a 
full blown ROM image with 32-byte aligned stub points at one point for 
all of the VMI calls.  In fact, it still is in that form, and it was 
required to overlap exactly with a native ROM that was built into 
Linux.  See patch 6, VMI magic fixes for the details.

The machinery is already in place to do this, and it is a very nice 
thing that Xen has decided to adopt a similar approach (to the ROM) of 
publishing hypervisor code.  I think they even use 32-byte alignment as 
well.  The power of an indirection at this layer is just too attractive, 
and once you decide on a single binary image, I think it is inevitable 
that everyone will converge on the same idea.  The same concept surfaces 
over and over - vsyscall being another example.  You're basically 
dynamically linking in code at runtime, which is a pretty common thing 
to do, and gives you a very powerful redirection interface.

But we discovered that we couldn't achieve native performance, even 
using directly linked calls into the ROM.  Calling out for sti / cli / 
popf / pushf on fast paths is just too expensive.  We had to inline the 
native code to match native performance.  And this leaves an opportunity 
for flexibility and performance in the hypervisor implementation.

You don't want direct calls to 32-byte stubs; in fact, as Joshua found, 
you can't get optimal performance in a hypervisor that way.  What you 
need is the ability to preferentially inline certain hot calls into the 
VMI layer by using NOP padding.  The non-hot calls can call out to the 
hypercall page.

Publishing code is the first step - inlining is the second, and it gets 
you back the hit you took when indirecting your fast paths.

Zach
