Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269762AbUJALlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269762AbUJALlS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 07:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269763AbUJALlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 07:41:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30856 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269762AbUJALlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 07:41:15 -0400
Subject: Re: [Patch 7/10]: ext3 online resize: SMP locking for group
	metadata
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20041001101822.GA18786@elf.ucw.cz>
References: <200409301323.i8UDNo99004796@sisko.scot.redhat.com>
	 <20041001101822.GA18786@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1096630838.2001.14.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Oct 2004 12:40:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2004-10-01 at 11:18, Pavel Machek wrote:

> > The precise rules we use are:

> > * Readers must hold lock_super() over the access
> > OR
> > * Readers must perform an smp_rmb() after reading the groups count
> >   and before reading any dependent data.
> > This leaves the hot path, where s_groups_count is referenced, requiring
> > an smp_rmb(); but no other locking on that hot path is required.
> 
> Should not s_groups_count be atomic_t, then? Is it possible that
> normal read sees only half-updated value?

Resize is very rare, whereas the s_groups_count is checked all the
time.  So I really want to use the most lightweight primitives possible
on the read path.  It may even be possible to downgrade the smp_rmb() to
an smp_read_data_depends().

So I don't want to make it atomic if I can avoid it.  It's just an
unsigned long, and I don't know of any cases where a simple read
colliding with a write is going to give the reader a corrupt value.  As
long as I get either the old or new value, everything should be fine
with the read/write barriers as they are.

There are a couple of other values being updated by resize: the reserved
block count, and the s_group_desc index into the group descriptor
buffer_heads.  Unfortunately, the latter simply can't be an atomic_t
(it's a pointer).

So if you really think there's a risk of getting inconsistent reads,
atomic_t isn't going to be enough to fix it.

Cheers,
 Stephen

