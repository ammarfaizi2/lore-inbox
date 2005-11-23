Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVKWSCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVKWSCW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVKWSCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:02:20 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:10811 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932123AbVKWSBw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:01:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e3WV7gI89zFkHFZYpcGZ8oNO/W6SZYKiuMn+2Qb5ZTeUYqyLGG2DLSMEi0SLtX0CutHtbIvLKRmuFv6Z9+oi2Dm8PXSg/aqeZKQ0bYZ24hD1vDFnCzGesFmDadOYVDU5aamBkLzEOYeH8CYmm+zQ5ZJMGfMKSe8Zg3VepY4zLd8=
Message-ID: <2ea3fae10511231001r47fcfa64r8afa8bd5552479d0@mail.gmail.com>
Date: Wed, 23 Nov 2005 10:01:51 -0800
From: yhlu <yinghailu@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [LinuxBIOS] x86_64: apic id lift patch
Cc: Ronald G Minnich <rminnich@lanl.gov>, discuss@x86-64.org,
       linuxbios@openbios.org, linux-kernel@vger.kernel.org,
       yhlu <yhlu.kernel@gmail.com>
In-Reply-To: <20051123175042.GM20775@brahms.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com>
	 <20051121220605.GD20775@brahms.suse.de> <43849FA5.4020201@lanl.gov>
	 <20051123173504.GK20775@brahms.suse.de>
	 <2ea3fae10511230943y5f697eb8sdbf891497fa8b88f@mail.gmail.com>
	 <20051123175042.GM20775@brahms.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NB_CFG bit 54 for E0 stepping later can be set.

When it is set
the initial apic id will be
node0/core0 : 0
node0/core1 : 1
node1/core0 : 2
node1/core1 : 3

So you can shift the initial apic id to the node id, but the problem
is you need to have right cores_vir,  because for single you need to
use 2 to shift instead of 1 the core num that you read from msr.

For LinuxBIOS, we go further, that we use NB_CFG bit 54 directly,
instead of check cpu version, because only E0 later can be set.

please check the code in LinuxBIOS that we are using to get node id...

YH

static inline unsigned int read_nb_cfg_54(void)
{
        msr_t msr;
        msr = rdmsr(NB_CFG_MSR);
        return ( ( msr.hi >> (54-32)) & 1);
}

struct node_core_id {
        unsigned nodeid;
        unsigned coreid;
};

static inline unsigned get_initial_apicid(void)
{
        return ((cpuid_ebx(1) >> 24) & 0xf);
}

static inline struct node_core_id get_node_core_id(unsigned nb_cfg_54)
{
        struct node_core_id id;
        //    get the apicid via cpuid(1) ebx[27:24]
        if( nb_cfg_54) {
                //   when NB_CFG[54] is set, nodid = ebx[27:25],
coreid = ebx[24]
                id.coreid = (cpuid_ebx(1) >> 24) & 0xf;
                id.nodeid = (id.coreid>>1);
                id.coreid &= 1;
        }
        else
        {
                // when NB_CFG[54] is clear, nodeid = ebx[26:24],
coreid = ebx[27]
                id.nodeid = (cpuid_ebx(1) >> 24) & 0xf;
                id.coreid = (id.nodeid>>3);
                id.nodeid &= 7;
        }
        return id;
}

static inline unsigned get_core_num(void)
{
        return (cpuid_ecx(0x80000008) & 0xff);
}

static inline struct node_core_id get_node_core_id_x(void) {

        return get_node_core_id( read_nb_cfg_54() ); // for pre_e0()
nb_cfg_54 always be 0
}
