Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWEJSq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWEJSq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 14:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWEJSq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 14:46:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32211 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932461AbWEJSq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 14:46:56 -0400
To: Al Viro <viro@ftp.linux.org.uk>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, dev@sw.ru,
       sam@vilain.net, xemul@sw.ru, haveblue@us.ibm.com, clg@fr.ibm.com,
       frankeh@us.ibm.com
Subject: Re: [PATCH 1/9] nsproxy: Introduce nsproxy
References: <29vfyljM.2006059-s@us.ibm.com>
	<20060510021129.GB32523@sergelap.austin.ibm.com>
	<20060510100057.GA27946@ftp.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 10 May 2006 12:45:09 -0600
In-Reply-To: <20060510100057.GA27946@ftp.linux.org.uk> (Al Viro's message of
 "Wed, 10 May 2006 11:00:57 +0100")
Message-ID: <m1ejz1wwga.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> writes:

> On Tue, May 09, 2006 at 09:11:29PM -0500, Serge E. Hallyn wrote:
>> Introduce the nsproxy struct.  Doesn't do anything yet, but has it's
>> own lifecycle pretty much mirrorring the fs namespace.
>> 
>> Subsequent patches will move the namespace struct into the nsproxy.
>> Then as more namespaces are introduced, such as utsname, they can
>> be added to the nsproxy as well.
>
> Is there any reason why those can't be simply part of namespace?  I.e.
> be carried by the stuff mounted in standard places...

Wee...  Exploring the implementation space.

So the namespaces under discussion are:
- The uts namespace
- The sysvipc namespace
- The pid namespace
- The network namespace
- The uid namespace
- The time namespace

None of which are currently expressed as a standard mount,
so there is not an obvious mapping.  Suggestions?

A standard mount location is not strong enough,
it must be a fixed mount location so the kernel can
use it.

Looking at a fixed mount location in the kernel looks
likely to be too clumsy to use we would need pointers
similar to those in fs_struct to cache the mount,
and we would still have the problem of identifying which
mounts from kernel space are for the different namespaces.

I am a little concerned about the overhead in implementing
this on the kernel side but those are simply implementation
optimization issues not semantic issues.

Exporting the different kernel namespaces/subsystem through
filesystems sounds reasonable if it will simplify the semantics.
Currently the only practical difference I can see is that you could
use mount/umount instead of clone and unshare.  Which seems to
give us additional complications for no real gain. 

If we did not have to be backwards compatible and we could reduce our
number of system calls by exporting whole subsystem instances as
filesystem mounts I can see great gains here, but since we
are concerned with existing namespaces/subsystems and just
want to make it appear that we have multiple instances of
them I don't see any gains. 

Eric
