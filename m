Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbUELVmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUELVmz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUELVkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:40:09 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:15367 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S261913AbUELVjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:39:24 -0400
Date: Wed, 12 May 2004 17:39:13 -0400
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-ID: <20040512213913.GA16658@fieldses.org>
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu> <Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com> <20040512200305.GA16078@elte.hu> <Pine.LNX.4.58.0405121400360.11950@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405121400360.11950@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.5.6i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 02:01:58PM -0700, Davide Libenzi wrote:
> On Wed, 12 May 2004, Ingo Molnar wrote:
> > the compiler cannot discard the multiplication and the division from the
> > following:
> > 
> > 	x * 1000 / 1000
> > 
> > due to overflows.
> 
> $ cat foo.c
> 
> int foo(int i) {
> 
> 
>         return i * 1000 / 1000;
> }

If gcc really optimizes that to just the identity function, then surely
that's a gcc bug?  Multiplication is left-associative, so i * 1000 /
1000 = (i * 1000) / 1000, but (i * 1000) should be zero for any i
divisible by i^(sizeof(int) - 12).

It shouldn't be able to optimize out the 1000 here for exactly the same
reason it shouldn't be able to optimize out the shifts in, e.g.,

	i << 12 >> 12

--Bruce Fields
