Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWC0QRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWC0QRj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 11:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWC0QRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 11:17:39 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:32004 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1750948AbWC0QRi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 11:17:38 -0500
Date: Mon, 27 Mar 2006 18:17:28 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Build system runs ld more often than needed
Message-Id: <20060327181728.a887c555.khali@linux-fr.org>
In-Reply-To: <20060327140606.GA10649@mars.ravnborg.org>
References: <20060327143848.3da1ac02.khali@linux-fr.org>
	<20060327140606.GA10649@mars.ravnborg.org>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

> > See how unrelated modules are linked again?
> 
> This is an unfortunate side-effect. Following snippet from
> scripts/Makfile.build explains it:
> 
> # We would rather have a list of rules like
> # 	foo.o: $(foo-objs)
> # but that's not so easy, so we rather make all composite objects depend
> # on the set of all their parts
> $(multi-used-y) : %.o: $(multi-objs-y) FORCE
> 	$(call if_changed,link_multi-y)
> 
> The problem is that we have no easy way to say that this specific
> module depends on this list of .o files.

OK, I see. Indeed, we had a similar problem in quilt. The kernel build
system is a bit too complex for me to propose a solution, but maybe if
I show you two rules I wrote for a similar case in the quilt Makefile,
you'll see if the same can be done for the kernel.

$(COMPAT_SYMLINKS:%=compat/%) :: Makefile
	$(call VIRTUAL_SYMLINK, \
		$($(shell echo $@ | $(AWK) '{split($$1, ar, "/"); print toupper(ar[2])}')), \
		$(strip $@))
	@chmod +x $(strip $@)

install-compat-symlink-% :: install-compat1
	ln -sf $($(shell echo $* | $(AWK) '{print toupper($$1)}'))	\
	       $(BUILD_ROOT)$(datadir)/$(PACKAGE)/compat/$*

Basically, the idea is to use awk (or any suitable tool, for that
matter) to extract and/or transform the relevant part of either the
target ($@) or the stem ($*), so as to build a variable name from it,
and then access that variable.

Given that composite targets each have an associated variable listing
the parts they must be made of, maybe it is possible to use the same
method for them? Or maybe it's too much hassle for the thin benefit,
it's up to you.

> With make 3.81 this would be possible utilising $(eval ...),
> but the benefit is too low to introduce such a dependency.

GNU make 3.80 already has $(eval ...), but having a dependency even on
3.80 is no good, agreed.

Thanks,
-- 
Jean Delvare
