Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319337AbSHVMI2>; Thu, 22 Aug 2002 08:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319338AbSHVMI2>; Thu, 22 Aug 2002 08:08:28 -0400
Received: from gra-lx1.iram.es ([150.214.224.41]:36620 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id <S319337AbSHVMI0>;
	Thu, 22 Aug 2002 08:08:26 -0400
Message-ID: <3D64D51C.9040603@iram.es>
Date: Thu, 22 Aug 2002 12:12:12 +0000
From: Gabriel Paubert <paubert@iram.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Yoann Vandoorselaere <yoann@prelude-ids.org>,
       cpufreq@lists.arm.linux.org.uk, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: fix 32bits integer overflow in loops_per_jiffy calculation
References: <20020822130200.31767@192.168.4.1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Ben,

 > None of the above can happen in the domain of application of this
 > function. It's used to scale up/down the loops_per_jiffy value when
 > scaling the CPU frequency. Anyway, the above isn't worse than the
 > original function. Ideally, we would want 64 bits arithmetics, but we
 >  decided long ago not to bring the libcc support routines for that in
 >  the kernel.

Well, first on sane archs which have an easily accessible, fixed
frequency time counter, loops_per_jiffy should never have existed :-)

Second, putting this code there means that one day somebody will
inevitably try to use it outside of its domain of operation (like it
happened for div64 a few months ago when I pointed out that it would not
work for divisors above 65535 or so).

Finally, I agree that we should not import libgcc, but for example on
PPC32 the double lengths shifts (__ashrdi3, __ashldi3, and __lshsldi3)
are implemented somewhere, and the assembly implementation (directly
taken from some appendix in PPC documentation, I just slightly twisted
__ashrdi3 to make it branchless AFAIR) is actually way faster than the
one in libgcc ;-), and less than half the size.

  Adding a few subroutines that implement a subset of libgcc's
functionality is necessary for most archs (which functions are needed is
arch, and sometimes compiler's, dependent).

In this case a generic scaling function, while not a standard libgcc/C
library feature has potentially more applications than this simple 
cpufreq approximation. But I don't see very much the need for scaling a 
long (64 bit on 64 bit archs) value, 32 bit would be sufficient.

	Regards,
	Gabriel.

