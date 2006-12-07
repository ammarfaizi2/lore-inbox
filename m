Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032354AbWLGQGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032354AbWLGQGc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 11:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032355AbWLGQGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 11:06:32 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:33642 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032354AbWLGQGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 11:06:31 -0500
Date: Thu, 7 Dec 2006 10:06:17 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, trevor.highland@gmail.com,
       tyhicks@ou.edu
Subject: Re: [PATCH 1/2] eCryptfs: Public key; transport mechanism
Message-ID: <20061207160617.GA4568@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20061206230638.GA9358@us.ibm.com> <20061206215555.85d584ca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206215555.85d584ca.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 09:55:55PM -0800, Andrew Morton wrote:
> On Wed, 6 Dec 2006 17:06:38 -0600
> Michael Halcrow <mhalcrow@us.ibm.com> wrote:
> 
> > This is a re-submission of the same public key patches (updated for
> > 2.6.19-rc6-mm2) that were submitted for review a while back.
> 
> I made a number of comments last time around, some temperate, some not.
> I trust the temperate ones were addressed?
> 
> Is there really no way in which any other kernel subsystem will ever want
> functionality of this nature?
> 
> > This is the transport code for public key functionality in
> > eCryptfs. It manages encryption/decryption request queues with a
> > transport mechanism. Currently, netlink is the only implemented
> > transport.
> 
> I wouldn't view this as an adequate changelog for this sort of work,
> frankly.  Not by a long shot.  You've told us very briefly what the patches
> do.  You haven't told us why they do it, nor how they do it.
> 
> What design decisions went into this?  What options were considered and
> eliminated and why?  etc.
> 
> It's just a great lump of code dumped in our laps.

Here is the longer description of the patches that I sent back in
August. These comments still apply to the current public key
patches. I apologize for not including this content again in the
recent submission.

I agree that the messaging code might be of use elsewhere in the
kernel in the future. If other kernel developers think that what
eCryptfs does for messaging with a userspace daemon is sane, then I
can get to work on a patch to extract that into a more general-purpose
function.

Mike

----- Forwarded message from Michael Halcrow <mhalcrow@us.ibm.com> -----

From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, tchicks@us.ibm.com, tshighla@us.ibm.com
Subject: Re: [PATCH 1/4] eCryptfs: Netlink functions for public key
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>

On Thu, Aug 24, 2006 at 08:54:19PM -0700, Andrew Morton wrote:
> On Thu, 24 Aug 2006 13:18:32 -0500
> Michael Halcrow <mhalcrow@us.ibm.com> wrote:
> > eCryptfs netlink type, header updates, and messaging code to
> > provide support for userspace callout to perform public key
> > operations.
>
> That tells us (with maximum terseness) what it does.  We're left to
> our own devices to work out why it does this, how it does it and why
> it does it in the way in which it does it?  This leads to dumb
> questions ;)

There is a design document in the works; it's in the ecryptfs-util
userspace tarball, under doc/design_doc/. It still needs some fleshing
out to encompass userspace components. I'll go ahead and summarize the
design for this patch set.

Each inode has a unique File Encryption Key (FEK). Under passphrase, a
File Encryption Key Encryption Key (FEKEK) is generated from a
salt/passphrase combo on mount. This FEKEK encrypts each FEK and
writes it into the header of each file using the packet format
specified in RFC 2440. This is all symmetric key encryption, so it can
all be done via the kernel crypto API.

These new patches introduce public key encryption of the FEK. There is
no asymmetric key encryption support in the kernel crypto API, so
eCryptfs pushes the FEK encryption and decryption out to a userspace
daemon. After considering our requirements and determining the
complexity of using various transport mechanisms, we settled on
netlink for this communication.

eCryptfs stores authentication tokens into the kernel keyring. These
tokens correlate with individual keys. For passphrase mode of
operation, the authentication token contains the symmetric FEKEK. For
public key, the authentication token contains a PKI type and an opaque
data blob managed by individual PKI modules in userspace.

Each user who opens a file under an eCryptfs partition mounted in
public key mode must be running a daemon. That daemon has the user's
credentials and has access to all of the keys to which the user should
have access. The daemon, when started, initializes the pluggable PKI
modules available on the system and registers itself with the eCryptfs
kernel module. Userspace utilities register public key authentication
tokens into the user session keyring. These authentication tokens
correlate key signatures with PKI modules and PKI blobs. The PKI blobs
contain PKI-specific information necessary for the PKI module to carry
out asymmetric key encryption and decryption.

When the eCryptfs module parses the header of an existing file and
finds a Tag 1 (Public Key) packet (see RFC 2440), it reads in the
public key identifier (signature). The asymmetrically encrypted FEK is
in the Tag 1 packet; eCryptfs puts together a decrypt request packet
containing the signature and the encrypted FEK, then it passes it to
the daemon registered for the current->euid via a netlink unicast to
the PID of the daemon, which was registered at the time the daemon was
started by the user.

The daemon actually just makes calls to libecryptfs, which implements
request packet parsing and manages PKI modules. libecryptfs grabs the
public key authentication token for the given signature from the user
session keyring. This auth tok tells libecryptfs which PKI module
should receive the request. libecryptfs then makes a decrypt() call to
the PKI module, and it passes along the PKI block from the auth
tok. The PKI uses the blob to figure out how it should decrypt the
data passed to it; it performs the decryption and passes the decrypted
data back to libecryptfs. libecryptfs then puts together a reply
packet with the decrypted FEK and passes that back to the eCryptfs
module.

The eCryptfs module manages these request callouts to userspace code
via message context structs. The module maintains an array of message
context structs and places the elements of the array on two lists: a
free and an allocated list. When eCryptfs wants to make a request, it
moves a msg ctx from the free list to the allocated list, sets its
state to pending, and fires off the message to the user's registered
daemon.

When eCryptfs receives a netlink message (via the callback), it
correlates the msg ctx struct in the alloc list with the data in the
message itself. The msg->index contains the offset of the array of msg
ctx structs. It verifies that the registered daemon PID is the same as
the PID of the process that sent the message. It also validates a
sequence number between the received packet and the msg ctx. Then, it
copies the contents of the message (the reply packet) into the msg ctx
struct, sets the state in the msg ctx to done, and wakes up the
process that was sleeping while waiting for the reply.

The sleeping process was whatever was performing the sys_open(). This
process originally called ecryptfs_send_message(); it is now in
ecryptfs_wait_for_response(). When it wakes up and sees that the msg
ctx state was set to done, it returns a pointer to the message
contents (the reply packet) and returns. If all went well, this packet
contains the decrypted FEK, which is then copied into the crypt_stat
struct, and life continues as normal.

The case for creation of a new file is very similar, only instead of
a decrypt request, eCryptfs sends out an encrypt request.

> - We have a great clod of key mangement code in-kernel.  Why is that
>   not suitable (or growable) for public key management?

eCryptfs uses Howells' keyring to store persistent key data and PKI
state information. It defers public key cryptographic transformations
to userspace code. The userspace data manipulation request really is
orthogonal to key management in and of itself. What eCryptfs basically
needs is a secure way to communicate with a particular daemon for a
particular task doing a syscall, based on the UID. Nothing running
under another UID should be able to access that channel of
communication.

> - Is it appropriate that new infrastructure for public key
> management be private to a particular fs?

The messaging.c file contains a lot of code that, perhaps, could be
extracted into a separate kernel service. In essence, this would be a
sort of request/reply mechanism that would involve a userspace
daemon. I am not aware of anything that does quite what eCryptfs does,
so I was not aware of any existing tools to do just what we wanted.

> - I see code in there in which the kernel "knows" about specific
>   userspace processes.  By uid and pid.  What's all that doing and why is
>   it done that way?

I hope the explanation I give above is sufficient.

>   What happens if one of these daemons exits without sending a quit
>   message?

There is a stale uid<->pid association in the hash table for that
user. When the user registers a new daemon, eCryptfs cleans up the old
association and generates a new one. See ecryptfs_process_helo().

<snip>

> - _why_ does it use netlink?

Netlink provides the transport mechanism that would minimize the
complexity of the implementation, given that we can have multiple
daemons (one per user). I explored the possibility of using relayfs,
but that would involve having to introduce control channels and a
protocol for creating and tearing down channels for the daemons. We do
not have to worry about any of that with netlink.

<snip old patch>
----- End forwarded message -----
