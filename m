Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278242AbRJSAxT>; Thu, 18 Oct 2001 20:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278244AbRJSAxK>; Thu, 18 Oct 2001 20:53:10 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:57240 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S278241AbRJSAw5>; Thu, 18 Oct 2001 20:52:57 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Fri, 19 Oct 2001 10:53:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15311.31087.29758.348795@notabene.cse.unsw.edu.au>
Cc: James Sutherland <jas88@cam.ac.uk>, Ben Greear <greearb@candelatech.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
In-Reply-To: message from Mike Fedyk on Thursday October 18
In-Reply-To: <3BCE6E6E.3DD3C2D6@candelatech.com>
	<Pine.SOL.4.33.0110180937420.13081-100000@yellow.csi.cam.ac.uk>
	<20011018132035.A444@mikef-linux.matchmail.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday October 18, mfedyk@matchmail.com wrote:
> 
> Actually, it looks like Niel is creating a two level Quota system.  In ther
> normal quota system, if you own a file anywhere, it is attributed to you.
> But, in the tree quota system, it is attributed to the owner of the
> tree...

Well, actually it is three level.  Though I wouldn't call them
levels.  They are really alternates.
The space usage of a filesystem object can be charged to
  1/ the owner of the file
  2/ the group-owner of the file
  3/ the owner of the tree containing the file.

I added the third.
You could conceivable impose quotas of all three sorts, but I suspect
that would cause unfortunate interactions and be a management
headache. I would recommend only using one at a time.

> 
> Niel, how do you plan to notify someone that their tree quota has been
> exceeded instead of their normal quota?

In what sense?  The kernel prints warning when you go over-quota.
It only does it if the process that causes quota to be exceeded is
reponsible for the quota.  This is determined in "need_print_warning"
in fs/dquot.c 
I haven't added a TREEQUOTA branch to that yet (just a FIXME comment).
A few moments reflection suggests that I should just "return 1" for
TREEQUOTA, so anyone who exceeds the quota gets the warning, not just 
the owner.

However, all my customers access their files via NFS and so don't get
these warnings.
I have a nightly job that sends email to people who are over quota,
and a global login script that prints a warning of the person is over
quota.
So they don't know the moment that they exceed their quota, but
should find out soon enough....

I wonder if NFSv4 should have a "Soft-Quota-Exceeded" non-error return
state so that clients could warn their users.... It doesn't yet.

NeilBrown
