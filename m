Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVASMi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVASMi0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 07:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVASMi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 07:38:26 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:22506 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261709AbVASMiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 07:38:23 -0500
Date: Wed, 19 Jan 2005 12:37:54 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Steve Longerbeam <stevel@mvista.com>
cc: Andi Kleen <ak@suse.de>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG in shared_policy_replace() ?
In-Reply-To: <41EDAA6E.5000900@mvista.com>
Message-ID: <Pine.LNX.4.44.0501191221400.4795-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005, Steve Longerbeam wrote:
> 
> Why free the shared policy created to split up an old
> policy that spans the whole new range? Ie, see patch.

I think you're misreading it.  That code comes from when I changed it
over from sp->sem to sp->lock.  If it finds that it needs to split an
existing range, so needs to allocate a new2, then it has to drop and
reacquire the spinlock around that.  It's conceivable that a racing
task could change the tree while the spinlock is dropped, in such a
way that this split is no longer necessary once we reacquire the
spinlock.  The code you're looking at frees up new2 in that case;
whereas in the normal case, where it is still needed, there's a
new2 = NULL after inserting it, so that it won't be freed below.

Hugh

