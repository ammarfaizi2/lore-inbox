Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbVJFOZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVJFOZu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbVJFOZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:25:50 -0400
Received: from mail22.sea5.speakeasy.net ([69.17.117.24]:29576 "EHLO
	mail22.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750992AbVJFOZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:25:49 -0400
Date: Thu, 6 Oct 2005 10:25:46 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management 
In-Reply-To: <23641.1128596760@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.63.0510061014540.26656@excalibur.intercode>
References: <Pine.LNX.4.63.0510060404141.25593@excalibur.intercode> 
 <29942.1128529714@warthog.cambridge.redhat.com>  <23641.1128596760@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2005, David Howells wrote:

> James Morris <jmorris@namei.org> wrote:
> 
> > I think this looks ok from an SELinux point of view if keys are treated as 
> > opaque objects, i.e. like files.
> 
> I'll make some changes based on the suggestions I've received. Those who
> request the return of keyfs can go boil their heads.

You know, I was thinking, ext3 could be much more compact if it was just a 
set of custom syscalls and had no VFS representation.

What about a per process /proc/pid/keys, which contains keyrings and keys, 
which can be opened, closed, use xattrs for any special access control 
etc. ?

> > We could do something like create a new object class (kernkey or 
> > something) and implement SELinux permissions for the class such as read, 
> > write, search, link, setattr and getattr.  Your KEY_VIEW perm could be 
> > translated to SELinux getattr.
> 
> Should I expand the permissions mask to include a setattr?

Possibly for setperm and chown.

> > I'm not sure if we need user-level labeling of keys via the set & get 
> > security ops, although LSPP may require some form of get_security. If we 
> > don't need to manually set security attributes but still view them, they 
> > could be displayed via /proc/keys rather than implementing a separate 
> > multiplexed syscall.
> 
> Would it be worth me adding a key type op by which a security module can ask
> the type its opinion (or by which key_alloc() can ask the type to give the
> security module an earful)?

Well, SELinux is the only significant LSM in the tree and I don't think it 
needs to set the labels.  So, no.

> >   keyctl_chown_key()
> >   keyctl_setperm_key()
> 
> Okay.
> 
> >   keyctl_set_reqkey_keyring()
> 
> Should this really be securified? It merely controls the default destination
> for a key created by request_key(), and is limited to the keyrings the process
> is subscribed to in any case.

Ok, if needed, it can be added later.

> > All users of key_permission() need to propagate the error code from the 
> > LSM back to the user.
> 
> Really? Why?

Because the LSM has final say on the error code returned to the caller.  
If the LSM runs out of memory, for example, it's silly to return -EACCES.

> Note that the fact that key_permission() fails for a key is sometimes ignored,
> such as when I'm doing a search and one potentially matching key fails, but a
> subsequent matching key passes.

Ok, that sounds like an internal issue to be resolved, ensuring that if 
you are returning to the caller, the LSM's error code is returned.


- James
-- 
James Morris
<jmorris@namei.org>
