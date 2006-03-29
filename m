Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWC2CSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWC2CSg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 21:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWC2CSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 21:18:36 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:65210 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750777AbWC2CSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 21:18:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=u5mMs0zV/rTJ6jiTkA83byR8Vhd+R8whMfaQEUg+zh9VyqYAmS70PVlifU4ye1tB60Ct3EWPKK7CRwfL6fVzOf4zqyVnpuSdXXxCPpFQq2jopfOPaB/ywR63hKQxd3jd98ykTnBH7XhTQ/MfsO74uXYRJrVASsc0BXZ/K5Or2VM=  ;
Message-ID: <4429CFCA.7010201@yahoo.com.au>
Date: Wed, 29 Mar 2006 11:07:38 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Zoltan Menyhart <Zoltan.Menyhart@free.fr>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Fix unlock_buffer() to work the same way as bit_unlock()
References: <200603281853.k2SIrGg28290@unix-os.sc.intel.com> <4429ADBC.50507@free.fr> <Pine.LNX.4.64.0603281537500.15037@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0603281537500.15037@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>On Tue, 28 Mar 2006, Zoltan Menyhart wrote:
>
>
>>Why not to use separate bit operations for different purposes?
>>
>>- e.g. "test_and_set_bit_N_acquire()" for lock acquisition
>>- "test_and_set_bit()", "clear_bit()" as they are today
>>- "release_N_clear_bit()"...
>>
>>
>
>That would force IA64 specifics onto all other architectures.
>
>Could we simply define these smb_mb__*_clear_bit to be noops
>and then make the atomic bit ops to have full barriers? That would satisfy 
>Nick's objections.
>
>

Well yes, I think the current operations should not be changed because
that would probably require large and difficult audits of the tree.

However, I think it might be reaonsable to use bit lock operations for
in places like page lock and buffer lock (ie. with acquire and relese
semantics). It improves ia64 without harming other architectures, and
also makes the code more expressive.

>Index: linux-2.6.16/include/asm-ia64/bitops.h
>===================================================================
>--- linux-2.6.16.orig/include/asm-ia64/bitops.h	2006-03-19 21:53:29.000000000 -0800
>+++ linux-2.6.16/include/asm-ia64/bitops.h	2006-03-28 15:45:08.000000000 -0800
>@@ -45,6 +45,7 @@
> 		old = *m;
> 		new = old | bit;
> 	} while (cmpxchg_acq(m, old, new) != old);
>+	smb_mb();
> }
> 
>

Can this allow the actual bitop to move up past previous memory ops?
Would it be sufficient to just put a release barrier above the acquire
barrier?

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
