Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbVKHVxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbVKHVxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbVKHVxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:53:32 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:22020 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030370AbVKHVxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:53:31 -0500
Message-ID: <43711E15.4090502@vmware.com>
Date: Tue, 08 Nov 2005 13:52:21 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 4/21] i386 Broken bios common
References: <200511080422.jA84MQxK009859@zach-dev.vmware.com> <Pine.LNX.4.64.0511080703530.3247@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511080703530.3247@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2005 21:52:22.0078 (UTC) FILETIME=[B28A55E0:01C5E4AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Mon, 7 Nov 2005, Zachary Amsden wrote:
>  
>
>>Both the APM BIOS and PnP BIOS code use a segment hack to simulate real
>>mode selector 0x40 (which points to the BIOS data area at 0x00400 in
>>real mode).  Several broken BIOSen use selector 0x40 as if they were
>>running in real mode, which we make work by faking up selector 0x40 in
>>the GDT to point to physical memory starting at 0x400.  We limit the
>>access to the remainder of this physical page using a byte granular
>>limit.  Rather than have this tricky code in multiple places, it makes
>>sense to define it in one place, and the GDT makes a very convenient
>>place for it.  Use GDT entry 4 as the BAD_BIOS_CACHE segment.
>>    
>>
>
>I'd much rather use entry 8 instead, which should just automatically mean 
>that selector 0x40 _always_ points to virtual address 0x400. No switching 
>etc..
>
>Isn't this what Wine already has to work around, or something?
>  
>

I have answers now to the questions:

Wine has to support allocating thread pointers for NT processes in 
ntdll, so it needs a way to allocate descriptors.  It doesn't seem to 
care if they are LDT or GDT descriptors.

>Ingo, can we move the TLS selectors upwards, or does user space perhaps 
>know about the current TLS layout? Wine in particular may well know ;(
>  
>

It does not know.  And DOSemu appears to only use LDT.  GDT is used to 
allocate a global thread area for Wine, but it has a fallback mechanism 
that appears to have been built from the start to deal with varying 
thread selectors rather than a fixed notion (as GDT TLS segments are not 
available on 2.4).  Rather convenient.

Now the million dollar question is : who uses three TLS segments?  Wine 
appears to use glibc, private, and I have no idea what other software 
makes use of this.  If only two thread selectors were needed, then this 
does the trick.  Or we could rebase the selectors down to 0x20-0x30.

 *  ------- start of TLS (Thread-Local Storage) segments:
 *
 *   6 - TLS segment #1                 [ glibc's TLS segment ]
 *   7 - TLS segment #2                 [ Wine's %fs Win32 segment ]
 *   8 - BIOS real mode segment


Zach
