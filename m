Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUCaWJS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUCaWJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:09:18 -0500
Received: from ns.suse.de ([195.135.220.2]:58573 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261766AbUCaWJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:09:08 -0500
Subject: Re: [PATCH] barrier patch set
From: Chris Mason <mason@suse.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <406B3799.5060203@pobox.com>
References: <20040319153554.GC2933@suse.de>
	 <200403201723.11906.bzolnier@elka.pw.edu.pl>
	 <1079800362.11062.280.camel@watt.suse.com>
	 <200403201805.26211.bzolnier@elka.pw.edu.pl>
	 <1080662685.1978.25.camel@sisko.scot.redhat.com>
	 <1080674384.3548.36.camel@watt.suse.com>
	 <1080683417.1978.53.camel@sisko.scot.redhat.com> <4069F2FC.90003@pobox.com>
	 <1080742105.1991.40.camel@sisko.scot.redhat.com>
	 <1080742895.3547.139.camel@watt.suse.com>  <406B3799.5060203@pobox.com>
Content-Type: text/plain
Message-Id: <1080770982.3546.207.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 31 Mar 2004 17:09:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-31 at 16:26, Jeff Garzik wrote:
>  
> > Yes, it gets ugly in a hurry.  Jeff, look at the whole thread about the
> > O_DIRECT read vs buffered write races.  I don't think we can use FUA for
> 
> Yes, I'm aware of the thread...
> 
> 
> > fsync or O_SYNC without using it for every write.
> 
> Why not for O_SYNC?  Is some crazy userspace application flipping this 
> bit on and off rapidly?
> 

For both fsync and O_SYNC, the pages we want to write synchronously are
also available for some other part of the kernel to write async.  Since
we do know the write is going to be O_SYNC when we are marking the pages
dirty, we could mark them dirty_fua or something as well.

Even assuming we can deal with the data=ordered ext3/reiserfs issues, it
makes the writeback for O_SYNC yet another corner case to check, and one
where we have no useful way to make sure the fua bit really got set on
all the writes for a given O_SYNC (unless we pin the page and check each
one after the writes are complete).

Since O_DIRECT is much less complex I think we should start there.

-chris



