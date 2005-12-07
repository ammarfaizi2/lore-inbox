Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751740AbVLGSiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbVLGSiU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbVLGSiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:38:20 -0500
Received: from silver.veritas.com ([143.127.12.111]:25655 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751732AbVLGSiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:38:19 -0500
Date: Wed, 7 Dec 2005 18:37:22 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ryan Richter <ryan@tau.solarneutrino.net>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <20051206204336.GA12248@tau.solarneutrino.net>
Message-ID: <Pine.LNX.4.61.0512071803300.2975@goblin.wat.veritas.com>
References: <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local>
 <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org> <20051201195657.GB7236@tau.solarneutrino.net>
 <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com>
 <20051202180326.GB7634@tau.solarneutrino.net>
 <Pine.LNX.4.61.0512021856170.4940@goblin.wat.veritas.com>
 <20051202194447.GA7679@tau.solarneutrino.net>
 <Pine.LNX.4.61.0512022037230.6058@goblin.wat.veritas.com>
 <20051206160815.GC11560@tau.solarneutrino.net>
 <Pine.LNX.4.61.0512062025230.28217@goblin.wat.veritas.com>
 <20051206204336.GA12248@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Dec 2005 18:37:26.0251 (UTC) FILETIME=[454383B0:01C5FB5D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005, Ryan Richter wrote:
> On Tue, Dec 06, 2005 at 08:31:43PM +0000, Hugh Dickins wrote:
> > Thanks for the further report.  And you had my st.c patch in along
> > with 2.6.14.3, but it still happened, very much like before (except the
> > latter errors, general protection fault onwards - but once we get into
> > using one page for two uses at the same time, anything can go wrong).
> > 
> > I've been staring and thinking, but no inspiration yet.
> 
> That's correct, thanks for looking.  Let me know if there's anything I
> could do get more information.

Still no luck with it, I'm afraid: I've found no error in st.c,
beyond what the patch already fixed, to account for what you see.

I have noticed that struct st_buffer's unsigned char do_dio ought to be
unsigned short, in order to accommodate its maximum value of 256; but
that would not account for your symptoms, nor does taper approach that
maximum.

The symptoms are consistent with that do_dio field (near the start of
struct st_buffer) being corrupted, infrequently but repeatedly - the
same page has been mis-released three times before your first error
message.  But I see nothing wrong with st.c's handling of do_dio,
nor with get_user_pages' returned count.

So I think the best I can suggest is that you rebuild your kernel with
CONFIG_DEBUG_SLAB=y, and see if that sheds any light.  And if you don't
mind doing so, advancing to 2.6.15-rc5 (which includes my patch) with
CONFIG_DEBUG_SLAB=y would be even better: there's a chance it's a bug
that's already been fixed.  Though that won't really be proved if you
don't hit the problem, since the new kernel will be sufficiently
different that it might just have shifted the bug aside.

To be honest, the symptoms seem a little too regular to blame someone
overrunning their slab; but I've searched in vain and must move on.

Hugh
