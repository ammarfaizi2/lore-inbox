Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285025AbRLKNbm>; Tue, 11 Dec 2001 08:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285030AbRLKNbc>; Tue, 11 Dec 2001 08:31:32 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:63977 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S285022AbRLKNbU>;
	Tue, 11 Dec 2001 08:31:20 -0500
Message-Id: <5.1.0.14.2.20011211131339.02aa9dc0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 11 Dec 2001 13:30:16 +0000
To: "Stephen C. Tweedie" <sct@redhat.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Implementing POSIX ACLs - was: Re: [PATCH] Revised extended
  attributes interface
Cc: Timothy Shimmin <tes@boing.melbourne.sgi.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, Nathan Scott <nathans@sgi.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
In-Reply-To: <20011211113306.E2268@redhat.com>
In-Reply-To: <20011211122258.V61575@boing.melbourne.sgi.com>
 <20011205143209.C44610@wobbly.melbourne.sgi.com>
 <20011207202036.J2274@redhat.com>
 <20011208155841.A56289@wobbly.melbourne.sgi.com>
 <20011210115209.C1919@redhat.com>
 <20011211122258.V61575@boing.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:33 11/12/01, Stephen C. Tweedie wrote:
>On Tue, Dec 11, 2001 at 12:22:58PM +1100, Timothy Shimmin wrote:
> > Could this not be catered for independent of the proposed EA interface
> > for getting/setting/removing EAs ?
>
>Definitely.  The whole problem I pointed out with the EA interface was
>that it didn't talk about ACLs at all.  So, sure, it gives us an API
>for arbitrary EAs, but it does absolutely nothing to help us unify ACL
>APIs.

And this is a Good Thing(TM). EAs are completely orthogonal to ACLs and the 
API for EAs should not in any way have anything to do with ACLs.

It is up to a different API to implement ACLs. In the case of xfs, ext3, 
etc, it can have EAs as a backend to the API but in the case of NTFS ACLs 
would not be anything to do with EAs.

_Please_ do not mix the two issues. We have here a IMO nice API for EAs. 
Lets get it into the kernel. Once that is done, one can start talking about 
an API for ACLs.

>In effect it is far _too_ extensible: we need to have some agreement on 
>how it can be used if the different ACL applications are to have any hope 
>of working together.

IMHO a generic POSIX ACL API would never even know that ACLs are stored as 
EAs, this should be up to the individual fs and if several fs use EAs it 
would make sense to have vfs helpers which all fs can use (a-la generic_* 
helpers).

If you create a hard connection between ACLs and EAs then you are already 
asserting from the start that there will be file systems with alternate ACL 
interface separate from this "generic" one and alternate user space 
utilities... Perhaps this is what you want, but then it certainly not a 
true generic interface, it's just a "cater for the people who first 
implemented it" interface.

>The bright point is that this can be done reasonably well in user
>space, if we're careful (but we still need to worry about exactly how
>the kernel will deal with validating ACE chains --- we need to specify
>whether EAs in the system namespace are expected to be stored verbatim
>or whether the filesystem is permitted to interpret their semantics
>intelligently.)

At the very least you have to allow for the possibility that a file system 
will have ACLs but those will be NOT EAs. An implementation which actually 
makes this impossible is IMHO unacceptable in the generic parts of the kernel.

IMHO an interface where each fs would have a set of acl_ops which the vfs 
can invoke like inode->acl_ops->{get,set,remove,add,whatever you 
like}_{acl,ace} - you get the idea - is required for a generic 
implementation of POSIX ACLs.

Each fs then implements ACLs any way it likes. xfs,ext3,et al would use the 
EA API, ntfs would use its own security attributes, other fs will do 
whatever is required.

This fits in nicely with the idea for vfs helpers so that xfs,ext3,etc 
could just set their acl_ops to generic_*_acl and be done with it.

Comments?

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

