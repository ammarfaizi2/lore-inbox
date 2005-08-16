Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbVHPRrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbVHPRrQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 13:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbVHPRrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 13:47:16 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:33547 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030258AbVHPRrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 13:47:15 -0400
Message-ID: <43022690.1090209@vmware.com>
Date: Tue, 16 Aug 2005 10:46:56 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, chrisl@vmware.com, pratap@vmware.com,
       virtualization@lists.osdl.org
Subject: Re: [RFC] [PATCH] Split host arch headers for UML's benefit
References: <20050816154201.GA6733@ccure.user-mode-linux.org>
In-Reply-To: <20050816154201.GA6733@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Aug 2005 17:46:55.0890 (UTC) FILETIME=[7E595F20:01C5A28A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:

>The patch below fixes the recent UML compilation failure in -rc5-mm1
>without making the UML build reach further into the i386 headers.  It
>splits the i386 ptrace.h and system.h into UML-usable and UML-unusable
>pieces.  
>
>The string "abi" is in there because I did ptrace.h first, and that
>involves separating the ptrace ABI stuff from everything else (if
>pt_regs is not considered part of the abi).  However, the system.h
>split is between random stuff that UML can use and random stuff that
>it can't.  So, perhaps better names would be -uml or -userspace or
>something.
>

I like this approach.  In general, it seems beneficial to split these 
into ABI and kernel implementation.  Also, this stuff eventually works 
its way into userspace headers.  It is not really clear which asm-xxx 
kernel headers are valid to include in userspace.  There are definitely 
multiple classes of things in the kernel header files : ABI definitions, 
user-useful macros and inlines, and things that are privately useful the 
kernel.  The ptrace split seems quite well defined here; the system 
split is a little less obvious, but I don't object to the way you have 
done it.

I've always wondered why we didn't have memory barriers in either 
asm/atomic.h or asm/barrier.h; system.h seems to just have a mixed bag 
of goodies.

Two things about the system.h split - do you use arch_align_stack()?.  
Also, do you use the alternative instruction replacement functionality, 
or do you just need the macro?  If you don't actually implement 
instruction replacement, it seems you could more easily redefine these to be

#define alternative(oldinstr, newinstr, feature) \
    asm volatile(oldinstr) ::: "memory")

Zach
