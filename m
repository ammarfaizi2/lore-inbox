Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267965AbUHKGjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267965AbUHKGjg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 02:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUHKGjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 02:39:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:59831 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267965AbUHKGiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 02:38:07 -0400
Date: Tue, 10 Aug 2004 23:37:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, James Morris <jmorris@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjanv@redhat.com,
       dwmw2@infradead.org, greg@kroah.com, Chris Wright <chrisw@osdl.org>,
       sfrench@samba.org, mike@halcrow.us,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] implement in-kernel keys & keyring management [try #5]
Message-ID: <20040810233730.B1924@build.pdx.osdl.net>
References: <16109.1092044758@redhat.com> <Pine.LNX.4.58.0408072221480.1793@ppc970.osdl.org> <Xine.LNX.4.44.0408080046130.27710-100000@dhcp83-76.boston.redhat.com> <16109.1092044758@redhat.com> <5788.1092160798@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5788.1092160798@redhat.com>; from dhowells@redhat.com on Tue, Aug 10, 2004 at 06:59:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

* David Howells (dhowells@redhat.com) wrote:
> It can be found at:
> 
> 	http://people.redhat.com/~dhowells/keys/keys-268rc2-5.diff.bz2

Here's a few comments/questions from first pass-thru.  Looks good so
far.  I have yet to fully digest it all, or run your current
patchset/toolset to play with it.

it's still tough to walk away from the idea that this is really close to
a filesystem interface.
                                                                                
sys_keyctl prototype declaration in key.h?  maybe in syscalls.h?
also, the #else /* !CONFIG_KEYS */ for doesn't look right.  i think
the syscall should always be there, instead use cond_syscall.
                                                                                
prctl case statement.  are case ranges supported in all gcc versions
that are valid for 2.6 kernel compilation?
                                                                                
key_euid_changed/key_egid_changed will change the process_keyring even
if it's just a thread which did the setuid/gid.  this doesn't sound
right.
                                                                                
i'm a little confused by suid_keys().  it's sprinkled in various spots,
yet the function does nothing.  what's the intention there (esp. w.r.t.
key_euid_changed)?  e.g.  placement in compute_creds is before the actual
process uid updates are done.
                                                                                
why check pid ==1 and uid ==0 in exec_keys?
                                                                                
why not switch_uid_keyring for non root_session_keyrings?
                                                                                
in alloc_uid_keyring, keyring_alloc failure for session_keyring leaks
uid_keyring allocation.
                                                                                
key_user can't be squished into user_struct?  seems like the quota stuff
could become setable from userspace (rlimit-like).
                                                                                
/sbin/request-key should probably path configurable like /sbin/hotplug.

thanks,
-chris
