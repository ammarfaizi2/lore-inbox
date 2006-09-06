Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWIFL7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWIFL7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 07:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWIFL7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 07:59:12 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:43803 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750739AbWIFL7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 07:59:10 -0400
Date: Wed, 6 Sep 2006 13:58:41 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Hua Zhong <hzhong@gmail.com>
Subject: Re: lockdep oddity
Message-ID: <20060906115841.GE6898@osiris.boeblingen.de.ibm.com>
References: <20060901015818.42767813.akpm@osdl.org> <20060905130356.GB6940@osiris.boeblingen.de.ibm.com> <1157486867.22250.9.camel@dwalker1.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157486867.22250.9.camel@dwalker1.mvista.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Found this will debugging some random memory corruptions that happen when
> > CONFIG_PROVE_LOCKING and CONFIG_PROFILE_LIKELY are both on.
> > Switching both off or having only one of them on seems to work.
> There's potential for a some issues in current -mm , given the config
> above. If you us the generic atomic operations
> (asm-generic/bitops/atomic.h) for test_and_set_bit(). It eventually
> calls into trace_hardirqs_off() and then back into likely profiling. 

Your patch has this in it too:

/* 
 * We check for constant values with __builtin_constant_p() since 
 * it's not interesting to profile them, and there is a compiler 
 * bug in gcc 3.x which blows up during constant evalution when 
 * CONFIG_PROFILE_LIKELY is turned on. 
 */ 
#define likely(x)       (__builtin_constant_p(x) ? (!!(x)) : __check_likely((x), 1)) 
#define unlikely(x)     (__builtin_constant_p(x) ? (!!(x)) : __check_likely((x), 0)) 

Could you define "blows up"? My reading of the text above is: "this code
below makes sure it does work with gcc 3.x as well".
Now I used gcc 3.4.1 and get random memory corruptions while with gcc 4.1.1
everything seems to be ok....
