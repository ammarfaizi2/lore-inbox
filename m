Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbSJYMm5>; Fri, 25 Oct 2002 08:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbSJYMm5>; Fri, 25 Oct 2002 08:42:57 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:14087 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S261384AbSJYMmz>; Fri, 25 Oct 2002 08:42:55 -0400
Date: Fri, 25 Oct 2002 05:49:01 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
Message-ID: <20021025124901.GE10440@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DB59722.2090701@sun.com> <Pine.LNX.4.44.0210251233030.23877-100000@chip.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210251233030.23877-100000@chip.ath.cx>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 12:34:20PM +0300, Panu Matilainen wrote:
> On Tue, 22 Oct 2002, Tim Hockin wrote:
> 
> > Jesse Pollard wrote:
> > 
> > > Does it actually work with NFS???? or any networked file system?
> > > Most of them limit ngroups to 16 to 32, and cannot send any data
> > > if there is an overflow, since that overflow would replace all of the
> > > data you try to send/recieve...
> > 
> > NFS has a smaller limit, that is correct.  An unfortunate limitation.
> 
> This is a real, if not terribly common problem here too. Thanks for 
> addressing the issue...

Now i'll poke my stick into the hornets nest...

What i think would be much more usefull and could be
supported by NFS et al would be to allow groups to be
members of other groups.

Method 1 -- explicitly:

	example group file extract:
		webroot:x:103:www,jim,joy
		custadm:x:140:%webroot,bob,carol,ted,alice
		webcusts:x:1000:%webcust1,%webcust2,%webcust3
		webcust1:x:1001:%custadm,%custwebs,Matt,Christoph
		webcust2:x:1002:%custadm,%custwebs,Suparna,Aaron,Tim
		webcust3:x:1003:%custadm,%custwebs,Randal,Jesse

	I'm using the % prefix here to specify the group
	namespace.

	It would require permissions checking to aquire a
	list of groups that are group members.

	Now, changing it at this level would require that
	the libs be updated (but so would infinite groups)
	and a way to inform the kernel of the nested group
	memberships.

	For informing the kernel i lean toward a sysfs
	interface fed by a user-space utility that would
	build or update a pinned table.  The in-kernel group
	lists would be unrolled (per the example
	webroot=custadm,webcust1,webcust2,webcust3)

	There would be problems with existing utilities due
	to the new logic but that is a fairly small set and
	it might not be unreasonable to provide an infinite
	NGROUPS emulation.  Also multiple inheritance and
	loops would have to be caught.

	It also provides a way to have 400 (out of 16000)
	users in a group without infinite line length in
	/etc/group.

Method 2 -- implicitly:

	Have the sysfs interface fed by a utility that would
	use a separate config file.  The group file would be
	constructed as though NGROUPS were infinite.

	When setgroups is called with size > NGROUPS
	it would have to search for any entries that
	matched the list (yuck).  Match failure would
	error with EINVAL

	The only change to libs and utilities would be to
	lift NGROUPS_MAX.  The need for explicity group
	numbers would be so it would work over networks.

	This method has far too much magic for my taste and
	the potential for admin error in maintaining
	separate files is frightening.

	The implicit method could be restricted to an
	extension to NFS but then you would need to have the
	match cached in task_struct (reset by setgroups).

The important thing either way would be that you would save
on memory for group lists and it would work over NFS without
a protocol change.

I've actually wanted the nested group memberships for a long
time.

The only other idea I've had for accommodating NFS and other
remote FS for processes having excessive NGROUPS is to have
the client fetch the ownership and ACLs and execute the
access specifying the applicable subset of groups.  This
would not be good for performance but might possibly be done
with the existing protocols and might be better
performance-wise than sending kilobytes of GIDs with every
RPC call.




-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
