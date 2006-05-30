Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWE3JXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWE3JXW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 05:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWE3JXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 05:23:22 -0400
Received: from mail.gmx.de ([213.165.64.20]:30427 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932204AbWE3JXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 05:23:21 -0400
X-Authenticated: #14349625
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060530063724.GE19870@elte.hu>
References: <20060529212109.GA2058@elte.hu> <1148964741.7704.10.camel@homer>
	 <20060530063724.GE19870@elte.hu>
Content-Type: text/plain
Date: Tue, 30 May 2006 11:25:34 +0200
Message-Id: <1148981134.8532.5.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 08:37 +0200, Ingo Molnar wrote:
> * Mike Galbraith <efault@gmx.de> wrote:
> 
> > Darn.  It said all tests passed, then oopsed.
> > 
> > (have .config all gzipped up if you want it)
> 
> yeah, please.

(sent off list)

> > EIP:    0060:[<b103a872>]    Not tainted VLI
> > EFLAGS: 00010083   (2.6.17-rc4-mm3-smp #157)
> > EIP is at count_matching_names+0x5b/0xa2
> 
> > 1151            list_for_each_entry(type, &all_lock_types, lock_entry) {
> > 1152                    if (new_type->key - new_type->subtype == type->key)
> > 1153                            return type->name_version;
> > 1154                    if (!strcmp(type->name, new_type->name))  <--kaboom
> > 1155                            count = max(count, type->name_version);
> 
> hm, while most code (except the one above) is prepared for type->name 
> being NULL, it should not be NULL. Maybe an uninitialized lock slipped 
> through? Please try the patch below - it both protects against 
> type->name being NULL in this place, and will warn if it finds a NULL 
> lockname.

Got the warning.  It failed testing, but booted.

Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBTYPES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... TYPEHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 696 kB
 per task-struct memory footprint: 1080 bytes
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
BUG: warning at kernel/lockdep.c:1977/lockdep_init_map()
 <b1003dd2> show_trace+0xd/0xf  <b10044c0> dump_stack+0x17/0x19
 <b103badf> lockdep_init_map+0x10a/0x10f  <b10398d7> __mutex_init+0x3b/0x44
 <b11d4601> init_type_X+0x37/0x4d  <b11d4638> init_shared_types+0x21/0xaa
 <b11dcca3> locking_selftest+0x76/0x1889  <b1597657> start_kernel+0x1e7/0x400
 <b1000210> 0xb1000210 
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 A-B-B-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |FAILED|  ok  |  ok  |  ok  |
                    double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |FAILED|             |  ok  |
  --------------------------------------------------------------------------
                non-nested unlock:FAILED|FAILED|FAILED|FAILED|
  ------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:  ok  |  ok  |FAILED|
     soft-irqs-on + irq-safe-A/12:  ok  |  ok  |FAILED|
     hard-irqs-on + irq-safe-A/21:  ok  |  ok  |FAILED|
     soft-irqs-on + irq-safe-A/21:  ok  |  ok  |FAILED|
       sirq-safe-A => hirqs-on/12:  ok  |  ok  |FAILED|
       sirq-safe-A => hirqs-on/21:  ok  |  ok  |FAILED|
         hard-safe-A + irqs-on/12:  ok  |  ok  |FAILED|
         soft-safe-A + irqs-on/12:  ok  |  ok  |FAILED|
         hard-safe-A + irqs-on/21:  ok  |  ok  |FAILED|
         soft-safe-A + irqs-on/21:  ok  |  ok  |FAILED|
    hard-safe-A + unsafe-B #1/123:  ok  |  ok  |FAILED|
    soft-safe-A + unsafe-B #1/123:  ok  |  ok  |FAILED|
    hard-safe-A + unsafe-B #1/132:  ok  |  ok  |FAILED|
    soft-safe-A + unsafe-B #1/132:  ok  |  ok  |FAILED|
    hard-safe-A + unsafe-B #1/213:  ok  |  ok  |FAILED|
    soft-safe-A + unsafe-B #1/213:  ok  |  ok  |FAILED|
    hard-safe-A + unsafe-B #1/231:  ok  |  ok  |FAILED|
    soft-safe-A + unsafe-B #1/231:  ok  |  ok  |FAILED|
    hard-safe-A + unsafe-B #1/312:  ok  |  ok  |FAILED|
    soft-safe-A + unsafe-B #1/312:  ok  |  ok  |FAILED|
    hard-safe-A + unsafe-B #1/321:  ok  |  ok  |FAILED|
    soft-safe-A + unsafe-B #1/321:  ok  |  ok  |FAILED|
    hard-safe-A + unsafe-B #2/123:  ok  |  ok  |FAILED|
    soft-safe-A + unsafe-B #2/123:  ok  |  ok  |FAILED|
    hard-safe-A + unsafe-B #2/132:  ok  |  ok  |FAILED|
    soft-safe-A + unsafe-B #2/132:  ok  |  ok  |FAILED|
    hard-safe-A + unsafe-B #2/213:  ok  |  ok  |FAILED|
    soft-safe-A + unsafe-B #2/213:  ok  |  ok  |FAILED|
    hard-safe-A + unsafe-B #2/231:  ok  |  ok  |FAILED|
    soft-safe-A + unsafe-B #2/231:  ok  |  ok  |FAILED|
    hard-safe-A + unsafe-B #2/312:  ok  |  ok  |FAILED|
    soft-safe-A + unsafe-B #2/312:  ok  |  ok  |FAILED|
    hard-safe-A + unsafe-B #2/321:  ok  |  ok  |FAILED|
    soft-safe-A + unsafe-B #2/321:  ok  |  ok  |FAILED|
      hard-irq lock-inversion/123:  ok  |  ok  |FAILED|
      soft-irq lock-inversion/123:  ok  |  ok  |FAILED|
      hard-irq lock-inversion/132:  ok  |  ok  |FAILED|
      soft-irq lock-inversion/132:  ok  |  ok  |FAILED|
      hard-irq lock-inversion/213:  ok  |  ok  |FAILED|
      soft-irq lock-inversion/213:  ok  |  ok  |FAILED|
      hard-irq lock-inversion/231:  ok  |  ok  |FAILED|
      soft-irq lock-inversion/231:  ok  |  ok  |FAILED|
      hard-irq lock-inversion/312:  ok  |  ok  |FAILED|
      soft-irq lock-inversion/312:  ok  |  ok  |FAILED|
      hard-irq lock-inversion/321:  ok  |  ok  |FAILED|
      soft-irq lock-inversion/321:  ok  |  ok  |FAILED|
      hard-irq read-recursion/123:FAILED|
      soft-irq read-recursion/123:FAILED|
      hard-irq read-recursion/132:FAILED|
      soft-irq read-recursion/132:FAILED|
      hard-irq read-recursion/213:FAILED|
      soft-irq read-recursion/213:FAILED|
      hard-irq read-recursion/231:FAILED|
      soft-irq read-recursion/231:FAILED|
      hard-irq read-recursion/312:FAILED|
      soft-irq read-recursion/312:FAILED|
      hard-irq read-recursion/321:FAILED|
      soft-irq read-recursion/321:FAILED|
-----------------------------------------------------------------
BUG:  69 unexpected failures (out of 210) - debugging disabled! |
-----------------------------------------------------------------


