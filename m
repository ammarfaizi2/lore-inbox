Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWCOJTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWCOJTW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 04:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWCOJTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 04:19:22 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:21008 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932121AbWCOJTV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 04:19:21 -0500
Message-ID: <4417DBE8.6070302@vmware.com>
Date: Wed, 15 Mar 2006 01:18:32 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Gerd Hoffmann <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
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
Subject: Re: [RFC, PATCH 7/24] i386 Vmi memory hole
References: <200603131804.k2DI4N6s005678@zach-dev.vmware.com> <20060314064107.GK12807@sorel.sous-sol.org> <44166D6B.4090701@vmware.com> <20060314215616.GM12807@sorel.sous-sol.org> <4417454F.2080908@vmware.com> <20060315043108.GP12807@sorel.sous-sol.org> <4417CFDA.1060806@suse.de> <4417D212.20401@vmware.com> <20060315090935.GS12807@sorel.sous-sol.org>
In-Reply-To: <20060315090935.GS12807@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Zachary Amsden (zach@vmware.com) wrote:
>   
>> ENTRY(sysenter_entry)
>>        movl TSS_sysenter_esp0(%esp),%esp
>> sysenter_past_esp:
>>        STI
>>        pushl $(__USER_DS)
>>        pushl %ebp
>>        pushfl
>>        pushl $(__USER_CS)
>>        pushl $SYSENTER_RETURN
>>
>> SYSENTER_RETURN is a link time constant that is defined based on the 
>> location of the vsyscall page.  If the vsyscall page can move, this can 
>> not be a constant.  The reason is, this "fake" exception frame is used 
>> to return back to the EIP of the call site, and sysenter does not record 
>> the EIP of the call site.
>>     
>
> It's only real issue for something like execshield.  For this it's easy
> to do the fixed math since it's still at fixed address.
>
> +       DEFINE(VSYSCALL_BASE, (PAGE_OFFSET - 2*PAGE_SIZE));
>   

Ok, I'm confused.  What fixed math?  The return EIP that is pushed here 
is used when sysenter is active and you have to IRET back to userspace.  
If that EIP is dynamically relocatable, you can't do fixed math unless 
you patch the pushl site dynamically.  Notable reasons for returning via 
IRET on this fake exception frame were (until my recent submission) IOPL 
changes, but I believe there were more.  I will have to inspect the 
source to determine if that is still the case.

Zach
