Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272433AbRH3Ufz>; Thu, 30 Aug 2001 16:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272436AbRH3Ufq>; Thu, 30 Aug 2001 16:35:46 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:47372 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S272433AbRH3Uf0>; Thu, 30 Aug 2001 16:35:26 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200108302035.f7UKZ6I20020@wildsau.idv-edu.uni-linz.ac.at>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: linux-kernel@vger.kernel.org
Date: Thu, 30 Aug 2001 22:35:06 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



hi,

I just can't see why the new min/max macros are any better than the old
one.

given the following two variables: "signed int i" and "unsigned int j"
assume i=-1 and j=2. we all know that -1 < 2, unfortunately, C doesnt
know that, probably when these values are stored in machineword quantities.
(i.e. no problem wich char and short, but with int on 32bit platform).

now, the new macros come in. we could now either write:

    min(unsigned int,i,j)           ; case 1
or
    min(signed int,i,j)             ; case 2


when casting to unsigned int, -1 will become 0xffffffff and 
"min(unsigned int,-1,2)" will return 2. this is wrong.

case 2 will give the right result.

but what will happen if the unsigned variable is so large that it will
use the most significant bit?

assume i=-1 and j=0xfffffff0;
still, -1 < 0xfffffff0 is true.

	min(unsigned int,i,j)
will give 0xfffffff0 because its < 0xffffffff;
wrong result.

	min(signed int,i,j)
will give 0xfffffff0 because it will be cast to -16 which is < -1.
wrong result again.

I think this shows that the type-argument in the macros gain nothing.
Instead, whenever we encounter such a problem, the code should be
closely investigated.

I think that this really is some compiler-issue. signed/unsigned comparison
is okay for char and short, but not for int; looks like the compiler
forgets to set or evaluate the carry-flag, perhaps?

