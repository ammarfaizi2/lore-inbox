Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131230AbRBUDCl>; Tue, 20 Feb 2001 22:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131293AbRBUDCb>; Tue, 20 Feb 2001 22:02:31 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:15373 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S131230AbRBUDCV>; Tue, 20 Feb 2001 22:02:21 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Roman Zippel <zippel@fh-brandenburg.de>
Date: Wed, 21 Feb 2001 14:02:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14995.12200.46230.717479@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: problems with reiserfs + nfs using 2.4.2-pre4
In-Reply-To: message from Roman Zippel on Tuesday February 20
In-Reply-To: <14993.48376.203279.390285@notabene.cse.unsw.edu.au>
	<Pine.GSO.4.10.10102200330330.25095-100000@zeus.fh-brandenburg.de>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday February 20, zippel@fh-brandenburg.de wrote:
> Hi,
> 
> On Tue, 20 Feb 2001, Neil Brown wrote:
> 
> > 2/ lookup("..").
> 
> A small question:
> Why exactly is this needed?
> 
> bye, Roman

Having read the subsequent posts, I now see what you are thinking and
know how to answer this.

The problem that I see is indeed related to rename, but not in the way
that Trond mentions.  (Tronds issue is a real, though very different,
issue). 

Suppose I have a directory path

   /a/b/c/d/e/f/g

Where filehandle X refers to /a/b and filehande Y refers to
/a/b/c/d/e/f/g

Then an NFS request comes in saying

   RENAME X/c to Y/h

If this was performed, then you would end up with a directory path
 
 /a/b

and a disconnected loop:


    d/e/f/g/h
    ^       v
    +-------+

which is not good.
This possibility is protected against by the VFS layer.  It serialises
all directory renames using s_vfs_rename_sem and then checks that the
source of the rename isn't an ancestor of the target.
For this check to be reliable, each dentry for a directory must be
properly connected to the root.

Now if you have a filesystem that:

 - cannot do ".." lookups efficiently, or doesn't want to and
 - can protect against this sort of loop (and any other issues that
    the VFS usually protects against) itself

then it can (with my patch) simply define decode_fh and encode_fh and
do whatever it likes, such as create a dentry that isn't properly
connected.

get_parent is only called by nfsd_find_fh_dentry which is a helper
routine which is normally called by the decode_fh function (and is
called by the default decode_fh function).
If a filesystem provides it's own decode_fh which doesn't call
nfsd_find_fh_dentry, then get_parent won't be called and isn't needed.

NeilBrown

