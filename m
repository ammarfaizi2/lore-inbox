Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275436AbTHNTpd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275438AbTHNTpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:45:32 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:12818 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S275436AbTHNTpS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:45:18 -0400
Date: Thu, 14 Aug 2003 21:45:00 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "'Timothy Miller'" <miller@techsource.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: generic strncpy - off-by-one error
Message-ID: <20030814194500.GA21146@alpha.home.local>
References: <D069C7355C6E314B85CF36761C40F9A42E20AB@mailse02.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D069C7355C6E314B85CF36761C40F9A42E20AB@mailse02.se.axis.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 11:34:50AM +0200, Peter Kjellerstedt wrote:
 
> char *strncpy(char *dest, const char *src, size_t count)
> {
> 	char *tmp = dest;
> 
> 	while (count) {
> 		if (*src == '\0')
> 			break;
> 
> 		*tmp++ = *src++;
> 		count--;
> 	}
> 
> 	while (count) {
> 		*tmp++ = '\0';
> 		count--;
> 	}
> 
> 	return dest;
> }
> 
> Moving the check for *src == '\0' into the first loop seems
> to let the compiler reuse the object code a little better
> (may depend on the optimizer). Also note that your version
> of the second loop needs an explicit  comparison with -1,
> whereas mine uses an implicit comparison with 0.

Well, if you're at this level of comparison, then I may object that
'count' is evaluated twice when jumping from one loop to the other one.

*Algorithmically* speaking, the most optimal code should be :

char *strncpy(char *dest, const char *src, size_t count)
{
        char *tmp = dest;
        if (unlikely(!count))
                goto end;
loop1:
        if ((*tmp = *src++) == '\0')
		goto next;
        tmp++;
        if (likely(--count))
		goto loop1;
	else
		goto end;
loop2:
        *tmp = '\0';
next:
        tmp++;
        if (likely(--count))
		goto loop2;
end:
        return dest;
}

(sorry for those who hate gotos). Look at it : no test is performed twice, no
byte is read nor written twice in any case. The assembly code produced is
optimal on x86 (well, in fact we could delete exactly one conditionnal jump
because the compiler doesn't know how to reuse them for several tests). 16
inlinable instructions (= excluding function in/out) which can be executed 2 at
a time if your CPU has 2 pipelines. about 3 cycles/copied byte, 2 cycles/filled
byte.

Unfortunately, it fools branch predictors and prefetch mechanisms found in
today's processors, so it results in slower code than yours (at least on
athlon and P3). Perhaps it would be fast on older processors, I don't know.

All that demonstrates that whatever your efforts in helping the optimizer, the
only meaningful result is the benchmark. Number of bytes and speculations on
the reusability of information between lines of codes are not what makes our
programs fast anymore :-(

> Testing on the CRIS architecture, your version is 24 instructions,
> whereas mine is 18. For comparison, Eric's one is 12 and the
> currently used implementation is 26 (when corrected for the
> off-by-one error by comparing with > 1 rather than != 0 in the
> second loop).

Just out of curiosity, can the CRIS architecture execute multiple instructions
per cycle ? have you tried to determine the dependencies between the
instructions ? Did you time the different functions ? (yours is rather fast on
x86 BTW).

To conclude, I would say that if we want to implement really fast low-level
primitives such as str*, mem*, ... there's nothing better than assembly
associated with benchmarks on different CPU architectures and models.

But I don't know if strncpy() is used enough to justify that...

Regards,
Willy
