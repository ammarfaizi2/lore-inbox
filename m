Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbTERJWR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 05:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTERJWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 05:22:17 -0400
Received: from zeus.kernel.org ([204.152.189.113]:25021 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261998AbTERJWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 05:22:14 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200305180921.h4I9LdD13274@oboe.it.uc3m.es>
Subject: recursive spinlocks. Shoot.
To: linux-kernel@vger.kernel.org
Date: Sun, 18 May 2003 11:21:39 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a before-breakfast implementation of a recursive spinlock. That
is, the same thread can "take" the spinlock repeatedly. This is crude -
I just want to focus some attention on the issue (while I go out and
have breakfast :'E).

The idea is to implement trylock correctly, and then get lock and
unlock from that via the standard algebra. lock is a loop doing
a trylock until it succeeds. We emerge from a successful trylock
with the lock notionally held.

The "spinlock" is a register of the current pid, plus a recursion
counter, with atomic access.  The pid is either -1 (unset, count is
zero) or some decent value (count is positive).

The trylock will succeed and set the pid if it is currently unset.  It
will succeed if the pid matches ours, and increment the count of
holders.

Unlock just decrements the count.  When we've unlocked enough times,
somebody else can take the lock.


The objection to this scheme that I have is

  1) its notion of identity is limited to the pid, which is crude
  2) it doesn't detect dead holders of the lock, which would be nice
  3) it should probably be done in assembler, using whatever trick
     rwlocks use
  4) it doesn't actually use a real spinlock to "hold" the lock, which
     makes me nervous.


typedef struct recursive_spinlock {
        spinlock_t lock;
        int pid;
        int count;
} recursive_spinlock_t;

int recursive_spin_trylock(recursive_spinlock_t *lock) {
        
        spin_lock(&lock->lock);
        if (lock->count <= 0) {
                // greenfield site
                lock->pid = current->pid;
                lock->count = 1;
                spin_unlock(&lock->lock);
                return 0;
        }
        // somebody has the lock
        if (lock->pid == current->pid) {
                // it was us! return ok`
                lock->count++;
                spin_unlock(&lock->lock);
                return 0;
        } 
        // somebody has the lock and it's not us! return fail
        spin_unlock(&lock->lock);
        return 1;
}

void recursive_spin_lock(recursive_spinlock_t *lock) {
        while (recursive_spin_trylock(lock) != 0);
}

void recursive_spin_unlock(recursive_spinlock_t *lock) {
        spin_lock(&lock->lock);
        if (--lock->count <= 0)
                lock->count = 0;
        spin_unlock(&lock->lock);
}

void recursive_spinlock_init(recursive_spinlock_t *lock) {
        spinlock_init(&lock->lock);
        lock->pid = -1;
        lock->count = 0;
}


Peter
