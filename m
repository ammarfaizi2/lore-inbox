Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWEKCB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWEKCB2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 22:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWEKCB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 22:01:28 -0400
Received: from CPE-144-136-172-108.sa.bigpond.net.au ([144.136.172.108]:9222
	"EHLO grove.modra.org") by vger.kernel.org with ESMTP
	id S1751228AbWEKCB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 22:01:27 -0400
Date: Thu, 11 May 2006 11:31:25 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Paul Mackerras <paulus@samba.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
Message-ID: <20060511020125.GF24458@bubble.grove.modra.org>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com> <20060510154702.GA28938@twiddle.net> <20060510.124003.04457042.davem@davemloft.net> <17506.21908.857189.645889@cargo.ozlabs.ibm.com> <20060511010438.GE24458@bubble.grove.modra.org> <17506.37259.755099.974824@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17506.37259.755099.974824@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 11:21:15AM +1000, Paul Mackerras wrote:
> Alan Modra writes:
> 
> > gcc shouldn't think there is any reason to cache the address.
> 
> Can I rely on that being true in the future?

It isn't true in the *present*, except with a compiler on my home
machine.  :-) 

__thread int i1;
void
f3 (void)
{
  int x = i1;
  __asm__ __volatile__ ("#dragons be here.  %0" : "+r" (x));
  i1 = x;
}

current mainline with -O2 -S -mtls-size=16

f3:
        addi 9,2,i1@tprel
        lwz 0,0(9)
#APP
        #dragons be here.  0
#NO_APP
        stw 0,0(9)
        blr

Same thing with my modified compiler.

f3:
        lwz 0,i1@tprel(2)
#APP
        #dragons be here.  0
#NO_APP
        stw 0,i1@tprel(2)
        blr

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
