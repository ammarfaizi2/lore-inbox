Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318903AbSHWQgc>; Fri, 23 Aug 2002 12:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318914AbSHWQgc>; Fri, 23 Aug 2002 12:36:32 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:9355 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318903AbSHWQgb>;
	Fri, 23 Aug 2002 12:36:31 -0400
Message-ID: <3D666531.4020909@us.ibm.com>
Date: Fri, 23 Aug 2002 09:39:13 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020808
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mala Anand <manand@us.ibm.com>
CC: Benjamin LaHaise <bcrl@redhat.com>, alan@lxorguk.ukuu.org.uk,
       Bill Hartner <bhartner@us.ibm.com>, davem@redhat.com,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       lse-tech-admin@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
References: <OF1AAF39E9.D733B26C-ON87256C1E.004ACC87@boulder.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mala Anand wrote:
> Readprofile ticks are not as accurate as the cycles I measured.
> Moreover readprofile can give misleading information as it profiles
> on timer interrupts. The alloc_skb and __kfree_skb call memory
> management routines and interrupts are disabled in many parts of that code.
> So I don't trust the readprofile data.

I don't believe your results to be accurate.  They may be _precise_ 
for a small case, but you couldn't have been measuring them for very 
long.  A claim of accuracy requires a large number of samples, which 
you apparently did not do.

I can't use oprofile or other NMI-based profilers on my hardware, so 
we'll just have to guess.  Is there any chance that you have access to 
a large Specweb setup on hardware that is close to mine and can run 
oprofile?

Where are interrupts disabled?   I just went through a set of kernprof 
data and traced up the call graph.  In the most common __kfree_skb 
case, I do not believe that it has interupts disabled.  I could be 
wrong, but I didn't see it.

http://www.sr71.net/~specweb99/old/run-specweb-2300-nodynpost-2.5.31-bk+profilers-08-14-2002-02.19.22/callgraph

The end result, as I can see it, is that your patches hurt Specweb 
performance.  They moved the profile around, but there was an overall 
decline in performance.  They partly address the symptom, but not the 
real problem.  We don't need to _tune_ it, we need to fix it.

The e1000's need to allocate/free fewer skbs.  NAPI's polling mode 
_should_ help this, or at least make it possible to batch them up.
-- 
Dave Hansen
haveblue@us.ibm.com

