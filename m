Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264369AbTDPNgN (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 09:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbTDPNgM 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 09:36:12 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:27833 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S264369AbTDPNgK 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 09:36:10 -0400
Subject: Re: [RFC][PATCH] Extended Attributes for Security Modules
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: richard offer <offer@sgi.com>
Cc: Andreas Gruenbacher <ag@bestbits.at>,
       Linus Torvalds <torvalds@transmeta.com>,
       lsm <linux-security-module@wirex.com>, "Ted Ts'o" <tytso@mit.edu>,
       lkml <linux-kernel@vger.kernel.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <385390000.1050425884@changeling.engr.sgi.com>
References: <Pine.LNX.4.33.0304140033100.12311-100000@muriel.parsec.at>
	 <1050414107.16051.70.camel@moss-huskers.epoch.ncsc.mil>
	 <385390000.1050425884@changeling.engr.sgi.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1050500841.2682.62.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Apr 2003 09:47:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-15 at 12:58, richard offer wrote:
> I see modules as empheral, but attritbutes as permanant. If I'm running one
> LSM module, I reboot and use a different LSM module, what happens to the
> attributes that the first module added to the file ?
> 
> Either we should guarantee that modules only touch attributes they know
> about---ignoring all others (but not overwriting them), or we have separate
> namespaces for each module's attributes.
> 
> Stacking modules will work with either scheme, but its seems to be that
> switching policies over a reboot could easily be broken by a scheme that
> shared a single namespace.

Thanks for your comments.  It occurred to me after I sent my initial
reply that you might be thinking of a scenario where you have two
different security modules for two different environments, and you
switch back and forth between them depending on what environment you are
working in.  However, I think that this scenario is fundamentally
flawed, as the two modules will end up needing to be tightly coupled in
order to provide any continuous guarantees of security and would be
better implemented as a single module that understands two (or n) states
of operation and has a mechanism for secure transitions between those
states.  If you keep them as independent modules, then each module has
no way of knowing what kind of data mixing occurred while the other
module was active, so the old attributes of existing files are no longer
trustworthy, and each module has no way of knowing how to handle new
files that were created while the other module was active.  You really
need the two modules to be aware of each other and to maintain
sufficient state information so that the other module can recover to a
secure initial state, at which point you might as well merge them into
one module with multiple states of operation.  A single module with
multiple states of operation can also potentially support transitions on
events without a reboot (or the overhead of a full module
removal+insertion), so you have greater flexibility.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

