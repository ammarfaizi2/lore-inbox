Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbUBTCbw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 21:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUBTCbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 21:31:52 -0500
Received: from thunk.org ([140.239.227.29]:18567 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S267705AbUBTCbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 21:31:50 -0500
Date: Thu, 19 Feb 2004 21:30:57 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
Message-ID: <20040220023057.GB22545@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>, Tridge <tridge@samba.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Jamie Lokier <jamie@shareable.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <16435.60448.70856.791580@samba.org> <Pine.LNX.4.58.0402181457470.18038@home.osdl.org> <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 11:48:50AM -0800, Linus Torvalds wrote:
> Let's leave the "check_or_create_name()" thing for now, and see how we can
> use this in user space (and realize that we only do this on cache failure,
> so this is the "slow case"):
> 
> 	set_bit_one(dir);
> 	lseek(dir, 0, SEEK_SET);
> 	while (readdir(dir, de)) {
> 		stat(de->d_name);
> 		.. might also compare the name here with whatever it is 
> 		   working on right now..
> 	}
> 	set_bit_two_if_one_is_set(dirfd);
> 
> Notice what the above does? After the above loop, bit two will be set IFF 
> the dentry cache now contains every single name in the directory. 
> Otherwise it will be clear. Bit two will basically be a "dcache complete" 
> bit.

Why do this in user space?  The set_bit_one() and
set_bit_two_if_one_is_set() can't really be used for anything else,
really, so why not let check_or_create_name() do the above loop if
necessary to populate all of the dcache entries in the dentry cache?

That way we only expose one system call (check_or_create_name()), and
we let the internal dcache flags be an internal implementation detail.
It will also make it much easier to avoid races.

						- Ted
