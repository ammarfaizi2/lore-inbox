Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWARSYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWARSYJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWARSYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:24:08 -0500
Received: from kanga.kvack.org ([66.96.29.28]:46037 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1030211AbWARSYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:24:07 -0500
Date: Wed, 18 Jan 2006 13:19:55 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, Chandra Seetharaman <sekharan@us.ibm.com>,
       Keith Owens <kaos@sgi.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] Notifier chain update
Message-ID: <20060118181955.GF16285@kvack.org>
References: <Pine.LNX.4.44L0.0601181118210.4632-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601181118210.4632-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 11:34:12AM -0500, Alan Stern wrote:
> There are some limitations, which should not be too hard to live with.
> For atomic/blocking chains, registration and unregistration must
> always be done in a process context since the chain is protected by a
> mutex/rwsem.  Also, a callout routine for a non-raw chain must not try
> to register or unregister entries on its own chain.  (This did happen
> in a couple of places and the code had to be changed to avoid it.)

This is bad, as rwsems are pretty much guaranteed to be a cache miss on 
smp systems, so their addition makes these code paths scale much more 
poorly than is needed.  Given the current approach to modules, would it 
not make sense to simply require that any code that the notifier paths 
touch simply remain loaded in the kernel?  In that case rcu protection 
of the pointers would suffice for the hooks.

		-ben
