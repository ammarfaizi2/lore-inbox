Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbTEBJ0V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 05:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTEBJ0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 05:26:21 -0400
Received: from t7o53p50.telia.com ([213.64.145.50]:46978 "EHLO
	best.localdomain") by vger.kernel.org with ESMTP id S261998AbTEBJ0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 05:26:20 -0400
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Faster generic_fls
References: <200305020452_MC3-1-3708-DBEE@compuserve.com>
From: Peter Osterlund <petero2@telia.com>
Date: 02 May 2003 11:37:26 +0200
In-Reply-To: <200305020452_MC3-1-3708-DBEE@compuserve.com>
Message-ID: <m2isstadux.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> writes:

>   GCC is the strangest combination of utterly brilliant and brain-dead
> stupid that I've ever seen... I've seen it do tail merges that took
> my breath away, followed by this:
> 
>   mov <mem1>,eax
>   mov eax,<mem2>
>   mov <mem1>,eax        ; eax already contains mem1 you stupid compiler
>   ret

Not necessarily if mem2 == mem1 + 2. Consider this code:

        #include <string.h>
        int f(char* a, char* b)
        {
            int t;
            memcpy(&t, a, sizeof(int));
            memcpy(b, &t, sizeof(int));
            memcpy(&t, a, sizeof(int));
            return t;
        }

"gcc -O2 -Wall -S test.c -fomit-frame-pointer" correctly generates:

f:
        movl    4(%esp), %ecx
        movl    (%ecx), %eax
        movl    8(%esp), %edx
        movl    %eax, (%edx)
        movl    (%ecx), %eax
        ret

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
