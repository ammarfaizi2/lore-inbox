Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbVLPKvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbVLPKvS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 05:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVLPKvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 05:51:18 -0500
Received: from mail.shareable.org ([81.29.64.88]:36012 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1750915AbVLPKvR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 05:51:17 -0500
Date: Fri, 16 Dec 2005 10:50:48 +0000
From: Jamie Lokier <jamie@shareable.org>
To: JANAK DESAI <janak@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, viro@ftp.linux.org.uk,
       chrisw@osdl.org, dwmw2@infradead.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/9] unshare system call: system call handler function
Message-ID: <20051216105048.GA32305@mail.shareable.org>
References: <1134513959.11972.167.camel@hobbs.atlanta.ibm.com> <m1k6e687e2.fsf@ebiederm.dsl.xmission.com> <43A1D435.5060602@us.ibm.com> <m1d5jy83nr.fsf@ebiederm.dsl.xmission.com> <43A24362.6000602@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A24362.6000602@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JANAK DESAI wrote:
> >I follow but I am very disturbed.
> >
> >You are leaving CLONE_NEWNS to mean you want a new namespace.
> >
> >For clone CLONE_FS unset means generate an unshared fs_struct
> >         CLONE_FS set   means share the fs_struct with the parent
> >
> >But for unshare CLONE_FS unset means share the fs_struct with others
> >           and CLONE_FS set   means generate an unshared fs_struct
> >
> >The meaning of CLONE_FS between the two calls in now flipped,
> >but CLONE_NEWNS is not.  Please let's not implement it this way.
> >
> > 
> CLONE_FS unset for unshare doesn't mean that share the fs_struct with
> others. It just means that you leave the fs_struct alone (which may or
> maynot be shared). I agree that it is confusing, but I am having difficulty
> in seeing this reversal of flag meaning. clone creates a second task and
> allows you to pick what you want to share with the parent. unshare allows
> you to pick what you don't want to share anymore. The "what" in both
> cases can be same and still you can end up with a task with "share" state
> for a perticular structure. 

> For example, if we #define  FS   CLONE_FS,
> then clone(FS) will imply that you want to share fs_struct but unshare(FS)
> will imply that we want to unshare fs_struct.

Right.

But clone(CLONE_NEWNS) and unshare(CLONE_NEWNS) _don't_ behave like
that: clone(CLONE_NEWNS) unshares ns, and unshare(CLONE_NEWNFS) _also_
unshares ns.

That is the inconsistency: some flags to clone() mean "keep sharing
this thing", and some flags mean "make a new instance of this thing".
It's not your fault that clone() has that inconsistency.  It's because
clone() needs to treat a value of 0 for any bit as the historically
default behaviour.

Like clone(), unshare() will have to change from year to year, as new
flags are added.  It would be good if the default behaviour of 0 bits
to unshare() also did the right thing, so that programs compiled in
2006 still function as expected in 2010.  Hmm, this
forward-compatibility does not look pretty.

-- Jamie
