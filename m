Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317325AbSGDDue>; Wed, 3 Jul 2002 23:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317327AbSGDDud>; Wed, 3 Jul 2002 23:50:33 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:18669 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317325AbSGDDuc>;
	Wed, 3 Jul 2002 23:50:32 -0400
Date: Thu, 4 Jul 2002 13:54:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Keith Owens <kaos@ocs.com.au>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
Message-ID: <20020704035403.GN1873@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Brian Gerst <bgerst@didntduck.org>, Keith Owens <kaos@ocs.com.au>,
	Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <10962.1025745528@kao2.melbourne.sgi.com> <3D23B21E.9030102@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D23B21E.9030102@didntduck.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2002 at 10:25:34PM -0400, Brian Gerst wrote:
> 		 Leaders
> PrivateKeith Owens wrote:
> >On Wed, 3 Jul 2002 05:48:09 +0200, 
> >Pavel Machek <pavel@ucw.cz> wrote:
> >
> >>Okay. So we want modules and want them unload. And we want it bugfree.
> >>
> >>So... then its okay if module unload is *slow*, right?
> >>
> >>I believe you can just freeze_processes(), unload module [now its
> >>safe, you *know* noone is using that module, because all processes are
> >>in your refrigerator], thaw_processes().
> >
> >
> >The devil is in the details.
> >
> >You must not freeze the process doing rmmod, that way lies deadlock.
> >
> >Modules can run their own kernel threads.  When the module shuts down
> >it terminates the threads but we must wait until the process entries
> >for the threads have been reaped.  If you are not careful, the zombie
> >clean up code can refer to the module that no longer exists.  You must
> >not freeze any threads that belong to the module.
> >
> >You must not freeze any process that has entered the module but not yet
> >incremented the use count, nor any process that has decremented the use
> >count but not yet left the module.  Simply looking at the EIP after
> >freeze is not enough.  Module code with a use count of 0 is allowed to
> >call any function as long as that function does not sleep.  That rule
> >used to be safe, but adding preempt has turned that safe rule into a
> >race, freezing processes has the same effect as preempt.
> >
> >Using freeze or any other quiesce style operation requires that the
> >module clean up be split into two parts.  The logic must be :-
> >
> >Check usecount == 0
> >
> >Call module unregister routine.  Unlike the existing clean up code,
> >this only removes externally visible interfaces, it does not delete
> >module structures.
> >
> ><handwaving>
> >  Outside the module, do whatever it takes to ensure that nothing is
> >  executing any module code, including threads, command callbacks etc.
> ></handwaving>
> >
> >Check the usecount again.
> >
> >If usecount is non-zero then some other code entered the module after
> >checking the usecount the first time and before unregister completed.
> >Either mark the module for delayed delete or reactivate the module by
> >calling the module's register routine.
> >
> >If usecount is still 0 after the handwaving, then it is safe to call
> >the final module clean up routine to destroy its structures, release
> >hardware etc.  Then (and only then) is it safe to free the module.
> >
> >
> >Rusty and I agree that if (and it's a big if) we want to support module
> >unloading safely then this is the only sane way to do it.  It requires
> >some moderately complex handwaving code, changes to every module (split
> >init and cleanup in two) and a new version of modutils in order to do
> >this method.  Because of the high cost, Rusty is exploring other
> >options before diving into a kernel wide change.
> 
> Why not treat a module just like any other structure?  Obtain a 
> reference to it _before_ using it.  I propose this change:

Because in general you don't know you're going to use a module before
you use it.  Using a module is (necessarily) not a narrow well-defined
interface.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson
