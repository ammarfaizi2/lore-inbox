Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbVKBQDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbVKBQDZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 11:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbVKBQDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 11:03:25 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:42917 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S965107AbVKBQDY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 11:03:24 -0500
Date: Wed, 2 Nov 2005 11:03:23 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Keith Owens <kaos@ocs.com.au>
cc: Chandra Seetharaman <sekharan@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Notifier chains are unsafe 
In-Reply-To: <5979.1130925011@ocs3.ocs.com.au>
Message-ID: <Pine.LNX.4.44L0.0511021058260.4928-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Keith Owens wrote:

> On Tue, 1 Nov 2005 16:20:43 -0500 (EST), 
> Alan Stern <stern@rowland.harvard.edu> wrote:
> >You mean the RCU-style update?  It will hang when a callout routine tries 
> >to deregister itself as it is running, although we could add a new 
> >unregister_self API to handle that.  Just check for num_callers equal to 1 
> >instead of 0.
> 
> A callout on an atomic notifer chain has no business calling the
> register/unregister functions.  It makes no sense for an atomic context
> to call a routine that can sleep or block.

Ah, but what if the unregister function for atomic chains is implemented
in such a way that it doesn't sleep or block?  That's what Chandra and I
have been discussing.

On the other hand, it's still true that for blocking chains, unregister
will have to acquire a write semaphore.  We won't want callouts on
blocking chains (which already own the read semaphore) trying to 
unregister themselves.

And in any case, it's cleaner for callouts never to unregister themselves.  
That's why I tend to prefer the block_enable/disable solution.

Alan Stern

