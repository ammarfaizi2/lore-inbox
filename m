Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWEZQdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWEZQdy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWEZQdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:33:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37293 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751086AbWEZQdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:33:32 -0400
To: "Magnus Damm" <magnus.damm@gmail.com>
Cc: "Magnus Damm" <magnus@valinux.co.jp>, "Andrew Morton" <akpm@osdl.org>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [Fastboot] [PATCH 03/03] kexec: Avoid overwriting the current
 pgd (V2, x86_64)
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	<20060524044247.14219.13579.sendpatchset@cherry.local>
	<m1slmystqa.fsf@ebiederm.dsl.xmission.com>
	<1148545616.5793.180.camel@localhost>
	<m11wuif5zy.fsf@ebiederm.dsl.xmission.com>
	<aec7e5c30605252017v1d8269a4jf75f055fe256f966@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 26 May 2006 10:32:19 -0600
In-Reply-To: <aec7e5c30605252017v1d8269a4jf75f055fe256f966@mail.gmail.com> (Magnus
 Damm's message of "Fri, 26 May 2006 12:17:14 +0900")
Message-ID: <m1ejygbvcc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Magnus Damm" <magnus.damm@gmail.com> writes:

> The code is not broken. The code does exactly what you are talking
> about. Maybe I was a bit unclear.

Ack.  I got a little confused.  I was still thinking of what
the identity mapping was trying to achieve, and you don't achieve
the same thing.

> "page_table_a" contains two mappings. One which is the same as where
> the page is mapped in the kernel (the virtual address where
> relocate_new_kernel is located), and one identity mapped. So when the
> switch occurs the cpu will continue to run on the same virtual
> address.

In the general case which you want to cover page_table_a is still
slightly wrong.  In particular you can theoretically get a conflict
between the virtual address of your page table switching function and
the physical address of the control code page.

However while I agree that you need to do this in assembly for
control I disagree that this code should be part of the
relocate_new_kernel function.

Please move the code that uses page_table_a to a separate function,
that when it is done jumps to the control_code page.  Then you can
map this page both virtually and physically with a statically
allocated page table built a compile time.

This is a little simpler as you don't need to build this first
page table dynamically and a little clearer as you aren't trying to
get the control code page to serve two different functions.

If this function was more than 3 lines of assembly it could even
be written in C for clarity with a special section so that
the linker would not map it twice.  Of course that would still need
to address the stack usage problem.


>> So you need at least one additional entry in your page table.
>>
>> The fact that this bug did not jump out is a clear sign you were
>> changing too many things at once, and did not have an adequate
>> explanation in your change log.
>
> I will ignore that last part for now. I've tested the code on i386,
> i386/pae, x86_64 (both opteron and athlon64) and all the combinations
> with and without xen, and all configurations except x86_64 with both
> kexec and kdump.

Testing is important here.  But given that 99% of the bug hunting must
be done via code review and thinking about the problem testing is not
sufficient.

Eric
