Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316746AbSGHCbb>; Sun, 7 Jul 2002 22:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316747AbSGHCbb>; Sun, 7 Jul 2002 22:31:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23300 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316746AbSGHCba>;
	Sun, 7 Jul 2002 22:31:30 -0400
Date: Mon, 8 Jul 2002 03:34:09 +0100
From: Matthew Wilcox <willy@debian.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Oliver Neukum <oliver@neukum.name>,
       Thunder from the hill <thunder@ngforever.de>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020708033409.P27706@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0207071702120.10105-100000@hawkeye.luckynet.adm> <200207080131.06119.oliver@neukum.name> <3D28D291.3020706@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D28D291.3020706@us.ibm.com>; from haveblue@us.ibm.com on Sun, Jul 07, 2002 at 04:45:21PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 04:45:21PM -0700, Dave Hansen wrote:
> Don't forget that the BKL is released on sleep.  It is OK to hold it
> over a schedule()able operation.  If I remember right, there is no 
> real protection needed for the file->private_data either because there 
> is 1 and only 1 struct file per open, and the data is not shared among 
> struct files.

one struct file per open(), yes.  however, fork() shares a struct file,
as does unix domain fd passing.  so we need protection between different
processes.  there's some pretty good reasons to want to use a semaphore
to protect the struct file (see fasync code.. bleugh).

however, our semaphores currently suck.  they attempt to acquire the sem
immediately and if they fail go straight to sleep.  schimmel (i think..)
suggests spinning for a certain number of iterations before sleeping.
the great thing is, it's all out of line slowpath code so the additional
size shouldn't matter.  obviously this is SMP-only, and it does require
someone to do it who can measure the difference (and figure out how may
iterations to spin for before sleeping).

i was wondering if this might be a project you'd like to take on which
would upset far fewer people and perhaps yield greater advantage.

-- 
Revolutions do not require corporate support.
