Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVGLHXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVGLHXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 03:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVGLHVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 03:21:54 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:4497 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261243AbVGLHVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 03:21:37 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Masover <ninja@slaphack.com>
Date: Tue, 12 Jul 2005 17:19:40 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17107.28428.30907.184223@cse.unsw.edu.au>
Cc: Stefan Smietanowski <stesmi@stesmi.com>, Hans Reiser <reiser@namesys.com>,
       Hubert Chan <hubert@uhoreg.ca>, Ross Biro <ross.biro@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: reiser4 plugins
In-Reply-To: message from David Masover on Monday July 11
References: <hubert@uhoreg.ca>
	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>
	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>
	<8783be6605062914341bcff7cb@mail.gmail.com>
	<878y0svj1h.fsf@evinrude.uhoreg.ca>
	<42C4F97B.1080803@slaphack.com>
	<87ll4lynky.fsf@evinrude.uhoreg.ca>
	<42CB0328.3070706@namesys.com>
	<42CB07EB.4000605@slaphack.com>
	<42CB0ED7.8070501@namesys.com>
	<42CB1128.6000000@slaphack.com>
	<42CB1C20.3030204@namesys.com>
	<42CB22A6.40306@namesys.com>
	<42CBE426.9080106@slaphack.com>
	<42D1F06C.9010905@stesmi.com>
	<42D2DB99.9050307@slaphack.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
X-CSE-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	note.orchestra.cse.unsw.EDU.AU
X-CSE-Spam-Level: 
X-CSE-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday July 11, ninja@slaphack.com wrote:
> Stefan Smietanowski wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > 
> >>Ok, still haven't heard much discussion of metafs vs file-as-directory,
> >>but it seems like it'd be easier in metafs.
> > 
> > 
> > Why not implement it inside the directory containg the file ?
> > 
> > Ie the metadata for /home/stesmi/foo is in /home/stesmi/.meta/foo
> > 
> > This should be suit both camps I'd think?
> 
> You still need to figure out the parent of "foo", which isn't 
> necessarily easy, especially considering that even if we store a link to 
> the parent, it will be inside the metadata.  Then you have a 
> chicken-and-egg situation.
> 
> Both camps seem to want to allow easy access to the metadata of a file, 
> whether we're given that file as an inode or as a pathname.  That's why 
> I suggested /meta/vfs and /meta/inode -- sometimes I want to look up a 
> file by name, and sometimes by inode, but either way, I should be able 
> to get its metadata.

Well, it's not really 'as an inode or as a pathname'.  It is 'as an
open file descriptor or as a path name' which is an important
difference.

Maybe it is worth repeating Al Viro's suggestion at this point.  I
don't have a reference but the idea was basically that if you open
"/foo" and get filedescriptor N, then
   /proc/self/fds/N-meta
is a directory which contains all the meta stuff for "/foo".
Then it is trivial to get the 'meta' stuff given a filedescriptor and
if you have a pathname, you can always get yourself a filedescriptor.

Then to allow
    cat /home/friend/foo/.meta.../perms
you write a little .so which redefines open, stat, and a few others to
scan for ".meta..." in the pathname and to the necessary magic, and
    export LD_PRELOAD=/that/.so

Finally you write a killer app which fundamentally relies on this
functionality, get everyone addicted to it, and *then* (and only then)
start trying to get this functionality into the kernel.

i.e. prototype new semantics in userspace.

NeilBrown
