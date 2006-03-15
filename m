Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWCOIhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWCOIhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 03:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751963AbWCOIhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 03:37:20 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:22797 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751907AbWCOIhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 03:37:19 -0500
Message-ID: <4417D212.20401@vmware.com>
Date: Wed, 15 Mar 2006 00:36:34 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>,
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
References: <200603131804.k2DI4N6s005678@zach-dev.vmware.com> <20060314064107.GK12807@sorel.sous-sol.org> <44166D6B.4090701@vmware.com> <20060314215616.GM12807@sorel.sous-sol.org> <4417454F.2080908@vmware.com> <20060315043108.GP12807@sorel.sous-sol.org> <4417CFDA.1060806@suse.de>
In-Reply-To: <4417CFDA.1060806@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Hoffmann wrote:
>>> The complications in my patch come 
>>> from the fact that the vsyscall page has to be relocated dynamically, 
>>> requiring, basically run time linking on the page and some tweaks to get 
>>> sysenter to work.  If you don't use vsyscall (say, non-TLS glibc), then 
>>> you don't need that complexity.  But I think it might be needed now, 
>>> even for Xen.
>>>       
>> I believe both Xen and execshield move vsyscall out of fixmap, and then
>> map into userspace as normal vma.
>>     
>
> Yep, my patch (attached below for reference) moves the vsyscall page
> into user address space, just below PAGE_OFFSET.  Works basically the
> same way the vsyscall page is mapped in the ia32 emulation of the x86_64
>  architecture.  Address stays fixed, thus the relocation magic isn't needed.
>
> Once the vsyscall page is moved out of fixmap it's easy to make fixmap
> movable and thus have a runtime-resizable address space hole at the top
> of address space.  Patch is attached too, although that one is more
> proof-of-concept, it doesn't make much sense as-is.  It has a kernel
> command line option to specify the top of address space so you can play
> around with it ...
>
> Both patches are against -rc3 and most likely still apply just fine,
> havn't tested that though.
>   

Your patch looks a lot cleaner and less hackish than mine.  But I wonder 
if it still works with kernels that support the sysenter method of 
calling into the kernel.  Look at the following code:

ENTRY(sysenter_entry)
        movl TSS_sysenter_esp0(%esp),%esp
sysenter_past_esp:
        STI
        pushl $(__USER_DS)
        pushl %ebp
        pushfl
        pushl $(__USER_CS)
        pushl $SYSENTER_RETURN

SYSENTER_RETURN is a link time constant that is defined based on the 
location of the vsyscall page.  If the vsyscall page can move, this can 
not be a constant.  The reason is, this "fake" exception frame is used 
to return back to the EIP of the call site, and sysenter does not record 
the EIP of the call site.

Zach
