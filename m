Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292539AbSCDRRq>; Mon, 4 Mar 2002 12:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292550AbSCDRRf>; Mon, 4 Mar 2002 12:17:35 -0500
Received: from 216-42-72-143.ppp.netsville.net ([216.42.72.143]:15781 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S292539AbSCDRRI>; Mon, 4 Mar 2002 12:17:08 -0500
Date: Mon, 04 Mar 2002 12:16:35 -0500
From: Chris Mason <mason@suse.com>
To: "Stephen C. Tweedie" <sct@redhat.com>,
        James Bottomley <James.Bottomley@steeleye.com>
cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <1201480000.1015262195@tiny>
In-Reply-To: <20020304170434.B1444@redhat.com>
In-Reply-To: <phillips@bonn-fries.net> <200203041503.g24F3WU01722@localhost.localdomain> <20020304170434.B1444@redhat.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, March 04, 2002 05:04:34 PM +0000 "Stephen C. Tweedie" <sct@redhat.com> wrote:

> Basically, as far as journal writes are concerned, you just want
> things sequential for performance, so serialisation isn't a problem
> (and it typically happens anyway).  After the journal write, the
> eventual proper writeback of the dirty data to disk has no internal
> ordering requirement at all --- it just needs to start strictly after
> the commit, and end before the journal records get reused.  Beyond
> that, the write order for the writeback data is irrelevant.
> 

writeback data order is important, mostly because of where the data blocks
are in relation to the log.  If you've got bdflush unloading data blocks
to the disk, and another process doing a commit, the drive's queue
might look like this:

data1, data2, data3, commit1, data4, data5 etc.

If commit1 is an ordered tag, the drive is required to flush 
data1, data2 and data3, then write the commit, then seek back
for data4 and data5.

If commit1 is not an ordered tag, the drive can write all the
data blocks, then seek back to get the commit.

-chris

