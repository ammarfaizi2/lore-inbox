Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVIDIUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVIDIUF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 04:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbVIDIUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 04:20:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42171 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750968AbVIDIUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 04:20:03 -0400
Date: Sun, 4 Sep 2005 01:18:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: phillips@istop.com, linux-cluster@redhat.com, wim.coekaerts@oracle.com,
       linux-fsdevel@vger.kernel.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-Id: <20050904011805.68df8dde.akpm@osdl.org>
In-Reply-To: <20050904080102.GY8684@ca-server1.us.oracle.com>
References: <20050901104620.GA22482@redhat.com>
	<200509040022.37102.phillips@istop.com>
	<20050903214653.1b8a8cb7.akpm@osdl.org>
	<200509040240.08467.phillips@istop.com>
	<20050904002828.3d26f64c.akpm@osdl.org>
	<20050904080102.GY8684@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> On Sun, Sep 04, 2005 at 12:28:28AM -0700, Andrew Morton wrote:
> > If there is already a richer interface into all this code (such as a
> > syscall one) and it's feasible to migrate the open() tricksies to that API
> > in the future if it all comes unstuck then OK.
> > That's why I asked (thus far unsuccessfully):
> 
> 	I personally was under the impression that "syscalls are not
> to be added".

We add syscalls all the time.  Whichever user<->kernel API is considered to
be most appropriate, use it.

>  I'm also wary of the effort required to hook into process
> exit.

I'm not questioning the use of a filesystem.  I'm questioning this
overloading of normal filesystem system calls.  For example (and this is
just an example!  there's also mknod, mkdir, O_RDWR, O_EXCL...) it would be
more usual to do

	fd = open("/sys/whatever", ...);
	err = sys_dlm_trylock(fd);

I guess your current implementation prevents /sys/whatever from ever
appearing if the trylock failed.  Dunno if that's valuable.

>  Not to mention all the lifetiming that has to be written again.
> 	On top of that, we lose our cute ability to shell script it.  We
> find this very useful in testing, and think others would in practice.
> 
> >    Are you saying that the posix-file lookalike interface provides
> >    access to part of the functionality, but there are other APIs which are
> >    used to access the rest of the functionality?  If so, what is that
> >    interface, and why cannot that interface offer access to 100% of the
> >    functionality, thus making the posix-file tricks unnecessary?
> 
> 	I thought I stated this in my other email.  We're not intending
> to extend dlmfs.

Famous last words ;)

>  It pretty much covers the simple DLM usage required of
> a simple interface.  The OCFS2 DLM does not provide any other
> functionality.
> 	If the OCFS2 DLM grew more functionality, or you consider the
> GFS2 DLM that already has it (and a less intuitive interface via sysfs
> IIRC), I would contend that dlmfs still has a place.  It's simple to use
> and understand, and it's usable from shell scripts and other simple
> code.

(wonders how to do O_NONBLOCK from a script)




I don't buy the general "fs is nice because we can script it" argument,
really.  You can just write a few simple applications which provide access
to the syscalls (or the fs!) and then write scripts around those.

Yes, you suddenly need to get a little tarball into users' hands and that's
a hassle.  And I sometimes think we let this hassle guide kernel interfaces
(mutters something about /sbin/hotplug), and that's sad.  
