Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265841AbUF2RIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUF2RIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 13:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUF2RIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 13:08:55 -0400
Received: from lakermmtao02.cox.net ([68.230.240.37]:8399 "EHLO
	lakermmtao02.cox.net") by vger.kernel.org with ESMTP
	id S265841AbUF2RHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 13:07:49 -0400
In-Reply-To: <5447.1087993789@redhat.com>
References: <643CA25E-C091-11D8-8574-000393ACC76E@mac.com> <984AC744-BFFB-11D8-8574-000393ACC76E@mac.com> <FC6EBB12-BF27-11D8-95EB-000393ACC76E@mac.com> <1087282990.13680.13.camel@lade.trondhjem.org> <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <1087080664.4683.8.camel@lade.trondhjem.org> <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com> <1087084736.4683.17.camel@lade.trondhjem.org> <DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com> <87smcxqqa2.fsf@asterisk.co.nz> <8666.1087292194@redhat.com> <10430.1087397355@redhat.com> <30952.1087472906@redhat.com> <5447.1087993789@redhat.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D3C62886-C9EE-11D8-947A-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Blair Strang <bls@asterisk.co.nz>, lkml <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Tue, 29 Jun 2004 13:07:39 -0400
To: David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I have some free time this week to code up a patch.  To start with 
everything
will rely on being in process context just to make things simple.  
Here's a short
summary of everything we've agreed upon so far:

1)	A key-ring is an object independent of what uses it.  It supports 
operations
to read, modify, and search it.

2)	When a key-ring is searched for a particular key by name and type, 
first
it checks all keys of the specified type within said key-ring.  If it 
does not find it
there, then it proceeds with all sub-key-rings.

3)	Keys and key-rings are allocated and referenced through an 
independent
number space (Somewhat like the PID allocator)

4)	Key and key-ring access should be controlled using permissions and
POSIX ACLs as though they were files.  In this case, however, the 
"execute"
permission bit is used to control in-kernel operations on the keys (EX: 
AES
encrypting a block of data using CryptoAPI without being able to read 
the key.

5)	Key-rings should be automatically associated with the following 
things.
This is also the search order when looking for a key.
Thread
Process
Process Group
Session
User
Group

6)	User process with the appropriate privileges (Perhaps a new 
capability
CAP_LINUX_KEYS or something) can modify/search/link/whatever any/all
keyrings.  (I'm still not quite sure how much should be allowed.)

7)	All algorithms working with keys and keyrings should be iterative, 
not
recursive, and should be run it process context.

8)	Graphs of nested key-rings must be non-circular.

9)	All memory allocated for key-rings and keys should be counted from
various limits associated with users/processes/etc.

10)	All kernel key-types should begin with a "+" character, and 
user-space
cannot use an unregistered key-type that begins with a "+" character. 
(This
means that all keys having a key-type beginning with a "+" character 
have
been validated by kernel code.

11)	A key-ring filesystem should be mounted on /proc/keys:	
	types
	keys/
		<keyID>/
			control
			type
			description
			state
  		<keyringID>/
			control
			type
			description
			state
  			<keyID> => ../<keyID> [symlink]

12)	It should be impossible to look up keys by number unless said key
filesystem is mounted.  The "control" entries in the key filesystem can 
be
open()ed to get the kind of file handle that KETCTL manipulates.

13)	A new syscall "keyctl":

KEYCTL_NEW_RING:	Creates a new key-ring and returns its fd
	Returns:	int filedesc
	Params:
		char *desc
		int *subkeys
		long subkey_count

KEYCTL_NEW_KEY:	Creates a new key and returns its fd
	Returns:	int filedesc
	Params:
		char *type
		char *desc
		void *data

KEYCTL_SHLOCK
KEYCTL_EXLOCK
KEYCTL_UNLOCK:	A mandatory lock on the key/key-ring
	Returns:	int error
	Params:
		int filedesc
		int flags

KEYCTL_TYPE:	Retrieves the "type" field
	Returns:	long bytes_left
	Params:
		char *desc
		long size

KEYCTL_DESC:	Retrieves the "desc" field
	Returns:	long bytes_left
	Params:
		char *desc
		long size

KEYCTL_READ:	Retrieves the "data" field
	Returns:	long bytes_left
	Params:
		char *data
		long size

KEYCTL_WRITE:	Modifies the "data" field
	Returns:	int error
	Params:
		char *data
		long size

KEYCTL_GET:	Retrieves the current key fd
	Returns:	int filedesc
	Params:
		int type
			KEY_THREAD
			KEY_PROCESS
			KEY_PGROUP
			KEY_SESSION
			KEY_USER
			KEY_GROUP

KEYCTL_SET:	Modifies the current key fd
	Returns:	int error
	Params:
		int type
			<See above KEYCTL_GET_KEY>
		int filedesc

KEYCTL_ENUM: Enumerates through all keys. NOTE: This must only be
called with a KEYCTL_SHLOCK, otherwise it might skip keys or repeat
keys.
	Returns:	int error
	Params:
		int keyring_fd
		int *key_fd

KEYCTL_LOOKUP:	Look for a key by type, but don't recurse
	Returns:	int filedesc

KEYCTL_SEARCH:	Searches for a specific key by type
	Returns:	int filedesc
	Params:
		char *type
		char *desc

KEYCTL_ADD:	Adds a key to a key-ring
	Returns:	int error
	Params:
		int keyring_fd
		int key_fd

KEYCTL_REMOVE:	Removes a key from a key-ring
	Returns:	int error
	Params:
		int keyring_fd
		int key_fd

KEYCTL_CLEAR:	Removes all keys from a key-ring
	Returns:	int error
	Params:
		int keyring_fd

KEYCTL_REVOKE:	Revokes a specific key file descriptor and any key
file descriptors it spawned.  This should even apply to keyrings!
	Returns:	int error
	Params:
		int filedesc


I think that's just about everything.  Let me know if I got something 
wrong
or have another problem with the above.

Cheers,
Kyle Moffett


