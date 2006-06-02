Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWFBOxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWFBOxP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 10:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWFBOxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 10:53:14 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:63374 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751419AbWFBOxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 10:53:14 -0400
Date: Fri, 2 Jun 2006 10:53:08 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       akiyama.nobuyuk@jp.fujitsu.com, Preben.Trarup@ericsson.com
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
Message-ID: <20060602145308.GA29610@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060530183359.a8d5d736.akiyama.nobuyuk@jp.fujitsu.com> <20060530145658.GC6536@in.ibm.com> <20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com> <20060531154322.GA8475@in.ibm.com> <20060601213730.dc9f1ec4.akiyama.nobuyuk@jp.fujitsu.com> <20060601151605.GA7380@in.ibm.com> <20060602141301.cdecf0e1.akiyama.nobuyuk@jp.fujitsu.com> <44800E1A.1080306@ericsson.com> <m1fyin6agv.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1fyin6agv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 05:52:32AM -0600, Eric W. Biederman wrote:
> Preben Traerup <Preben.Trarup@ericsson.com> writes:
> 
> > Since I'm one of the people who very much would like best of both worlds,
> > I do belive Vivek Goyal's concern about the reliability of kdump must be
> > adressed properly.
> >
> > I do belive the crash notifier should at least be a list of its own.
> >   Attaching element to the list proves your are kdump aware - in theory
> >
> > However:
> >
> > Conceptually I do not like the princip of implementing crash notifier
> > as a list simply because for all (our) practical usage there will only
> > be one element attached to the list anyway.
> >
> > And as I belive crash notifiers only will be used by a very limited
> > number of users, I suggested in another mail that a simple
> >
> > if (function pointer)
> >    call functon
> >
> > approach to be used for this special case to keep things very simple.
> 
> I am completely against crash notifiers.  The code crash_kexec switches to
> is what is notified and it can do whatever it likes.  The premise is
> that the kernel does not work.  Therefore  we cannot safely notify
> kernel code.  We do the very minimal to get out of the kernel,
> and it is my opinion we still do to much.
> 
> The crash_kexec entry point is not about taking crash dumps.  It is
> about implementing policy when the kernel panics.  Generally the
> policy we want is a crash dump but the mechanism is general purpose
> and not limited to that.

Does that mean that we can implement only one policy which crash_kexec()
can execute. In this case clash seems to be that we want multiple policies
to co-exist. Like, a user wants to generate a notification for the 
remote node so that remote node takes over and then also take crash dump
to diagnose the source of problem on failing node.  


> 
> You can put anything you want for crash_kexec to execute.
> 

How do I ensure co-existence of multiple policies?

> If the problem is strictly limited to hardware failure and software
> can cope with that then don't panic the kernel and execute an orderly
> transition.
> 
> If software cannot cope, and must panic the kernel it clearly cannot
> do something sensible.

That's true. Anything which runs after panic() is running in an unreliable
environment. But I guess everybody understands that and all the code which
runs after panic(), is not guranteed to execute successfuly. Otherwise there
is no point in keeping panic_notifier_list around.

So the concern here is that how do we manage multiple policies which should
execute after a crash/panic?

Thanks
Vivek
