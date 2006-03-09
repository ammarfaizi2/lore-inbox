Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752102AbWCIX5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbWCIX5B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbWCIX5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:57:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10432 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752085AbWCIX46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:56:58 -0500
Date: Thu, 9 Mar 2006 15:56:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Buesch <mbuesch@freenet.de>
cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org, mingo@redhat.com,
       alan@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Document Linux's memory barriers [try #4]
In-Reply-To: <200603100045.10375.mbuesch@freenet.de>
Message-ID: <Pine.LNX.4.64.0603091554200.18022@g5.osdl.org>
References: <16835.1141936162@warthog.cambridge.redhat.com>
 <17424.48029.481013.502855@cargo.ozlabs.ibm.com> <200603100045.10375.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Mar 2006, Michael Buesch wrote:
> 
> So what about:
> 
> #define spin_lock_mmio(lock)	spin_lock(lock)
> #define spin_unlock_mmio(lock)	do { spin_unlock(lock); mmiowb(); } while (0)

You need to put the mmiowb() inside the spinlock.

Yes, that is painful. But the point being that if it's outside, then when 
somebody else gets the lock, the previous lock-owners MMIO stores may 
still be in flight, which is what you didn't want in the first place.

Anyway, no need to make a new name for it, since you might as well just 
use the mmiowb() explicitly. At least until this has been shown to be a 
really common pattern (it clearly isn't, right now ;)

		Linus
