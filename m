Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUGAQzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUGAQzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 12:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266132AbUGAQxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 12:53:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46801 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266105AbUGAQw1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 12:52:27 -0400
Message-ID: <40E4413B.5050000@pobox.com>
Date: Thu, 01 Jul 2004 12:52:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
       vojtech@suse.cz, James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>
Subject: Re: [parisc-linux] Re: [PATCH] Fix the cpumask rewrite
References: <1088266111.1943.15.camel@mulgrave>  <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>  <1088268405.1942.25.camel@mulgrave>  <Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>  <20040701131158.GP698@openzaurus.ucw.cz> <1088690821.4621.11.camel@localhost.localdomain> <Pine.LNX.4.58.0407010908260.11212@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0407010908260.11212@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> It _happens_ to be one on x86, so sadly it works on 99% of the machines 
> out there. And to avoid the extra (suprefluous) mb(), there are
> 
> 	smp_mb__before_clear_bit()
> 	smp_mb__after_clear_bit()
> 
> that only works with "clear_bit()", on the assumption that the way you'd 
> do locking is:
> 
> 	lock:
> 		while (test_and_set_bit(..)) /* This is a memory barrier */
> 			while (test_bit(..))
> 				cpu_relax();
> 
> 	.. protected region ..
> 
> 	unlock:
> 		smp_mb__before_clear_bit();
> 		clear_bit(..);


FWIW one of the major uses of bitops currently is e.g. in 
include/linux/netdevice.h, where bitops are used for atomic selection of 
code paths, but not spinning:

static inline void netif_carrier_off(struct net_device *dev)
{
         if (!test_and_set_bit(__LINK_STATE_NOCARRIER, &dev->state))
                 linkwatch_fire_event(dev);
}

