Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTE1VLY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 17:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbTE1VLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 17:11:22 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:39500 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261153AbTE1VLO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 17:11:14 -0400
Subject: RE: [BUGS] 2.5.69 syncppp
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1053970962.16694.17.camel@dhcp22.swansea.linux.org.uk>
References: <OPENKONOOJPFMJFAJLHAKEPCCBAA.paulkf@microgate.com>
	 <1053970962.16694.17.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1054157063.2279.2.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 28 May 2003 16:24:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-26 at 12:42, Alan Cox wrote: 
> On Sad, 2003-05-24 at 00:11, Paul Fulghum wrote:
> > I thought it was in place to serialize state changes.
> > I'll look at it harder, you may be right in that
> > it is not necessary.
> 
> The state serialization doesn't have to be 100% for PPP however,
> you already have the same races present due to wire time so I
> also think it should be ok.

OK, state changes can happen from several different
sources, and not all of these sources of input are
synchronized.

The spinlock in cp_timeout() does not synchronize
with input from sppp_input(), but *does* synchronize
with sppp_keepalive() which is run off another timer.

But I think I understand what Alan is getting at in
that the PPP state tables are designed to be tolerant
of transient oddities and should converge to a final
state regardless of a timing glitch/race.

Not worrying about state change synchronization and
discarding the use of the spinlock in cp_timeout()
will remove the warning for that case.

But sppp_keepalive() uses a spinlock to synchronize
access to the linked list of sppp devices. So this
path can also cause the warning.

So there are multiple places that call dev_queue_xmit()
with spinlocks held, which provokes this warning.

Which makes me wonder:
Was it really the intention of the change to kernel/softirq.c:105
(source of the warning) that callers to dev_queue_xmit()
not be allowed to use spinlocks? If so, then what other
synchronization techniques are appropriate for use in
an interrupt and timer context?



-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com

