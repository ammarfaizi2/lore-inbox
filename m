Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWBXKap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWBXKap (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 05:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWBXKap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 05:30:45 -0500
Received: from relay1.wplus.net ([195.131.52.143]:27398 "EHLO relay1.wplus.net")
	by vger.kernel.org with ESMTP id S932198AbWBXKao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 05:30:44 -0500
From: Vitaly Fertman <vitaly@namesys.com>
Reply-To: vitaly@namesys.com
To: "Matheus Izvekov" <mizvekov@gmail.com>
Subject: Re: cannot open initial console
Date: Fri, 24 Feb 2006 13:33:52 +0300
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>
References: <305c16960602221818h69de46cfpa06027b44c2e07e8@mail.gmail.com> <305c16960602222241m1a28a718l82cfe185772449be@mail.gmail.com> <305c16960602222246h27341bf9qf6e4a89c1f14505e@mail.gmail.com>
In-Reply-To: <305c16960602222246h27341bf9qf6e4a89c1f14505e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QEu/Deq4thVgf3A"
Message-Id: <200602241333.52734.vitaly@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_QEu/Deq4thVgf3A
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 23 February 2006 09:46, Matheus Izvekov wrote:
> On 2/23/06, Matheus Izvekov <mizvekov@gmail.com> wrote:
> > On 2/22/06, Matheus Izvekov <mizvekov@gmail.com> wrote:
> > > Hi all
> > >
> > > When i tried kernel 2.6.15.4, i noticed i cant boot it, i get
> > > "warning: cannot open initial console" then it reboots. I've searched
> > > for it and found the breakage occurs from 2.6.15.1 to 2.6.15.2
> > >
> > > Before i start to bisect to find the culpirit, and as there were few
> > > changes, anyone has a good guess about what broke it?
> > >
> > > Thanks all in advance.
> > >
> >
> > Found the bad patch by reversing by hand.
> >
> > diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
> > index 42afb5b..9c38f10 100644
> > --- a/fs/reiserfs/super.c
> > +++ b/fs/reiserfs/super.c
> > @@ -1131,7 +1131,7 @@ static void handle_attrs(struct super_bl
> >                         REISERFS_SB(s)->s_mount_opt &= ~(1 << REISERFS_ATTRS);
> >                 }
> >         } else if (le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared) {
> > -               REISERFS_SB(s)->s_mount_opt |= REISERFS_ATTRS;
> > +               REISERFS_SB(s)->s_mount_opt |= (1 << REISERFS_ATTRS);
> >         }
> >  }
> >
> > Reversing this fixes the problem, double checked it. What was that
> > patch supposed to do anyway?
> >
> 
> Adding Vitaly Fertman to this thread, as he is the one who seems to
> have submitted that patch.

this line enables attribues by default -- sets the mount option flag. 
the problem was that the value itself, instead of the flag, was set.

reiserfs_attrs_cleared on-disk super block flag indicates if attributes 
of all files were cleared initially or not -- fs is ready to use attributes.
if they were not cleared, files may contain garbage instead of attribute flags. 

reiserfs_attrs_cleared flag may lie, garbage in file attributes may appear 
due to using old kernels/reiserfsprogs, before attributes were supported by 
reiserfs; or due to a corruption.

so it seems better to disable the enable-by-default behaviour -- look into 
the attachment please -- and clear the file attributes before using them: 
	reiserfsck --clean-attributes <device>

-- 
Vitaly

--Boundary-00=_QEu/Deq4thVgf3A
Content-Type: message/rfc822;
  name="Attachment: 1"
Content-Transfer-Encoding: 7bit
Content-Description: Jeff Mahoney <jeffm@suse.com>: [PATCH] reiserfs: disable automatic enabling of reiserfs inode attributes
Content-Disposition: inline;
	filename*=

Return-Path: <jeffm@locomotive.unixthugs.org>
Delivered-To: vitaly@namesys.com
Received: (qmail 29339 invoked by uid 85); 12 Feb 2006 16:38:04 -0000
Received: from jeffm@locomotive.unixthugs.org by thebsh.namesys.com by uid 82 with qmail-scanner-1.15 
 (spamassassin: 2.43-cvs.  Clear:SA:0(0.0/2.0 tests=none autolearn=no version=2.60):. 
 Processed in 0.490437 secs); 12 Feb 2006 16:38:04 -0000
Received: from locomotive.csh.rit.edu (HELO locomotive.unixthugs.org) (postfix@129.21.60.149)
  by thebsh.namesys.com with SMTP; 12 Feb 2006 16:38:03 -0000
Received: by locomotive.unixthugs.org (Postfix, from userid 500)
	id 75B518F1C6; Sun, 12 Feb 2006 11:37:58 -0500 (EST)
Date: Sun, 12 Feb 2006 11:37:58 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>,
 Linus Torvalds <torvalds@osdl.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ReiserFS List <reiserfs-list@namesys.com>
Cc: Chris Mason <mason@suse.com>,
 Hans Reiser <reiser@namesys.com>,
 Vitaly Fertman <vitaly@namesys.com>
Subject: [PATCH] reiserfs: disable automatic enabling of reiserfs inode attributes
Message-ID: <20060212163758.GB5190@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	thebsh.namesys.com
X-Spam-DCC: : 
X-Spam-Status: No, hits=0.0 required=2.0 tests=none autolearn=no version=2.60

 Unfortunately, the reiserfs_attrs_cleared bit in the superblock flag can lie.
 File systems have been observed with the bit set, yet still contain garbage
 in the stat data field, causing unpredictable results.

 This patch backs out the enable-by-default behavior.

 It eliminates the changes from: d50a5cd860ce721dbeac6a4f3c6e42abcde68cd8, and
 ef5e5414e7a83eb9b4295bbaba5464410b11e030.

  fs/reiserfs/super.c |    2 --
  1 files changed, 2 deletions(-)

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.15/fs/reiserfs/super.c linux-2.6.15-reiserfs/fs/reiserfs/super.c
--- linux-2.6.15/fs/reiserfs/super.c	2006-02-06 19:54:27.000000000 -0500
+++ linux-2.6.15-reiserfs/fs/reiserfs/super.c	2006-02-12 11:19:15.000000000 -0500
@@ -1121,8 +1121,6 @@ static void handle_attrs(struct super_bl
 					 "reiserfs: cannot support attributes until flag is set in super-block");
 			REISERFS_SB(s)->s_mount_opt &= ~(1 << REISERFS_ATTRS);
 		}
-	} else if (le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared) {
-		REISERFS_SB(s)->s_mount_opt |= (1 << REISERFS_ATTRS);
 	}
 }
 
-- 
Jeff Mahoney
SuSE Labs


--Boundary-00=_QEu/Deq4thVgf3A--
