Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267555AbUHJSA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267555AbUHJSA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267588AbUHJR5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 13:57:42 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:36086 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S267507AbUHJRm6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:42:58 -0400
Subject: Re: bkl cleanup in do_sysctl
From: Dave Hansen <haveblue@us.ibm.com>
To: Josh Aas <josha@sgi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, steiner@sgi.com
In-Reply-To: <4118FE9D.2050304@sgi.com>
References: <4118FE9D.2050304@sgi.com>
Content-Type: text/plain
Message-Id: <1092158905.11212.18.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 10:28:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 09:58, Josh Aas wrote:
> I'd like to hear people's thoughts on replacing the bkl in do_sysctl 
> with a localized spin lock that protects the sysctl structures. Instead 
> of grabbing the bkl, anyone that needs to mess with those values could 
> grab the localized lock (1 to protect all structures). Such a localized 
> lock would allow us to get rid of bkl usage in at least one other place 
> as well (do_coredump). In order to do this though, we would have to make 
> sure all code that grabs the bkl instead of the localized lock while 
> using sysctl values switches to the new lock. Might be a big job, but 
> perhaps it would be a good one to start after 2.6.8 is out the door.

Remember that the BKL isn't a plain-old spinlock.  You're allowed to
sleep while holding it and it can be recursively held, which isn't true
for other spinlocks.

So, if you want to replace it with a spinlock, you'll need to do audits
looking for sysctl users that might_sleep() or get called recursively
somehow.  The might_sleep() debugging checks should help immensely for
the first part, but all you'll get are deadlocks at runtime for any
recursive holders.  But, those cases are increasingly rare, so you might
luck out and not have any.  

Or, you could just make it a semaphore and forget about the no sleeping
requirement.  

-- Dave

