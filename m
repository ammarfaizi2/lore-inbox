Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262161AbTCRFtn>; Tue, 18 Mar 2003 00:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262165AbTCRFtn>; Tue, 18 Mar 2003 00:49:43 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:25548 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262161AbTCRFtm>; Tue, 18 Mar 2003 00:49:42 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@digeo.com>
Date: Tue, 18 Mar 2003 16:59:53 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15990.46553.729846.969182@notabene.cse.unsw.edu.au>
Cc: gilbertd@treblig.org, linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: 2.4.20: ext3/raid5 - allocating block in system zone/multiple 1
 requests for sector
In-Reply-To: message from Andrew Morton on Monday March 17
References: <20030316150148.GC1148@gallifrey>
	<15990.28660.687262.457216@notabene.cse.unsw.edu.au>
	<20030317192738.6a420ed0.akpm@digeo.com>
X-Mailer: VM 7.08 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 17, akpm@digeo.com wrote:
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> >
> > These two symptoms strongly suggest a buffer aliasing problem.
> > i.e. you have two buffers (one for data and one for metadata)
> > that refer to the same location on disc.
> > One is part of a file that was recently deleted, but the buffer hasn't
> > been flushed yet.  The other is part of a new directory.
> > The old buffer and the new buffer both get written to disc at much the
> > same time (hence the "multiple 1 requests"), but the old buffer hits
> > the disc second and so corrupts the filesystem.
> 
> This aliasing can happen very easily with direct-io, and it is something
> which drivers should be able to cope with.
> 
> I hope RAID is not still assuming that all requests are unique in this way?

No.  RAID copes.  If raid5 sees a write request for a block that it
already has a pending write request for, it will print a warning and
delay the second until the first complete.

In the cas in question I don't think raid5 is contributing to the
problem.  It is just provide extra information which might help point
towards the problem - i.e. it is confirming that some sort of aliasing
is happening.

NeilBrown
