Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbSKJSJ7>; Sun, 10 Nov 2002 13:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264988AbSKJSJ6>; Sun, 10 Nov 2002 13:09:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24393 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264986AbSKJSJ4>; Sun, 10 Nov 2002 13:09:56 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.33L2.0211091533260.10722-100000@dragon.pdx.osdl.net>
	<m1bs4ycer2.fsf@frodo.biederman.org>
	<1036938913.1009.8.camel@irongate.swansea.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Nov 2002 11:13:55 -0700
In-Reply-To: <1036938913.1009.8.camel@irongate.swansea.linux.org.uk>
Message-ID: <m1el9tb8d8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sun, 2002-11-10 at 02:58, Eric W. Biederman wrote:
> > > What I'm trying to say is that I think the new kernel must
> > > already be loaded when the panic happens.
> > > Is that what you describe later (below)?
> > 
> > Yes that was my meaning.   The new kernel must be preloaded.
> > And only started on panic.
> 
> Another question from the point of view of unifying things. What is
> wrong with
> 
> 	insmod kexec
> 		creates /dev/kexec (or kexecfs is you are Al Viro)
> 		hooks the reboot and panic final notifiers
> 	user copies file to /dev/kexec (which stuffs it into ram)
> 
> 	reboot
> 		kexec module handler jumps to the first page of the
> 		kexec data in a defined state assuming its PIC
> 
> 
> At which point we have clearly reduced kexec/oops reporter/lkcd/netdump 
> to a single common tiny interface.

It would take a special hook that ran after the notifiers, and
device_shutdown.  At least in the normal case running what shutdown
code we can is fairly important.  And hooking the notifier lists
would not give a guarantee of going last.

There is a long ways to go in working with device drivers to even get
the easy kexec case working stably, in non-special circumstances.

The kernel gets there great but it does not cope well with the APICs
activated and the legacy pic disabled during bootup.  

The additional device shutdown code is useful even in the normal
reboot path.  Most BIOS's don't care but it should fix a few problems
with BIOS that are not as paranoid about the state of the system as
they should be when reboot is called.  Little things like always
shutting down on the bootstrap cpu are on my todo list.

Eric

