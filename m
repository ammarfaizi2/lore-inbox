Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318689AbSG0DUa>; Fri, 26 Jul 2002 23:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318690AbSG0DUa>; Fri, 26 Jul 2002 23:20:30 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:6407 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S318689AbSG0DU2>;
	Fri, 26 Jul 2002 23:20:28 -0400
Date: Fri, 26 Jul 2002 23:23:46 -0400 (EDT)
Message-Id: <200207270323.g6R3Nkb39182@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Subject: keep code simple
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remember that "optimized" code often runs slower than
simple code.

Here's a nice piece of obfuscated C code:

>>> Both there and for user supplied byte offsets/sizes, we just need to check
>>> that user supplied values are not being overflowed on 32-bit sector_t
>>> compiled kernels... something like
>>>
>>>          if (sizeof(sector_t) == 4) {
>>>                  if (value & ~(((u64)1 << 32) - 1))
>>>                          return -E2BIG;
>>>          }
>>>
>>> should compile out nicely for 64-bit sector_t and provide a simple, highly
>>> optimized check for 32-bit sector_t... (If gcc optimizes it well I should
>>> hope it will just do a simple 32-bit compare of the high 32-bits with 
>>> zero...)

True, gcc will optimize that, but the extra screwing
around will prevent additional optimizations. Don't
be trying this either:

>> More readable:
>>
>> if( sizeof(sector_t)==4 && (value>>32) ) return -E2BIG;

Really, this is what you want:

if( sizeof(sector_t)==4 && (value>0xffffffff) )
        return -E2BIG;

I'm not kidding. Besides looking better, it's faster.
I put the above code in a simple function that would also
do a printf if not too big. Checking the assembly...

Trying to beat the compiler:

load a zero into r4
OR that and "value" into r0 to set flags
conditional branch to .L33
// useful stuff -- where I put printf
load the OK return value
branch to .L35
.L33
load the -E2BIG return value
.L35
return

The simple way:

compare
load the -E2BIG return value
conditional branch to .L42
// useful stuff -- where I put printf
load the OK return value
.L42
return

This is with "GCC: (GNU) 2.95.4 20011002 (Debian prerelease)",
on 32-bit ppc, which surely isn't anything special or unusual.

I get pretty much the same result on Red Hat 7 with
gcc 2.96 20000731 on x86: an extra jump in the assembly.
