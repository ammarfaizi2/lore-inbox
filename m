Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbSJPH4H>; Wed, 16 Oct 2002 03:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264949AbSJPH4H>; Wed, 16 Oct 2002 03:56:07 -0400
Received: from n13.sp.op.dlr.de ([129.247.25.4]:12731 "EHLO n13.sp.op.dlr.de")
	by vger.kernel.org with ESMTP id <S264945AbSJPH4H>;
	Wed, 16 Oct 2002 03:56:07 -0400
Message-ID: <3DAD1C3C.3080001@dlr.de>
Date: Wed, 16 Oct 2002 09:58:52 +0200
From: Martin Wirth <Martin.Wirth@dlr.de>
Reply-To: Martin.Wirth@dlr.de
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.0.0) Gecko/20020611
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] futex-2.5.42-A2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(My first reply seems to have been lost, so lets try a second time)


 >Um, this test existed for a reason:
 >
 >> -	/* Must be "naturally" aligned, and not on page boundary. */
 >> -	if ((pos_in_page % __alignof__(int)) != 0
 >> -	    || pos_in_page + sizeof(int) > PAGE_SIZE)
 >> +	/* Must be "naturally" aligned */
 >> +	if (pos_in_page % sizeof(int))
 >>  		return -EINVAL;
 >
 >If you do this, *please* add:
 >	/* Above check not sufficient if align of int < size.  Break link. */
 >	if (__alignof__(int) < sizeof(int)) {
 > 
	extern void __error_small_int_align();
 > 
	__error_small_int_align();
 >	}

I suggested to tighten the above test, because if
__alignof__(int) < sizeof(int) the test leads to sporadic user space
errors if the futex variable accidentally crosses a page boundary. The
only sane way to control this is to force the user space compiler
to use __alignof__(int) == sizeof(int) for futex variables.

Anyway, the test dates back to times when the futex code did atomic
operations on the user space variable. But this is gone. The present
code only touches users space by get_user which does its on checks.
So from the point of keeping the kernel in a sane state we could drop the test
completely.


Martin

