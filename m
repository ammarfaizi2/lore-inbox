Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbRCGTO0>; Wed, 7 Mar 2001 14:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131160AbRCGTOQ>; Wed, 7 Mar 2001 14:14:16 -0500
Received: from zeus.kernel.org ([209.10.41.242]:46822 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131158AbRCGTOL>;
	Wed, 7 Mar 2001 14:14:11 -0500
Date: Wed, 7 Mar 2001 19:10:44 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        David Balazic <david.balazic@uni-mb.si>, torvalds@transmeta.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <20010307191044.M7453@redhat.com>
In-Reply-To: <3AA53DC0.C6E2F308@uni-mb.si> <20010306213720.U2803@suse.de> <20010307135135.B3715@redhat.com> <20010307151241.E526@suse.de> <20010307150556.L7453@redhat.com> <20010307195152.C4653@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010307195152.C4653@suse.de>; from axboe@suse.de on Wed, Mar 07, 2001 at 07:51:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 07, 2001 at 07:51:52PM +0100, Jens Axboe wrote:
> On Wed, Mar 07 2001, Stephen C. Tweedie wrote:
> 
> My bigger concern is when the journalled fs has a log on a different
> queue.

For most fs'es, that's not an issue.  The fs won't start writeback on
the primary disk at all until the journal commit has been acknowledged
as firm on disk.

Certainly for ext3, synchronisation between the log and the primary
disk is no big thing.  What really hurts is writing to the log, where
we have to wait for the log writes to complete before submitting the
commit write (which is sequentially allocated just after the rest of
the log blocks).  Specifying a barrier on the commit block would allow
us to keep the log device streaming, and the fs can deal with
synchronising the primary disk quite happily by itself.

Cheers,
 Stephen
