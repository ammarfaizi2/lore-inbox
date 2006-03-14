Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752193AbWCNQeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbWCNQeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbWCNQeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:34:04 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:11275 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1752184AbWCNQeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:34:03 -0500
Message-ID: <4416F038.90707@vmware.com>
Date: Tue, 14 Mar 2006 08:32:56 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 17/24] i386 Vmi msr patch
References: <200603131812.k2DICGJE005747@zach-dev.vmware.com> <200603141723.54365.ak@suse.de>
In-Reply-To: <200603141723.54365.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 13 March 2006 19:12, Zachary Amsden wrote:
>   
>> Fairly straightforward code motion of MSR / TSC / PMC accessors
>> to the sub-arch level.  Note that rdmsr/wrmsr_safe functions are
>> not moved; Linux relies on the fault behavior here in the event
>> that certain MSRs are not supported on hardware, and combining
>> this with a VMI wrapper is overly complicated.  The instructions
>> are virtualizable with trap and emulate, not on critical code
>> paths, and only used as part of the MSR /proc device, which is
>> highly sketchy to use inside a virtual machine, but must be
>> allowed as part of the compile, since it is useful on native.
>>     
>
> I'm not aware of any MSR access being on a critical code
> path on a 32bit kernel. 
>   

There aren't really any.  There are some unexpected ones - such as 
setting SYSENTER_CS during a context switch, but only if leaving v8086 
mode, which isn't a common case.  But most importantly, the MSR 
functions were challenging to get correct, because they combine two 
novel elements - 64 bit values, as well as non-C calling conventions.  
They were actually some of the first functions I inlined, because I knew 
there would be problems, and the solutions would yield more powerful 
inlining macros.

> And I don't think it's a good idea to virtualize the TSC 
> without CPU support.
>   

We currently don't support configurations without a TSC.  But we're not 
trying to virtualize the TSC without CPU support.  It is possible.  But 
I have no idea _why_ you would want to do such a thing.

Zach
