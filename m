Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVGFCEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVGFCEQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVGFCEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:04:07 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:25036 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262010AbVGFCDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:03:51 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Hans Reiser <reiser@namesys.com>
Date: Wed, 6 Jul 2005 11:59:25 +1000
Message-ID: <17099.15101.233487.623549@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: David Masover <ninja@slaphack.com>, Hubert Chan <hubert@uhoreg.ca>,
       Ross Biro <ross.biro@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: reiser4 plugins
In-Reply-To: message from Hans Reiser on Tuesday July 5
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
	<42CB1E12.2090005@namesys.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 5, reiser@namesys.com wrote:
> I got it slightly wrong.
> 
> One can have hardlinks to a directory without cycles provided that one
> does not have hardlinks from the children of that directory to any file
> not a child of that directory.  (Mountpoints currently implement that
> restriction.)
> 
> Question: can one implement that lesser restriction above with elegant
> code?  Is the greater restriction below easier to code?  (If no to the
> first and yes to the second is correct, then I can accept the greater
> restriction described below.)

<technical-content>
I think the "lesser restriction above" can be implemented elegantly,
but it would require major dcache surgery.

Currently all the dentries of names in a directory are linked to the
dentry of the directory.  As you would have to let a directory have
multiple dentries, it would be best to change that linkage so that the
dentries of names in a directory were linked to the "inode" of that
directory (of which there is still only one).
Thus instead of just having a dentry tree with inodes attached at each
point, you would have a dentry/inode tree with inodes a more integral
part of the tree. (i.e. the path from the root down would be dentry ->
inode -> dentry ->inode -> dentry etc).
This would have major implications for the current code.

The "greater restriction below" should be easy to code providing you
were willing to have two sorts of directories: those which could be
linked (ie. they sometimes look like files) and those which cannot
(they never look like files).  Then for each dentry, you remember the
closest parent which is a can-be-linked directory an make sure a
hard-link will never want to change the can-be-linked directory for
the target.

If you want to be more general, and have only one sort of directory
that just behaves differently in different situations, then it would
be much harder.
You have to make sure both 
 a/ that you never hard link a file that is under a hard-linked
    directory to somewhere outside of that hard-linked directory and
 b/ that you never hard link a directory that contains a file which is
    hard-linked to somewhere outside that directory.

The first is probably quite manageable.  The second is essentially the
cycle-detection problem.

</technical-content>

<humour>
SUN used to advertise:
  "The network is the computer"
However I think we have all come to realise that the network is the
network, and the computer is the computer.

Now Hans wants to tells that
   "The directory is the file"

but I don't find it any more convincing than SUN's message...

</humour>

<opinion>
If you really want to change traditional Unix semantics, I would
suggest you get rid of hard-links.  They really are more trouble than
they are worth, and discarding them makes this whole issue moot.
</opinion>

NeilBrown
