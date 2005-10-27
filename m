Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVJ0ONM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVJ0ONM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 10:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVJ0ONM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 10:13:12 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:38887 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750795AbVJ0ONL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 10:13:11 -0400
Date: Thu, 27 Oct 2005 10:13:10 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andi Kleen <ak@suse.de>
cc: Chandra Seetharaman <sekharan@us.ibm.com>, Keith Owens <kaos@ocs.com.au>,
       <dipankar@in.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Notifier chains are unsafe
In-Reply-To: <200510262344.37982.ak@suse.de>
Message-ID: <Pine.LNX.4.44L0.0510271004590.4891-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2005, Andi Kleen wrote:

> Like I wrote earlier: as long as the notifier doesn't unregister itself
> the critical RCU section for the list walk is only a small part of notifier_call_chain.
> It's basically a stable anchor in the list that won't change.

I have to disagree with you.  The critical section is the entire dynamic
scope of notifier_call_chain.  After all, what if a _different_ thread
unregisters a notifier routine while the routine is running?  What if the 
_following_ routine is unregistered also?

The desired behavior for notifier_unregister is that when it returns, the
notifier routine is not running on any processor and will not start
running.  The only way to guarantee this is to put the entire routine into
the critical section.  And that means putting the entire chain into the 
critical section.

Alan Stern

