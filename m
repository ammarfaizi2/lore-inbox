Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268142AbUJJGYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268142AbUJJGYV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 02:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268145AbUJJGYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 02:24:21 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:26522 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268142AbUJJGYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 02:24:13 -0400
Date: Sun, 10 Oct 2004 08:24:11 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, jmorris@redhat.com, serue@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] lsm: add bsdjail module
Message-ID: <20041010062411.GA17254@MAIL.13thfloor.at>
Mail-Followup-To: Chris Wright <chrisw@osdl.org>,
	Andrew Morton <akpm@osdl.org>, jmorris@redhat.com, serue@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <20041007040859.GA17774@escher.cs.wm.edu> <Xine.LNX.4.44.0410070216130.2191-100000@thoron.boston.redhat.com> <20041006232208.505ccacd.akpm@osdl.org> <20041007090645.U2357@build.pdx.osdl.net> <20041007114039.6e861b2b.akpm@osdl.org> <20041007115240.C2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007115240.C2357@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 11:52:40AM -0700, Chris Wright wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> > Chris Wright <chrisw@osdl.org> wrote:
> > > * Andrew Morton (akpm@osdl.org) wrote:
> > > Which feature are you concerned over, the additional hook or the
> > > new module?
> > 
> > I am concerned about the presence of new code - simple as that.
> 
> Understood.
> 
> > We need to be able to demonstrate that the new code is sufficiently useful
> > to a sufficiently large number of people as to warrant the cost of
> > maintaining it in the tree for the rest of eternity.
> 
> That's fine.  Serge, can you enlighten us with an idea of the users of
> this code?
> 
> > >  The module is a no-op for anybody who doesn't want it.
> > 
> > It still needs to be maintained.
> 
> Absolutely.
> 
> > > I can't vouch for the number of users of this module although I've seen
> > > some positive feedback from users.  One nice bit is that it goes a way
> > > towards helping vserver which does have quite a few users.
> > 
> > Tell us more.
> 
> One portion of the vserver project (that which has to do with security
> and isolation) could be largely covered by this work.  And vserver
> is an active project with many users AFAICT.  The vserver maintainer
> has expressed some interest in this as well.  The other portion of the
> project, which does the resource limiting has a decent chance of working
> well with something like CKRM or similar.

well, as 'the vserver project' probably means the
'linux-vserver project', I would like to point out 
why and where the bsdjail LSM, in it's current form
is flawed from the linux-vserver point of view ...

Serge, don't get me wrong, this is neither against 
you nor against the bsdjail LSM, which I consider
an interesting approach, and I'm still confident 
that we find some way of cooperation ...

(copied the jail struct here to comment it)

| struct jail_struct {
| 	struct kref		kref;
|
|	/* these are set on writes to /proc/<pid>/attr/exec */
|	char *root_pathname; /* char * containing path to use as jail / */

linux-vserver uses namespaces to create the vservers, 
only the legacy method uses a simple chroot() to
setup the vserver environment ...

| 	char *ip4_addr_name;  /* char * containing ip4 addr to use for jail */
| 	char *ip6_addr_name;  /* char * containing ip6 addr to use for jail */

linux-vserver is slowly moving from chbind (which 
restricts a process and it's children to a set of 
IPs to an iptable (marking) based approach, which 
is much more flexible

| 	/* these are set when a jail becomes active */
| 	__u32 addr4;		/* internal form of ip4_addr_name */
| 	struct in6_addr addr6;  /* internal form of ip6_addr_name */

up to 16 addresses are currently allowed in this set
in the future the limit will go away (network code is
actually the oldest piece) by using 'markings'
(network is virtualized to allow binding to 0.0.0.0)

| 	struct dentry *dentry;  /* dentry of fs root */
| 	struct vfsmount *mnt;	/* vfsmnt of fs root */
 
| 	/* Resource limits.  0 = no limit */
| 	int max_nrtask; 	/* maximum number of tasks within this jail. */
| 	int cur_nrtask; 	/* current number of tasks within this jail. */

linux-vserver already has a nice and usable resource
management system for most resources, supporting
much more limits than those ...

| 	long maxtimeslice;	/* max timeslice in ms for procs in this jail */
|	long nice;		/* nice level for processes in this jail */
| 	long max_data, max_memlock;  /* equivalent to RLIMIT_{DATA,MEMLOCK} */

the resource limitations should not be part of a 
security module, and the scheduler slice would be
a step in the wrong redirection, as linux-vserver
already uses token buckets to control the scheduler

| 	char jail_flags;
|};

also many distributions (and distribution hosting
is _the_ main application area for linux-vserver)
require the 'jail' to be as similar as possible
to a real host (like a separate init process, or
the ability to renice services) so some of the
'features' of that LSM are contra productive here
not to mention that linux-vserver's security is
mainly based on linux capabilities which are not
handled by this LSM at all ...

aside from that, without the notion of a security
context, which can be controlled and entered from
outside (the host) the 'jail' can not be used for
typical hosting purposes 

> > >  This module
> > > really demonstrates one of the points of LSM...to support multiple
> > > security models.
> > 
> > Sure.  But that doesn't mean that those modules have to live at kernel.org
> > rather than, say, at bsdjail.sourceforge.net.
> 
> I agree, some userbase does wonders to justify mainlining the code.

I'm pretty confident the fact that a big company
seems interested in this LSM will help with the 
integration into mainline, but I can not say that 
'linux-vserver' users or developers will have any 
immediate benefit from it's inclusion ... why?

 - the linux-vserver user would have to apply an
   additional patch anyway (and install special
   tools to control the vservers)

 - the LSM does not provide what linux-vserver
   requires and would need heavy modification
   (missing context, namespaces, network, most
   virtualization, resource isolation)

 - once CKRM will be able to replace the resource
   management currently present in linux-vserver,
   it (CKRM) will collide with the resource stuff
   done in this LSM

so while I'm fine with the idea to move a part of
linux-vserver to the LSM framework (once the LSM
stackering issues are resolved), this part would
not be usable without a decent part of kernel
modifications to do the virtualization and the
resource isolation

of course if there _is_ interest to include 
linux-vserver like features into mainline, then 
there should be some commitment to do it properly 
and this includes not limiting it to a security
module, where it requires much more to be useful
to anyone ...

finally I have no problem to maintain the 'vserver'
patches outside the kernel tree, as they are 
probably only of limited interest for the typical
linux desktop user ...

best,
Herbert 
(linux-vserver maintainer)

PS: for details see the linux-vserver paper at
http://www.linux-vserver.org/index.php?page=Linux-VServer-Paper

> thanks,
> -chris
> -- 
> Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
