Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269711AbUICOC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269711AbUICOC2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 10:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269710AbUICOC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 10:02:27 -0400
Received: from daq3.if.pw.edu.pl ([194.29.174.23]:34441 "HELO milosz.na.pl")
	by vger.kernel.org with SMTP id S269698AbUICN7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:59:22 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Reply-To: bzolnier@milosz.na.pl
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: fix the barrier IDE detection logic
Date: Fri, 3 Sep 2004 15:54:31 +0200
User-Agent: KMail/1.6.2
Cc: torvalds@osdl.org, axboe@suse.dk, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <20040831165046.GA6928@devserv.devel.redhat.com>
In-Reply-To: <20040831165046.GA6928@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409031554.31057.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday 31 August 2004 18:50, Alan Cox wrote:
> This fixes the logic so we always check for the cache. It also defaults
> to safer behaviour for the non cache flush case now we have the right bits
> in the right places. I've also played a bit with timings - the worst case
> timings I can get for the flush are about 7 seconds (which I'd expect
> as the engineering worst cases will include retries)
> 
> Probably what should happen is that the barrier logic is enabled providing
> the wcache is disabled. I've not meddled with this as I don't know what
> the intended semantics and rules are for disabling barrier on a live disk
> (eg when a user uses hdparm to turn on the write cache). In the current
> code as with Jens original that cannot occur.

I think that logic is reversed here, I guess it should be: enable barrier
if user enables wcache and disable it if user disables wcache.

> I've also fixed the new printk's as per a private request from Matt Domsch.

Patch looks fine except:

> +	/* Now we have barrier awareness we can be properly conservative
> +	   by default with other drives. We turn off write caching when
> +	   barrier is not available. Users can adjust this at runtime if

This is not true because there is a check for flush cache in write_cache().

I agree that disabling write cache by default is a good thing but user
should be informed about this fact (ideally there also should be easily
available FAQ somewhere) otherwise we will get a lot of bogus bugreports
about decreased performance...

> +	   they need unsafe but fast filesystems. This will reduce the
> +	   performance of non cache flush supporting disks but it means
> +	   you get the data order guarantees the journalling fs's require */
> +	   
> +	write_cache(drive, barrier);

I'll drop this chunk and resend to Linus.

Thanks!

PS: please also cc: linux-ide on all ATA related stuff
