Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVDGIeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVDGIeQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVDGIeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:34:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:18574 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262400AbVDGIc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:32:58 -0400
Date: Thu, 7 Apr 2005 01:32:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: guillaume.thouvenin@bull.net, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-Id: <20050407013213.7bdb083e.akpm@osdl.org>
In-Reply-To: <1112862232.28858.102.camel@uganda>
References: <1112859412.18360.31.camel@frecb000711.frec.bull.fr>
	<1112860419.28858.76.camel@uganda>
	<20050407005852.36a1264b.akpm@osdl.org>
	<1112862232.28858.102.camel@uganda>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> > 
> > Plus, I'm still quite unsettled about the whole object lifecycle
> > management, refcounting and locking in there.  The fact that the code is
> > littered with peculiar barriers says "something weird is happening here",
> > and it remains unobvious to me why such a very common kernel pattern was
> > implemented in such an unusual manner.
> > 
> > So.  I'd like to see the whole thing reexplained and resubmitted so we can
> > think about it all again.
> 
> All those barriers can be replaced with atomic_dec_and_test(), 

What a shame you didn't say atomic_dec_and_lock()...

> i.e. with something that returns the value.
> Methods that return value requires explicit barriers.
> 
> Actually there are quite many places where we have:
> 
> cpu0                             cpu1
> use object
> atomic_dec()
>                                  if atomic_read/atomic_dec_and_test == 0
>                                     free object.

Yes, but those places normally also use locking to prevent the obvious race.

Yes, atomic_dec_and_test() and barrier removal would be better.  Especially
if it's associated with code commentary which explains why the whole thing
isn't racy (ie: explains why no other CPU can look this object up).

> > Which comments were not addressed?
> 
> CBUS code comments [I did not get ack on CBUS itself], and two below
> issues.

I continue to not see any point in cbus.  It moves work from one place to
another while increasing the amount of code and quite probably increasing
the net amount of work too.

IOW it looks like a net loss which happens to provide gains in one rather
uninteresting microbenchmark.

I'll gleefully admit that I'm wrong, but I don't think that has been
demonstrated yet.


