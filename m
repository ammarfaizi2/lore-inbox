Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267912AbUHFX0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267912AbUHFX0T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 19:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUHFX0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 19:26:19 -0400
Received: from zero.aec.at ([193.170.194.10]:33284 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268320AbUHFX0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 19:26:08 -0400
To: Tim Bird <tim.bird@am.sony.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is extern inline -> static inline OK?
References: <2q0Wb-2Tc-17@gated-at.bofh.it> <2q1pe-3hq-17@gated-at.bofh.it>
	<2qlo1-wO-37@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 07 Aug 2004 01:26:04 +0200
In-Reply-To: <2qlo1-wO-37@gated-at.bofh.it> (Tim Bird's message of "Sat, 07
 Aug 2004 00:30:13 +0200")
Message-ID: <m3657vj1bn.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Bird <tim.bird@am.sony.com> writes:

> H. Peter Anvin wrote:
>> Followup to:  <4112D32B.4060900@am.sony.com>
>> By author:    Tim Bird <tim.bird@am.sony.com>
>> In newsgroup: linux.dev.kernel
>>
>>>Pardon my ignorance...
>>>
>>>Under what conditions is it NOT OK to convert "extern inline"
>>>to "static inline"?
>>>
>> When the code is broken if it doesn't inline.
>
> Thanks!
>
>  From what I have read, for either 'extern inline' or 'static inline'
> the compiler is free to not inline the code. Is this wrong?

Yes, it's wrong in current Linux 2.6. It currently defines inline to
inline __attribute__((always_inline))

> It is my understanding that...
> In the 'static inline' case the compiler may create a function in the
> local compilation unit. But in the 'extern inline' case an extern
> non-inline function must exist. If the compiler decides not to inline
> the function, and a non-inline function does not exist, you get a linker
> error.  Are you saying that, therefore, 'extern inline' functions are
> used (without definition of extern non-inline functions to back them)
> in order to guarantee that NO non-inline version of the function exists?

Exactly.

Originally it was used this way, but then the inlining algorithms got
completely broken to not explode compile times on broken C++ template
horrors, and in order to still compile the kernel most uses of extern
inline were converted to static inline.

Drawback is that you suddenly got a lot of binary bloat
(e.g. at some point gcc decided to not inline anymore 
the constant evaluation code in copy_{to,from}_user,
which caused incredibly code bloat).

That is when the #define inline __attribute__((always_inline)) was
added.

> Or are you saying that the non-inline version of the function may
> be written differently than the inline version?

That was the original intention I think, but Linux always has used
it for the first interpretation.

It's pretty obsolete now, modern gcc has __attribute__((always_inline)),
which is a better way to do this. You get a compiler error when 
the function cannot inlined. It also has a __attribute__((noinline))
for the opposite case.

Hope this helps,

-Andi

