Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVC3AuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVC3AuL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 19:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVC3AuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 19:50:11 -0500
Received: from adsl-64-164-130-3.dsl.snfc21.pacbell.net ([64.164.130.3]:5624
	"EHLO deadrat.localdomain") by vger.kernel.org with ESMTP
	id S261684AbVC3At7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 19:49:59 -0500
Date: Tue, 29 Mar 2005 16:49:28 -0800 (PST)
From: null@lclogic.com
X-X-Sender: rich@deadrat.localdomain
To: Adrian Bunk <bunk@stusta.de>
cc: Roland Dreier <roland@topspin.com>, jgarzik@pobox.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/net/at1700.c: at1700_probe1: array overflow
In-Reply-To: <20050325203820.GF3153@stusta.de>
Message-ID: <Pine.LNX.4.58.0503291646020.7750@deadrat.localdomain>
References: <20050325181836.GB3153@stusta.de> <528y4b7ekc.fsf@topspin.com>
 <20050325203820.GF3153@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005, Adrian Bunk wrote:

> Date: Fri, 25 Mar 2005 21:38:20 +0100
> From: Adrian Bunk <bunk@stusta.de>
> To: Roland Dreier <roland@topspin.com>
> Cc: jgarzik@pobox.com, linux-net@vger.kernel.org,
>      linux-kernel@vger.kernel.org
> Subject: Re: drivers/net/at1700.c: at1700_probe1: array overflow
>
> On Fri, Mar 25, 2005 at 10:42:11AM -0800, Roland Dreier wrote:
> >     Adrian> This can result in indexing in an array with 8 entries the
> >     Adrian> 10th entry.
> >
> > Well, not really, since the first 8 entries of the array have every
> > 3-bit pattern.  So pos3 & 0x07 will always match one of them.
> >
> > I agree it would be cleaner to make the loop only go up to 7 though.
>
> You either have this (impossible) overflow, or the case l_i == 7 isn't
> tested explicitely.
>
> I'd say simply leave it as it is now.
>
> But if noone disagrees, I'm inclined to add a comment.
>
> >  - R.
>
> cu
> Adrian
>

But on the other hand why loop if you don't have to?

static int at1700_ioaddr_pattern[] __initdata = {
-         0x00, 0x04, 0x01, 0x05, 0x02, 0x06, 0x03, 0x07
+         0x00, 0x02, 0x04, 0x06, 0x01, 0x03, 0x05, 0x07
};
...

static int __init at1700_probe1(struct net_device *dev, int ioaddr)
{
...
-       for (l_i = 0; l_i < 0x09; l_i++)
-               if (( pos3 & 0x07) == at1700_ioaddr_pattern[l_i])
-                       break;
-       ioaddr = at1700_mca_probe_list[l_i];
+       ioaddr = at1700_mca_probe_list[at1700_ioaddr_pattern[pos3&7]];
...
}

