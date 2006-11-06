Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751907AbWKFSnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbWKFSnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 13:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWKFSnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 13:43:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61581 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751907AbWKFSnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 13:43:50 -0500
Date: Mon, 6 Nov 2006 13:32:58 -0500 (EST)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-20.boston.redhat.com
To: linux-kernel@vger.kernel.org
cc: mingo@elte.hu, arjan@infradead.org
Subject: locking hierarchy based on lockdep
Message-ID: <Pine.LNX.4.64.0611061315380.29750@dhcp83-20.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

So based on Ingo and Arjan's lockdep, i thought it would be interesting to 
generate a 'locking hierarchy' for the entire kernel. That is for each 
lock we assign a number, such that if a < b than lock a must be taken 
before lock b. I've done this by doing a depth first search on the lockdep 
structures already present in the kernel. This is not a unique ordering 
nor is it entirely correct, in the sense that if a path is not traversed 
by the kernel, the ordering produced might not be correct. Ideas for this 
list might be a starting point for Documenting the locking hierarchy or 
even producing a prescriptive lock checker for the kernel, which would 
have a lower runtime overhead...other ideas?

I've implemented this as a /proc file, but Ingo suggested that it might be 
better for us to simply produce an adjaceny list, and then generate a 
locking hierarchy or anything else of interest off of that list....In any 
case below is a patch that generates the hierarchy in a /proc file and 
i've included a list from a booted kernel...this patch isn't meant as 
'this should be merged' but rather as a starting point for a diccussion, 
if people are interested. 

thanks,

-jason


--- linux-2.6.18/include/linux/lockdep.h.bak	2006-11-01 09:27:23.000000000 -0500
+++ linux-2.6.18/include/linux/lockdep.h	2006-11-02 07:15:07.000000000 -0500
@@ -112,6 +119,7 @@ struct lock_class {
 
 	const char			*name;
 	int				name_version;
+	struct list_head		lock_ordering_entry; 
 };
 
 /*
@@ -132,6 +140,7 @@ struct lock_list {
 	struct list_head		entry;
 	struct lock_class		*class;
 	struct stack_trace		trace;
+	int				distance;
 };
 
 /*
--- linux-2.6.18/kernel/lockdep.c.bak	2006-11-01 08:57:22.000000000 -0500
+++ linux-2.6.18/kernel/lockdep.c	2006-11-02 07:14:40.000000000 -0500
@@ -48,7 +48,7 @@
  * to use a raw spinlock - we really dont want the spinlock
  * code to recurse back into the lockdep code.
  */
-static raw_spinlock_t hash_lock = (raw_spinlock_t)__RAW_SPIN_LOCK_UNLOCKED;
+raw_spinlock_t hash_lock = (raw_spinlock_t)__RAW_SPIN_LOCK_UNLOCKED;
 
 static int lockdep_initialized;
 
@@ -454,7 +454,7 @@ static void print_lock_dependencies(stru
  * Add a new dependency to the head of the list:
  */
 static int add_lock_to_list(struct lock_class *class, struct lock_class *this,
-			    struct list_head *head, unsigned long ip)
+			    struct list_head *head, unsigned long ip, int distance)
 {
 	struct lock_list *entry;
 	/*
@@ -466,6 +466,7 @@ static int add_lock_to_list(struct lock_
 		return 0;
 
 	entry->class = this;
+	entry->distance = distance;
 	save_trace(&entry->trace);
 
 	/*
@@ -856,7 +857,7 @@ check_deadlock(struct task_struct *curr,
  */
 static int
 check_prev_add(struct task_struct *curr, struct held_lock *prev,
-	       struct held_lock *next)
+	       struct held_lock *next, int distance)
 {
 	struct lock_list *entry;
 	int ret;
@@ -934,8 +935,11 @@ check_prev_add(struct task_struct *curr,
 	 *  L2 added to its dependency list, due to the first chain.)
 	 */
 	list_for_each_entry(entry, &prev->class->locks_after, entry) {
-		if (entry->class == next->class)
+		if (entry->class == next->class) {
+			if (distance == 1)
+				entry->distance = 1;
 			return 2;
+		}
 	}
 
 	/*
@@ -943,7 +947,8 @@ check_prev_add(struct task_struct *curr,
 	 * to the previous lock's dependency list:
 	 */
 	ret = add_lock_to_list(prev->class, next->class,
-			       &prev->class->locks_after, next->acquire_ip);
+			       &prev->class->locks_after, next->acquire_ip, distance);
+
 	if (!ret)
 		return 0;
 	/*
@@ -953,7 +958,7 @@ check_prev_add(struct task_struct *curr,
 	if (ret == 2)
 		return 2;
 	ret = add_lock_to_list(next->class, prev->class,
-			       &next->class->locks_before, next->acquire_ip);
+			       &next->class->locks_before, next->acquire_ip, distance);
 
 	/*
 	 * Debugging printouts:
@@ -999,13 +1004,14 @@ check_prevs_add(struct task_struct *curr
 		goto out_bug;
 
 	for (;;) {
+		int distance = curr->lockdep_depth - depth + 1;
 		hlock = curr->held_locks + depth-1;
 		/*
 		 * Only non-recursive-read entries get new dependencies
 		 * added:
 		 */
 		if (hlock->read != 2) {
-			check_prev_add(curr, hlock, next);
+			check_prev_add(curr, hlock, next, distance);
 			/*
 			 * Stop after the first non-trylock entry,
 			 * as non-trylock entries have added their
@@ -2702,3 +2708,45 @@ void debug_show_held_locks(struct task_s
 
 EXPORT_SYMBOL_GPL(debug_show_held_locks);
 
+//create a list of the lock ordering
+
+LIST_HEAD(ordering_list_head);
+
+void dfs_lock_sort(struct lock_class *class) {
+
+	struct lock_list *entry;
+
+	class->version = 1;
+
+	list_for_each_entry(entry, &class->locks_after, entry) {
+		if (entry->class->version == 0 && entry->distance == 1)
+			dfs_lock_sort(entry->class);
+	}
+
+	class->version = 2;
+	list_add(&class->lock_ordering_entry, &ordering_list_head);
+
+}
+
+
+struct list_head *generate_lock_ordering() {
+
+	struct lock_class *class;
+
+	//first mark everything not visisted.
+        list_for_each_entry(class, &all_lock_classes, lock_entry) {
+		class->version = 0;
+	}
+
+	INIT_LIST_HEAD(&ordering_list_head);
+
+	list_for_each_entry(class, &all_lock_classes, lock_entry) {
+		if (class->version == 0)
+			dfs_lock_sort(class);
+	}
+
+	return &ordering_list_head;	
+
+}
+
+
--- linux-2.6.18/kernel/lockdep_proc.c.bak	2006-11-01 08:57:32.000000000 -0500
+++ linux-2.6.18/kernel/lockdep_proc.c	2006-11-02 08:14:14.000000000 -0500
@@ -16,6 +16,7 @@
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
 #include <linux/debug_locks.h>
+#include <asm/uaccess.h>
 
 #include "lockdep_internals.h"
 
@@ -326,6 +327,43 @@ static struct file_operations proc_lockd
 	.release	= seq_release,
 };
 
+static int lockdep_ordering_show(struct seq_file *m, void *v)
+{
+
+	struct list_head *tmp_head;
+	struct lock_class *class;
+	unsigned long flags;
+	int i = 0;
+
+        raw_local_irq_save(flags);
+	__raw_spin_lock(&hash_lock);
+
+	tmp_head = generate_lock_ordering();
+
+	list_for_each_entry(class, tmp_head, lock_ordering_entry) {
+                seq_printf(m, "%i: %s\n", i, class->name);
+                i++;
+        }
+
+	__raw_spin_unlock(&hash_lock);
+	raw_local_irq_restore(flags);
+
+	return 0;
+
+}
+
+static int lockdep_ordering_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, lockdep_ordering_show, NULL);
+}
+
+static struct file_operations proc_lockdep_ordering_operations = {
+	.open		= lockdep_ordering_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static int __init lockdep_proc_init(void)
 {
 	struct proc_dir_entry *entry;
@@ -338,6 +376,10 @@ static int __init lockdep_proc_init(void
 	if (entry)
 		entry->proc_fops = &proc_lockdep_stats_operations;
 
+	entry = create_proc_entry("lockdep_ordering", S_IRUSR, NULL);
+	if (entry)
+		entry->proc_fops = &proc_lockdep_ordering_operations;
+
 	return 0;
 }
 
--- linux-2.6.18/kernel/lockdep_internals.h.bak	2006-11-02 08:18:24.000000000 -0500
+++ linux-2.6.18/kernel/lockdep_internals.h	2006-11-02 07:15:27.000000000 -0500
@@ -30,6 +30,8 @@
 #define MAX_STACK_TRACE_ENTRIES	262144UL
 
 extern struct list_head all_lock_classes;
+extern raw_spinlock_t hash_lock;
+extern struct list_head *generate_lock_ordering(void);
 
 extern void
 get_usage_chars(struct lock_class *class, char *c1, char *c2, char *c3, char *c4);



> cat /proc/lockdep_ordering


0: entries_lock
1: &undo_list->lock
2: slock-AF_INET
3: &fbc->lock
4: dst_lock
5: ip6_frag_lock
6: ipfrag_lock
7: allocated_ptys.lock
8: slock-AF_INET6
9: tcp_death_row.death_lock
10: fib6_gc_lock
11: i8253_beep_lock
12: &ids->mutex
13: &atkbd->event_mutex
14: vt_activate_queue.lock
15: &tty->atomic_read_lock
16: &entry->access
17: &im->lock
18: log_wait.lock
19: acpi_bus_event_queue.lock
20: acpi_system_event_lock
21: &type->s_umount_key
22: hci_dev_list_lock
23: old_style_rw_init
24: &list->lock
25: &d->lock
26: af_callback_keys + sk->sk_family
27: old_style_rw_init
28: hci_cb_list_lock
29: sk_lock-AF_BLUETOOTH
30: slock-AF_BLUETOOTH
31: old_style_rw_init
32: hci_task_lock
33: &ps->lock
34: hci_notifier.lock
35: &ep->lock
36: &ep->sem
37: &file->f_ep_lock
38: &type->s_umount_key
39: &type->s_lock_key
40: cache_list_lock
41: &key->sem
42: key_construction_sem
43: old_style_spin_init
44: key_serial_lock
45: key_user_lock
46: task_capability_lock
47: inet_peer_unused_lock
48: &rcu_bh_ctrlblk.lock
49: peer_pool_lock
50: &txdr->tx_lock
51: &adapter->tx_queue_lock
52: &adapter->stats_lock
53: af_callback_keys + sk->sk_family
54: sk_lock-AF_PACKET
55: &po->bind_lock
56: sk_lock-AF_INET
57: af_callback_keys + sk->sk_family
58: slock-AF_INET
59: inet_peer_idlock
60: rt_peer_lock
61: ip_conntrack_lock
62: ip6_ra_lock
63: ipv6_sk_ac_lock
64: sk_lock-AF_INET6
65: tcp_hashinfo.lhash_wait.lock
66: &newsk->sk_dst_lock
67: slock-AF_PACKET
68: ipv6_sk_mc_lock
69: af_callback_keys + sk->sk_family
70: tcp_hashinfo.lhash_lock
71: &sk->sk_dst_lock
72: udp_hash_lock
73: &xt[i].mutex
74: &table->lock
75: nf_sockopt_mutex
76: slock-AF_INET6
77: tcp_lock
78: &queue->syn_wait_lock
79: &tcp_hashinfo.bhash[i].lock
80: &tcp_hashinfo.ehash[i].lock
81: addrconf_hash_lock
82: addrconf_verify_lock
83: inet6_proto_lock
84: raw_v6_lock
85: inetsw6_lock
86: &policy->lock
87: disable_ratelimit_lock
88: performance_mutex
89: &type->s_umount_key
90: &type->s_lock_key
91: disks_mutex
92: all_mddevs_lock
93: cm_sbs_mutex
94: registration_lock
95: parportlist_lock
96: &tmp->waitlist_lock
97: &tmp->cad_lock
98: &tmp->pardevice_lock
99: topology_lock
100: ports_lock
101: full_list_lock
102: &card->power_lock
103: &ctl->read_lock
104: &card->files_lock
105: (struct lock_class_key *)id
106: ops_mutex
107: &chip->reg_lock
108: list_mutex
109: &card->ctl_files_rwlock
110: &card->controls_rwsem
111: &ac97->reg_mutex
112: idecd_ref_mutex
113: snd_card_mutex
114: register_lock
115: &grp->list_mutex
116: &grp->list_mutex
117: &grp->list_lock
118: register_mutex
119: &client->ports_mutex
120: &client->ports_lock
121: register_mutex
122: clients_lock
123: rng_mutex
124: cdrom_lock
125: register_mutex
126: sound_oss_mutex
127: sound_loader_lock
128: sg_dev_arr_lock
129: core_lists
130: i2c_adapter_idr.lock
131: snd_ioctl_rwsem
132: old_style_spin_init
133: sound_mutex
134: register_mutex
135: strings
136: info_mutex
137: fdc_wait.lock
138: command_done.lock
139: floppy_hlt_lock
140: dma_spin_lock
141: floppy_usage_lock
142: floppy_lock
143: &s->s_vfs_rename_mutex
144: sysfs_rename_sem
145: old_style_spin_init
146: &dev->up_mutex
147: &u->readlock
148: sk_lock-AF_NETLINK
149: slock-AF_NETLINK
150: kauditd_wait.lock
151: audit_backlog_wait.lock
152: &list->lock
153: audit_cmd_mutex
154: simple_transaction_lock
155: sk_lock-AF_UNIX
156: slock-AF_UNIX
157: &u->lock
158: &u->lock
159: &af_unix_sk_receive_queue_lock_key
160: af_callback_keys + sk->sk_family
161: unix_table_lock
162: init_signals.wait_chldexit.lock
163: &s->lock
164: load_mutex
165: sel_mutex
166: sel_netif_lock
167: audit_filter_mutex
168: &bdev->bd_mount_mutex
169: &type->s_umount_key
170: &journal->j_barrier
171: _event_lock
172: &md->map_lock
173: _hash_lock
174: old_style_spin_init
175: &dio->bio_lock
176: &bdev->bd_mutex
177: &p->lock
178: swapon_mutex
179: swap_lock
180: _lock
181: old_style_spin_init
182: _lock
183: &shost->free_list_lock
184: &shost->scan_mutex
185: sd_index_lock
186: sd_index_idr.lock
187: host_cmd_pool_mutex
188: (reboot_notifier_list).rwsem
189: old_style_spin_init
190: (module_notify_list).rwsem
191: old_style_spin_init
192: af_callback_keys + sk->sk_family
193: module_mutex
194: (munmap_notifier).rwsem
195: old_style_spin_init
196: policy_rwlock
197: &bdev->bd_mutex
198: open_lock
199: &new->reconfig_mutex
200: _minor_lock
201: _minor_idr.lock
202: &bdev->bd_mutex
203: sd_ref_mutex
204: &namespace_sem
205: &tty->atomic_write_lock
206: redirect_lock
207: uts_sem
208: old_style_spin_init
209: &mm->mmap_sem
210: &new->lock
211: &futex_queues[i].lock
212: &futex_queues[i].lock
213: &mm->mmap_sem
214: __pte_lockptr(new)
215: &per_cpu(flush_state, i).tlbstate_lock
216: __pte_lockptr(new)
217: tty_mutex
218: (console_sem).wait.lock
219: rif_lock
220: packet_sklist_lock
221: xfrm_km_lock
222: afinfo_lock
223: llc_sap_list_lock
224: leds_list_lock
225: triggers_list_lock
226: usb_bus_list_lock
227: &ehci->lock
228: (usb_notifier_list).rwsem
229: old_style_spin_init
230: mon_lock
231: deviceconndiscwq.lock
232: &type->s_umount_key
233: &type->s_lock_key
234: hcd_root_hub_lock
235: &uhci->lock
236: &retval->lock
237: &new_driver->dynids.lock
238: &urb->lock
239: hcd_data_lock
240: &type->s_umount_key
241: &type->s_lock_key
242: pin_fs_lock
243: tune_lock
244: block_subsys_lock
245: serial_mutex
246: port_mutex
247: &state->mutex
248: &tty->read_lock
249: &irq_lists[i].lock
250: probing_active
251: &blocking_pool.lock
252: cpufreq_driver_lock
253: &drv->dynids.lock
254: elv_list_lock
255: crypto_alg_sem
256: old_style_spin_init
257: &type->s_lock_key
258: &type->s_umount_key
259: nf_hook_lock
260: &type->s_umount_key
261: &type->s_lock_key
262: nls_lock
263: &type->s_umount_key
264: &type->s_umount_key
265: &type->s_lock_key
266: &type->s_umount_key
267: &type->s_umount_key
268: &type->s_umount_key
269: pdflush_lock
270: die_chain.lock
271: kprobe_mutex
272: serial_lock
273: audit_freelist_lock
274: &type->s_umount_key
275: uidhash_lock
276: tcp_cong_list_lock
277: raw_v4_lock
278: bdev_lock
279: xfrm_policy_afinfo_lock
280: xfrm_state_afinfo_lock
281: ptype_lock
282: neigh_tbl_lock
283: inetsw_lock
284: inet_proto_lock
285: cpufreq_governor_mutex
286: serio_mutex
287: &s->rwsem
288: device_state_lock
289: &serio->drv_mutex
290: psmouse_mutex
291: input_devices_poll_wait.lock
292: &dev->mutex
293: &ps2dev->cmd_mutex
294: i8042_lock
295: &serio->lock
296: serio_event_lock
297: serio_wait.lock
298: &type->s_umount_key
299: genl_mutex
300: qdisc_mod_lock
301: &dma_list_mutex
302: hub_event_lock
303: khubd_wait.lock
304: notify_lock
305: &dev->queue_lock
306: pnp_lock
307: acpi_link_lock
308: acpi_prt_lock
309: pci_lock
310: pci_bus_sem
311: old_style_spin_init
312: &k->k_lock
313: acpi_device_lock
314: acpi_gbl_gpe_lock
315: chrdevs_lock
316: sysrq_key_table_lock
317: pci_config_lock
318: init_mm.mmap_sem
319: old_style_spin_init
320: bus_type_sem
321: old_style_spin_init
322: &(per_cpu(listener_array, i).sem)
323: (task_exit_notifier).rwsem
324: old_style_spin_init
325: &fs->lock
326: net_todo_run_mutex
327: rtnl_mutex
328: rt6_lock
329: fib6_walker_lock
330: &ifa->lock
331: &in_dev->mc_tomb_lock
332: &in_dev->mc_list_lock
333: (inetaddr_chain).rwsem
334: &rt_hash_locks[i]
335: rt_flush_lock
336: fib_info_lock
337: fib_hash_lock
338: old_style_spin_init
339: &nlk->cb_lock
340: &mc->mca_lock
341: &dev->_xmit_lock
342: &idev->mc_lock
343: &ndev->lock
344: addrconf_lock
345: &list->lock
346: lweventlist_lock
347: sysctl_lock
348: &tbl->lock
349: &hh->hh_lock
350: &n->lock
351: &list->lock
352: dev_base_lock
353: qdisc_tree_lock
354: &dev->queue_lock
355: sequence_lock
356: nl_table_wait.lock
357: nl_table_lock
358: &nonblocking_pool.lock
359: net_family_lock
360: proto_list_lock
361: &type->s_umount_key
362: binfmt_lock
363: &k->list_lock
364: workqueue_mutex
365: &rcu_ctrlblk.lock
366: &inode->i_mutex
367: &inode->i_mutex
368: &p->pi_lock
369: cpu_add_remove_lock
370: (cpu_chain).rwsem
371: old_style_spin_init
372: panic_notifier_list.lock
373: &sighand->siglock
374: &base->lock_key
375: &base->lock_key
376: &base->lock_key
377: &base->lock_key
378: vector_lock
379: init_task.file_lock
380: pidmap_lock
381: acpi_gbl_hardware_lock
382: smp_alt
383: &inode->i_mutex
384: cdev_lock
385: &inode->inotify_mutex
386: &ih->mutex
387: &dev->ev_mutex
388: &sbi->s_next_gen_lock
389: (kernel_sem).wait.lock
390: &ei->xattr_sem
391: mb_cache_spinlock
392: &type->s_umount_key
393: &type->s_lock_key
394: proc_subdir_lock
395: proc_inum_lock
396: proc_inum_idr.lock
397: files_lock
398: &type->s_umount_key
399: &type->s_lock_key
400: &type->s_umount_key
401: old_style_rw_init
402: &type->s_umount_key
403: &sysfs_inode_imutex_key
404: fasync_lock
405: &inode->i_alloc_sem
406: &ei->truncate_mutex
407: &fbc->lock
408: &sbi->s_rsv_window_lock
409: &inode->i_lock
410: &f->f_owner.lock
411: &bgl->locks[i].lock
412: &type->s_lock_key
413: &inode->i_data.private_lock
414: &journal->j_revoke_lock
415: &tsk->delays->lock
416: &md->io_lock
417: &host_set->lock
418: &shost->default_lock
419: &journal->j_state_lock
420: &transaction->t_handle_lock
421: modlist_lock
422: &journal->j_list_lock
423: &info->lock
424: &inode->i_data.tree_lock
425: &sbinfo->stat_lock
426: &zone->lru_lock
427: &inode->i_data.i_mmap_lock
428: &anon_vma->lock
429: &mm->page_table_lock
430: &type->s_umount_key
431: &type->s_lock_key
432: &s->s_dquot.dqonoff_mutex
433: dq_list_lock
434: &sbsec->isec_lock
435: dcache_lock
436: rename_lock
437: vfsmount_lock
438: &dentry->d_lock
439: &dentry->d_lock
440: inode_lock
441: sb_lock
442: sb_security_lock
443: unnamed_dev_lock
444: &idp->lock
445: file_systems_lock
446: shrinker_rwsem
447: old_style_spin_init
448: root_session_keyring.sem
449: keyring_serialise_link_sem
450: old_style_spin_init
451: &candidate->lock
452: old_style_spin_init
453: old_style_spin_init
454: keyring_name_lock
455: callback_mutex
456: init_task.alloc_lock
457: cpu_bitmask_lock
458: mtrr_mutex
459: set_atomicity_lock
460: pgd_lock
461: kthread_stop_lock
462: kretprobe_lock
463: vmlist_lock
464: tasklist_lock
465: &sig->stats_lock
466: init_sighand.siglock
467: &sighand->siglock
468: &newf->file_lock
469: &p->alloc_lock
470: cfq_exit_lock
471: ide_lock
472: random_read_wait.lock
473: &input_pool.lock
474: random_write_wait.lock
475: &q->__queue_lock
476: congestion_wqh[1].lock
477: base_lock_keys + cpu
478: base_lock_keys + cpu
479: &cwq->lock
480: &sdev->list_lock
481: base_lock_keys + cpu
482: &avc_cache.slots_lock[i]
483: notif_lock
484: &sem->wait_lock
485: cache_chain_mutex
486: call_lock
487: &ptr->list_lock
488: &on_slab_key
489: &parent->list_lock
490: kclist_lock
491: &zone->lock
492: &port_lock_key
493: &q->lock
494: logbuf_lock
495: vga_lock
496: tty_ldisc_lock
497: tty_ldisc_wait.lock
498: base_lock_keys + cpu
499: &irq_desc_lock_class
500: rtc_lock
501: old_style_seqlock_init
502: clocksource_lock
503: &rq->rq_lock_key
504: &rq->rq_lock_key
505: &rq->rq_lock_key
506: &rq->rq_lock_key
507: resource_lock
508: ioapic_lock
509: i8259A_lock
510: index_init_lock
511: init_mm.page_table_lock
