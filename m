Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUABKw0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 05:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265511AbUABKwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 05:52:25 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:7864 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265510AbUABKwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 05:52:15 -0500
Date: Fri, 2 Jan 2004 16:26:57 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, rusty@au1.ibm.com,
       lhcs-devel@lists.sourceforge.net
Subject: Re: [lhcs-devel] Re: in_atomic doesn't count local_irq_disable?
Message-ID: <20040102162657.A15350@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <3FF044A2.3050503@colorfullife.com> <20031230185615.A9292@in.ibm.com> <20031231190553.B9041@in.ibm.com> <3FF4C0B7.30308@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FF4C0B7.30308@colorfullife.com>; from manfred@colorfullife.com on Fri, Jan 02, 2004 at 01:52:07AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 01:52:07AM +0100, Manfred Spraul wrote:
> Could you write a test module that reads cr2, executes a few prefetch 
> instructions and then checks if cr2 changed? I won't have access to my 
> P3 SMP system in the next few days.
 
Hi Manfred,
	I wrote a test module and found that CR2 remains same across the 
prefetch. The module source I used is as below. Note that I had
to used "my_prefetch" because the original prefetch (in asm/processor.h) 
has been disabled in my tree to do nothing.



inline void my_prefetch(const void *x)
{
        alternative_input(ASM_NOP4,
                          "prefetchnta (%1)",
                          X86_FEATURE_XMM,
                          "r" (x));
}

int array[10];

static int __init dummy_init_module(void)
{
        unsigned long address;
        int i=0;
        int x;

        /* get the address */
        __asm__("movl %%cr2,%0":"=r" (address));

        printk ("CR2 before prefetch is %x \n", address);

        for (i=0; i<10; ++i)
                my_prefetch(array+i);

        for (i=0; i<10; ++i)
                x = *(array+i);

        /* get the address */
        __asm__("movl %%cr2,%0":"=r" (address));


        printk ("CR2 after prefetch is %x \n", address);


        return 0;

}


static void __exit dummy_cleanup_module(void)
{
}

module_init(dummy_init_module);
module_exit(dummy_cleanup_module);
MODULE_LICENSE("GPL");


Output of the above printk is :


CR2 before prefetch is 40017000
CR2 after prefetch is 40017000








-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
