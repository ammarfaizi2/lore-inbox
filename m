Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVB1N4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVB1N4P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVB1NzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:55:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25219 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261618AbVB1Nxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:53:44 -0500
Date: Mon, 28 Feb 2005 06:29:01 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: jamal <hadi@cyberus.ca>
Cc: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       kaigai@ak.jp.nec.com, "David S. Miller" <davem@redhat.com>,
       jlan@sgi.com, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       elsa-devel@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-ID: <20050228092901.GE23606@logos.cnet>
References: <421CEC38.7010008@sgi.com> <421EB299.4010906@ak.jp.nec.com> <20050224212839.7953167c.akpm@osdl.org> <20050227094949.GA22439@logos.cnet> <4221E548.4000008@ak.jp.nec.com> <20050227140355.GA23055@logos.cnet> <42227AEA.6050002@ak.jp.nec.com> <1109575236.8549.14.camel@frecb000711.frec.bull.fr> <20050227233943.6cb89226.akpm@osdl.org> <1109592658.2188.924.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109592658.2188.924.camel@jzny.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm net ignorant, so just hit me with a cluebat if thats appropriate.

On Mon, Feb 28, 2005 at 07:10:58AM -0500, jamal wrote:
> 
> Havent seen the beginnings of this thread. But whatever you are trying
> to do seems to suggest some complexity that you are trying to
> workaround. What was wrong with just going ahead and just always
> invoking your netlink_send()? 

What overhead does the netlink_send() impose if there are no listeners? 

Sure, it wont go anywhere, but the message will have to be assembled and sent 
anyway. Correct? 

The way things are now, its necessary to make the decision to invoke or not 
netlink_send() due to the supposed overhead. 

Thats what Guillaume is doing, and thats what will have to be done whenever
one wants to send information through netlink from performance critical paths.

Can't the assembly/etc overhead associated with netlink_send() be avoided
earlier, approaching zero-cost ? 

Being able to get rid of the decision to invoke or not the sendmsg would be nice.

TIA


> If there are nobody in user space (or
> kernel) listening, it wont go anywhere.
> 
> cheers,
> jamal
> 
> On Mon, 2005-02-28 at 02:39, Andrew Morton wrote:
> > Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> > >
> > >    Ok the protocol is maybe too "basic" but with this mechanism the user
> > >  space application that uses the fork connector can start and stop the
> > >  send of messages. This implementation needs somme improvements because
> > >  currently, if two application are using the fork connector one can
> > >  enable it and the other don't know if it is enable or not, but the idea
> > >  is here I think.
> > 
> > Yes.  But this problem can be solved in userspace, with a little library
> > function and a bit of locking.
> > 
> > IOW: use the library to enable/disable the fork connector rather than
> > directly doing syscalls.
> > 
> > It has the problem that if a client of that library crashes, the counter
> > gets out of whack, but really, it's not all _that_ important, and to handle
> > this properly in-kernel each client would need an open fd against some
> > object so we can do the close-on-exit thing properly.  You'd need to create
> > a separate netlink socket for the purpose.
