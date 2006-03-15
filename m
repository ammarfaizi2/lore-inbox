Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWCOX7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWCOX7e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbWCOX7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:59:34 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:26381 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1752182AbWCOX7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:59:33 -0500
Message-ID: <4418A9C5.1070701@vmware.com>
Date: Wed, 15 Mar 2006 15:56:53 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
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
Subject: Re: [RFC, PATCH 4/24] i386 Vmi inline implementation
References: <200603131802.k2DI22OK005657@zach-dev.vmware.com> <20060315225212.GB1719@elf.ucw.cz>
In-Reply-To: <20060315225212.GB1719@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> We already do runtime patching for SMP vs. UP, could you use same
> infrastructure? I do not want VMI-specific grub.

I think we could almost use the same infrastructure - or extend it to 
work.  The problem is how to determine register liveness for calls into 
the VMI layer which take > 3 arguments.  If you squeeze all the 
arguments into fixed registers, you can unnecessarily constrain the 
native code - and rapidly run out of registers for the compiler to use, 
generating impossible constraints in some cases.

To work around these issues, we do not constrain the arguments beyond 
the first three registers.  But this means that the hypervisor needs a 
way to locate the additional arguments.  That information gets encoded 
implicitly by the auto-generated translation into a VMI call, which 
pushes the arguments onto the stack (thus revealing the registers, and 
allowing constant immediate optimization).

Now, if you can generate all of the code to do the callout to the VMI, 
you could use it directly in an alternative instruction sequence, just 
as the existing infrastructure.  But I'm not sure you can do it in one 
compiler pass.  We are already pushing the limits of the preprocessor, 
compiler and assembler here.  Having another preprocessing pass may make 
it possible, but it does make the build more complicated.

I'm not sure it is really what we want though.  The alternative 
instruction interfaces is based on global feature detection that is done 
and applied by the _kernel_.  In the end, we want the hypervisor to be 
able to toggle each VMI call site as a separate feature, and replace it 
with hypervisor specific code.  In this way, a VT based hypervisor could 
simply not patch those class of VMI calls that are already emulated by 
hardware, and also inline direct hypercalls for those classes that are 
not.  The VMI layer is supposed to be very much an inline linker for 
feature detection done by the _hypervisor_.

Zach
