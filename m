Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267517AbRGXNRq>; Tue, 24 Jul 2001 09:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267532AbRGXNRh>; Tue, 24 Jul 2001 09:17:37 -0400
Received: from chmls05.mediaone.net ([24.147.1.143]:6354 "EHLO
	chmls05.mediaone.net") by vger.kernel.org with ESMTP
	id <S267517AbRGXNR3>; Tue, 24 Jul 2001 09:17:29 -0400
From: andrew@pimlott.ne.mediaone.net (Andrew Pimlott)
Date: Tue, 24 Jul 2001 09:07:04 -0400
To: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
        martizab@libertsurf.fr, rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control
Message-ID: <20010724090704.A27771@pimlott.ne.mediaone.net>
Mail-Followup-To: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>,
	linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
	martizab@libertsurf.fr, rusty@rustcorp.com.au
In-Reply-To: <3B5C91DA.3C8073AC@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3B5C91DA.3C8073AC@wanadoo.fr>; from jerome.de-vivie@wanadoo.fr on Mon, Jul 23, 2001 at 11:06:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 11:06:34PM +0200, Jerome de Vivie wrote:
> >From CVS to ClearCase, i haven't seen any easy tool. I feel a real 
> need to handle SCM simply.

I think your approach is too simple.  ClearCase is a monster, but at
the core is conceptually sound (assuming the goal is file-based
control, not change-set-based; Rational has tried to layer a
change-set-based product on top of ClearCase, and I hear it is a
mess).  By comparison you are missing some important things, some of
which I will try to point out.

> Here's the main features:
> 
> -no check-out/check-in 

(You do have check-in, you just call it something else.)

> When a C-file is created,

Presumably this is an explicit operation?  What system call?

> the label "init" is put onto.  The first
> write on a C-file create a private copy for the user who run the
> process. This C-file is added to a "User File List" (UFL). This
> private copy is now selected by the FS in place of version "init". 
> Each user can start his own private copy by writting into a C-file.

per-user?  So how do I let another developer look at what I'm
working on?  In ClearCase, it's one private version per-view, which
is much more flexible.

Does the private copy know which label it was branched from?  This
is essential.

> When a developper has reach a step and, would like to share his work;
> he creates a new label.

Ie, check-in by a different name.  What system call?

> This label will be put on every private copy
> listed in the UFL and, the UFL is zeroed.

If I have to check in all files at once, it is even more important
that I be able to have multiple "views".  What if, in the middle of
a big change, I make a small fix that I want to check in
independently?

> First, if the C-file is into the UFL, we have a private copy to
> select. Else, we choose the version labeled by "$CONFIGURATION". If
> such version does not exist, we search the version marked by the
> nearest "parent" label (at least, label "init" match).

You just threw away the most useful feature of filesystem
integration: comparing different versions.  How do I do this if
everything is keyed off $CONFIGURATION?

I really don't see what you've gained over CVS.  (Once you add in
all the little things you didn't mention: setting up the filesystem,
adding files to version control, etc, I don't think you can argue
that your system is simpler.)

Also, what if you create a label, but forget to update
$CONFIGURATION, and start to make more changes?  You can just say
"stupid user", but the fact that this failure mode exists is a wart.

> In userland, we need:
> -a "mklabel" tool.
> -use a "CONFIGURATION" environment variable.
> -use existing tool for "merge" operations.

- setup filesystem
- add file to version control
- list labels, private files (what system calls?)

How will the existing merge tool work, if a single process can only
see one $CONFIGURATION?

Here's my conclusion:  The overall semantics of a version control
system are non-trivial and should be kept out of the kernel.  The
real win with kernel integration is transparent, flexible, read-only
access to versions.  Your scheme puts unnecessary stuff in the
kernel, without getting the most important thing right.

(The only other potential win I see with kernel integration is
check-out-on-write, but that doesn't sound like a big deal to me.)

Andrew
