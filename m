Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266667AbUFWVD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266667AbUFWVD0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUFWVD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:03:26 -0400
Received: from lakermmtao09.cox.net ([68.230.240.30]:35568 "EHLO
	lakermmtao09.cox.net") by vger.kernel.org with ESMTP
	id S266667AbUFWVDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:03:03 -0400
In-Reply-To: <5447.1087993789@redhat.com>
References: <643CA25E-C091-11D8-8574-000393ACC76E@mac.com> <984AC744-BFFB-11D8-8574-000393ACC76E@mac.com> <FC6EBB12-BF27-11D8-95EB-000393ACC76E@mac.com> <1087282990.13680.13.camel@lade.trondhjem.org> <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <1087080664.4683.8.camel@lade.trondhjem.org> <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com> <1087084736.4683.17.camel@lade.trondhjem.org> <DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com> <87smcxqqa2.fsf@asterisk.co.nz> <8666.1087292194@redhat.com> <10430.1087397355@redhat.com> <30952.1087472906@redhat.com> <5447.1087993789@redhat.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B6AE615C-C558-11D8-8D26-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Blair Strang <bls@asterisk.co.nz>, lkml <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Wed, 23 Jun 2004 17:03:02 -0400
To: David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 23, 2004, at 08:29, David Howells wrote:
> Kyle Moffett <mrmacman_g4@mac.com> wrote:
>> You are referring to the attachment point from the UID to key-ring or
>> process to key-ring.  I was referring to your method of telling the 
>> key-ring
>> what is attached to it, though I could have misread your code.  Of 
>> course a
>> task_struct should have a key-ring pointer, but the key-ring 
>> shouldn't need
>> to know what points to it, just how many things point to it (ref 
>> count).
>
> A keyring doesn't know what points to it, only the keys that it holds. 
> The key
> part of the keyring keeps track of the refcount.
>
> A keyring does have a name, though, but it is arbitrary and otherwise 
> ignored.

Ok, that makes sense, I just confused myself when I read your code.  
Could we
just use numbers?  Possibly a port of the PID allocator would make that 
easier.

>> I see, we're going about this different ways.  For me, the ideal 
>> search path
>> within a single key-ring: keyring, keyring->parent, 
>> keyring->parent->parent,
>> etc.
> So you're thinking of a credential stack? That gets tricky when su is 
> thrown
> into the mix. Not that I'm saying my method is precisely simple then 
> either.
>
> Actually, you don't need the concept of a parent at all. If the 
> process had a
> current credential TOS pointer, you could push another keyring by 
> adding the
> TOS pointer as a child of the new keyring, and then redirecting the TOS
> pointer. Basically, the old TOS becomes a child of the new TOS.
>
> I've suggested a stack before, but it got rejected for various reasons.

We've been looking at this from different perspectives.  My search 
system was
to have a special "parent" that is searched if a key cannot be found in 
the
current key-ring.  Your search systeam appears to be to have a bunch of
"children" that are just an extra collection of more keys that are 
searched after
the key-ring.

>> That way we wouldn't even need a "session" key-ring in the kernel, a 
>> PAM
>> module could join processes to the appropriate key-ring when you 
>> login.
>> That way if I login several times on different console virtual 
>> terminals it
>> can share a key-ring across all of them, but not when I login 
>> remotely.
>>
> True. You would still have a "session" keyring, but it would be 
> entirely
> defined and governed by userspace (PAM) as to what it meant.
>
> I sort of like that idea. The kernel could still pin keyrings for 
> groups and
> users, and PAM could bolt them together, so upon login PAM could 
> create:
>
>  TOS
>   |
>   +--> Session keyring
>        |
>        +--> UID keyring
>        +--> GID keyring
>        +--> Supplementary Group keyring
>        +--> Supplementary Group keyring
>        +--> Supplementary Group keyring
>
> And then a process or a thread that wanted its own private keys could 
> stack a
> new ring:
>
>  TOS
>   |
>   +--> Thread keyring
>        |
>        +--> Process keyring
>             |
>             +--> Session keyring

I really like that idea, but perhaps it could be made more extendable.  
Maybe
we could use a system like this:

Searching a key-ring involves searching its keys, then searching its 
children,
(Child order is undefined).  When a task begins a search operation it 
searches
the following key-rings in this order:

Thread
Process
User
Primary Group
Secondary Group(s)  (Undefined order)

The recommended way to join a process to a session is to change its 
process
key-ring to something like the following:
Process
	|
	+---New empty process key-ring
		|
		+---"Session" key-ring

> However, you have a number of problems to contend with:
>
>  (*) How do you handle setuid() and co?

By default the init process receives a NULL key-ring (No key-ring at 
all).  This
means that new processes spawned by init receive a NULL key-ring.  These
are NULL key-ring pointers, not empty key-rings, so no data/keys are 
shared.
If a process tries to create keys in a NULL key-ring, it will fail.  
Then setuid(),
etc. merely change the uid, etc.  If a daemon is explicitly given a 
keyring at
startup it will retain that keyring.  This preserves maximum 
compatibility even
though there are no changes to libc.

>  (*) How do you handle setgid() and co?

The same way as setuid().

>  (*) How do you handle setgroups()?

The same way as setgid().

>  (*) How do you handle S_SUID?
>
>      This last could be handled in three ways: stack a new credential 
> on the
>      front; have a second TOS pointer (similar to UIDs); or start a 
> new stack.
>
>      If having a second TOS pointer, you could have setresuid() clear 
> it if
>      setting all UIDs to non-zero.
>
>  (*) There needs to be a limit on recursion.

As long as we're careful to do all key-ring operations within an 
interruptible task
context, and only use a locking iterative search, we don't need to care 
about
tree depth.  If the user creates too deep of a child structure, it just 
gets credited to
their process time and user limits.  Iterative searches eliminate the 
stack usage
problems and make it simple to fit in a 4k stack limit.

>> Let's allow user programs to *request* (Could be overridden) that 
>> certain
>> keys be swappable, and we could always allow them to be in highmem, 
>> as long
>> as we can ensure that certain keys won't be swapped.  There are 
>> advantages
>> to not allowing keys to be swapped.
>
> I'm not sure making keys swappable is necessarily easy.

So in the initial implementation of the key-ring system all requests 
for swappable
keys would be overridden to be not swappable.  After all, it's only a 
*request* :-D

> Put a counter in "struct user".

Possibly also per-process or per-thread limits.  Maybe even per-group 
limits, if we
want to go all the way.  Those are relatively simple, though.

>> Are the serial numbers unique within a key-ring or within the entire
>> subsystem?
> The latter.
That makes it much easier to move keys around between key-rings, I 
guess.

>> Are the types numbers?  That would seem simpler and allow differing
>> user-space and kernel-space key-type allocation.  Then it would be:
>> type: KEYTYPE_KRB5 (1042 or some such user-space allocated number)
>> desc: "krbtgt/MY.REALM@MY.REALM"
>
> No. The types are names. I suppose they could be made numeric too, but 
> I don't
> think there's a need for that. I could just decree that all userspace 
> type
> names begin with a '+' or something.

I suppose that makes sense.  I think at one point I had a technical 
reason for why
types should be numbers but it seems to have gone away.  Oh well :-)

>>> Some of this could be done by link and rename.
>> Yeah, but carefully.
>
> Actually, symlink() would probably be better. Though Al Viro might 
> kill me for
> abusing it:-)

We want to be careful to give processes a way to prevent race conditions
when accessing/modifying key-rings.

> Let's try not to bend the VFS layer too far. Just add another syscall 
> or
> prctl() for that.

Yeah.  Generally we want to give them a file or directory handle 
instead of a
key-ring ID.  That way we have a simple way to detect when they're done
using it.

> Perhaps it'd be better to make each key a directory, whether or not 
> it's a
> keyring:
>
>   /proc/keys/
> 	types
> 	keys/
> 		<keyID>/
> 			type
> 			state
> 			description
> 			payload
>  		<keyringID>/
> 			type
> 			state
> 			description
>  			<keyID> => ../<keyID> [symlink]

I like this idea.  It's a simple shallow directory tree.

>> We can also store sub-key-rings that way.  Here "unlink()" of a 
>> directory
>> could be permitted.
>
> I don't think you can unlink() a directory, and rmdir() might not work 
> if it's
> got contents.

Yes, but unlink would only be needed on the symlinks, which is what we
need.  The keys and key-rings themselves would go away when all
references to them have been destroyed.

> With some special keyIDs:
>
> 	0xABCD0001	- This thread's keyring
> 	0xABCD0002	- This process's keyring
> 	0xABCD0003	- This session's keyring
> 	0xABCD0004	- This UID's keyring
> 	0xABCD0005	- This GID's keyring

Why not just have separate keyctl calls to set thread, process, UID, 
and GID
keyrings for specific threads/processes/UIDs/GIDs.  That way a process 
with
the appropriate capabilities can manipulate keys as needed.  It also 
frees
us from the need to worry about not allocating those particular IDs.

>> Yeah.  We ought to have equivalent IOCTLs so that mostly atomic 
>> updates can
>> be done to key-rings, possibly even setting up a mandatory flock() 
>> for key
>> and key-ring file-handles.  Opening a file-handle would be enough to 
>> make
>> sure it doesn't go away, but flocking it would protect against other 
>> kinds
>> of operations.
>
> We don't want to add ioctls if we can avoid it... And I don't think 
> you want
> to try mixing flock() in.
>
> What you're suggesting makes filesystem key searching tricky... what 
> happens
> when it is running in softirq context and encounters a locked keyring?

Is there anything that needs to run in softirq context that should be 
accessing
key-rings there?  Perhaps one condition on key-ring access would be to
require that it be done from interruptible task context.  We could 
re-implement
the flock operation for our particular key filesystem to be a mandatory 
key lock.
That would prevent race conditions in priv'ed processes manipulating the
key-rings by allowing atomic modifications on a large scale.

> hard-link or soft-link to what? Keyrings are directories on another
> filesystem, and we can only assume that it's mounted on /proc/keys. 
> Besides,
> you can't hard-link directories.

Ahh, sorry, I was thinking and got lost.  Nevermind :-D
Perhaps we should add a few /proc/<pid>/keyring/{thread,process,...} 
"files"
to allow the sysadmin to view what key-rings are currently used by a 
particular
process.

Cheers,
Kyle Moffett

