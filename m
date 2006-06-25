Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWFYPQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWFYPQe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 11:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWFYPQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 11:16:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6106 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751077AbWFYPQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 11:16:33 -0400
Date: Sun, 25 Jun 2006 08:16:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: rjw@sisk.pl, davej@redhat.com, linux-kernel@vger.kernel.org,
       sekharan@us.ibm.com, rusty@rustcorp.com.au, rdunlap@xenotime.net,
       sam@ravnborg.org
Subject: Re: 2.6.17-mm2
Message-Id: <20060625081610.9b0a775a.akpm@osdl.org>
In-Reply-To: <20060625032243.fcce9e2e.akpm@osdl.org>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	<20060624172014.GB26273@redhat.com>
	<20060624143440.0931b4f1.akpm@osdl.org>
	<200606251051.55355.rjw@sisk.pl>
	<20060625032243.fcce9e2e.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 03:22:43 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Anyway.  It's regrettable that the new section-checking code didn't
> complain about the bug.  It looks like this is because the call to
> cpufreq_register_driver() happened at modprobe-time, and we don't check for
> that.  Which is rather bad.
> 
> Sam, would it be possible to check for references from modules into
> statically-linked __init code?  It's always wrong...
> 
> Rusty/Randy/whoever looks after modules: it also seems wrong that it's
> possible to load a module which refers to now-unloaded symbols.  In fact,
> it's surprising - sorry if I'm misinterpreting this.  If I'm not, it should
> be pretty easy to barf if a module is trying to get at symbols which lie
> between __init_begin and __init_end?
> 

Actually we should be able to address this pretty simply by disallowing
exports of symbols which are in the __init section.  There's no sense in
exporting something which ain't there.

IOW, any reference from __ksymtab, __ksymtab_gpl or __ksymtab_gpl_future
into __init or __initdata should be a hard error.

It'd be lovely to do that at compile-time, but I cannot think of a way.

Sam, does that sound reasonable&&feasible?
