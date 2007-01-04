Return-Path: <linux-kernel-owner+w=401wt.eu-S964813AbXADM1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbXADM1H (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 07:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbXADM1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 07:27:07 -0500
Received: from mx2.go2.pl ([193.17.41.42]:45364 "EHLO poczta.o2.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964812AbXADM1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 07:27:05 -0500
Date: Thu, 4 Jan 2007 13:28:43 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: Jon Maloy <jon.maloy@ericsson.com>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, Per Liden <per.liden@ericsson.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       "'tipc-discussion\@lists\.sourceforge\.net'" 
	<tipc-discussion@lists.sourceforge.net>
Subject: Re: [PATCH] tipc: checking returns and Re: Possible Circular Locking in TIPC
Message-ID: <20070104122843.GC3175@ff.dom.local>
References: <20061228121702.GA5076@ff.dom.local> <459C396B.1090508@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459C396B.1090508@ericsson.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 11:16:59PM +0000, Jon Maloy wrote:
> See my comments below.
> Regards
> ///jon
> 
> Jarek Poplawski wrote:
> 
> >..........
> >
> >Maybe I misinterpret this but, IMHO lockdep
> >complains about locks acquired in different
> >order: tipc_ref_acquire() gets ref_table_lock 
> >and then tipc_ret_table.entries[index]->lock,
> >but tipc_deleteport() inversely (with:
> >tipc_port_lock() and tipc_ref_discard()).
> >I hope maintainers will decide the correct
> >order.
> > 
> >
> This order is correct. There can never be parallel access to the
> same _instance_ of tipc_ret_table.entries[index]->lock from
> the two functions you mention.
> Note that tipc_deleteport() takes as argument the reference (=index)
> returned from tipc_ref_acquire(), so  it can not be (and is not) called
> until and unless the latter function has returned a valid reference.
> As a parallel, you can't do free() on a memory chunk until
> malloc() has given you a pointer to it.

I'm happy the order is correct! But the warning 
probably will be back. I know lockdep is sometimes
too careful but nevertheless some change is needed
to fix a real bug or give additional information
to lockdep. 

> >Btw. there is a problem with tipc_ref_discard():
> >it should be called with tipc_port_lock, but
> >how to discard a ref if this lock can't be
> >acquired? Is it OK to call it without the lock
> >like in subscr_named_msg_event()?
> > 
> >
> I suspect you are mixing up things here. 
> We are handling two different reference entries and two
> different locks in this function.
> One reference entry points to a subscription instance, and its
> reference (index) is obtainable from subscriber->ref. So, we
> could easily lock the entry if needed. However, in this
> particular case it is unnecessary, since there is no chance that
> anybody else could have obtained the new reference, and
> hence no risk for race conditions.
> The other reference entry was intended to point to a new port,
> but, since we didn't obtain any reference in the first place,
> there is no port to delete and no reference to discard.

I admit I don't know this program and I hope I
didn't mislead anybody with my message. I only
tried to point at some doubts and maybe this
function could be better commented about when
the lock is needed.

Thanks for explanations & best regards,

Jarek P.
