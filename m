Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVAaQBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVAaQBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 11:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVAaQBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 11:01:45 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:1077 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261241AbVAaQBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 11:01:42 -0500
Date: Mon, 31 Jan 2005 16:01:06 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nix <nix@esperi.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: SPARC64 mapped figure goes unsignedly negative...
In-Reply-To: <87sm4hwr81.fsf@amaterasu.srvr.nix>
Message-ID: <Pine.LNX.4.61.0501311545200.5933@goblin.wat.veritas.com>
References: <87sm4izw3u.fsf@amaterasu.srvr.nix> 
    <Pine.LNX.4.61.0501311256580.5368@goblin.wat.veritas.com> 
    <87sm4hwr81.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005, Nix wrote:
> On Mon, 31 Jan 2005, Hugh Dickins suggested tentatively:
> > On Sun, 30 Jan 2005, Nix wrote:
> >> /proc/meminfo on my UltraSPARC IIi:
> >> Mapped:       18446744073687883208 kB
> >> 
> >> (This kernel is compiled with GCC-3.4.3, which might be relevant.)
> > 
> > Indeed: sparc64 gcc-3.4 seems to be having trouble with that
> > since 2.6.9: we've been persuing it offlist, I'll factor you in.
> 
> Excellent; thank you!
> 
> (2.6.10 seems to *run* perfectly well on that box, for what it's worth;
> unless this is a symptom of some underlying dark and terrible failure,
> it looks like a not-very-important cosmetic bug.)

A lot of the time you're right and it is just cosmetic.  But if memory
gets tight and it should be using swap, it mistakenly fails to do so,
so you may end up getting OOM-killed.  Patch below is a temporary hack
workaround against that.  The Mapped count also affects when dirty file
writeback kicks in, but the effect there appears to be less serious.

More worrying is, what else might sparc64 gcc-3.4 be getting wrong?
(if it really is to blame: looks to be so but not yet proven)

Hugh

--- 2.6.10/mm/vmscan.c	2004-12-24 21:36:18.000000000 +0000
+++ linux/mm/vmscan.c	2005-01-31 12:44:56.006629152 +0000
@@ -690,6 +690,8 @@ refill_inactive_zone(struct zone *zone, 
 	 * is mapped.
 	 */
 	mapped_ratio = (sc->nr_mapped * 100) / total_memory;
+	if (mapped_ratio < 0)
+		mapped_ratio = 78;
 
 	/*
 	 * Now decide how much we really want to unmap some pages.  The mapped
