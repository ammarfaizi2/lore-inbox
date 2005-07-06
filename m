Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVGGD32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVGGD32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 23:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbVGFT5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:57:48 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:6135 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S262134AbVGFQIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:08:16 -0400
Date: Wed, 06 Jul 2005 09:06:51 -0700
From: Nate Diller <nate@namesys.com>
Subject: Re: reiser4 plugins
In-reply-to: <17099.15101.233487.623549@cse.unsw.edu.au>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Hubert Chan <hubert@uhoreg.ca>, Ross Biro <ross.biro@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Nate Diller <ndiller@namesys.com>
Message-id: <42CC019B.70503@namesys.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en
References: <hubert@uhoreg.ca>
	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>
	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>
	<8783be6605062914341bcff7cb@mail.gmail.com>
	<878y0svj1h.fsf@evinrude.uhoreg.ca>	<42C4F97B.1080803@slaphack.com>
	<87ll4lynky.fsf@evinrude.uhoreg.ca>	<42CB0328.3070706@namesys.com>
	<42CB07EB.4000605@slaphack.com>	<42CB0ED7.8070501@namesys.com>
	<42CB1128.6000000@slaphack.com>	<42CB1E12.2090005@namesys.com>
 <17099.15101.233487.623549@cse.unsw.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105
 Debian/1.7.5-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

>On Tuesday July 5, reiser@namesys.com wrote:
>  
>
>>I got it slightly wrong.
>>
>>One can have hardlinks to a directory without cycles provided that one
>>does not have hardlinks from the children of that directory to any file
>>not a child of that directory.  (Mountpoints currently implement that
>>restriction.)
>>
>>Question: can one implement that lesser restriction above with elegant
>>code?  Is the greater restriction below easier to code?  (If no to the
>>first and yes to the second is correct, then I can accept the greater
>>restriction described below.)
>>    
>>
>
><technical-content>
>I think the "lesser restriction above" can be implemented elegantly,
>but it would require major dcache surgery.
>
>Currently all the dentries of names in a directory are linked to the
>dentry of the directory.  As you would have to let a directory have
>multiple dentries, it would be best to change that linkage so that the
>dentries of names in a directory were linked to the "inode" of that
>directory (of which there is still only one).
>Thus instead of just having a dentry tree with inodes attached at each
>point, you would have a dentry/inode tree with inodes a more integral
>part of the tree. (i.e. the path from the root down would be dentry ->
>inode -> dentry ->inode -> dentry etc).
>This would have major implications for the current code.
>
>The "greater restriction below" should be easy to code providing you
>were willing to have two sorts of directories: those which could be
>linked (ie. they sometimes look like files) and those which cannot
>(they never look like files).  Then for each dentry, you remember the
>closest parent which is a can-be-linked directory an make sure a
>hard-link will never want to change the can-be-linked directory for
>the target.
>
>If you want to be more general, and have only one sort of directory
>that just behaves differently in different situations, then it would
>be much harder.
>You have to make sure both 
> a/ that you never hard link a file that is under a hard-linked
>    directory to somewhere outside of that hard-linked directory and
> b/ that you never hard link a directory that contains a file which is
>    hard-linked to somewhere outside that directory.
>
>The first is probably quite manageable.  The second is essentially the
>cycle-detection problem.
>
></technical-content>
>
><humour>
>SUN used to advertise:
>  "The network is the computer"
>However I think we have all come to realise that the network is the
>network, and the computer is the computer.
>
>Now Hans wants to tells that
>   "The directory is the file"
>
>but I don't find it any more convincing than SUN's message...
>
></humour>
>
><opinion>
>If you really want to change traditional Unix semantics, I would
>suggest you get rid of hard-links.  They really are more trouble than
>they are worth, and discarding them makes this whole issue moot.
></opinion>
>  
>
have you read Giampaolo's BeFS design book?  he talks (ch 11) about this 
big argument they had at Be about how their API would let programs store 
references to files.  the macintosh people wanted to have the program 
store an inode number, and the posix guys wanted it to store a path.  in 
my mind, the only reason posix is right on this is because it allows 
hard links AND symlinks as a way of giving a choice in the matter, since 
hard links increment the reference count and softlinks don't.  it seems 
much *more* important to be able to have this choice for file attributes 
than for the traditional posix namespace.

as an example, if a program were to store some things it needs access to 
in its executable's attributes, it should have the option of keeping a 
hard reference to something, so that it can't be deleted out from 
underneath.  this enables sane sharing of resources without ownership 
tracking problems (see windows DLL hell for details).  the attribute 
space should be indistinguishable from the rest of the namespace, and 
should be able to link (soft or hard) anywhere in the FS.  anything less 
is too much work for too little reward.

NATE

>NeilBrown
>
>
>  
>

