Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbULGSom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbULGSom (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 13:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbULGSom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 13:44:42 -0500
Received: from mail.aknet.ru ([217.67.122.194]:21002 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261884AbULGSoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 13:44:37 -0500
Message-ID: <41B5FA1B.9090507@aknet.ru>
Date: Tue, 07 Dec 2004 21:44:43 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: prasanna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kprobes: dont steal interrupts from vm86
References: <20041109130407.6d7faf10.akpm@osdl.org> <20041110104914.GA3825@in.ibm.com> <4192638C.6040007@aknet.ru> <20041117131552.GA11053@in.ibm.com> <41B1FD4B.9000208@aknet.ru> <20041207055348.GA1305@in.ibm.com>
In-Reply-To: <20041207055348.GA1305@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prasanna.

You wrote:
> The patch below should fix this problem. Please
Thanks.

> let me know if you any issues.
Well, it kind of fixes the problem.
Actually it happened that it fixes
even the problem for the programs
that are using the segmentation.
Now am I happy? I am afraid, not.
To me your patch looks very wrong
(sorry), even though I am really not
the one to do such a claims.
Let's see how it "fixes" the problem
with segmentation, that I outlined
in my previous posting:

> -			ret = 1;
> +			ret = 0;
It is easy to notice that ret==0 at
that point *always*, so effectively
this code is now a no-op. Apparently
also gcc mentioned that, and removed
that code together with the surrounding
"if" clause. And it was exactly the
"if" condition where the bogus pointer
gets dereferenced. Now, since it gets
optimized away, the Oops is not any
more. But if I stick a simple printk()
in that block, the Oops is back.
So you "fixed" that based on the gcc
optimization.
Now the comments (that you just altered)
suggest that the break-point can be
removed by another CPU. I don't think
delivering the fault to the user-space
in this case is wise (but that's what
I'd care least, as I am not using the
kprobes myself yet). Maybe instead
it would be better to return 1 when
p!=NULL?
Also, you still use the completely
invalid addrress and pass it to several
functions like get_kprobe() (addr is
invalid in either v86 case or when the
segmentation is used). Since the
deref is now optimized away by gcc, I
can't write an Oops test-case for this,
but why you do not perform the sanity
checks to see whether or not the address
is valid? (the checks like I suggested
in previous posting)

Oh well. That said, your patch works
for me. I'd appreciate another patch
very much, that will address the problems
I see, but can't demonstrate by the
test-case any more. But of course at
least for me it is already better than
nothing, and of course it is not me to
decide whether the patch is to apply
or not. We'll see. Thanks anyway.

