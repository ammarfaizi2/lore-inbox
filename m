Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSIAMen>; Sun, 1 Sep 2002 08:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316882AbSIAMen>; Sun, 1 Sep 2002 08:34:43 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:59145 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316878AbSIAMem>; Sun, 1 Sep 2002 08:34:42 -0400
Date: Sun, 1 Sep 2002 14:39:03 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "David S. Miller" <davem@redhat.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warnkill trivia 2/2
Message-ID: <20020901123903.GB7325@louise.pinerecords.com>
References: <20020901113741.GM32122@louise.pinerecords.com> <20020901.043512.51698754.davem@redhat.com> <20020901121053.GA7325@louise.pinerecords.com> <20020901.051611.85397564.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020901.051611.85397564.davem@redhat.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 7 days, 4:02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: Tomas Szepe <szepe@pinerecords.com>
>    Date: Sun, 1 Sep 2002 14:10:53 +0200
> 
>    > Let's keep the sparc atomic_read() how it is so more bugs
>    > like this can be found.
>    
>    I don't know, though... scratching my head here -- Is GCC actually
>    able to distinguish between 'const int *a' and 'int const *a'?
>    
> No I don't mean this in a "C" sense, I mean conceptually that marking
> an object const which has members which are volatile and updated
> asynchronously makes zero sense.

True.

I've been playing a bit with how gcc handles the const qualifiers
and made an interesting discovery:

Trying to compile

typedef int *p_int;
void a(const p_int t) { *t = 0; }
void b(const p_int t) { t = (int *) 0; }
void c(const int *t) { *t = 0; }
void d(const int *t) { t = (int *) 0; }
void e(int const *t) { *t = 0; }
void f(int const *t) { t = (int *) 0; }

will give 'assignment of read-only location' warnings for
b(), c() and e(), i.e. it's impossible to have a constant
pointer to a non-constant value w/o using a qualified
typedef.

W/o a typedef, gcc seems unable to tell the difference
between 'const int *' and 'int const *' altogether. In case
one needs a constant pointer to a constant value, something
like this should do:

typedef const int *p_int;
void f(const p_int a);

Usable? I don't quite think so.

T.
