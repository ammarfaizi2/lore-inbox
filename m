Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285034AbRLKOfO>; Tue, 11 Dec 2001 09:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285032AbRLKOfF>; Tue, 11 Dec 2001 09:35:05 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:22000 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S285022AbRLKOe5>; Tue, 11 Dec 2001 09:34:57 -0500
Date: Tue, 11 Dec 2001 14:34:44 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Timothy Shimmin <tes@boing.melbourne.sgi.com>,
        Nathan Scott <nathans@sgi.com>, Andreas Gruenbacher <ag@bestbits.at>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: Implementing POSIX ACLs - was: Re: [PATCH] Revised extended attributes interface
Message-ID: <20011211143444.H2268@redhat.com>
In-Reply-To: <20011211122258.V61575@boing.melbourne.sgi.com> <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <20011210115209.C1919@redhat.com> <20011211122258.V61575@boing.melbourne.sgi.com> <20011211113306.E2268@redhat.com> <5.1.0.14.2.20011211131339.02aa9dc0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20011211131339.02aa9dc0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Tue, Dec 11, 2001 at 01:30:16PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 11, 2001 at 01:30:16PM +0000, Anton Altaparmakov wrote:
> At 11:33 11/12/01, Stephen C. Tweedie wrote:
> >On Tue, Dec 11, 2001 at 12:22:58PM +1100, Timothy Shimmin wrote:
> > > Could this not be catered for independent of the proposed EA interface
> > > for getting/setting/removing EAs ?
> >
> >Definitely.  The whole problem I pointed out with the EA interface was
> >that it didn't talk about ACLs at all.  So, sure, it gives us an API
> >for arbitrary EAs, but it does absolutely nothing to help us unify ACL
> >APIs.
> 
> And this is a Good Thing(TM). EAs are completely orthogonal to ACLs and the 
> API for EAs should not in any way have anything to do with ACLs.

At the moment, however, they do.

The user-visible APIs for ACLs and EAs are quite separate.  However,
the way that the user ACL libraries talk to the filesystem is through
special reserved EAs, to which the kernel magically imparts ACL
semantics.  The format of that EA, its name, its semantics and so on,
are all completely glossed over by the existing EA spec, despite the
fact that this mechanism is right at the very core of the ACL
implementation.

> It is up to a different API to implement ACLs. In the case of xfs, ext3, 
> etc, it can have EAs as a backend to the API but in the case of NTFS ACLs 
> would not be anything to do with EAs.

I know, and that's part of the problem we identified over a year ago.
My old EA proposal had the concept of "attribute families", and
allowed us to define ACL attributes in a completely different
namespace from EAs, so that NTFS, AFS or NFSv4 ACLs could be passed
cleanly through the same API.

> _Please_ do not mix the two issues. We have here a IMO nice API for EAs. 
> Lets get it into the kernel. Once that is done, one can start talking about 
> an API for ACLs.

I'm not mixing them: I'm *trying* to unmix them.

The existing EA code implements magic "handlers" for system EAs.
Undefined magic gets called when you set such an EA.  There's no
mention about this in the spec.

So right now the EA code opens up what is basically a named-ioctl back
door into the filesystems, and ACLs work on top of that.  The existing
ACL and EA code is already enormously intertwined.

> IMHO a generic POSIX ACL API would never even know that ACLs are stored as 
> EAs, this should be up to the individual fs and if several fs use EAs it 
> would make sense to have vfs helpers which all fs can use (a-la generic_* 
> helpers).

Yes, and the existing bestbits ACL API does not have anything like
that abstraction: rather, it relies on doing an assignment to a "$acl"
EA.

So how are we going to do ACLs on top of EAs?  Even if we forget about
the ACL API for now, the API between the ACL layer and the EA layer
*does* matter.  

Cheers,
 Stephen
