Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSHVS2p>; Thu, 22 Aug 2002 14:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSHVS2p>; Thu, 22 Aug 2002 14:28:45 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:45304 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S315454AbSHVS2o>; Thu, 22 Aug 2002 14:28:44 -0400
Date: Thu, 22 Aug 2002 14:32:52 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Mala Anand <manand@us.ibm.com>
Cc: alan@lxorguk.ukuu.org.uk, Bill Hartner <bhartner@us.ibm.com>,
       davem@redhat.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, lse-tech-admin@lists.sourceforge.net,
       ak@muc.de
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
Message-ID: <20020822143252.G16763@redhat.com>
References: <OF126E7130.D54285DD-ON87256C1C.0077A747@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF126E7130.D54285DD-ON87256C1C.0077A747@boulder.ibm.com>; from manand@us.ibm.com on Thu, Aug 22, 2002 at 12:22:34PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 12:22:34PM -0500, Mala Anand wrote:
> I would like to stress again that this patch helps only when the
> allocations
> and frees occur on two different CPUs.  I measured it in a UNI system and
> did not see any impact.

Thanks, that looks a lot more complete.  We discussed this on irc a bit, and 
Andi Kleen pointed out that several years of hacking on skbs has probably 
changed the layout significantly from the original intention of keeping all 
the initializations to a cacheline or two.  I also pointed out that it might 
be worth looking at cache misses and perhaps adding a prefetch instruction 
or two, especially during allocation when an skb will be used immediately.  
Another point is to check the order of writes that gcc is generating to the 
skb: if the writes are sequential, the cpu can combine them and make use of 
the internal 64 bit bus to the cache.  In combination with write buffers in 
the cpu, that makes the writes in __kfree_skb almost free, but if the cache 
lines are spread out or cold, that would explain the degredation you're 
seeing.  Cheers,

		-ben
