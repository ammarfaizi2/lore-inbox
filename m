Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268222AbTCAEpf>; Fri, 28 Feb 2003 23:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268451AbTCAEpf>; Fri, 28 Feb 2003 23:45:35 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:16073 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S268222AbTCAEpb>;
	Fri, 28 Feb 2003 23:45:31 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303010455.h214tpO11048@csl.stanford.edu>
Subject: [CHECKER] a few race conditions
To: linux-kernel@vger.kernel.org
Date: Fri, 28 Feb 2003 20:55:51 -0800 (PST)
Cc: mc@cs.stanford.edu
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

here are a small number of initial results from a static race condition
checker.  If anyone has time, feedback on whether these are errors would
be great.  Also, if there are known races, let me know and I can make
sure we're finding them.

The checker works by statistically inferring which locks protect which
variables by:
	1. counting the number of times a given lock protects a given
	   variable versus not.  errors are flagged when locks that
	   that often protect a variable are omitted.

	2. if any critical section only has a single shared variable use
	   or function call, the checker assumes the lock must protect
	   the var/function.  e.g.,:
			lock(l);
			foo();
			unlock(l);
	   the checker assumes l must protect foo and whines when it does
	   not.
	   
The message format is a bit confusing.  It gives the places where the
checker thinks there are errors, and then a short list of examples
that made it think that an omitted lock protects the variable.

The checker is currently very much under development, but I'd like to
make it rock solid.

Dawson
-----------------------------------------------------------------------

BUG: pair: lock=<ad1848_t.reg_lock>, var=<snd_ad1848_out>

  z score=0.53
  singles = 1
  first = 2
  last = 3
  global-var
  1 error out of 8 uses:
     /u2/engler/mc/oses/linux/linux-2.5.53/sound/isa/ad1848/ad1848_lib.c:669:snd_ad1848_probe: ERROR: var <snd_ad1848_out> not protected by <ad1848_t.reg_lock>(pop=8, s=7) [locked=0] 
  ====================================
  7 examples:
    /u2/engler/mc/oses/linux/linux-2.5.53/sound/isa/cmi8330.c:397:snd_cmi8330_probe: NOTE: var <snd_ad1848_out> protected by <ad1848_t.reg_lock> [annot=single] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/sound/isa/cmi8330.c:snd_cmi8330_probe:395] (pop=8, s=7)
    /u2/engler/mc/oses/linux/linux-2.5.53/sound/isa/ad1848/ad1848_lib.c:642:snd_ad1848_probe: NOTE: var <snd_ad1848_out> protected by <ad1848_t.reg_lock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/sound/isa/ad1848/ad1848_lib.c:snd_ad1848_probe:641] (pop=8, s=7)
    /u2/engler/mc/oses/linux/linux-2.5.53/sound/isa/ad1848/ad1848_lib.c:581:snd_ad1848_capture_prepare: NOTE: var <snd_ad1848_out> protected by <ad1848_t.reg_lock> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/sound/isa/ad1848/ad1848_lib.c:snd_ad1848_capture_prepare:580] (pop=8, s=7)

---------------------------------------------
BUG: pair: lock=<atm_dev_lock:spinlock_t:0>, var=<atm_devs,struct atm_dev,1>
  global-var
  1 error out of 6 uses:
     /u2/engler/mc/oses/linux/linux-2.5.53/net/atm/proc.c:382:atm_svc_info: ERROR: var <atm_devs,struct atm_dev,1> not protected by <atm_dev_lock:spinlock_t:0>(pop=6, s=5) [locked=0]

        left = pos-1;
        for (dev = atm_devs; dev; dev = dev->next)
                for (vcc = dev->vccs; vcc; vcc = vcc->next)
                        if (vcc->family == PF_ATMSVC && !left--) {
                                svc_info(vcc,buf);
                                return strlen(buf);

  ====================================
  5 examples:
    /u2/engler/mc/oses/linux/linux-2.5.53/net/atm/signaling.c:224:sigd_close: NOTE: var <atm_devs,struct atm_dev,1> protected by <atm_dev_lock:spinlock_t:0> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/net/atm/signaling.c:sigd_close:223] (pop=6, s=5)

        spin_lock (&atm_dev_lock);
        for (dev = atm_devs; dev; dev = dev->next) purge_vccs(dev->vccs);
        spin_unlock (&atm_dev_lock);

    /u2/engler/mc/oses/linux/linux-2.5.53/net/atm/common.c:312:atm_connect_vcc: NOTE: var <atm_devs,struct atm_dev,1> protected by <atm_dev_lock:spinlock_t:0> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/net/atm/common.c:atm_connect_vcc:311] (pop=6, s=5)


---------------------------------------------
BUG: pair: lock=<ax25_route_lock:rwlock_t:0>, var=<ax25_route_list,ax25_route,1>
  global-var
  1 error out of 5 uses:
     /u2/engler/mc/oses/linux/linux-2.5.53/net/ax25/ax25_route.c:499:ax25_rt_free: ERROR: var <ax25_route_list,ax25_route,1> not protected by <ax25_route_lock:rwlock_t:0>(pop=5, s=4) [locked=0]


void __exit ax25_rt_free(void)
{
        ax25_route *s, *ax25_rt = ax25_route_list;

        write_unlock(&ax25_route_lock);
        while (ax25_rt != NULL) {
                s       = ax25_rt;
                ax25_rt = ax25_rt->next;

                if (s->digipeat != NULL)
                        kfree(s->digipeat);

                kfree(s);
        }
        write_unlock(&ax25_route_lock);

  ====================================
  4 examples:
    /u2/engler/mc/oses/linux/linux-2.5.53/net/ax25/ax25_route.c:64:ax25_rt_device_down: NOTE: var <ax25_route_list,ax25_route,1> protected by <ax25_route_lock:rwlock_t:0> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/net/ax25/ax25_route.c:ax25_rt_device_down:63] (pop=5, s=4)
    /u2/engler/mc/oses/linux/linux-2.5.53/net/ax25/ax25_route.c:357:ax25_get_route: NOTE: var <ax25_route_list,ax25_route,1> protected by <ax25_route_lock:rwlock_t:0> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/net/ax25/ax25_route.c:ax25_get_route:352] (pop=5, s=4)
    /u2/engler/mc/oses/linux/linux-2.5.53/net/ax25/ax25_route.c:224:ax25_rt_opt: NOTE: var <ax25_route_list,ax25_route,1> protected by <ax25_route_lock:rwlock_t:0> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/net/ax25/ax25_route.c:ax25_rt_opt:222] (pop=5, s=4)
    /u2/engler/mc/oses/linux/linux-2.5.53/net/ax25/ax25_route.c:293:ax25_rt_get_info: NOTE: var <ax25_route_list,ax25_route,1> protected by <ax25_route_lock:rwlock_t:0> [annot=none] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/net/ax25/ax25_route.c:ax25_rt_get_info:289] (pop=5, s=4)


---------------------------------------------
BUG FALSE pair: lock=<dcache_lock:spinlock_t:0>, var=<struct inode.i_dentry>
  2 errors out of 5 uses:
     /u2/engler/mc/oses/linux/linux-2.5.53/fs/dcache.c:284:d_prune_aliases: ERROR: var <struct inode.i_dentry> not protected by <dcache_lock:spinlock_t:0>(pop=5, s=3) [locked=0]

        i think this actually is a race: other places check it.

void d_prune_aliases(struct inode *inode)
{
        struct list_head *tmp, *head = &inode->i_dentry;
restart:
        spin_lock(&dcache_lock);


  3 examples:
    /u2/engler/mc/oses/linux/linux-2.5.53/fs/intermezzo/dcache.c:189:presto_try_find_alias_with_dd: NOTE: var <struct inode.i_dentry> protected by <dcache_lock:spinlock_t:0> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/fs/intermezzo/dcache.c:presto_try_find_alias_with_dd:188] (pop=5, s=3)
    /u2/engler/mc/oses/linux/linux-2.5.53/fs/affs/amigaffs.c:138:affs_fix_dcache: NOTE: var <struct inode.i_dentry> protected by <dcache_lock:spinlock_t:0> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/fs/affs/amigaffs.c:affs_fix_dcache:137] (pop=5, s=3)
    /u2/engler/mc/oses/linux/linux-2.5.53/fs/dcache.c:256:d_find_alias: NOTE: var <struct inode.i_dentry> protected by <dcache_lock:spinlock_t:0> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/fs/dcache.c:d_find_alias:255] (pop=5, s=3)


---------------------------------------------
BUG: pair: lock=<lock_kernel:none:1>, var=<rpc_execute>
  z score=0.38
  singles = 3
  last = 1
  global-lock
  global-var
  1 error out of 7 uses:
     /u2/engler/mc/oses/linux/linux-2.5.53/fs/nfs/nfs4proc.c:1561:nfs4_proc_renew: ERROR: var <rpc_execute> not protected by <lock_kernel:none:1>(pop=7, s=6) [locked=0]
  ====================================
  6 examples:
    /u2/engler/mc/oses/linux/linux-2.5.53/fs/nfs/write.c:980:nfs_commit_list: NOTE: var <rpc_execute> protected by <lock_kernel:none:1> [annot=single] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/fs/nfs/write.c:nfs_commit_list:979] (pop=7, s=6)
    /u2/engler/mc/oses/linux/linux-2.5.53/fs/nfs/write.c:780:nfs_flush_one: NOTE: var <rpc_execute> protected by <lock_kernel:none:1> [annot=single] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/fs/nfs/write.c:nfs_flush_one:779] (pop=7, s=6)
    /u2/engler/mc/oses/linux/linux-2.5.53/fs/nfs/read.c:217:nfs_pagein_one: NOTE: var <rpc_execute> protected by <lock_kernel:none:1> [annot=single] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/fs/nfs/read.c:nfs_pagein_one:216] (pop=7, s=6)

---------------------------------------------
BUG: pair: lock=<lock_kernel:none:1>, var=<struct inode.i_flock>
  global-lock
  4 errors out of 14 uses:
     /u2/engler/mc/oses/linux/linux-2.5.53/fs/locks.c:1116:lease_get_mtime: ERROR: var <struct inode.i_flock> not protected by <lock_kernel:none:1>(pop=14, s=10) [locked=0]

        sure looks like a race; or are these fields monotonic?


  ====================================
  10 examples:
    /u2/engler/mc/oses/linux/linux-2.5.53/fs/locks.c:724:flock_lock_file: NOTE: var <struct inode.i_flock> protected by <lock_kernel:none:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/fs/locks.c:flock_lock_file:723] (pop=14, s=10)
    /u2/engler/mc/oses/linux/linux-2.5.53/fs/locks.c:1912:lock_may_write: NOTE: var <struct inode.i_flock> protected by <lock_kernel:none:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/fs/locks.c:lock_may_write:1911] (pop=14, s=10)
    /u2/engler/mc/oses/linux/linux-2.5.53/fs/locks.c:1669:locks_remove_flock: NOTE: var <struct inode.i_flock> protected by <lock_kernel:none:1> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/fs/locks.c:locks_remove_flock:1668] (pop=14, s=10)

---------------------------------------------
BUG pair: lock=<rt6_lock:rwlock_t:0>, var=<fn,struct fib6_node,0>

  z score=1.61
  1 error out of 19 uses:
     /u2/engler/mc/oses/linux/linux-2.5.53/net/ipv6/route.c:1057:rt6_get_dflt_router: ERROR: var <fn,struct fib6_node,0> not protected by <rt6_lock:rwlock_t:0>(pop=19, s=18) [locked=0]

        fn = &ip6_routing_table;

        write_lock_bh(&rt6_lock);
        for (rt = fn->leaf; rt; rt=rt->u.next) {
                if (dev == rt->rt6i_dev &&
                    ipv6_addr_cmp(&rt->rt6i_gateway, addr) == 0)
                        break;
        }
        if (rt)
                dst_clone(&rt->u.dst);



---------------------------------------------
BUG pair: lock=<struct inode.i_sem>, var=<notify_change>
  last = 2
  global-var
  4 errors out of 11 uses:
     /u2/engler/mc/oses/linux/linux-2.5.53/fs/hpfs/namei.c:384:hpfs_unlink: ERROR: var <notify_change> not protected by <struct inode.i_sem>(pop=11, s=7) [locked=0]
     /u2/engler/mc/oses/linux/linux-2.5.53/fs/nfsd/vfs.c:1192:nfsd_symlink: ERROR: var <notify_change> not protected by <struct inode.i_sem>(pop=11, s=7) [locked=0]
     /u2/engler/mc/oses/linux/linux-2.5.53/fs/nfsd/vfs.c:298:nfsd_setattr: ERROR: var <notify_change> not protected by <struct inode.i_sem>(pop=11, s=7) [locked=0]
  ====================================
  7 examples:
    /u2/engler/mc/oses/linux/linux-2.5.53/fs/open.c:269:sys_utime: NOTE: var <notify_change> protected by <struct inode.i_sem> [annot=single] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/fs/open.c:sys_utime:268] (pop=11, s=7)
    /u2/engler/mc/oses/linux/linux-2.5.53/fs/open.c:314:do_utimes: NOTE: var <notify_change> protected by <struct inode.i_sem> [annot=single] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/fs/open.c:do_utimes:313] (pop=11, s=7)
    /u2/engler/mc/oses/linux/linux-2.5.53/fs/nfsd/vfs.c:733:nfsd_write: NOTE: var <notify_change> protected by <struct inode.i_sem> [annot=single] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/fs/nfsd/vfs.c:nfsd_write:732] (pop=11, s=7)
    /u2/engler/mc/oses/linux/linux-2.5.53/fs/open.c:559:chown_common: NOTE: var <notify_change> protected by <struct inode.i_sem> [annot=single] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/fs/open.c:chown_common:558] (pop=11, s=7)

---------------------------------------------
BUG: pair: lock=<tasklist_lock:rwlock_t:0>, var=<init_task,struct task_struct,1>
  global-var
  1 error out of 13 uses:
     /u2/engler/mc/oses/linux/linux-2.5.53/drivers/char/sysrq.c:308:send_sig_all: ERROR: var <init_task,struct task_struct,1> not protected by <tasklist_lock:rwlock_t:0>(pop=13, s=12) [locked=0]
  ====================================
  12 examples:
    /u2/engler/mc/oses/linux/linux-2.5.53/fs/proc/base.c:1163:get_pid_list: NOTE: var <init_task,struct task_struct,1> protected by <tasklist_lock:rwlock_t:0> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/fs/proc/base.c:get_pid_list:1162] (pop=13, s=12)

        read_lock(&tasklist_lock);
        for_each_process(p) {

    /u2/engler/mc/oses/linux/linux-2.5.53/fs/proc/inode.c:238:proc_fill_super: NOTE: var <init_task,struct task_struct,1> protected by <tasklist_lock:rwlock_t:0> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/fs/proc/inode.c:proc_fill_super:237] (pop=13, s=12)
    /u2/engler/mc/oses/linux/linux-2.5.53/fs/namespace.c:939:chroot_fs_refs: NOTE: var <init_task,struct task_struct,1> protected by <tasklist_lock:rwlock_t:0> [annot=first] [level=0] [path=/u2/engler/mc/oses/linux/linux-2.5.53/fs/namespace.c:chroot_fs_refs:938] (pop=13, s=12)

