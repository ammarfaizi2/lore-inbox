Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSILM4F>; Thu, 12 Sep 2002 08:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSILM4F>; Thu, 12 Sep 2002 08:56:05 -0400
Received: from [217.167.51.129] ([217.167.51.129]:20676 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S315440AbSILM4E>;
	Thu, 12 Sep 2002 08:56:04 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Jens Axboe" <axboe@suse.de>, "Paul Mackerras" <paulus@samba.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] highmem I/O for ide-pmac.c
Date: Thu, 12 Sep 2002 07:37:01 +0200
Message-Id: <20020912053701.904@192.168.4.1>
In-Reply-To: <20020912062057.GK30234@suse.de>
References: <20020912062057.GK30234@suse.de>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Looking at it again, both ide_build_sglist and ide_raw_build_sglist do
>> *almost* what we want.  If ide-pmac used hwif->sg_table instead of
>> pmif->sg_table, and if ide_[raw_]build_sglist were exported and took
>> the maximum number of entries as a parameter instead of using the
>> PRD_ENTRIES constant, then ide-pmac wouldn't need to have its own
>> versions of those routines.  Would those changes be OK?
>
>Sounds like a perfectly fine change to me.
>
>> Ben, any reason why we have to use pmif->sg_table rather than
>> hwif->sg_table?
>
>Looks identical to me. hwif->sg_table is kmalloc'ed sg list of
>PRD_ENTRIES (256), pmif->sg_table is kmalloc'ed ditto of MAX_DCMDS (256)
>entries.

Well, I decided to move all of those to pmif when I had the media
bay broken because ide_unregister calling ide_release_dma which
disposed of the tables behind my back.

Looking at ide.c in it's current incarnation (2.4.20pre), it seems
the common code will only play such tricks if hwif->dma_base is
non-NULL, in which case it assumes a PRD-style DMA.

So if we keep hwif->dma_base to 0, then we can probably go back
to using the hwif fields for sg_* and thus share the routines
with ide-dma.

I'd suggest you don't bother too much with that now. I'm working
with andre on his new IDE stuff in which I already did some
cleanup work on ide-pmac, I'll add that to it next week. That
code should ultimately move to both 2.4 and 2.5 (by 2.4.21 time
frame I beleive).

Ben.

