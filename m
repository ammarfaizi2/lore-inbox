Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUHTH0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUHTH0z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUHTH0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:26:55 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:13730 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S261875AbUHTH0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:26:50 -0400
Subject: Re: module.viomap support for ppc64
From: Rusty Russell <rusty@rustcorp.com.au>
To: Olaf Hering <olh@suse.de>
Cc: Hollis Blanchard <hollisb@us.ibm.com>, Dave Boutcher <boutcher@us.ibm.com>,
       linuxppc64-dev@lists.linuxppc.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20040820055741.GA16519@suse.de>
References: <20040812173751.GA30564@suse.de>
	 <1092339278.19137.8.camel@localhost> <1092354195.25196.11.camel@bach>
	 <20040813094040.GA1769@suse.de> <1092404570.29604.5.camel@bach>
	 <20040819212824.GA13204@suse.de> <1092973671.28849.243.camel@bach>
	 <20040820055741.GA16519@suse.de>
Content-Type: text/plain
Message-Id: <1092986745.28849.343.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 17:25:46 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 15:57, Olaf Hering wrote:
>  On Fri, Aug 20, Rusty Russell wrote:
> 
> > Current implementation of aliases is to load one at random: multiple
> > alias resolution is undefined because noone knew what we should do (load
> > them all?  Load until one succeeds?).  But note that that the base
> > config file overrides anything extracted from the modules themselves, so
> > users/distributions can always specify an exact match.
> 
> How is the blacklist stuff supposed to work then? It must be possible
> to map an alias entry to a list of modules, and check if any of them is
> blacklisted. Then just 'for i in $DRIVERS ; do modprobe $i ; done'.

Olaf, I'm trying to understand the problem.  We currently have a system
where modprobe resolves aliases, and that's good because it allows users
to override those aliases.  We could have a "modprobe --resolve-aliases"
function, but that breaks down if the user puts in an install command,
which they should be able to do.

Looking through SLES and my Debian system, I see:
1) Modules which never want autoloading (eg. evbug)
2) Modules which defer to other modules (eg. de4x5)
3) Modules for which you want to suppress autoloading altogether because
they cause problems, or are handled by other subsystems.

For (1), the information should be contained in the module itself.  This
will involve a kernel patch.

For (2), the information should be placed in /etc/modprobe.d/ overriding
those aliases the preferred way.

For (3), modprobe cannot have this in a config file, because what needs
to be blacklisted depends on who is invoking modprobe.  For example,
there's a comment that ISDN modules on SuSE are not handled by hotplug,
but /etc/init.d/isdn.

So, a solution would be:
a) A "MODULE_NO_TABLES" macro which suppresses ID table alias
generation,
b) A -X argument to modprobe which says "don't load these modules", and
c) Change modprobe to load all the aliases which match, not just one?  I
hadn't done this because I wasn't aware of anything which needed it: is
there something?

I think we're getting there: sorry if I seem a bit obtuse...
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

