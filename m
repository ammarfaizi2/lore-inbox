Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVHHW3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVHHW3S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVHHW3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:29:18 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:40863 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932296AbVHHW3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:29:17 -0400
Message-ID: <42F7DCBB.3000607@vc.cvut.cz>
Date: Tue, 09 Aug 2005 00:29:15 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jiang <djiang@mvista.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: x86_64 frame pointer via thread context
References: <42F3EC97.2060906@mvista.com.suse.lists.linux.kernel> <p73slxn1dry.fsf@bragg.suse.de> <42F7A609.5030502@mvista.com> <42F7BB2C.6070004@vc.cvut.cz> <42F7BE4A.6030709@mvista.com> <42F7C01E.4020108@vc.cvut.cz> <42F7C9F9.7000505@mvista.com>
In-Reply-To: <42F7C9F9.7000505@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jiang wrote:
> Petr Vandrovec wrote:
>> #0  tb_sig_handler (sig=33, info=0x407ff2f0, ucontext=0x407ff1c0) at 
>> ttest1.c:26
>> #1  <signal handler called>
>> #2  0x00002aaaaad81335 in nanosleep () from /lib/libc.so.6
>> #3  0x00002aaaaad811a5 in sleep () from /lib/libc.so.6
>> #4  0x0000000000400871 in test_thread1 (arg=0x0) at ttest1.c:40
>> #5  0x00002aaaaabc6b55 in start_thread () from /lib/libpthread.so.0
>> #6  0x00002aaaaada87f0 in clone () from /lib/libc.so.6
> 
> 
> Ooops, you are right. I forgot about those ones in the threads. Yes you 
> are right. Once the sleep goes away rBP displays the correct values. Is 
> this issue due to glibc or because of the toolchain? I do not have this 
> issues on 32bit x86.... I would assume that the reason it works on 
> Mandrake is due to the toolchain they use versus other distros? The 
> toolchain determines which registers to use and the 
> -fno-omit-frame-pointer did not prevent some of them from clobbering rbp?

You are building only your application with -fno-omit-frame-pointer,
libraries you are using are just used as is.  On 32bit x86 it works
as -O2 on x86 does not imply -fomit-frame-pointer, as frame pointer
is required (well, was) for debugging.  On x86-64 frame pointer is
not needed for debugging as it was always using DWARF debug info,
and so -O2 on x86-64 implies -fomit-frame-pointer.  Due to this most
of libraries you'll find on your 64bit system are built without frame
pointer.  Mandrake either explicitly asks for -fno-omit-frame-pointer,
or maybe their glibc is just sufficiently different that their sleep()
does not need %rbp for sleep().

Loading their glibc to the debugger and inspecting sleep & nanosleep
will reveal whether %rbp is just unchanged by these (and so it works
due to luck), or whether their sleep uses pushq %rbp; movq %rsp,%rbp
- in which case they built glibc with frame pointers for no apparent
reason.

You must use debugging informations to get stacktrace on x86-64.
Blindly following %rbp does not work on this architecture (and lot
of others).
							Petr

