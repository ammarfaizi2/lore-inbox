Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbSLQRrW>; Tue, 17 Dec 2002 12:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbSLQRrV>; Tue, 17 Dec 2002 12:47:21 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:32180
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265396AbSLQRrS>; Tue, 17 Dec 2002 12:47:18 -0500
Message-ID: <3DFF6501.3080106@redhat.com>
Date: Tue, 17 Dec 2002 09:55:13 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212170858510.2702-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212170858510.2702-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Yeah, it's not very convenient. I didn't find any real alternatives,
> though, and you can always just put 0xfffff000 in memory or registers and
> jump to that.

Putting the value into memory myself is not possible.  In a DSO I have
to address memory indirectly.  But all registers (except %ebp, and maybe
it'll be used some day) are used at the time of the call.

But there is a way: if I'm using

   #define makesyscall(name) \
        movl $__NR_##name, $eax; \
        call 0xfffff000-__NR_##name($eax)

and you'd put at address 0xfffff000 the address of the entry point the
wrappers wouldn't have any problems finding it.


> In fact, I suspect that if you actually want to use it in
> glibc, then at least in the short term that's what you need to do anyway,
> sinc eyou probably don't want to have a glibc that only works with very
> recent kernels.

That's a compilation option.  We might want to do dynamic testing and
yes, a simple pointer indirection is adequate.

But still, the problem is detecting the capable kernels.  You have said
not long ago that comparing kernel versions is wrong.  And I agree.  It
doesn't cover backports and nothing.  But there is a lack of an alternative.

If you don't like the process-global page thingy (anymore) the
alternative would be a sysconf() system call.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

