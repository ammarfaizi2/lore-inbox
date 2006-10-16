Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161143AbWJPWQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbWJPWQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbWJPWQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:16:12 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:51427 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1161143AbWJPWQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:16:11 -0400
Message-ID: <453404A2.6090008@vmware.com>
Date: Mon, 16 Oct 2006 15:16:02 -0700
From: Petr Vandrovec <petr@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.13) Gecko/20060809 Debian/1.7.13-0.3
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Gerd Hoffmann <kraxel@suse.de>, john stultz <johnstul@us.ibm.com>,
       caglar@pardus.org.tr, lkml <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>
Subject: Re: Vmware problems was Re: [RFC] Avoid PIT SMP lockups
References: <1160170736.6140.31.camel@localhost.localdomain> <1160592235.5973.5.camel@localhost.localdomain> <4533AE82.6010502@suse.de> <200610161822.48500.ak@suse.de>
In-Reply-To: <200610161822.48500.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2006 22:16:08.0790 (UTC) FILETIME=[AE33CF60:01C6F170]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 16 October 2006 18:08, Gerd Hoffmann wrote:
> 
>>john stultz wrote:
>>
>>>Hey Gerd,
>>>	Looks like the smp replacements code in 2.6.18 is breaking with vmware.
>>>I'm guessing we're taking an interrupt while apply_replacements is
>>>running. Any ideas?
>>
>>It's not the smp alternatives code, its the one for processor-specific
>>instructions.  The eip offset for alternative_instructions() in the
>>trace suggests it is the first call to apply_replacements.  The second
>>one is the one for the smp alternatives (which doesn't do anything btw
>>as we patch away the lock prefixes only).
> 
> 
> I would have expected that they trap those writes and invalidate the cache.
> Even qemu and valgrind do that fine.
> 
> Perhaps Zach has some clue or can refer to someone who has.

Why do you think it has something to do with VMware's emulation - except 
timing?  From what I see, there were bytes

0xF0 0x83 0x44 0x24 0x00 0x00

before apply_alternatives() was entered (binutils 2.17 would generate 
one byte shorter code, 0xF0 0x83 0x04 0x24 0x00, but that's another 
story - 2.16 and older treat 0(%esp) differently from (%esp)) .  Now 
update alternatives comes in and starts overwritting alternative - note 
that it does that in two steps - first it memcpy()-ies alternative, then 
it memcpy()-ies nop padding.  So after first memcpy() code looks like

0x0F 0xAE 0xE8 0x24 0x00 0x00

Now timer interrupt arrives, and these data are interpreted as

lfence; andb $0,%al; add %cl,0x465B9415(%ebx)

If it would not crash, once it would return 0x24 0x00 0x00 will get 
overwritten with 3 bytes NOP sequence and everybody will be happy.

AFAIT you do not see this because you have to use old binutils to repro 
this - I'm unable to reproduce this on Debian box with binutils 2.17, as 
then byte sequence is valid instruction even if partially overwritten - 
it just clears %al to zero, but nobody notices that...

So as far as I can tell, interrupts (and NMIs?) should be disabled when 
apply_alternatives() run if interrupt handlers are using alternatives - 
and as it was just proven, they do.

Reason you see this happening in VM often is that this first 
alternatives run invalidates lot of internal state, and it takes so long 
that next timer interrupt is for sure pending as soon as first "rep 
movsb" in alternatives finishes.

						Petr

