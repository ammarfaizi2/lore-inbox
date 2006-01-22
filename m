Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWAVQaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWAVQaR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 11:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWAVQaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 11:30:17 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:46540 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751275AbWAVQaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 11:30:16 -0500
Subject: Re: [PATCH] driver core: remove unneeded klist methods
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0601202321430.14739-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0601202321430.14739-100000@netrider.rowland.org>
Content-Type: text/plain
Date: Sun, 22 Jan 2006 10:30:05 -0600
Message-Id: <1137947405.4058.10.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 23:37 -0500, Alan Stern wrote:
> The problem is that put_device must not be called while holding a
> spinlock.  This has always been true, but we only started noticing it
> recently when Greg added a might_sleep.  Your klist method would call
> put_device while holding the klist's spinlock.

Right, but we currently have this problem everywhere throughout the
code.  Avoiding it by not taking references doesn't look to be the right
way to go because then we have to dismantle the whole refcounting
infrastructure.

> Not so.  A device structure can't be freed before device_del returns, and
> the patch makes device_del call klist_remove instead of klist_del.  The
> difference between the two is that klist_remove blocks until all iterators
> have finished using the klist node.  New iterators can't start using it
> because the routine removes the node from the klist.

Sorry ... forgot to mention that part ... the change from _del to
_remove ties us up with a wait for the list to actually remove.  This is
potentially dangerous because you're waiting on events you don't
control.  Additionally, next_child isn't refcounted, so it could
potentially disappear out from under you.

James


