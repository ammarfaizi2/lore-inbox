Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269478AbRHCRGm>; Fri, 3 Aug 2001 13:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269481AbRHCRGc>; Fri, 3 Aug 2001 13:06:32 -0400
Received: from ntt-connection.daiwausa.com ([210.175.188.3]:17384 "EHLO
	ead42.ead.dsa.com") by vger.kernel.org with ESMTP
	id <S269478AbRHCRGN>; Fri, 3 Aug 2001 13:06:13 -0400
Date: Fri, 3 Aug 2001 13:06:01 -0400
From: "Bill Rugolsky Jr." <rugolsky@ead.dsa.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010803130601.A12695@ead45>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010803155255.X12470@redhat.com> <15210.48950.179949.657793@pizda.ninka.net> <01080317250906.01827@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <01080317250906.01827@starship>; from phillips@bonn-fries.net on Fri, Aug 03, 2001 at 05:25:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 05:25:09PM +0200, Daniel Phillips wrote:
> As I read the (excerpts from the) SUS, this isn't required, only that
> at least one namespace path from the root to the fsynced file is
> preserved.  I can imagine an efficient implementation for this.

I might be way off base here; if so tell me.
Let's litter some sample code with fsync():

	fd = open("tmp/x",O_CREAT|O_WRONLY);
	...
	fsync(fd);
	rename("tmp/x","spool/x");
	fsync(fd);
	close(fd);

This looks safe and correct, given your semantics.  It is, unless the
link count of that file rises above 1, from say a mail admin quite
reasonably doing

	ln tmp/x peek/x

in the interval specified by "...".  In that case, it's not required
that "tmp/x" or "spool/x" ever hit disk.  So the code is only correct
if the file only has a single link, or we specify ordered meta-data
updates for open/rename/link/...  Following Stephen's argument, is 
"peek/x" any better than "lost+found"?  With more than one admin?

On older non-BSD systems (SYS3?,SYSV 3.x?) that don't do rename(), files can't
be moved without bumping their link counts:

	fd = open("tmp/x",O_CREAT|O_WRONLY);
	...
	fsync(fd);
	link("tmp/x","spool/x");
	fsync(fd);  /* <- possibly a NOP with your semantics */
	unlink("tmp/x");
	fsync(fd);
	close(fd);

Again, this will fail to preserve your desired semantics on crash,
unless we have ordered meta-data updates, or the stronger synchronous
link() requirement.

I think the semantics that you propose might be marginally useful, but
I don't think SUS requires it; my understanding (and that of a
close friend and former POSIX reviewer) has always been that inodes are
distinct from directory entries, and that fsync() preserves the fields
that stat() returns: mode, uid, gid, size, {a,c,m}time.

Regards,

   Bill Rugolsky
