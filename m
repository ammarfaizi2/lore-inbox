Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVJFLGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVJFLGV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 07:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVJFLGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 07:06:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3991 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750820AbVJFLGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 07:06:21 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.63.0510060404141.25593@excalibur.intercode> 
References: <Pine.LNX.4.63.0510060404141.25593@excalibur.intercode>  <29942.1128529714@warthog.cambridge.redhat.com> 
To: James Morris <jmorris@namei.org>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Thu, 06 Oct 2005 12:06:00 +0100
Message-ID: <23641.1128596760@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> I think this looks ok from an SELinux point of view if keys are treated as 
> opaque objects, i.e. like files.

I'll make some changes based on the suggestions I've received. Those who
request the return of keyfs can go boil their heads.

> We could do something like create a new object class (kernkey or 
> something) and implement SELinux permissions for the class such as read, 
> write, search, link, setattr and getattr.  Your KEY_VIEW perm could be 
> translated to SELinux getattr.

Should I expand the permissions mask to include a setattr?

> More thought needs to go into whether we need to implement an SELinux 
> create permission (and add hooks into the code), for control over whether 
> a process can create an anonymous keyring.

That's not really a per-key type of thing.

> I'm not sure if we need user-level labeling of keys via the set & get 
> security ops, although LSPP may require some form of get_security. If we 
> don't need to manually set security attributes but still view them, they 
> could be displayed via /proc/keys rather than implementing a separate 
> multiplexed syscall.

Would it be worth me adding a key type op by which a security module can ask
the type its opinion (or by which key_alloc() can ask the type to give the
security module an earful)?

>   keyctl_chown_key()
>   keyctl_setperm_key()

Okay.

>   keyctl_set_reqkey_keyring()

Should this really be securified? It merely controls the default destination
for a key created by request_key(), and is limited to the keyrings the process
is subscribed to in any case.

>   keyctl_join_session_keyring()  [only if we add a 'create' perm]

This does need a security hook, at least for joining an existing session.

I wonder if I should treat named sessions on a per-user basis and whether I
should separate them from keyrings, so that session names refer to keyrings
and have their own permissions and security, but aren't those keyrings. This
latter bit is the big stumbling block that I had with the clone-handle
functionality that Kyle Moffett woulkd like.

> All users of key_permission() need to propagate the error code from the 
> LSM back to the user.

Really? Why?

Note that the fact that key_permission() fails for a key is sometimes ignored,
such as when I'm doing a search and one potentially matching key fails, but a
subsequent matching key passes.

David
