Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272743AbTHEMyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272754AbTHEMyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:54:50 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:33982 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S272743AbTHEMyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:54:40 -0400
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>, chip@pobox.com
Content-Type: text/plain
Organization: 
Message-Id: <1060087479.796.50.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 Aug 2003 08:44:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip Salzenberg writes:

> GCC is warning about a pointer-to-int conversion when
> the likely() and unlikely() macros are used with pointer
> values.  So, for architectures where pointers are larger
> than 'int', I suggest this patch.
...
> -#define likely(x) __builtin_expect((x),1)
> -#define unlikely(x) __builtin_expect((x),0)
> +#define likely(x) __builtin_expect((x),      1)
> +#define likely_p(x) __builtin_expect((x) != 0, 1)
> +#define unlikely(x) __builtin_expect((x)      ,0)
> +#define unlikely_p(x) __builtin_expect((x) != 0 ,0)

That's ugly, plus the "_p" suffix is kind of a
standard for "predicate". (__builtin_constant_p, etc.)

I'm using these in the procps project:

// tell gcc what to expect:   if(unlikely(err)) die(err);
#define likely(x)       __builtin_expect(!!(x),1)
#define unlikely(x)     __builtin_expect(!!(x),0)
#define expected(x,y)   __builtin_expect((x),(y))

That makes a slight change to the meaning, since the
original value is no longer available. I've not
found that to be any trouble at all; if it is then
you could work around it using a statement-expression
with a variable, cast, and/or __typeof__.

Something like this:

#define likely(x) ({   \
__typeof__ (x) _tmp;    \
__builtin_expect(!!_tmp,1); \
_tmp; \
})


