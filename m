Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422747AbWHYTSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422747AbWHYTSo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422754AbWHYTSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:18:44 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:11469 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422747AbWHYTSn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:18:43 -0400
Date: Fri, 25 Aug 2006 14:18:37 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, tchicks@us.ibm.com, tshighla@us.ibm.com
Subject: Re: [PATCH 1/4] eCryptfs: Netlink functions for public key
Message-ID: <20060825191837.GA3122@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060824181722.GA17658@us.ibm.com> <20060824181831.GB17658@us.ibm.com> <20060824205419.c3894612.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824205419.c3894612.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

> - It uses netlink to transport keys.  What are the security implications
>   of this?  (Can they be sniffed, for example?)

On further reflection, I think the code we sent is vulnerable to one
particular attack in the event that a daemon dies without sending a
QUIT message (an unlikely scenario, but still possible):

1) Bob registers his daemon; eCryptfs correlates the
   NETLINK_CREDS(skb)->uid with NETLINK_CREDS(skb)->pid,
2) Alice determines the PID for Bob's daemon (BOB-PID),
3) Bob's daemon dies without sending a QUIT,
4) Alice runs a rogue daemon over and over again until the rogue
   daemon's PID matches BOB-PID,
5) Bob creates a new file,
6) The module sends the newly generated FEK to the rogue daemon,
7) The rogue daemon obliges the encrypt request and stores off the
   FEK for Bob's new file,
8) The reply comes through and the module only checks the
   NETLINK_CREDS(skb)->pid; the module thinks that everything is well
   and moves forward.

I think the solution to this is, quite simply, to check the uid as
well as the pid from the netlink credentials. The rogue daemon will
still get the FEK, but that FEK will never be used because the file
create attempt will fail.

The included patch makes this correction.

> - _why_ does it use netlink?

Netlink provides the transport mechanism that would minimize the
complexity of the implementation, given that we can have multiple
daemons (one per user). I explored the possibility of using relayfs,
but that would involve having to introduce control channels and a
protocol for creating and tearing down channels for the daemons. We do
not have to worry about any of that with netlink.

---

Check the uid as well as the pid to authenticate a message from
userspace.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/ecryptfs_kernel.h |    3 ++-
 fs/ecryptfs/messaging.c       |   10 +++++++++-
 fs/ecryptfs/netlink.c         |    4 ++--
 3 files changed, 13 insertions(+), 4 deletions(-)

52cb76eae1dd6c8fe66ff02d4cfaba5714b20074
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index fcf6d8b..c61ef97 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -547,7 +547,8 @@ ecryptfs_process_cipher(struct crypto_tf
 
 int ecryptfs_process_helo(unsigned int transport, uid_t uid, pid_t pid);
 int ecryptfs_process_quit(uid_t uid, pid_t pid);
-int ecryptfs_process_response(struct ecryptfs_message *msg, pid_t pid, u32 seq);
+int ecryptfs_process_response(struct ecryptfs_message *msg, uid_t uid,
+			      pid_t pid, u32 seq);
 int ecryptfs_send_message(unsigned int transport, char *data, int data_len,
 			  struct ecryptfs_msg_ctx **msg_ctx);
 int ecryptfs_wait_for_response(struct ecryptfs_msg_ctx *msg_ctx,
diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
index bc6aaab..2242d76 100644
--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -242,7 +242,8 @@ unlock:
  * userspace. Returns zero upon delivery to desired context element;
  * non-zero upon delivery failure or error.
  */
-int ecryptfs_process_response(struct ecryptfs_message *msg, pid_t pid, u32 seq)
+int ecryptfs_process_response(struct ecryptfs_message *msg, uid_t uid,
+			      pid_t pid, u32 seq)
 {
 	struct ecryptfs_daemon_id *id;
 	struct ecryptfs_msg_ctx *msg_ctx;
@@ -267,6 +268,13 @@ int ecryptfs_process_response(struct ecr
 				msg_ctx->task->euid, pid);
 		goto wake_up;
 	}
+	if (msg_ctx->task->euid != uid) {
+		rc = -EBADMSG;
+		ecryptfs_printk(KERN_WARNING, "Received message from user "
+				"[%d]; expected message from user [%d]\n",
+				uid, msg_ctx->task->euid);
+		goto unlock;
+	}
 	if (id->pid != pid) {
 		rc = -EBADMSG;
 		ecryptfs_printk(KERN_ERR, "User [%d] received a "
diff --git a/fs/ecryptfs/netlink.c b/fs/ecryptfs/netlink.c
index aba061d..e3aa225 100644
--- a/fs/ecryptfs/netlink.c
+++ b/fs/ecryptfs/netlink.c
@@ -107,8 +107,8 @@ static int ecryptfs_process_nl_response(
 				"incorrectly specified data length\n");
 		goto out;
 	}
-	rc = ecryptfs_process_response(msg, NETLINK_CREDS(skb)->pid,
-				       nlh->nlmsg_seq);
+	rc = ecryptfs_process_response(msg, NETLINK_CREDS(skb)->uid,
+				       NETLINK_CREDS(skb)->pid, nlh->nlmsg_seq);
 	if (rc)
 		printk(KERN_ERR
 		       "Error processing response message; rc = [%d]\n", rc);
-- 
1.3.3

