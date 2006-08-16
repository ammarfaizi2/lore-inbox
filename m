Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWHPUbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWHPUbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 16:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWHPUbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 16:31:11 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:63952 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751149AbWHPUbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 16:31:10 -0400
Date: Wed, 16 Aug 2006 15:30:43 -0500
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, James K Lewis <jklewis@us.ibm.com>,
       Arnd Bergmann <arnd@arndb.de>,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>, akpm@osdl.org
Subject: Re: [PATCH 1/2]:  powerpc/cell spidernet bottom half
Message-ID: <20060816203043.GJ20551@austin.ibm.com>
References: <20060811170337.GH10638@austin.ibm.com> <20060816161856.GD20551@austin.ibm.com> <44E34825.2020105@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E34825.2020105@garzik.org>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 12:30:29PM -0400, Jeff Garzik wrote:
> Linas Vepstas wrote:
> >
> >The recent set of low-waterark patches for the spider result in a
> 
> Let's not reinvented NAPI, shall we...

?? 

I was under the impression that NAPI was for the receive side only.
This round of patches were for the transmit queue.

Let me describe the technical problem; perhaps there's some other
solution for it?  

The default socket size seems to be 128KB; (cat
/proc/sys/net/core/wmem_default) if a user application
writes more than 128 KB to a socket, the app is blocked by the 
kernel till there's room in the socket for more.  At gigabit speeds,
a network card can drain 128KB in about a millisecond, or about
four times a jiffy (assuming  HZ=250).  If the network card isn't
generaing interrupts, (and there are no other interrupts flying 
around) then the tcp stack only wakes up once a jiffy, and so 
the user app is scheduled only once a jiffy.  Thus, the max
bandwidth that the app can see is (HZ * wmem_default) bytes per 
second, or about 250 Mbits/sec for my system.  Disappointing 
for a gigabit adapter.

There's three ways out of this: 

(1) tell the sysadmin to 
    "echo 1234567 > /proc/sys/net/core/wmem_default" which 
    violates all the rules.

(2) Poll more frequently than once-a-jiffy. Arnd Bergmann and I 
    got this working, using hrtimers. It worked pretty well,
    but seemed like a hack to me.

(3) Generate transmit queue low-watermark interrupts, 
    which is an admitedly olde-fashioned but common
    engineering practice.  This round of patches implement 
    this.


--linas


