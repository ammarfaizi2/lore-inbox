Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261694AbSJAQwU>; Tue, 1 Oct 2002 12:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262194AbSJAQuR>; Tue, 1 Oct 2002 12:50:17 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:11535 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262183AbSJAQtf>; Tue, 1 Oct 2002 12:49:35 -0400
Date: Tue, 1 Oct 2002 17:55:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20021001175500.A26635@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20020927003210.A2476@sgi.com> <Pine.GSO.4.33.0209270743170.22771-100000@raven> <20020927175510.B32207@infradead.org> <200209271809.g8RI92e6002126@turing-police.cc.vt.edu> <20020927191943.A2204@infradead.org> <200209271854.g8RIsPe6002510@turing-police.cc.vt.edu> <20020927195919.A4635@infradead.org> <200209301419.g8UEJI6E001699@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209301419.g8UEJI6E001699@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Mon, Sep 30, 2002 at 10:19:18AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 10:19:18AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 27 Sep 2002 19:59:19 BST, Christoph Hellwig said:
> 
> > insmod doesn't require modules to be in /lib/modules.
> 
> This would probably be closed by this code in sys_create_module():
> 
>         /* check that we have permission to do this */
>         error = security_ops->module_ops->create_module(name, size);
>         if (error)
>                 goto err1;
> 

It wouldn't.  sys_create_module doesn't get the absolute path of the module passed.

> Similarly, there are other hooks that will stop renaming of the interface (I
> have to admit I haven't had enough caffeine to verify whether doing a /bin/mv
> to rename an interface will change the name that's presented to the iptables
> rulesets), or did you have other "rename" methods in mind?

For gods sake, what interface do you want to /bin/mv?  network device don't have
associated special files in Linux (or BSD).  I'm talking about SIOCSIFNAME.

> However, you're missing the point - I was using that as *AN EXAMPLE* of "you
> might want to check what parameters are being passed".  Are you prepared to
> make the same sort of analysis for *EVERY* parameter of *every* module, and
> every combination thereof (including interacting parameters of different
> modules)?

If I wanted to implement a trusted system: yes.  I you wanted and paid me
enough for it: also yes.  And that's exactly my point.  If you want a
trusted system you're not done by adding a few hooks in places that look
strategic, you have to a proper audit of _all_ code in your project.

Let me repeat _ALL_ code.  Yes, you have to understand WTF is going on,
and that's where LSM fail miserably.

> In order to assert that the hook to check parameters in module loading is
> useless, you'd have to verify that there exist *NO* modules that can have their
> security status changed by changing the parameters.

Noooh!  You got something very wrong.  You (or rather the LSM people) want to
add a new feature, and they have to prove it useful.  An as long as there is no
standard on what a specific string in a module option means for the kernel
in the end such a check is pretty damn useless.

> And even more importantly,
> you'd have to make this a permanent restriction on module parameters,
> which puts the onus on "getting it right" on the module author, rather than
> on the LSM author who's in a better position to know what is/isn't acceptable
> for his module.

How does the lsm author know what the option x=y means for my module?  In my
module a it means print lots of nice windowish nagscreen, but in my friend
Paul's module (who works for the German BND) it means scribble all over my
disk because only someone who has stolen the notebook might be stupid
enough to use such a silly option.

See what I mean?


> And quite a bit of thought *did* go into it - a *LOT* of those hooks got added
> along the way precisely *because* the writers of a module found that they were
> trying to enforce a policy, and found it could be backdoored by means like
> module parameters.

>From my reading of the LSM lists a hgook usually got added because author A
of the unaudited module B though that it might help him in imlpementing what
he and only he thinks his module should do if it worked properly.

