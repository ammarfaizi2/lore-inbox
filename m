Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268215AbTBYRr1>; Tue, 25 Feb 2003 12:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268216AbTBYRr1>; Tue, 25 Feb 2003 12:47:27 -0500
Received: from cs666873-16.austin.rr.com ([66.68.73.16]:40966 "EHLO
	raptor.int.mccr.org") by vger.kernel.org with ESMTP
	id <S268215AbTBYRrY>; Tue, 25 Feb 2003 12:47:24 -0500
Date: Tue, 25 Feb 2003 11:57:08 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: Zilvinas Valinskas <zilvinas@gemtek.lt>, helgehaf@aitel.hist.no,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.62-mm3 - no X for me
Message-ID: <131360000.1046195828@[10.1.1.5]>
In-Reply-To: <20030225015537.4062825b.akpm@digeo.com>
References: <20030223230023.365782f3.akpm@digeo.com>
 <3E5A0F8D.4010202@aitel.hist.no><20030224121601.2c998cc5.akpm@digeo.com>
 <20030225094526.GA18857@gemtek.lt> <20030225015537.4062825b.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, February 25, 2003 01:55:37 -0800 Andrew Morton
<akpm@digeo.com> wrote:

> Ah, thank you.
> 
> 	kernel BUG at mm/rmap.c:248!
> 
> The fickle finger of fate points McCrackenwards.

Yep.  He tripped over my sanity check that pages not marked anon actually
have a real mapping pointer.  Apparently X allocates a page that should be
marked anon but isn't.

My main reason for adding the anon flag was to prove to myself that the
mapping pointer can be trusted.  Apparently it can, generally, but it looks
like I haven't successfully tracked down all the places that should set it.
It looks like anon pages can come from random sources, so it might be an
impossible task to find them all.

I know you said you like the idea of having the flag, but I think the
cleanest fix would be to change the check from

	if (PageAnon(page))
to
	if (page->mapping && !PageSwapCache(page))

Or I could set the anon flag based on that test.  I know page flags are
getting scarce, so I'm leaning toward removing the flag entirely.

What would you recommend?

Dave McCracken

