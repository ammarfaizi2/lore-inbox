Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264222AbTEGU3c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 16:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264228AbTEGU3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 16:29:32 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6618 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264222AbTEGU3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 16:29:30 -0400
Date: Wed, 7 May 2003 13:38:56 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: top stack (l)users for 2.5.69
Message-Id: <20030507133856.02748f4e.rddunlap@osdl.org>
In-Reply-To: <3EB95BD7.8060700@pobox.com>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
	<Pine.LNX.4.53.0305070933450.11740@chaos>
	<1052332566.752437@palladium.transmeta.com>
	<3EB95BD7.8060700@pobox.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 May 2003 15:17:43 -0400 Jeff Garzik <jgarzik@pobox.com> wrote:

| Linus Torvalds wrote:
| > In article <Pine.LNX.4.53.0305070933450.11740@chaos>,
| > Richard B. Johnson <root@chaos.analogic.com> wrote:
| > 
| >>You know (I hope) that allocating stuff on the stack is not
| >>"bad". 
| > 
| > 
| > Allocating stuff on the stack _is_ bad if you allocate more than a few
| > hundred bytes. That's _especially_ true deep down in the call-sequence,
| > ie in device drivers, low-level filesystems etc.
| > 
| > The kernel stack is a very limited resource, with no protection from
| > overflow. Being lazy and using automatic variables is a BAD BAD thing,
| > even if it's syntactically easy and generates good code.
| 
| 
| Note that the problem is exacerbated if you have a bunch of disjoint 
| stack scopes.  For that case, gcc will take the _sum_ of the stacks and 
| not the union.  rth was kind enough to file gcc PR 9997 on this problem.

Glad to hear that.
 
| It is turning out to be fairly common problem in the various drivers' 
| ioctl handlers.  Kernel hackers (myself included) often create automatic 
| variables for each case in a C switch statement.  (and now I'm having to 
| go back and fix that :))

I've written a few of the stack reduction patches.  Lots of ioctl functions
need work, so gcc handling it better would be good to have.

I have mostly used kmalloc/kfree, but using automatic variables is certainly
cleaner to write (code).  One of the patches that I did just made each ioctl
cmd call a separate function, and then each separate function was able to use
automatic variables on the stack instead of kmalloc/kfree.  I prefer this
method when it's feasible (and until gcc can handle these cases).

--
~Randy
