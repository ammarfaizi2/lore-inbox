Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266890AbUG1MIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266890AbUG1MIz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 08:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266891AbUG1MIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 08:08:55 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:4304 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266890AbUG1MIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 08:08:53 -0400
Date: Wed, 28 Jul 2004 14:08:52 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Avi Kivity <avi@exanet.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
 server on local NFS mount
In-Reply-To: <20040727203438.GB2149@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0407281402020.26456@artax.karlin.mff.cuni.cz>
References: <41050300.90800@exanet.com> <20040726210229.GC21889@openzaurus.ucw.cz>
 <4106B992.8000703@exanet.com> <20040727203438.GB2149@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi!
>
> > >>On heavy write activity, allocators wait synchronously for kswapd to
> > >>free some memory. But if kswapd is freeing memory via a userspace NFS
> > >>server, that server could be waiting for kswapd, and the system seizes
> > >>instantly.
> > >>
> > >>This patch (against RHEL 2.4.21-15EL, but should apply either
> > >>literally
> > >>or conceptually to other kernels) allows a process to declare itself
> > >>as
> > >>kswapd's little helper, and thus will not have to wait on kswapd.
> > >>
> > >>
> > >
> > >Ok, but what if its memory runs out, anyway?
> > >
> > >
> > >
> > Tough. What if kswapd's memory runs out?
>
> I'd hope that kswapd was carefully to make sure that it always has
> enough pages...
>
> ...it is harder to do the same auditing with userland program.
>
> > A more complete solution would be to assign memory reserve levels below
> > which a process starts allocating synchronously. For example, normal
> > processes must have >20MB to make forward progress, kswapd wants >15MB
> > and the NFS server needs >10MB. Some way would be needed to express the
> > dependencies.
>
> Yes, something like that would be neccessary. I believe it would be
> slightly more complicated, like
>
> "NFS server needs > 10MB *and working kswapd*", so you'd need 25MB in
> fact... and this info should be stored in some readable form so that
> it can be checked.

Hi!

And if the NFS server is waiting for some lock that is held by another
process that is wating for kswapd...? It won't help.

The solution would be a limit for dirty pages on NFS --- if you say that
less than 1/8 of memory might be dirty NFS pages, than you can keep system
stable even if NFS writes starve. If you export NFS filesystem via NFSD
again, even this woudn't help, but there's no fix for this case.

Mikulas
