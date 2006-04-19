Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWDSStK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWDSStK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWDSStK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:49:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64448 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751003AbWDSStJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:49:09 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Arjan van de Ven <arjan@infradead.org>
To: Crispin Cowan <crispin@novell.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <44468258.1020608@novell.com>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com>
	 <1145381250.19997.23.camel@jackjack.columbia.tresys.com>
	 <44453E7B.1090009@novell.com>
	 <1145389813.2976.47.camel@laptopd505.fenrus.org>
	 <44468258.1020608@novell.com>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 20:48:55 +0200
Message-Id: <1145472535.3085.94.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 11:32 -0700, Crispin Cowan wrote:
> Arjan van de Ven wrote:
> > On Tue, 2006-04-18 at 12:31 -0700, Crispin Cowan wrote:
> >   
> >> AppArmor (then called "SubDomain") showed how this worked in practice
> >> years before the Targeted Policy came along. The Targeted Policy
> >> implements an approximation to the AppArmor security model, but does it
> >> with domains and types instead of path names, imposing a substantial
> >> cost in ease-of-use on the user.
> >>     
> > I would suspect that the "filename" thing will be the biggest achilles
> > heel...
> >   
> The filename thing is the core point of AppArmor that distinguishes it
> from SELinux. We argue that the work required to make pathname-based
> access controls work in the Linux kernel is worth the effort, and we are
> putting up the effort to achieve it.

if you mean "to make it user manageable" I don't buy your argument. If
you would have made the policy using path names, but a policy compiler
that turns it into file object attributes + a compiled policy using
attributes you achieve the same ease of use. However you get the
security on the object rather than on the pointers to the object.
 
> 
> > after all what does filename mean in a linux world with
> > * hardlinks
> >   
> If the policy lets you access /foo/bar/baz then you get to access
> /foo/bar/baz, even if it is a hard link to /foo/bif.
> 
> Some allege that this is a security hole in AppArmor. However,
> AppArmor's design is that you only get to create that hard link if you
> are either unconfined or your profile says you get to create it.
> AppArmor implicitly trusts all non-confined processes, so anything they
> do is ok, by definition. Confined processes can create hard links, but
> only if the policy allows them to, and you need access rights greater
> than or equal to the access rights of the link source. In order to
> create the source, you need to have write access, so in principal you
> need write access to the target of your link. So, if you've subverted
> the process and you can create the link, you already had write access
> *anyway*.

and this falls appart if you can compromise 2 daemons with
non-overlapping permissions. or in many other situations ;)

> 
> > * chroot
> >   
> In the currently shipping AppArmor, the names AppArmor sees are
> chroot-relative. The patch we are about to submit fixes that and the
> names AppArmor sees are now absolute, regardless of chroot jailing.

what is an absolute path? How does that work if you have namespaces or
floating mounts? (eg after lazy umount for example)

> 
> > * namespaces
> > * bind mounts
> >   
> As far as we know, our namespace support is fine; we mediate attempts to
> modify namespaces (such as denying mount and umount)

but you can trick other parts in the system to mount/umount stuff anyway
(hal for example)
and still clone is the part that plays with namespaces most

>  and requiring
> cap_sys_chroot to modify the root of the namespace. If there are
> instances where we are incorrect we would greatly appreciate a detailed
> description of the issue (or better a testcase) so we can look at
> resolving it.

you don't get to control it. Simple example: hal doing a lazy umount on
your usb stick.


> > * unlink of open files
> > * fd passing over unix sockets

> >    you get passed
> the fd from another process, or you call our change_hat() API.

how do you validate the fd? the there no longer is a filename for that
file (it may be unlinked, renamed, lazy umounted etc etc)

> Note that d_path still returns pathnames for files that have been
> removed from the filesystem (that are open)

it does return "something". It just doesn't return meaningful pathnames.
At all.


> > * relative pathnames
> >   
> If you access "../hosts.allow" AppArmor will canonicalize your path name
> to /etc/hosts.allow before checking the policy.

and does it do that for recursive symlinks? And what if I'm dynamically
playing with the symlink tree while you're resolving?


