Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278249AbRJSBNa>; Thu, 18 Oct 2001 21:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278261AbRJSBNM>; Thu, 18 Oct 2001 21:13:12 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:24729 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S278247AbRJSBM5>; Thu, 18 Oct 2001 21:12:57 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 19 Oct 2001 11:13:15 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15311.32299.52409.88200@notabene.cse.unsw.edu.au>
Cc: James Sutherland <jas88@cam.ac.uk>, Ben Greear <greearb@candelatech.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
In-Reply-To: message from Andreas Dilger on Thursday October 18
In-Reply-To: <3BCE6E6E.3DD3C2D6@candelatech.com>
	<Pine.SOL.4.33.0110180937420.13081-100000@yellow.csi.cam.ac.uk>
	<20011018132035.A444@mikef-linux.matchmail.com>
	<20011018151718.O1144@turbolinux.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday October 18, adilger@turbolabs.com wrote:
> On Oct 18, 2001  13:20 -0700, Mike Fedyk wrote:
> > On Thu, Oct 18, 2001 at 09:38:47AM +0100, James Sutherland wrote:
> > > No - "the ... usage of a file is charged to the tree, RATHER THAN THE
> > > OWNER OF THE FILE". So, in this case, if you own a file in ~idiot/foo,
> > > idiot's quota is charged for the file, not you.
> 
> However, this means that if anyone has write permission into a tree, they
> can "offload" their quota to another user and keep more files than they
> ought to.  Also, depending on the permissions of the file/directory, the
> "tree" owner may not even be able to delete the files that are causing
> their quota to be exceeded.

Exactly the same is true of group based quotas.
We have a set-uid tool that allows people in a group to do
 "chmod g+rwx" on any directory in that group's home directory. 

> 
> > Actually, it looks like Niel is creating a two level Quota system.  In ther
> > normal quota system, if you own a file anywhere, it is attributed to you.
> > But, in the tree quota system, it is attributed to the owner of the tree...
> 
> Hmm, we already have group quotas, and (excluding ACLs) you would need to
> have group write permission into the tree to be able to write there.  How
> does the tree quota help us in the end?  Either users are "nice" and you
> don't need quotas, or users are "not nice" and you don't want them to be
> able to dump their files into an area that doesn't keep them "in check" as
> quotas are designed to do.

People need to agree to be "nice" to other people in their group.
Tree quotas forces them, as a group, to be "nice" to everyone else.

I wrote a little blurb on why I want tree quotas at:

  http://www.cse.unsw.edu.au/~neilb/wiki/?WhyTreeQuotas

I include it below.

NeilBrown

----------------------------------------------------------------
Why Would we want tree based quotas

It is reasonable to ask why user or group based quotas are not
enough. 

My answer is not a general rationale, but rather an answer as to why
they aren't enough for me in my situation. If you have a similar
situation, the reasons might apply to you too.. Or they might not.

We provide centralised home directories for a wide variety of users
(students and academics mostly). These home directories are stored on
a number of different filesystems on a number of different hosts.

We wish to impose clear, predictable, repeatable restrictions on disc
space usage on these home directories so as to protect the various
users from one another. It would be nice if the restrictions were also
fair and equitable, but that is not a technological issue.

Thus we need a clear way to identify who each file should be charged
to, and to make sure that the total of files charged to a user (or
other entity - a "who") is controlled by their stated quota (with
allowances for soft and hard limits, and grace periods etc).

We also have people who wish to, and people who are required to, work
co-laboratively. Thus they may need to work on files in their own home
directory, and also files in some other home directory, such as a
group directory or a co-workers directory.

We also have people who want to make use of discressionary access
control (DAC) and give access to certain file to certain groups of
people.

Given all of this, quotas based on the "owner" of a file cannot
work. This is because (due to group work) an individual may own file
in multiple filesystem, and unix style quotas are per-filesystem
based. People would need to have their assigned quota shared among
various filesystems, and this would be awkward to manage. It also
makes it hard to find all files that you are being changed for, so
that you can clean up.

Similar, quotas based on the "group-owner" of a file cannot work. This
is because some groups are used for DAC only and do not justify having
any quota.

We have worked with a combination of these schemes for a while:
user-based quotas for some people, and group based quotas for
others. However this only reduces some of the problems, and doesn't
completely remove any.

Tree based quotas provide an answer to all of this. Each person or
entity that merits some storage space (e.g. groups) is given a home
directory. All files in this home directory get charged to that
entity, no matter who the owner and group-owner are. This clearly
separates access control from usage charges.

It is possible, when sharing access, for one person to use up lots of
storage that gets charged to another person (or a group) such that a
person who is affected by the charge does not have access permission
to delete some of the files that they are being charged for. This is
also possible with group based quotas.

To resolve this, any person who is being changed for space must be
given access to remove files consuming that space. This means that
they must be able to get read/write/execute permission on any
directory that they are being charged for.

This can be done in user-space with a simple set-uid tools.
