Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbVHZUI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbVHZUI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 16:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVHZUI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 16:08:58 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:10595 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030254AbVHZUI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 16:08:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=A5dunT1sb5ERrqC9ddZFanHZ/oiuWCYTiYGWhYmcfpyAuhMgtMBoYwzXsIRjFFKPrqownDqG0etfcf93ir130RihcYFYAnit/tLmF4mjB+1DbbJ4SNF4pM83s48fVL+D8KKk0afnWqWiz7fFUGAnV8dr40GdK8IkIJHStiYHODg=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [patch 1/2] Fixup symlink function pointers for hppfs [for 2.6.13]
Date: Fri, 26 Aug 2005 22:04:43 +0200
User-Agent: KMail/1.8.1
Cc: torvalds@osdl.org, akpm@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20050826145749.03BFE24D661@zion.home.lan> <20050826190339.GA9322@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050826190339.GA9322@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508262204.43683.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 August 2005 21:03, Al Viro wrote:
> On Fri, Aug 26, 2005 at 04:57:44PM +0200, blaisorblade@yahoo.it wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

> > Update hppfs for the symlink functions prototype change.
> > Should be trivial, but please verify it's correct.

> > Yes, I know the code I leave there is still _bogus_, see next patch for
> > this.

About what it's doing, hppfs (HoneyPot Proc FS) is a wrapper for procfs, which 
must be able to hide part of the content for avoid an hacker inside UML 
realize he's hacking a virtual machine, and it's normally mounted on /proc, 
if used.

> Assuming that the next patch was "hppfs: fix symlink error path",
Yes.
> you've still left BS in there -
BullShit? Thanks for improving my acronym dictionary!
> >  	proc_file = dentry_open(dget(proc_dentry), NULL, O_RDONLY);

> is obviously wrong; at the very least you need vfsmount in there.
And beyond that what? I cannot even think what's the rest *. And "obvious" 
doesn't hold with me.

I'm _not_ a VFS hacker, I don't go beyond Documentation/filesystems/vfs.txt, 
so I'd better leave fixing that to you.

At least what you don't mention. I'll fix vfsmount in these days (if you want 
to do it yourself, I've put together needed info below).

I had to check dentry_open prototype to realize you're referring to the NULL 
there and not to dget.

And the dentries you see are all descendants of the root one, taken in 
hppfs_fill_super() from 

       err = init_inode(root_inode, proc_sb->s_root);

I guess the current hack could be replaced with reading 
fs/proc/inode.c:proc_mnt... I wouldn't pass proc_mnt directly because we 
don't know we took _that_ mount inside hppfs_fill_super(), but I like 
replacing

list_entry(get_fs_type("proc")->fs_supers.next,...) 

with proc_mnt->mnt_sb (assuming it's always filled in - IIRC I already checked 
the initialization order).

* I've verified that there's no missing dput() in failure case as that's 
handled by dentry_open().
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com
