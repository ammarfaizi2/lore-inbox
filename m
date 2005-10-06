Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVJFIit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVJFIit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 04:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVJFIit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 04:38:49 -0400
Received: from mail25.sea5.speakeasy.net ([69.17.117.27]:21217 "EHLO
	mail25.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750754AbVJFIis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 04:38:48 -0400
Date: Thu, 6 Oct 2005 04:38:46 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management
In-Reply-To: <29942.1128529714@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.63.0510060404141.25593@excalibur.intercode>
References: <29942.1128529714@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this looks ok from an SELinux point of view if keys are treated as 
opaque objects, i.e. like files.

We could do something like create a new object class (kernkey or 
something) and implement SELinux permissions for the class such as read, 
write, search, link, setattr and getattr.  Your KEY_VIEW perm could be 
translated to SELinux getattr.

More thought needs to go into whether we need to implement an SELinux 
create permission (and add hooks into the code), for control over whether 
a process can create an anonymous keyring.

I'm not sure if we need user-level labeling of keys via the set & get 
security ops, although LSPP may require some form of get_security. If we 
don't need to manually set security attributes but still view them, they 
could be displayed via /proc/keys rather than implementing a separate 
multiplexed syscall.

It seems that there are no LSM checks for the following:

  keyctl_chown_key()
  keyctl_setperm_key()
  keyctl_set_reqkey_keyring()

  keyctl_join_session_keyring()  [only if we add a 'create' perm]


All users of key_permission() need to propagate the error code from the 
LSM back to the user.


- James
-- 
James Morris
<jmorris@namei.org>
