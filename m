Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965326AbWKDUJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965326AbWKDUJp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965551AbWKDUJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:09:45 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:7360 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965326AbWKDUJo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:09:44 -0500
Message-ID: <454CF388.509@vmware.com>
Date: Sat, 04 Nov 2006 12:09:44 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: remove IOPL check on task switch
References: <200611031900_MC3-1-D041-6F32@compuserve.com> <454CE7D9.3070308@vmware.com> <454CEC5C.2050507@vmware.com> <Pine.LNX.4.64.0611041152060.25218@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611041152060.25218@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sat, 4 Nov 2006, Zachary Amsden wrote:
>   
>> Ok, checking shows Linus put it back to stop NT leakage.  This is correct, but
>> unlikely.  Would be nice to avoid it unless absolutely necessary.  Perhaps xor
>> eflags old and new and only set_system_eflags() if non-ALU bits have changed.
>>     
>
> Not just NT. AC also leaked, and caused crashes in other programs (Wine) 
> that didn't expect AC to be set and did unaligned accesses.

Yes, AC, NT, IOPL, ID are bad to leak.  DF / TF / RF are impossible to 
leak by privilege contract.  SF, ZF, PF, OF, CF can be clobbered.

VM / VIF / VIP are dealt with in separate switch paths (although I have 
witnessed a VIF leak once from a userspace process that managed to get 
VIF set).  These can't even be set with popf, and require iret to fix.

But 99% of the time, only SF / ZF / PF / OF / CF will be different, so 
you can avoid the popf.

Zach
