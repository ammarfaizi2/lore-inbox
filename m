Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262621AbSJVOJz>; Tue, 22 Oct 2002 10:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262636AbSJVOJz>; Tue, 22 Oct 2002 10:09:55 -0400
Received: from cs.columbia.edu ([128.59.16.20]:47601 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S262621AbSJVOJy>;
	Tue, 22 Oct 2002 10:09:54 -0400
Subject: Re: can chroot be made safe for non-root?
From: Shaya Potter <spotter@cs.columbia.edu>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021022072132.GN147946@niksula.cs.hut.fi>
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net>
	 <87n0pevq5r.fsf@ceramic.fifi.org>
	 <1035213732.27259.160.camel@irongate.swansea.linux.org.uk>
	 <20021022072132.GN147946@niksula.cs.hut.fi>
Content-Type: text/plain
Organization: 
Message-Id: <1035296135.1089.35.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2 (Preview Release)
Date: 22 Oct 2002 10:15:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 03:21, Ville Herva wrote:
> On Mon, Oct 21, 2002 at 04:22:12PM +0100, you [Alan Cox] wrote:
> > On Wed, 2002-10-16 at 07:44, Philippe Troin wrote:
> > > > Is there a reason besides standards compliance that chroot() does not
> > > > already change directory to the chroot'd directory for root processes?
> > > > Would it actually break existing apps if it did change the directory?
> > > 
> > > Probably not. Make that: change the directory to chroot'd directory if
> > > the current working directory is outside the chroot. That is, leave
> > > the cwd alone if it is already inside the chroot.
> > 
> > Last time it was tried real apps broke.
> > 
> > chroot is not jail chroot is not a sandbox. Do the job right (eg the
> > vroot work) and it'll get a lot further
> 
> vserver (http://www.solucorp.qc.ca/miscprj/s_context.hc) seems to work
> pretty decently. It's somewhat similar to bsd's jail.

from vserver patch

diff -rc2P linux-2.4.19/fs/namei.c linux-2.4.19ctx-14/fs/namei.c
*** linux-2.4.19/fs/namei.c     Tue Aug  6 15:02:24 2002
--- linux-2.4.19ctx-14/fs/namei.c       Sun Oct 13 23:58:55 2002
***************
*** 153,156 ****
--- 153,165 ----
        umode_t                 mode = inode->i_mode;
  
+       /*
+               A dir with permission bit all 0s is a dead zone for
+               process running in a vserver. By doing
+                       chmod 000 /vservers
+               you fix the "escape from chroot" bug.
+       */
+       if ((mode & 0777) == 0
+               && S_ISDIR(mode)
+               && current->s_context != 0) return -EACCES;
        if (mask & MAY_WRITE) {
                /*

I don't think that will work, especially as it seems vserver's dont
nest.

I described an algo (on this list a day or 2 ago) that should work for
fixing the fd problem (everything else seems to be root's power related,
not chroot related)

we add a new field to the task_struct, which is some linked list of
chroot points, normally null for non chrooted processes.

when we call chroot, we dont just change the fs_struct, we pre-append
the same data as a linked list node to the beg of the list (i.e. the
element in the task struct)

in follow_dotdot() instead of checking against the fs_struct, we
basically say
	if (!current->chroot_points)
		; //we know we are not chrooted
	else
		for each element in chroot_list
			if current dir = chroot dir
				chroot = true;
				break
		
		if ( chroot )
			do whatever kernel does now
		else 
			do whatever kernel does now.

on fork, all you have to do is copy the list efficiently b/w parent and
child.

the reason this works, is that any fd you get has to be inside a chroot
point (or within the original root), therefore if you try to chroot
under a chroot while holding fd's, there will be a .. of one of those
fd's that will be a chroot point, that you can kill the path_walk at.


