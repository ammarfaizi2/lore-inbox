Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264444AbUG2MnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUG2MnU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 08:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUG2MnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 08:43:19 -0400
Received: from lakermmtao09.cox.net ([68.230.240.30]:22751 "EHLO
	lakermmtao09.cox.net") by vger.kernel.org with ESMTP
	id S264444AbUG2MnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 08:43:11 -0400
In-Reply-To: <Xine.LNX.4.44.0407290116340.13892-100000@dhcp83-76.boston.redhat.com>
References: <Xine.LNX.4.44.0407290116340.13892-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D92C5330-E15C-11D8-9EC8-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: lkml List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Preliminary Linux Key Infrastructure 0.01-alpha1
Date: Thu, 29 Jul 2004 08:43:10 -0400
To: James Morris <jmorris@redhat.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 29, 2004, at 01:58, James Morris wrote:
> Firstly, it might be useful for other developers if you could write up 
> a
> brief rationale about this feature, why it's needed and why this is a 
> good
> solution.  I do know of a few projects which could make use of 
> keyrings:

Hrm, oops!  Somehow my readme got left out of the tarball, I'll upload
another revision sometime today.

Basically, I put a generic "encryption key" type in the kernel with 
functions
to manipulate it.

>  - cryptfs (Michael Halcrow)
>  - afs

These two, as well as NFSv4 and possibly others could benefit from
having user accessible keys/keyrings in the kernel

>  - module signing (David Howells/ Arjan)

This is the hard one, because this is only really useful for a kernel 
that
doesn't allow unsigned modules, which means that you need to put a
key in the kernel when it is compiled, and possibly sign the entire 
kernel
with said key.  Such a key shouldn't be modifiable in any way.

> Are there others (with running code, merged or potentially mergable) ?
>
> Does your design cater for all needs?
That's what I'm asking :-D.  There was a big discussion a week or two
ago on the LKML "In-kernel Authentication Tokens (PAGs)".  This is an
outgrowth of that discussion.

> I think I heard that Greg-KH had some keyring code already, so there 
> may
> be some existing code floating around.
I think that was David Howells, and I've looked at his code extensively.

> To get more people to look at the code, I'd suggest that you get it
> running and prepared as a patch to the mainline kernel.  It will also 
> help
> if you follow Documentation/CodingStyle and use more idiomatic kernel
> development practices.

Yeah, what I have now is one weekend's worth of work just throwing it
together to get myself started.  I may have something new tomorrow, but
if not I'm gone for a week and I'll have something when I get back.


> For example, typedefs are generally frowned upon (but perhaps 
> acceptable
> to improve readability of complex function pointer stuff).
>
> You don't need to cast the result of kmalloc:
>
> 	key = (lki_key_t *)kmalloc(sizeof(lki_key_t),GFP_KERNEL);
>
> should be:
>
> 	key = kmalloc(sizeof(lki_key_t),GFP_KERNEL);
>
> Avoid using sizeof(some_type) for things like the above, use the actual
> object itself:
>
> 	key = kmalloc(sizeof(*key), GFP_KERNEL);
>
> (in case the type of *key changes some day).

Ok, thanks.  In the past some compilers had given we warnings when I
didn't cast, so I wasn't sure.

> Use wrapper functions like wait_event_interruptible() instead of 
> rolling
> your own.

I needed a specialized version that dropped a spinlock after adding 
itself
to the waitqueue and before sleeping, then relocking before checking the
condition.  Is there a better way to do what I need there?

> It's better (IMHO) to have one exit path in a function, to clarify 
> error
> handling, locking, and make it easier to audit the code.  e.g. in
> lki_key_used_list_allocate(), you grab a lock then have several return
> points with no unlock.

Yeah, my error handling is a real mess and needs to be cleaned up.

> Having some real code which uses the framework will also be good.

Yep.

>> TODO:
>> 	keyctl:
>> 		The syscall that makes it all possible
>
> Why would you need a syscall?

The only way to _manipulate_ keys is by first getting a key handle.
To get a key handle you can open the file "keyfs/<keyid>/control"
for a specific key number, or you can just get a key handle straight
from the KEYCTL_CREATE call, or from the KEYCTL_GET call, or
from a couple other calls.  A key handle is just a file handle with a
special struct key_handle attached to it to provide access to the
key behind it.

>> 	keyfs:
>> 		keys by number: On hold while I learn more about filesystems :-D
>
> What does this mean?

A file system somewhat like the following:

keyfs/
	<keyid>/
		control
		desc
		blob
	<keyid>/
		control
		desc
		blob
		ring/
			<keyid>	=>	../../<keyid>
			<keyid>	=>	../../<keyid>
	<keyid>/
		[...]

> I would imagine that the entire userspace API would be filesystem 
> based.
> e.g.  you could load the keys for module signature checking during 
> boot by
> writing them to a node like:
>
> cat keyring.txt > /keyrings/modsign/keys
>
> Disable further changes:
>
> echo "0" > /keyrings/modsign/write
>
> You could manage per process credentials via /proc/self/something

There was a big discussion about user interface, see the earlier thread
"In-kernel Autnetication Tokens (PAGs)" for more info.

Thanks for your comments!

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


