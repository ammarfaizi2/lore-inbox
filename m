Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbUFQTH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUFQTH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUFQTHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:07:09 -0400
Received: from lakermmtao11.cox.net ([68.230.240.28]:22248 "EHLO
	lakermmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261832AbUFQTGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:06:12 -0400
In-Reply-To: <30952.1087472906@redhat.com>
References: <984AC744-BFFB-11D8-8574-000393ACC76E@mac.com> <FC6EBB12-BF27-11D8-95EB-000393ACC76E@mac.com> <1087282990.13680.13.camel@lade.trondhjem.org> <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <1087080664.4683.8.camel@lade.trondhjem.org> <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com> <1087084736.4683.17.camel@lade.trondhjem.org> <DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com> <87smcxqqa2.fsf@asterisk.co.nz> <8666.1087292194@redhat.com> <10430.1087397355@redhat.com> <30952.1087472906@redhat.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <643CA25E-C091-11D8-8574-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Blair Strang <bls@asterisk.co.nz>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Thu, 17 Jun 2004 15:06:09 -0400
To: David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 17, 2004, at 07:48, David Howells wrote:
> The main reason that there are attachment points for keyrings on UIDs,
> processes, etc, is that there needs to be some way for things like 
> open() to
> find them without adding an equivalent syscalls that take a key as 
> well.
>
> In a way, you could look at it as these attachment points are like the 
> PATH
> variable - they describe a search path. You still need one of those.
>
> LSM modules can always create keyrings and subscribe one of the five 
> keyrings
> a task has to them so that they become accessible.

You are referring to the attachment point from the UID to key-ring or 
process to
key-ring.  I was referring to your method of telling the key-ring what 
is attached
to it, though I could have misread your code.  Of course a task_struct 
should
have a key-ring pointer, but the key-ring shouldn't need to know what 
points to
it, just how many things point to it (ref count).

> It supports nested keyrings - up to a certain depth anyway - and when 
> you add
> one keyring into another it checks to see you're not trying to create 
> a cycle
> (at least, you can from the kernel... you can't from userspace yet).

Ahh, that's basically what I was thinking about, I must have missed it 
in your patch.

> I'm not keen on the "parent" idea. I'm not sure what you are thinking 
> of
> exactly - a keyring can have multiple parents, and also this sounds 
> like it
> may cause a cycle.

I see, we're going about this different ways.  For me, the ideal search 
path within
a single key-ring: keyring, keyring->parent, keyring->parent->parent, 
etc.  That
way we wouldn't even need a "session" key-ring in the kernel, a PAM 
module
could join processes to the appropriate key-ring when you login.  That 
way if
I login several times on different console virtual terminals it can 
share a key-ring
across all of them, but not when I login remotely.

> Using LSM hooks could represent a chicken vs egg scenario if you want 
> to use
> these keys to represent LSM security data (which you might reasonably 
> want to
> do).

It just means that LSM modules that want to use keys to hold LSM 
security data
must be careful about their access to key-ring FS objects.  Besides, 
there's no
requirements that LSM use the user-space interfaces, we'd probably need 
a
set of kernel-space functions that could ignore the access check if 
requested,
and most LSM modules would just use unreadable/unwritable/unusable keys
and ignore the access checks.

> It could be made such that arbitrary keys can be stored there (just 
> another
> keytype)... it's just that the keys eat into the kernel low memory 
> region. It
> may be better to permit such keys to be stored in highmem or swap 
> somehow.

Let's allow user programs to *request* (Could be overridden) that 
certain keys
be swappable, and we could always allow them to be in highmem, as long 
as
we can ensure that certain keys won't be swapped.  There are advantages 
to
not allowing keys to be swapped.

> Plus, should there be a quota system?

Definitely, by limiting the amount of memory allocated per security 
context.
We should make sure that the extra key-ring struct data also counts, so 
the
user can't just allocate thousands of empty keys.

> Keys have a serial number, a type, a description and a payload. 
> Currently the
> types can't be arbitrary - a kernel driver or whatever must have 
> registered
> that type for it to be used. If that driver unregisters its key type, 
> all keys
> of that type are immediately withdrawn.

Are the serial numbers unique within a key-ring or within the entire 
subsystem?
Perhaps we should allow user-space to "allocate" a key-type dynamically,
something >=1024, while <1024 is reserved for kernel-registered 
key-types.
Key-types should be mappable name=>number and number=>name.

> For instance, my kafs module registers an "afs" key type in which it 
> can store
> a Krb5 ticket. Having a type management system like this allows the 
> type to
> have operations to validate, match and pretty-print key descriptions. 
> The
> first one is the most important, I feel, because we can validate a key 
> upon
> addition.

Kernel-registered key-types should definitely be validated by the 
kernel.

> It might be possible to make this more flexible. Have userspace upload 
> a
> "potential" key with arbitrary type, description and payload; and then 
> have,
> say, a kafs's file open routine locate a candidate key and render it 
> into
> parsed key form. Hmmm...

User-space should be required to parse the key as much as possible, so
that we can keep clutter out of kernel-space.  But it's not an issue if 
all AFS
ever does with the key is just perform mathematical operations on it and
it happens to be corrupted, as long as it doesn't break the kernel.  If 
we
allow user-space key-type allocations then we should allow arbitrary 
data
to be stored there, up to quota.

> One thing I want to avoid is having to have the filesystem (or 
> whatever)
> validate the key every time it looks at it.

No kidding.  Once it's added (And validated if needed), we only need to
check it again if it's modified.

> In this example, you might have something like:
>
> 	type	krbtgt
> 	desc	MY.REALM@MY.REALM
>
> Or:
>
> 	type	user
> 	desc	krbtgt/MY.REALM@MY.REALM
>
> But you'd have to provide the kernel with a type registration for the 
> key type
> in question.

Are the types numbers?  That would seem simpler and allow differing
user-space and kernel-space key-type allocation.  Then it would be:
type: KEYTYPE_KRB5 (1042 or some such user-space allocated number)
desc: "krbtgt/MY.REALM@MY.REALM"

>> Hmm, so going along with these ideas, how about this?
>> /proc/keyring/
>> 	MODE = 555
>> 	DESC = keyringfs, contains keyring metadata
> I presume you mean keyringfs or keyfs mounted on /proc/keyring/ (or 
> /proc/keys/).
Of course

>> 	<id>/
>> 		MODE = Access control for entire keyring
>> 		DESC = A keyring entry, referenced by number
>> 		opendir = Increments the ref count to make sure it won't go away.
>>
>> 		parent => ../<id>
>> 			DESC = A symlink or hardlink to the parent keyring
>>
>> 		<typeid>/
>> 			MODE = 555
>> 			DESC = A numerical "key-type" (KEYTYPE_KRB5)
>>
>> 			<service>
>> 				MODE = Access control for a single key
>> 				DESC = The key, accessed as a file.
>>
>> 		<typename> => <typeid>/
>> 				DESC = A symlink or hardlink to a type number from
>> 					a type name.  These types could be registered
>> 					by modules that implement them.
>>
>> There would be IOCTLs on the key-ring dir handles for getting the 
>> key-ring
>> number
> Why? That's the filename of the keyring dir.
If you were passed a key-ring handle and told to do something with it, 
how
would you find out what number the keyring is?

>> adding new keys, etc.
> Some of this could be done by link and rename.
Yeah, but carefully.

>>  On key handles there would be IOCTLs for deleting the key,
> unlink.
Duh, I feel stupid now.

>> revoking access, etc.
>
>> We'd also need a few syscalls for creating new key-rings.
>
> mkdir would be nice, but the key manager supplies the ID.
How about a key-ring id directory "-1" that can be opendir()ed to
generate a new key-ring.  Then once you have that you can just
use IOCTLs to find out what key-ring ID it has.  That gives you a
directory file-handle and makes the retain count management a
little simpler.  If they don't use the key-ring and just close the dir
handle then the retain count becomes zero and it disappears.

> I think I'd make the filesystem look like:
>
>  /proc/keys/
> 	types
> 	keys/
> 		<keyID>
> 		<keyringID>/
> 			<keyID>
> 			<keyringID> => ../<keyringID> [symlink]
> 			<keyID>
> 			<keyID> [hardlink to keyID]
> 		<keyringID>/
> 		<keyID>
> 		<keyID>
> 		<keyringID>/
> 		<keyringID>/
> 		<keyID>

I think we are referring to the same ability here, you just referenced 
it as "child"
key-rings, whereas I referenced them as "parent" key-rings.  Both have 
the same
behavior.  I think I like the multiple inheritance idea better.  What 
we do need is
a way to make a

> Each key would then have a UID, GID and umask which behave like for 
> normal
> files. Reading key files would then get you a summary of the key 
> contents and
> state. getxattr could be used also. The payload would only be 
> accessible
> through getxattr.

Yeah, but I think the payload should be accessible through read(), 
write(), etc so
that cat can be used to get a dump of the keys, it makes it easier on 
sysadmins
who are trying to debug things. Perhaps we could have two files for 
each key in
a kernel-registered key-type:
	"123"	=> summary of key, from kernel handler
	"123-raw"	=> raw binary data of key, if accessible
User-mode key-types wouldn't have kernel functions, and so would only 
have a
"123-raw" file.

> I might even permit the use of link() and rename(), provided the keys
> filenames stay the same, and unlink().
What if we have:
<keyring-id>/
	0/		=> These are sub-key-rings (type=0,desc=<key-ring ID string>)
		<keyring-no>
		<keyring-no>
	<key-type>/
		<key-desc>
	<key-type>_raw/
		<key-desc>
Or something like that.  That way key filenames stay the same, are easy 
to
locate and use in scripts, and give detailed information just in the 
directories.
We can also store sub-key-rings that way.  Here "unlink()" of a 
directory could
be permitted.  If it's a primary key-ring entry then we just remove it 
from the
visible database but not from anything that references it (Like 
unlink() on an
open file).

> However, I think I'd prefer to extend the syscall interface some more.
> I've got four prctls:
>
>  (*) Get process subscribed keyring ID (choose which of the five).
>
>  (*) Clear process subscribed keyring ID (choose which of the five).
>
>  (*) Request new session keyring for this process.
>
>  (*) Add key to process subscribed keyring ID (choose which of the 
> five).
>
> I could then add some more syscalls:
>
>  (*) Add key to arbitrary keyring.
>
>  (*) Update key.
>
>  (*) Retire key.
>
>  (*) Get list of key IDs from keyring.
>
>  (*) Get type of key.
>
>  (*) Get description of key.
>
>  (*) Get payload of key.
>
>  (*) Link key to keyring.
>
>  (*) Unlink key from keyring.
>
> All but the first two are trivially easy to do with a keyfs using 
> standard
> operations.

Yeah.  We ought to have equivalent IOCTLs so that mostly atomic updates
can be done to key-rings, possibly even setting up a mandatory flock() 
for
key and key-ring file-handles.  Opening a file-handle would be enough to
make sure it doesn't go away, but flocking it would protect against 
other
kinds of operations.

As for the first two operations, looking up key-rings, we could just 
add a
hard-link or soft-link /proc/<pid>/keyring/process/thread, though we'd 
want
sys-calls as well, since the UID and group ones aren't mapped in proc.  
I
don't expect those will be used as much, though.

Cheers,
Kyle Moffett

