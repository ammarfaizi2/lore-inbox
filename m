Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbVHKAn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbVHKAn2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 20:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbVHKAn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 20:43:28 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:36010 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030185AbVHKAn1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 20:43:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oA3Pq4PACDwSozLDtknfmEY3GQ1B7qKxfkCJ5ZpVnT4Y43s1GwAHdn0WLfChf14N2MZorJyohDs8OLucv/nO5FSYnwzU0WfkngF+ij09TjsrvD/RRrxxtInG68qLnqwSQraS75720ySWJo7+m0Nzna37cKULeHf/oA+q3viBDUM=
Message-ID: <86802c440508101743783588df@mail.gmail.com>
Date: Wed, 10 Aug 2005 17:43:23 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: 2.6.13-rc2 with dual way dual core ck804 MB
Cc: Mike Waychison <mikew@google.com>, YhLu <YhLu@tyan.com>,
       Peter Buckingham <peter@pantasys.com>, linux-kernel@vger.kernel.org,
       "discuss@x86-64.org" <discuss@x86-64.org>
In-Reply-To: <20050811002841.GE8974@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3174569B9743D511922F00A0C94314230AF97867@TYANWEB>
	 <42FA8A4B.4090408@google.com> <20050810232614.GC27628@wotan.suse.de>
	 <86802c4405081016421db9baa5@mail.gmail.com>
	 <20050811000430.GD8974@wotan.suse.de>
	 <86802c4405081017174c22dcd5@mail.gmail.com>
	 <86802c440508101723d4aadef@mail.gmail.com>
	 <20050811002841.GE8974@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I mean more aggressive

static void __init smp_init(void)
{
        unsigned int i;

        /* FIXME: This should be done in userspace --RR */
        for_each_present_cpu(i) {
                if (num_online_cpus() >= max_cpus)
                        break;
                if (!cpu_online(i))
                        cpu_up(i);
        }


let cpu_up take one array instead of one int.

So  in do_boot_cpu() of smpboot.c
                /*
                 * Wait 5s total for a response
                 */
                for (timeout = 0; timeout < 50000; timeout++) {
                        if (cpu_isset(cpu, cpu_callin_map))
                                break;  /* It has booted */
                        udelay(100);
                }

could wait all be cpu_callin_map is set.

then we can spare more time.

YH


On 8/10/05, Andi Kleen <ak@suse.de> wrote:
> On Wed, Aug 10, 2005 at 05:23:31PM -0700, yhlu wrote:
> > I wonder if you can make the bsp can start the APs callin in the same
> > time, and make it asynchronous, So you make spare 2s or more.
> 
> The setting of cpu_callin_map in the AP could be moved earlier yes.
> But it's not entirely trivial because there are some races to consider.
> 
> And the 1s quiet period on the AP could be probably also reduced
> on modern systems. I doubt it is needed on Xeons or Opterons.
> 
> -Andi
>
