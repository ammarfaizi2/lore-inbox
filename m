Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbWDNAbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbWDNAbd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 20:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWDNAbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 20:31:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:4523 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965070AbWDNAbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 20:31:32 -0400
Subject: Re: [RFC] PATCH 0/4 - Time virtualization
From: john stultz <johnstul@us.ibm.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 17:31:27 -0700
Message-Id: <1144974688.8548.26.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 13:19 -0400, Jeff Dike wrote:
> This set of patches implements 
> 	time virtualization by creating a time namespace
> 	an interface to it through unshare
> 	a ptrace extension to allow UML to take advantage of this
> 	UML support
> 
> The guts of the namespace is just an offset from the system time.  Within
> the container, gettimeofday adds this offset to the system time.  settimeofday
> changes the offset without touching the system time.  As such, within a 
> namespace, settimeofday is unprivileged.
> 
> The interface to it is through unshare(CLONE_TIME).  This creates the new
> namespace, initialized with a zero offset from the system time.
> 
> The advantage of this for UML is that it can create a time namespace for itself
> and subsequently let its process' gettimeofday run on the host, without
> being intercepted and run inside UML.  As such, it should basically run at
> native speed.
> 
> In order to allow this, we need selective system call interception.  The
> third patch implements PTRACE_SYSCALL_MASK, which specifies, through a 
> bitmask, which system calls are intercepted and which aren't.
> 
> Finally, the UML support is straightforward.  It calls unshare(CLONE_TIME)
> to create the new namespace, sets gettimeofday to run without being 
> intercepted, and makes settimeofday call the host's settimeofday instead
> of maintaining the time offset itself.
> 
> As expected, a gettimeofday loop runs basically at native speed.  The two
> quick tests I did had it running inside UML at 98.8 and 99.2 % of native.
> 
> BUG - as I was writing this, I realized that refcounting of the time_ns
> structures is wrong - they need to be incremented at process creation and
> decremented at process exit.


Looks interesting. I've never quite understood the need for different
time domains, it only allows you to run one domain with the incorrect
time, but I'm sure there is some use case that is desired.

I'm not psyched about possible namespace vs nanosecond confusion w/
terms like "time_ns", but that's pretty minor.

Also I hope you're not wanting to deal w/ NTP adjustments between
domains that have the incorrect time? That would be very ugly.

thanks
-john


