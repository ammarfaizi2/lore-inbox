Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbUCXEMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 23:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUCXEMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 23:12:13 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:27641 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262998AbUCXEMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 23:12:09 -0500
Date: Tue, 23 Mar 2004 20:11:01 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com
Subject: Re: [PATCH] nodemask_t x86_64 changes [5/7]
Message-Id: <20040323201101.3427494c.pj@sgi.com>
In-Reply-To: <20040324020357.GC791@holomorphy.com>
References: <1079651082.8149.175.camel@arrakis>
	<20040322230850.1d8f26dc.pj@sgi.com>
	<20040323101323.GD2045@holomorphy.com>
	<20040323133650.2044fd8f.pj@sgi.com>
	<20040324020357.GC791@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any idea where this bogon might be?

Unless I'm missing something (quite possible), the following would
expose the complement operators setting of high unused bits.

    You have 32 bit unsigned longs and NR_CPUS == 24, you complement
    some cpumask, and you then ask if it is empty, or ask if it is
    equal to another cpumask that differs only in the unused
    high byte, or ask its Hamming weight?

The arithmetic cpumask ops don't mask off the unused bits above NR_CPUS.

This might never be noticed, because cpumask_complement is the only op
that sets these unused bits, the complement op is very rarely used, and
none of its current uses can lead to the above bugs that I see offhand.

My workarea (vanilla 2.6.4 plus Matthew's nodemask patch) right now has:

 1) this complement operator entirely removed
 2) its rare uses recoded to not use that op

I'm also experimenting with adding a precondition to each operation,
that no bits above the specified size (NR_CPUS or whatever the
equivalent for NODES is) may be set on input mask arguments.  Each
operation need do just enough to avoid setting any such unused high bits
of output masks, given the assumption that they aren't already set on
any input parameters.

With this precondition, operations need make no promise to avoid being
confused by such high bits if improperly set on an input.  They make no
promise to mask off such bits in a result mask if passed in.  Nor do
they promise not to mask them off - that's at the discretion of the
implementation.

This precondition actually fits the existing implementation quite well.
About all I'd have to do, that I see so far, is to add code to the
complement op to zero out the unused bits.  Or just get rid of the
complement op entirely ... as I'm considering.

Ah - one other place needs fixing - the array cpumask CPU_MASK_ALL
initializer sets all bits, which is ok now, since the other array
ops more or less all limit their considerations to the first NR_CPUS
bits.  But it wouldn't surprise me if someday a bug showed up here
as well, added in the future perhaps, in the case that NR_CPUS is
not an exact multiple of unsigned longs.

I still don't know how I will fix the CPU_MASK_ALL static initializor in
the multi-word case - since I can't put runtime code in it.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
