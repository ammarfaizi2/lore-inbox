Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268369AbRGXRLw>; Tue, 24 Jul 2001 13:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268374AbRGXRLn>; Tue, 24 Jul 2001 13:11:43 -0400
Received: from smtp-rt-4.wanadoo.fr ([193.252.19.156]:19889 "EHLO
	areca.wanadoo.fr") by vger.kernel.org with ESMTP id <S268370AbRGXRL0>;
	Tue, 24 Jul 2001 13:11:26 -0400
Message-ID: <3B5DACDA.69D0B81A@wanadoo.fr>
Date: Tue, 24 Jul 2001 19:14:02 +0200
From: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>
Organization: CoolSite
X-Mailer: Mozilla 4.74 [fr] (X11; U; Linux 2.4.4-sb i686)
X-Accept-Language: French, fr, en
MIME-Version: 1.0
To: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
CC: linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
        martizab@libertsurf.fr, rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control
In-Reply-To: <3B5C91DA.3C8073AC@wanadoo.fr> <20010724090704.A27771@pimlott.ne.mediaone.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Andrew Pimlott a écrit :
> 
> On Mon, Jul 23, 2001 at 11:06:34PM +0200, Jerome de Vivie wrote:
> > >From CVS to ClearCase, i haven't seen any easy tool. I feel a real
> > need to handle SCM simply.
> 
> I think your approach is too simple.  ClearCase is a monster, but at
> the core is conceptually sound (assuming the goal is file-based
> control, not change-set-based; Rational has tried to layer a
> change-set-based product on top of ClearCase, and I hear it is a
> mess).  By comparison you are missing some important things, some of
> which I will try to point out.
> 
> > Here's the main features:
> >
> > -no check-out/check-in
> 
> (You do have check-in, you just call it something else.)

Yes: co is now a "copy on write", so it's automatic.

> 
> > When a C-file is created,
> 
> Presumably this is an explicit operation?  What system call?

Yes it's explicit. I know though about a userspace solution but
i would have added a "O_CREATE like" flags on open, or use ioctl.


> per-user?  So how do I let another developer look at what I'm
> working on?  In ClearCase, it's one private version per-view, which
> is much more flexible.

No.

> Does the private copy know which label it was branched from?  This
> is essential.

Yes.

> 
> > When a developper has reach a step and, would like to share his work;
> > he creates a new label.
> 
> Ie, check-in by a different name.  What system call?

Yes. Probably with a ioctl (but now with a user command !)

> 
> > This label will be put on every private copy
> > listed in the UFL and, the UFL is zeroed.
> 
> If I have to check in all files at once, it is even more important
> that I be able to have multiple "views".  What if, in the middle of
> a big change, I make a small fix that I want to check in
> independently?

It's impossible. If you want to go back, you have to put a label on 
each step you want and, set the $CONFIGURATION to this label.

> 
> > First, if the C-file is into the UFL, we have a private copy to
> > select. Else, we choose the version labeled by "$CONFIGURATION". If
> > such version does not exist, we search the version marked by the
> > nearest "parent" label (at least, label "init" match).
> 
> You just threw away the most useful feature of filesystem
> integration: comparing different versions.  How do I do this if
> everything is keyed off $CONFIGURATION?

With 2 process and shared memory, it should be possible but i haven't
though deeper.

> 
> I really don't see what you've gained over CVS.  (Once you add in
> all the little things you didn't mention: setting up the filesystem,
> adding files to version control, etc, I don't think you can argue
> that your system is simpler.)

A developper has a minimum operation to do:
-set his configuration
-commit his work

That's all ! No branch, no config-spec, no view server, no vob server,
no registery server, no ci, no co, ...


> 
> Also, what if you create a label, but forget to update
> $CONFIGURATION, and start to make more changes?  You can just say
> "stupid user", but the fact that this failure mode exists is a wart.

1. You stop from this new "branch". 
2. You commit your work with a new label.
3. You set $CONFIGURATION to the good label and merge the previous 
work into.


> 
> How will the existing merge tool work, if a single process can only
> see one $CONFIGURATION?

Same as for diff (...but now, obolete)

> 
> Here's my conclusion:  The overall semantics of a version control
> system are non-trivial and should be kept out of the kernel.  The
> real win with kernel integration is transparent, flexible, read-only
> access to versions.  Your scheme puts unnecessary stuff in the
> kernel, without getting the most important thing right.
> 
> (The only other potential win I see with kernel integration is
> check-out-on-write, but that doesn't sound like a big deal to me.)

Copy-on-write was the first new idea. Using the same system 
(labelization) to identify both individual version and configuration 
is also a neat idea. The last one is "hacking the nfsd" (thx Rik !)
I'm sure that we can handle SCM differently.

regards,

j.

-- 
Jerome de Vivie 	jerome . de - vivie @ wanadoo . fr
