Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030418AbWGZJO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbWGZJO3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 05:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbWGZJO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 05:14:29 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:41447 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030418AbWGZJO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 05:14:28 -0400
Date: Wed, 26 Jul 2006 11:13:57 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
cc: 7eggert@gmx.de, Joshua Hudson <joshudson@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what is necessary for directory hard links
In-Reply-To: <200607260100.k6Q10miJ007619@laptop13.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.58.0607260948370.2112@be1.lrz>
References: <200607260100.k6Q10miJ007619@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006, Horst H. von Brand wrote:
> Bodo Eggert <7eggert@elstempel.de> wrote:
> > Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
> > > Joshua Hudson <joshudson@gmail.com> wrote:

> > > [...]
> > > 
> > >> Maybe someday I'll work out a system by which much less is locked.
> > >> Conceptually, all that is requred to lock for the algorithm
> > >> to work is creating hard-links to directories and renaming directories
> > >> cross-directory.
> > > 
> > > Some 40 years of filesystem development without finding a solution to that
> > > conundrum would make that quite unlikely, but you are certainly welcome to
> > > try.
> 
> > There is a simple solution against loops: No directory may contain a
> > directory with a lower inode number.
> 
> This is a serious restriction...

That's why I relax it in the next paragraph, so you'll only have to deal 
with inode numbers iff you want to hardlink directories.

> > Off cause this would interfere with normal operations, so you'll allocate all
> > normal inodes above e.g. 0x800000 and don't test between those inodes.
> 
> And allow loops there? I don't see how that solves anything...

No. Don't allow dir-hardliks there, so you can't create loops so you can 
freely create them without risking loops.

> > If you want to hardlink, you'll use a different (privileged) mkdir call
> > that will allocate a choosen low inode number. This is also required for
> > the parents of the hardlinked directories.
> 
> Argh... even /more/ illogical restrictions!

If no (hardlink) directory may contain a lower inode directory, all 
parents need to have a low inode.


A legal tree would e.g. look like this:

1-+-100
  | +-10001
  | `-10002
  +-101
  | +-10101
  | +-10002
  | `-10102
  `-10101

In order to create a loop, you'd e.g. need to link 101 into 10002. You 
can't, because they are ordered.

Directories above 0x800000 aren't ordered except being greater than low 
inodes, so you can create normal directories anywhere you desire, but you
obviously can't hardlink them.

-- 
It's redundant! It's redundant! 
