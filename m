Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317861AbSGKRDc>; Thu, 11 Jul 2002 13:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317862AbSGKRDb>; Thu, 11 Jul 2002 13:03:31 -0400
Received: from dsl-213-023-020-056.arcor-ip.net ([213.23.20.56]:25491 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317861AbSGKRDa>;
	Thu, 11 Jul 2002 13:03:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rusty Russell <rusty@rustcorp.com.au>, Alexander Viro <viro@math.psu.edu>
Subject: Re: Rusty's module talk at the Kernel Summit
Date: Thu, 11 Jul 2002 12:54:42 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "David S. Miller" <davem@redhat.com>, adam@yggdrasil.com,
       R.E.Wolff@BitWizard.nl, linux-kernel@vger.kernel.org
References: <20020711071203.888A84275@lists.samba.org>
In-Reply-To: <20020711071203.888A84275@lists.samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Sbat-0002TF-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 July 2002 09:14, Rusty Russell wrote:
> In message you write:
> > Not needed.  Really not needed (just wait for a couple of days until
> > I get the infrastructure for race-free register/unregister on generic
> > stuff into submittable shape).
> 
> Yes, I look forward to your code.
> 
> There's no point discussing this until we see your solution, is there?

Except to say that this exactly mirrors my conclusion - after looking at all 
the finicky, nasty ways there are of trying to count users of modules at the 
call level I went back and looked at the filesystem interface, which is 
already very nearly race free.  It works by dumping the job of counting 
subsystem users on the subsystem interface, instead of trying to make the 
module interface do it.

In this case, counting users ends up being mount/unmount's job, which only 
needs a simple interaction with register/unregister_filesystem to be 
completely raceless.  Then register/unregister are directly coupled to 
insmod/rmmod so that, for instance, unregister can fail because rmmod called 
it when it still had users.

Closing the rmmod race with this interface is easy.  We can for example just 
keep a state variable in the module struct (protected by a lock) to say the 
module is in the process of being deregistered.  The same state variable 
prevents races during the registration process, that is, mount will not 
succeed if the module is in the process of being registered.  The rest of the 
potential module races are in the symbol handling: the first thing insmod 
does is create the symbol in the 'registering' state; the last thing it does 
is remove it, while in the 'deregistering' state.

Note how the rmmod-during-ret race just disappeared, because rmmod directly 
calls deregister, which either succeeds or doesn't.  If it succeeds there are 
no mounts on the module and everything is quiet, remove away.  Easy huh?  
Note also how we don't really have to divide up the 'deactivate' and 
'destroy' parts of the deregistration process, though I can see why it still 
might be useful to do that.  Such refinements become a concern of the 
filesystem machinery, not the module interface.

This is all by way of saying that Al is apparently well advanced in 
implementing exactly the strategy I'd intended to demonstrate (Rusty and 
Keith seem to be heading to the same place as well, by a twistier path).  I'm 
more than happy to bow out now, because I won't be waking up any more in the 
middle of the night in a cold sweat brought on by fear of rmmod disappearing 
from my favorite OS.

-- 
Daniel
