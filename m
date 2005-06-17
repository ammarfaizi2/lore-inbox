Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVFQRsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVFQRsD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 13:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVFQRsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 13:48:03 -0400
Received: from CPE000f6690d4e4-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.134]:26894
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S262031AbVFQRrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 13:47:49 -0400
Date: Fri, 17 Jun 2005 13:54:57 -0400
To: Zach Brown <zab@zabbo.net>
Cc: Robert Love <rml@novell.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] inotify, improved.
Message-ID: <20050617175455.GA1981@tentacle.dhs.org>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net> <1118946334.3949.63.camel@betsy> <42B227B5.3090509@yahoo.com.au> <1118972109.7280.13.camel@phantasy> <1119021336.3949.104.camel@betsy> <42B30654.4030307@zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B30654.4030307@zabbo.net>
User-Agent: Mutt/1.5.9i
From: John McCutchan <ttb@tentacle.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 10:20:20AM -0700, Zach Brown wrote:
> 
> > +		schedule();
> 
> Here's a stab at getting rid of that raw schedule() in inotify_read().
> It maintains the behaviour where it returns when an event doesn't fit
> and returns after events have been copied instead of sleeping.  It
> changes behaviour in that it returns partial reads that suceeded instead
> of the error that stopped processing.  It also lets threads who race out
> of a wakeup to find an empty list go back to sleep instead of returning
> 0.  Dunno if that's behaviour you'd prefer but it seemed reasonable.  I
> hope that lockless list_empty() is OK, I didn't think very hard about it.
> 

I really don't like sending partial events. I don't think it's worth the
extra effort in tracking how much of an event we sent out last time. I
also don't see any added benefit to user space when providing partial
events. It's going to complicate the user space event parsing code to.

> Compiles but totally untested.  Check my work :)

At first glance, I don't see any code to restart the partially sent
event. Am I missing the obvious or what? Without that, the user would
get the first half of an event, then get both halfs on the next read.
That simply won't work. 

John
