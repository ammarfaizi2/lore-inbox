Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTEOIhf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 04:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbTEOIhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 04:37:35 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:10370
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263868AbTEOIhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 04:37:34 -0400
Date: Thu, 15 May 2003 10:50:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Dave McCracken <dmccr@us.ibm.com>, mika.penttila@kolumbus.fi,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <20030515085023.GU1429@dualathlon.random>
References: <199610000.1052864784@baldur.austin.ibm.com> <20030513181018.4cbff906.akpm@digeo.com> <18240000.1052924530@baldur.austin.ibm.com> <20030514103421.197f177a.akpm@digeo.com> <82240000.1052934152@baldur.austin.ibm.com> <20030514105706.628fba15.akpm@digeo.com> <99000000.1052935556@baldur.austin.ibm.com> <20030514111748.57670088.akpm@digeo.com> <108250000.1052936665@baldur.austin.ibm.com> <20030514115319.51a54174.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514115319.51a54174.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 11:53:19AM -0700, Andrew Morton wrote:
> converting i_sem to an rwsem and taking it in the pagefault would certainly
> stitch it up.  Unpopular, very messy.

and very slow, down_read on every page fault wouldn't scale

> Could "truncate file" return some code to say pages were left behind, so
> truncate re-runs zap_page_range()?  Sounds unpleasant.
> 
> 
> Yes, re-checking the page against i_size from do_no_page() would fix it up.

think if there are two truncates, one zapping the entere file, and
another restoring the previous i_size, in such case the new_page will be
wrong, as it won't be zeroed out. I mean if we do anything about it, we
should close all races and make it 100% correct.

My fix has no scalability cost, no indirect calls, touches mostly just
hot cachelines anyways, and addresses the multiple truncate case too.


>  But damn, that's another indirect call, 64-bit math, etc on _every_
> file-backed pagefault.
> 
> 
> Remind me again what problem this whole thing is currently causing?

the only thing I can imagine is an app trapping SIGBUS to garbage
collect the end of a file. So for example you truncate the file and you
wait the SIGBUS to know you've to re-extend it. it would be a legitimate
use, and this is a bug, it's not read against write that has no way to
synchronize anyways, however I doubt any application is being bitten by
this race.

Andrea
