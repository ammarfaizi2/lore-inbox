Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313444AbSDGTkn>; Sun, 7 Apr 2002 15:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313447AbSDGTkm>; Sun, 7 Apr 2002 15:40:42 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:39052 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S313444AbSDGTkl>; Sun, 7 Apr 2002 15:40:41 -0400
Date: Sun, 7 Apr 2002 15:40:33 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Two fixes for 2.4.19-pre5-ac3
Message-ID: <20020407194032.GA15051@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020407173343.GA18940@compsoc.man.ac.uk> <E16uIB6-0006TQ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 08:18:16PM +0100, Alan Cox wrote:
> > I'm a bit disappointed this has just gone in without any real discussion
> > on the usefulness of this for certain circumstances :(
> 
> How about "there are no correct users". Its basically impossible to patch
> the syscall table safely anyway. As Arjan pointed out there are races 
> against module unload that on SMP are basically incurable. Doing the
> right hooks makes the AFS code portable which is a big win.

What they do in the syscall is still questionable in my opinion. AFS
wants to have a process authentication group (PAG) associated with
processes. The syscall rewrites some fields in the task structure,
basically adds 'hidden' entries to the groups array. They should
probably use something like the task-ornaments patch (was that by Dave
Howells?), which is what I plan to use for Coda whenever they get merged
into the mainline.

Both Coda and AFS have semantically quite similar requirements for the
PAG indentifier, a generic solution is probably better than having
random modules hacking their stuff into the syscall table and task
structures, which is why I do not consider their solution the right one.

Either add getpag/newpag natively (good for yearly flamefests in
linux-kernel), or the more generic task-ornaments so I can make a
trivial module that adds /dev/pag, semantics could be as simple as
reading returns the current pag, and writing adds a new pag as a
task-ornament.

Then both Coda and AFS can use the common mechanism and we'll get things
like PAM support and PAG aware daemons more quickly and consistently.
Anything that currently relies on setuid/setgid would f.i. benefit from
this on Coda and AFS type filesystems, as we can tell the difference
between administrator, random hacker, mail delivery process, nameserver,
cron daemon even when they all have the uid 'root'.

Jan

