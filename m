Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317818AbSGKS0g>; Thu, 11 Jul 2002 14:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317846AbSGKS0f>; Thu, 11 Jul 2002 14:26:35 -0400
Received: from dsl-213-023-020-056.arcor-ip.net ([213.23.20.56]:51613 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317818AbSGKS0f>;
	Thu, 11 Jul 2002 14:26:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Rusty's module talk at the Kernel Summit
Date: Thu, 11 Jul 2002 20:28:50 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rusty Russell <rusty@rustcorp.com.au>, Alexander Viro <viro@math.psu.edu>,
       "David S. Miller" <davem@redhat.com>, <adam@yggdrasil.com>,
       <R.E.Wolff@bitwizard.nl>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207111929500.8911-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0207111929500.8911-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17SigN-0002V1-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 July 2002 19:37, Roman Zippel wrote:
> Hi,
> 
> On Thu, 11 Jul 2002, Daniel Phillips wrote:
> 
> > Closing the rmmod race with this interface is easy.  We can for example just
> > keep a state variable in the module struct (protected by a lock) to say the
> > module is in the process of being deregistered.
> 
> Please check try_inc_mod_count(). It's already done.

It's a good start, but it's not quite right.  Deregister_filesystem has to be
the authority on whether the module can be deleted or not, and there's no
interface for that at the moment.  Also, the mod_count is actually irrelevant
here, what matters is whether deregister_filesystem thinks the module can be
removed.  Finally, it's not enough to flag only the 'removing module' state,
the 'inserting module' state has to be flagged as well[1].  The latter may
well be flagged in some way in the existing code, I did not dig in to find
out, but even so, we'd hardly have the thing in its simplest possible form.

In short, it's close to the truth, but it's not quite there in its current
form.  Al said as much himself.

[1] It's possible that only a single bit of state is needed, 'busy'.  I don't
know, I stopped thinking about this when it became clear a fix is coming down
the pipe.

-- 
Daniel
