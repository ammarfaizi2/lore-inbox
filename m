Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266958AbSKSP6o>; Tue, 19 Nov 2002 10:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbSKSP6o>; Tue, 19 Nov 2002 10:58:44 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:14065 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266763AbSKSP6l>; Tue, 19 Nov 2002 10:58:41 -0500
Date: Tue, 19 Nov 2002 11:06:22 -0500
From: Doug Ledford <dledford@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Alexander Viro <viro@math.psu.edu>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Why /dev/sdc1 doesn't show up...
Message-ID: <20021119160622.GA8738@redhat.com>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Alexander Viro <viro@math.psu.edu>,
	Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
References: <20021119055636.94C182C088@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119055636.94C182C088@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 04:52:25PM +1100, Rusty Russell wrote:
> > right).  Or you can run a notifier on "enlivening" a module: I'd hoped
> > to avoid that.
> 
> Actually, after some thought, this seems to clearly be the Right
> Thing, because it solves another existing race.  Consider a module
> which does:
> 
> 	if (!register_foo(&my_foo))
> 		goto cleanup;
> 	if (!create_proc_entry(&my_entry))
> 		goto cleanup_foo;

There is *NO* module that does this right now and can be considered even 
close to working.  The rule always has been "register yourself when you 
are ready for use".  You're trying to add this new "You can fail after 
registering yourself" semantic for brain dead coders that can't write an 
init function to save thier ass.  My position is that in doing so, you 
fuck all of us that do write a reasonable init sequence and handle our 
error conditions.  Plus, since this is a changes in semantics, you have 
possibly 50 or 100 modules that rely on the old behaviour, and maybe a few 
that are broken in regards to registration ordering.  I think you are 
trying to fix the wrong group of modules here.

So, to me, the answer is clear.  The rule is hard and fast, you don't hand 
out your function pointers to other modules or the core kernel until you 
are ready for them to be used.  Don't muck with the module loader to solve 
the problem, fix the maybe 4 or 5 modules that might violate this rule.

> If register_foo() calls /sbin/hotplug, the module can still fail to
> load and /sbin/hotplug is called for something that doesn't exist.

Which is just totally fucking stupid on the part of any module author that 
would do things in that order.  You're trying to write a module loader 
that makes it safe for a module author to be a total moron.  Don't.  Let 
the morons go code somewhere else.  For the kernel, make them follow a few 
sensible rules instead of enforcing moron proof crap on everyone else.

> With the new module loader, you can also have /sbin/hotplug try to
> access the module before it's gone live, which will fail to prevent
> the "using before we know module won't fail init" race.
> 
> Now, if you run /sbin/hotplug out of a notifier which is fired when
> the module actually goes live, this problem vanishes.  It also means
> we can block module unload until /sbin/hotplug is run.
> 
> The part that makes this feel like the Right Thing is that adding to
> init/main.c:
> 
> 	/* THIS_MODULE == NULL */
> 	notifier_call_chain(&module_notifiers, MODULE_LIVE, NULL);
> 
> means that /sbin/hotplug is called for everything which was registered
> at boot.  (We may not want to do this, but in general the symmetry
> seems really nice).
> 
> [ Note: the logic for /sbin/hotplug applies to any similar "publicity"
>   function which promises that something now exists. ]
> 
> Al, thoughts?

I actually like the idea of having an automatic go live function that we 
can trigger, but I still don't think that justifies blocking a module from 
entering itself during init.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
