Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWCOXec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWCOXec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbWCOXec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:34:32 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:40970 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751295AbWCOXeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:34:31 -0500
Message-ID: <4418A486.2010409@vmware.com>
Date: Wed, 15 Mar 2006 15:34:30 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
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
Subject: Re: [RFC, PATCH 16/24] i386 Vmi io header
References: <200603131811.k2DIBS8j005741@zach-dev.vmware.com> <m1acbrxv9v.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1acbrxv9v.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Zachary Amsden <zach@vmware.com> writes:
>
>   
>> Move I/O instruction building to the sub-arch layer.  Some very crafty
>> but esoteric macros are used here to get optimized native instructions
>> for port I/O in Linux be writing raw instruction strings.  Adding a
>> wrapper layer here is fairly easy, and makes the full range of I/O
>> instructions available to the VMI interface.
>>
>> Also, slowing down I/O is not a useful operation in a VM, so there
>> is a VMI call specifically to allow making it a NOP.  I could find
>> no place where SLOW_IO_BY_JUMPING is still used, and consider it
>> obsoleted.  Even on older 386 systems, the I/O delay approximation
>> by touching the extra page register is likely to better.
>>     
>
> This sounds like a prime candidate for the alternate instruction interfaces
> and I don't see that being used here.

The problem is that floppy controllers and other crufty hardware 
actually do need those slowing port operations to work reliably.  If you 
look at the usage of slow_down_io, you get scared pretty quick.  If you 
want your driver to use it, you have the option of defining 
REALLY_SLOW_IO in your C file, then suffix your I/O calls with _p.  The 
definition of SLOW_DOWN_IO actually used to be raw assembly instructions 
encapsulated in quotations.  I just realized this does actually change 
the semantics of drivers/net/de600.c, which really is the only driver 
which defines SLOW_IO_BY_JUMPING.

This usage of predefined macros in the driver causing port I/O semantics 
to change seems a little strange to try to wrap onto an alternate 
instruction interfaces, since it is dependent definitions local to each 
.C file, rather than global processor or derived feature bits.

The VMI call wrappers are very much similar to the alternate instruction 
interfaces - they just leave the alternative to be defined by the 
hypervisor.
