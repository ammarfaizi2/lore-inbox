Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316847AbSGHMMv>; Mon, 8 Jul 2002 08:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316851AbSGHMMu>; Mon, 8 Jul 2002 08:12:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61195 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316847AbSGHMMt>;
	Mon, 8 Jul 2002 08:12:49 -0400
Date: Mon, 8 Jul 2002 13:15:25 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Matthew Wilcox <willy@debian.org>, Dave Hansen <haveblue@us.ibm.com>,
       Oliver Neukum <oliver@neukum.name>,
       Thunder from the hill <thunder@ngforever.de>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020708131525.Q27706@parcelfarce.linux.theplanet.co.uk>
References: <20020708033409.P27706@parcelfarce.linux.theplanet.co.uk> <Pine.GSO.4.21.0207072255020.24900-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0207072255020.24900-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Jul 07, 2002 at 10:58:04PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 10:58:04PM -0400, Alexander Viro wrote:
> On Mon, 8 Jul 2002, Matthew Wilcox wrote:
> > one struct file per open(), yes.  however, fork() shares a struct file,
> > as does unix domain fd passing.  so we need protection between different
> > processes.  there's some pretty good reasons to want to use a semaphore
> > to protect the struct file (see fasync code.. bleugh).
> 
> ??? What exactly do you want to protect there?

andrea & i discussed this off-list a few days ago... see fs/fcntl.c

                case F_SETFL:
                        lock_kernel();
                        err = setfl(fd, filp, arg);
                        unlock_kernel();

setfl() does:

        if ((arg ^ filp->f_flags) & FASYNC) {
                if (filp->f_op && filp->f_op->fasync) {
                        error = filp->f_op->fasync(fd, filp, (arg & FASYNC) != 0);

and:

        if (arg & O_DIRECT) {
                down(&inode->i_sem);
                if (!filp->f_iobuf)
                        error = alloc_kiovec(1, &filp->f_iobuf);
                up(&inode->i_sem);

and finally:

        filp->f_flags = (arg & SETFL_MASK) | (filp->f_flags & ~SETFL_MASK);

i pointed out that if alloc_kiovec slept, the BKL provides no protection
against someone else doing a setfl at the same time, so we can get the
wrong number of fasync events sent.  Marcus Alanen pointed out that
fasync can also sleep, so we're at risk anyway.  i don't think that
abusing i_sem as andrea did is the Right Thing to do...

-- 
Revolutions do not require corporate support.
