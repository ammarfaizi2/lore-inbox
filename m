Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263033AbREWJf5>; Wed, 23 May 2001 05:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263037AbREWJft>; Wed, 23 May 2001 05:35:49 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:22358 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263034AbREWJfd>; Wed, 23 May 2001 05:35:33 -0400
Date: Wed, 23 May 2001 10:23:44 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Peter J. Braam" <braam@mountainviewdata.com>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Edgar Toernig <froese@gmx.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-lvm@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Message-ID: <20010523102344.C27177@redhat.com>
In-Reply-To: <200105222010.f4MKAWZk011755@webber.adilger.int> <Pine.LNX.4.33.0105221415540.2271-100000@lustre.us.mvd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0105221415540.2271-100000@lustre.us.mvd>; from braam@mountainviewdata.com on Tue, May 22, 2001 at 02:59:32PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 22, 2001 at 02:59:32PM -0600, Peter J. Braam wrote:
 
> But during recovery, LVM cannot possibly know if the whole process of
> copying out the data from the current to the snapshot area completed
> during the previous run. Yes, LVM updates the redirection table first and
> then copies, but, still, you don't know _where exactly_ the writes stopped
> happening and in particular you don't know if the block was copied already
> or not.

LVM updates the snapshot redirection without knowing that the new
redirection location has been written?  So if I write to a LVM
snapshot and take a crash, I might not actually get either the old or
the new data, but in fact some previous random contents of a new
block?  Eek.  Journaling will not like that.  Databases won't like
that.  Anything that relies on fsync to ensure some write ordering on
disk will be potentially upset by that.

> It's better to keep the snapshot in the old volume and write the new data
> to a separate area (that's what most commercial systems do I think).

No.  The commercial systems write snapshots to a new area, usually.
There are two very good reason for that --- when you come to delete a
snapshot, there's no IO involved; and you avoid fragmenting the
original root volume.  

In systems I'm familiar with, the copy-out is always done in the same
direction with the snapshot getting the new block.  This even happens
if the snapshot is writable: regardless of whether it is the snapshot
or the root being written, the copy-out always results in the snapshot
getting moved, not the root.

Cheers, 
 Stephen
