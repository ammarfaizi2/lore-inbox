Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUHGITz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUHGITz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 04:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266339AbUHGITz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 04:19:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:23509 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266333AbUHGITu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 04:19:50 -0400
Date: Sat, 7 Aug 2004 01:17:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, arjanv@redhat.com,
       dwmw2@infradead.org, jmorris@redhat.com, greg@kroah.com,
       chrisw@osdl.org, sfrench@samba.org, mike@halcrow.us,
       trond.myklebust@fys.uio.no, mrmacman_g4@mac.com
Subject: Re: [PATCH] implement in-kernel keys & keyring management
Message-Id: <20040807011758.62831dbf.akpm@osdl.org>
In-Reply-To: <6453.1091838705@redhat.com>
References: <6453.1091838705@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> I've made available a patch that does a better job of key and keyring
>  management for authentication, cryptography, etc.. I've added a good bit of
>  documentation and I've commented the code more thoroughly.

Nicely presented patch, thanks.

- Why have a separate key_user structure, rather than adding stuff to
  struct user_struct?  This appears to be feasible.

- I had a hard time working out the locking which protects key->flags. 
  It looks racy.

- Are the various system-wide locks going to end up hurting on big SMP?

- user_describe_key() appears to leak a key ref if kmalloc() fails. 
  user_describe_key() appears to leak a key ref if copy_to_user() faults. 
  The one-return-statement-per-function rule rules.

- Various people are likely to get upset about this:

  asmlinkage long sys_keyctl(int option, unsigned long arg2, unsigned long arg3,
		   unsigned long arg4, unsigned long arg5)

  I guess the pure way to do it is to add 13 new syscalls....

- I really hesitate to stick my nose into this perennial, but
  keyring_hash() is a bit lame.  I once read that

	hash = hash * 33 + *p++;

  works as well as pretty much anything else.

- All that keyring tree management (keyring_detect_cycle) looks tricky. 
  Do we really need such complexity?

- __key_link() does

	/* dispose of the old keyring list */
	if (klist)
		kfree(klist);

  but elsewhere you freely do kfree(0)

- Why does the proc code do spin_lock_irq(&key_user_lock)?  Other
  process-context code just does spin_lock().

- In key_create_or_update():

	mode = 0100;
	if (ktype == &key_type_keyring)
		mode = 0700;
	else if (ktype == &key_type_user)
		mode = 0700;
	else if (ktype->update)
		mode |= 0300;

  you've used the stat.h symbols elsewhere.

- How come install_process_keyring() and friends take task_lock() around
  the key_put()?  It's not done elsewhere.

  Please update the what-it-locks comment over task_lock()

- Documentation/CodingStyle doesn't mention

		if (clone_flags & CLONE_THREAD) {
			atomic_inc(&tsk->process_keyring->usage);
		}
		else {

- join_session_keyring() leaks the memory at `name'.  Trivial DoS hole. 
  Please audit the whole patch.

- request_key_construction() leaks `key' if __call_request_key() fails. 
  Multiple return statements again...

- request_key() appears to leak a ref to the key if key_user_lookup()
  fails.  Multiple return statements.

- In user_instantiate():

	if (!key->payload.data) {
		key_put(key->payload.data);

  the key_put() can be removed.


It's a lot of code, isn't it?
