Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbSKCJLy>; Sun, 3 Nov 2002 04:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbSKCJLy>; Sun, 3 Nov 2002 04:11:54 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:221 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261696AbSKCJLx>;
	Sun, 3 Nov 2002 04:11:53 -0500
Date: Sun, 3 Nov 2002 04:18:23 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dax Kelson <dax@gurulabs.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Oliver Xymoron <oxymoron@waste.org>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <1036307763.31699.214.camel@thud>
Message-ID: <Pine.GSO.4.21.0211030337380.25010-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 3 Nov 2002, Dax Kelson wrote:

> Each app should run in its own security context by itself.  That is why
> I have all the following users in my /etc/passwd:
> 
> apache nscd squid xfs ident rpc pcap nfsnobody radvd gdm named ntp
> 
> I didn't have to do this myself, my vendor shipped it that way. I don't
> have any daemons running as 'nobody'.
> 
> I think it is well understood that having more than one app run as the
> same uid (historically, nobody) is a Bad Thing(tm).
 
Yes, but there is more to that.  Namely, these daemons acquire their UIDs
not via suid bit and they are very likely owned by some other UID (root,
most likely).

> On a 'everything install RHL8.0', there exists 47 SUID root binaries.
> 
> Don't we want to convert them to 'run with UID of caller and with some
> capabilities'?
> 
> Isn't this the common case?
 
> 1. SUID root binaries --> run as caller with need capabilities
> 2. root daemons --> run as defined non-root user with capabilities
> 
> Problem space 2 can be tackled right now assuming the daemon doesn't try
> to fork+exec another binary and expect that binary to inherit the
> capabilities that it has.

3. suid-root that needs full-caps (check and you'll see quite a few of these.
just at random - sudo, chfn, mount).  These are equivalent to root - either
by function (if su can't give me root, I'll be _really_ PO'd) or by trivial
elevation of priveleges available if they are subverted (are capable of
changing the file that contains, among other things, shell of UID 0, are
capable of calling mount(2), which is enough for everything).

4. can be modified in a way that wouldn't require suid or would _really_
require it for a small helper (i.e. there is a small piece that is
root-equivalent, but it can be separated).

5. gratitious.

Care to give a splitup into these categories?  And yes, (4) requires
modification of programs - TANSTAAFL and all such...

As for (2) - most of those are started by priveleged process, so they
need to drop capabilities more than acquire them.  What exactly do
you have in mind?

