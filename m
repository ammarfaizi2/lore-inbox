Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWAKI1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWAKI1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 03:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWAKI1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 03:27:46 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:3001 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932317AbWAKI1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 03:27:38 -0500
Date: Wed, 11 Jan 2006 03:24:10 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] fix i386 mutex fastpath on FRAME_POINTER &&
  !DEBUG_MUTEXES
To: Ingo Molnar <mingo@elte.hu>
Cc: Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601110327_MC3-1-B5A3-6E0E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060110210744.GA8850@elte.hu>

On Tue, 10 Jan 2006 at 22:07:44 +0100, Ingo Molnar wrote:

> --- linux.orig/include/asm-i386/mutex.h
> +++ linux/include/asm-i386/mutex.h
> @@ -28,7 +28,13 @@ do {                                                                       \
>                                                                       \
>       __asm__ __volatile__(                                           \
>               LOCK    "   decl (%%eax)        \n"                     \
> -                     "   js "#fail_fn"       \n"                     \
> +                     "   js 2f               \n"                     \
> +                     "1:                     \n"                     \
> +                                                                     \
> +             LOCK_SECTION_START("")                                  \
> +                     "2: call "#fail_fn"     \n"                     \
> +                     "   jmp 1b              \n"                     \
> +             LOCK_SECTION_END                                        \
>                                                                       \
>               :"=a" (dummy)                                           \
>               : "a" (count)                                           \


But now it's inefficient again.

Why not this:

                LOCK    "   decl (%%eax)        \n"                     \
                        "   jns 1f              \n"                     \
                        "   call "#fail_fn"     \n"                     \
                        "1:                     \n"                     \
                                                                        \
                :"=a" (dummy)                                           \
                : "a" (count)                                           \


Will the extra taken forward conditional jump in the fastpath cause much of
a slowdown?

-- 
Chuck
Currently reading: _Olympos_ by Dan Simmons
