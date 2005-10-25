Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVJYRGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVJYRGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 13:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVJYRGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 13:06:34 -0400
Received: from main.gmane.org ([80.91.229.2]:49635 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932212AbVJYRGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 13:06:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: Notifier chains are unsafe
Date: Tue, 25 Oct 2005 12:59:03 -0400
Message-ID: <djlo8l$7hv$1@sea.gmane.org>
References: <Pine.LNX.4.44L0.0510241634410.4448-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.44L0.0510241634410.4448-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> Has anyone been bothered by the fact that notifier chains are not safe 
> with regard to registration and unregistration while the chain is in use?
> The notifier_chain_register and notifier_chain_unregister routines have 
> writelock protections, but the corresponding readlock is never taken!
> 
> It shouldn't be hard to make this work safely, even allowing such things
> as notifier routines unregistering themselves as they run.  The patch
> below contains an example implementation, showing one way to do it.
> 
> But doing this correctly requires knowing how notifier chains are used.  
> 
> 	Are they always called in process context, with interrupts enabled?
> 
> 	Or do some get called in interrupt context?
> 
> 	Are there any notifier chains invoked on a critical fast path?
> 	(I hope not...)
> 
> 	How many different threads are likely to call a particular 
> 	notifier chain at one time?
> 
> Feedback is requested.
> 
> Alan Stern
> 
[...]

It's not clear how you are making this safe.  You aren't using one
of the known solutions to this problem.  For GC lock-free based solutions,
you can't use RCU since notify_call can sleep.  You could use a
form of reference counting but you'd have to implement it yourself.
Ditto on RCU+SMR or some other form of proxy GC.  Not implemented.

You could use COR (Copy On Read).  Make a copy of the list while holding
a lock, release the lock, do the notifications, and then delete the copy
of the list.

The non-blocking schemes can do notify_calls after unregistration so you
need to take this into account.  Whatever you're calling against still
has to be there and has to be in a meaningful state.

