Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVIYWKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVIYWKB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 18:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVIYWKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 18:10:01 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:34054 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932317AbVIYWKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 18:10:00 -0400
Date: Mon, 26 Sep 2005 00:06:28 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@osdl.org>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] fixes for overflow in poll(), epoll(), and msec_to_jiffies()
Message-ID: <20050925220628.GA998@alpha.home.local>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain> <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com> <20050924061500.GA24628@alpha.home.local> <20050924171928.GF3950@us.ibm.com> <Pine.LNX.4.63.0509241120380.31327@localhost.localdomain> <20050924193839.GB26197@alpha.home.local> <20050925205518.GB5079@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050925205518.GB5079@us.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2005 at 01:55:18PM -0700, Nishanth Aravamudan wrote:
> On 24.09.2005 [21:38:39 +0200], Willy Tarreau wrote:
> > Hello,
> > 
> > After the discussion around epoll() timeout, I noticed that the functions used
> > to detect the timeout could themselves overflow for some values of HZ.
> > 
> > So I decided to fix them by defining a macro which represents the maximal
> > acceptable argument which is guaranteed not to overflow. As an added bonus,
> > those functions can now be used in poll() and ep_poll() and remove the divide
> > if HZ == 1000, or replace it with a shift if (1000 % HZ) or (HZ % 1000) is a
> > power of two.
> > 
> > Patches against 2.6.14-rc2-mm1 sent as replies to this mail.
> 
> These look really good, Willy. Thanks for the fixes!

Thanks.
I noticed that there still existed a high risk of overflow with HZ values
for which (HZ % 1000) != 0 && (1000 % HZ) != 0, because we hit the only
situation where we start with a multiply by HZ, which is even worse as HZ
grows. The only cases I've found are :

  - alpha : 1024 or 1200
  - ia64  : 1024

Fortunately, they're both 64 bits, and since the result is an unsigned long,
the multiply returns 64 bits result so it won't overflow in a while. However,
we should avoid those combinations on 32-bits archs, because the limit is
then rather low. For example, using HZ=1200 on an x86 will set MAX_MSEC_OFFSET
to 3579138 ms, which is just below one hour. For reference, with HZ=1000,
MAX_MSEC_OFFSET would be 2^32-1 ms, or 49.7 days, which makes quite a
difference.

It is possible that some self-made setups hit the overflow before the patch.
For this reason, I wonder how we could discourage people from using such
bastard HZ values on 32 bits platforms :-/

Regards,
Willy

