Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316870AbSEVGZB>; Wed, 22 May 2002 02:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316871AbSEVGZA>; Wed, 22 May 2002 02:25:00 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:55004 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316870AbSEVGY7>; Wed, 22 May 2002 02:24:59 -0400
Date: Wed, 22 May 2002 16:28:49 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-Id: <20020522162849.5908ecff.rusty@rustcorp.com.au>
In-Reply-To: <3CEAC020.4F63A181@zip.com.au>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2002 14:46:08 -0700
Andrew Morton <akpm@zip.com.au> wrote:
> Is it safe to stick a nose in here with some irrelevancies?

Well, if you can do it, I guess I can too...

Someone who knows x86 asm better than I can change everything in uaccess.h
to always return 0, like so:

#define copy_from_user(to, from, n) 				\
({								\
	/* Returns non-zero only if hit fault handler */	\
	if (general_copy_user((to), (from), (n)))		\
		memset(to, 0, n);				\
	0;							\
})

So the fault handler sends a SIGSEGV, and makes generic_copy_user return 1
immediately (if you were ambitious, it could do the memset too).

If someone wants to write the asm for that, I'll fix the SEGV delivery code
and mount option reading (two places where we must not deliver a signal),
and we can see what it looks like.

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
