Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbTDSITS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 04:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbTDSITS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 04:19:18 -0400
Received: from dp.samba.org ([66.70.73.150]:51684 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263366AbTDSITR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 04:19:17 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] kstrdup 
In-reply-to: Your message of "Sat, 19 Apr 2003 00:48:36 -0400."
             <3EA0D524.7010309@pobox.com> 
Date: Sat, 19 Apr 2003 18:28:24 +1000
Message-Id: <20030419083116.668DB2C003@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3EA0D524.7010309@pobox.com> you write:
> Since the kernel does its own string ops, the compiler does not have 
> enough information to deduce that further optimization is possible.

You're right, I was measuring without the kernel string ops.
> > Case in point: gcc-3.2 on -O2 on Intel is one instruction longer for
> > your version.
> 
> And?  It's still slower.

Who gives a flying fuck?  You're doing an allocation in there
ferchissakes.  Choose the simplest option.  Jeff, if you have time to
post on this, I think you need a hobby 8)

char *__constant_kstrdup(const char *s, unsigned int size, int gfp)
{
	char *buf = kmalloc(size, gfp);
	if (likely(buf))
		memcpy(buf, s, size);
	return buf;
}

char *__kstrdup(const char *s, int gfp)
{
	return __constant_kstrdup(s, strlen(s)+1, gfp);
}

#define kstrdup(str, gfp)						\
	(__builtin_constant_p(str) && sizeof(str) != sizeof(char *) ?	\
		__constant_kstrdup(str, sizeof(str), gfp)		\
	: __kstrdup(str, gfp))

Feature list:
1) Optimizes the constant kstrdup case,
2) Doesn't multi-evaluate args (except if constant string),
3) Uses likely() to bias against the case of kmalloc failing.

OK, so I guess I need a hobby, too..
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
