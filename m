Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbULVIzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbULVIzu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 03:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbULVIzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 03:55:49 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:29774 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261935AbULVIzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 03:55:38 -0500
Message-ID: <41C93687.5050508@tls.msk.ru>
Date: Wed, 22 Dec 2004 11:55:35 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: rmmod & O_NONBLOCK: why to block?
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With "new" (not so new anymore) module infrastructure,
the caller -- in delete_module() syscall -- may specify
O_NONBLOCK to indicate it is not willing to wait for
the module refcount to become 0 -- IF I understand this
flag correctly.

Yet it is not really honored by the kernel, kernel places
the process who issued remove_module() call into uninterruptable
state.

Current rmmod from module-init-tools first checks whenever
the use count is zero, and if it is, tries to remove the
module (not that simple, there's also forced unload etc,
but basically that's it).  But it's trivial to have a race
here: when we looked for refcount, it was zero, but when
we're trying to do actual remove, it is not anymore: rmmod
will block, even without -w flag.

Here's the relevant code from kernel/module.c, "simplified"
a bit for better readability:

int try_stop_module(mod, flags) {
    foreach_cpu() { // actually stop_machine_run()
       /* If it's not unused, quit unless we are told to block. */
       if ((flags & O_NONBLOCK) && module_refcount(mod) != 0) {
          if (!try_force(flags))
            return -EWOULDBLOCK;
       }
    }
    return 0;
}

long sys_delete_module(module, flags) {
         ...
         /* Set this up before setting mod->state */
         mod->waiter = current;

         /* Stop the machine so refcounts can't move and disable module. */
         ret = try_stop_module(mod, flags, &forced);

         /* Never wait if forced. */
         if (!forced && module_refcount(mod) != 0)
                 wait_for_zero_refcount(mod);

         free_module(mod);
         return ret;
}

In short, try_stop_module() can return -EWOULDBLOCK (or stop_machine_run()
may fail for other reasons too), but the return value is never checked...
Should there be an "if (ret != 0) return ret;" somewhere right after
try_stop_module() call?  But since I don't quite understand all the
logic here, I don't know what to do with mod->waiter assigned in the
previous line.

(And, I'm not sure stop_machine_run() returns whatever result actual
routine returned, -EWOULDBLOCK in this case).

BTW, why this wait_for_zero_refcount() at all?  Why/where/how it can be
useful?  It's relatively easy to implement in userspace with try/sleep
loop, but having unkillable processes in wait_for_zero_refcount state
isn't good...

Comments anyone?

/mjt
