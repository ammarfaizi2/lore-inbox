Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWDEPCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWDEPCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 11:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWDEPCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 11:02:30 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:29940 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750889AbWDEPCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 11:02:30 -0400
Subject: Re: [RFC] packet/socket owner match (fireflier) using skfilter
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: edwin@gurde.com
Cc: James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <200604031839.38590.edwin@gurde.com>
References: <200604021240.21290.edwin@gurde.com>
	 <Pine.LNX.4.64.0604031117070.7743@d.namei>
	 <200604031839.38590.edwin@gurde.com>
Content-Type: text/plain; charset=UTF-8
Organization: National Security Agency
Date: Wed, 05 Apr 2006 11:06:31 -0400
Message-Id: <1144249591.25790.56.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 18:39 +0300, Török Edwin wrote:
> I am not trying to reinvent SELinux. But I do not know how to accomplish what 
> I want with SELinux.
> 
> Here it is what I want:
> - have security labels applied to sockets based on their owners (ok, I guess 
> SELinux does this by default)

Yes, if owner == creator.

> - the security labels of processes be assigned based on their executable's 
> inode+mountpoint.

Not sure what you mean by inode+mountpoint here.  SELinux already allows
you to define a domain transition for the process based on the caller's
domain and the type assigned to the executable file via inode extended
attribute.

> Is there a way to do auto-labeling with SELinux? I mean having a security 
> context applied based on the inode, without me having to run 'make relabel', 
> setfiles, and so on....

Attributes have to be bound to the actual objects, which means that
something has to set those attributes.  This is no different than normal
Linux DAC attributes like file owner/group/mode (aside from the need to
use extended attributes for storage).  Some package managers have
already been extended to support setting SELinux attributes when files
are installed, like rpm in Fedora, dpkg in Debian unstable, portage in
Hardened Gentoo.  install(1) in Fedora also is patched to apply the
proper context for installation of files without using the package
manager.  restorecon can be selectively applied to specific files to
restore their labels to the initial values specified in the
configuration.

> Let's say I compile&install a program. Can it have a security label 
> auto(magically) applied, based on the inode of its executable? (without 
> recompiling, & reloading the policy)
>
> (From my very limited understanding of SELinux, this would mean creating a 
> context for each executable, that is altering the policy, if each executable 
> needs to have a separate context. Is it possible to dinamically generate the 
> context at runtime? Is it possible to integrate my autolabel.c with SELinux?)

If you truly need to distinguish each such program, then yes, they would
need separate contexts, although you likely can organize them into
equivalence classes.  You could generate a policy module in userspace
and feed it to semodule to be linked into the base policy and loaded,
although the details are not entirely clear as to what you would need to
put into the policy module (e.g. you seem to just want to define the
domain and type and then make the domain identical to the caller's
domain since you aren't trying to restrict it any further, just use it
for labeling purposes).

> It doesn't have to have a security label applied by its inode, but that is 
> unique, I don't know how secure would it be to identify processes by path...

It isn't.  Path-based access control considered harmful.

> If the above is possible, could you please provide pointers to documentation?
> 
> How can I implement auto-labeling with SELinux? (is there a possibility to 
> write some sort of plugins that provide this functionality?)
> 
> To sum up, I wrote my LSM stuff because I didn't know how to use SELinux to 
> accomplish what I wanted. 
> If it can be done with SELinux easily, I'm happy to switch to that. (easy from 
> the end-user's perspective, using fireflier for example. it doesn't matter 
> how much work it would imply to make fireflier handle the stuff "behind the 
> scenes")

You aren't likely to get much review of your actual LSM without breaking
it up into manageable chunks and posting with patches inline for review
to linux-security-module@vger.kernel.org.

-- 
Stephen Smalley
National Security Agency

