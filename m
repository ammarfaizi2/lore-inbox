Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264635AbSIQVuy>; Tue, 17 Sep 2002 17:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbSIQVuy>; Tue, 17 Sep 2002 17:50:54 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:7442 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S264635AbSIQVuu>; Tue, 17 Sep 2002 17:50:50 -0400
Date: Tue, 17 Sep 2002 14:55:40 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 throughput woes on certain (possibly heavily fragmented) files
Message-ID: <20020917215540.GA13363@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20020903092419.GA5643@vitelus.com> <20020906170614.A7946@redhat.com> <15736.57972.202889.872554@laputa.namesys.com> <20020906182457.F3029@redhat.com> <20020916223911.GA1658@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020916223911.GA1658@netnation.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2002 at 03:39:11PM -0700, Simon Kirby wrote:
> This box is primarily running a POP3 server (written in-house to cache
> mbox offsets, so that it can handle a huge volume of mail), and also
> exports the mail spool via NFS to other servers which run exim (-fsync). 
> nfsd is exported async.  Everything is mounted noatime, nodiratime.  No
> applications should be calling sync/fsync/fdatasync or using O_SYNC. 
> It's a mail server, so everything is fragmented.
> 
> We're using dotlocking.  Would this cause metadata journalling?  We had
> to hash the mail spool a long time ago do to system time eating all CPU
> (the ext2 linear directory scan to find a slot available in the spool
> directory to add the dotlock file).  I estimate about 200 - 300 dotlock
> files are created per second, but these should all be asynchronous. 
> Would switching to fctnl() locking (if this works over NFS) solve the
> problem?

I'd absolutly go to fcntl().  As bad as dotlocking is for
journaling filesystems it is even worse for NFS (when it works).
Look at the lkml thread "invalidate_inode_pages in 2.5.32/3"
to get an idea.  Multiply the directory invalidations by the
size of the directories.  fcntl() is the preferred way of locking
over NFS as it will even report if there is a problem with
lockd.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
