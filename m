Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753492AbWKGXuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbWKGXuX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 18:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbWKGXuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 18:50:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56024 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753492AbWKGXuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 18:50:20 -0500
Date: Tue, 7 Nov 2006 18:39:09 -0500 (EST)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-20.boston.redhat.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, arjan@infradead.org, rdreier@cisco.com
Subject: Re: locking hierarchy based on lockdep
In-Reply-To: <20061106200529.GA15370@elte.hu>
Message-ID: <Pine.LNX.4.64.0611071833450.22572@dhcp83-20.boston.redhat.com>
References: <Pine.LNX.4.64.0611061315380.29750@dhcp83-20.boston.redhat.com>
 <20061106200529.GA15370@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Nov 2006, Ingo Molnar wrote:

> 
> * Jason Baron <jbaron@redhat.com> wrote:
> 
> > I've implemented this as a /proc file, but Ingo suggested that it 
> > might be better for us to simply produce an adjaceny list, and then 
> > generate a locking hierarchy or anything else of interest off of that 
> > list.... [...]
> 
> this would certainly be the simplest thing to do - we could extend 
> /proc/lockdep with the list of 'immediately after' locks separated by 
> commas. (that list already exists: it's the lock_class.locks_after list)
> 
> i like your idea of using lockdep to document locking hierarchies.
> 
> 	Ingo
> 

hi,

So below is patch that does what you suggest, although i had to add the 
concept of 'distance' to the patch since the locks_after list loses this 
dependency info afaict. i also wrote a user space program to sort the 
locks into cluster of interelated locks and then sorted within these 
clusters...the results show one large clump of locks...perhaps there are a 
few locks that time them all together like scheduler locks...but i 
couldn't figure out which ones to exclude to make the list look really 
pretty (also, there could be a bug in my program :). Anyways i'm including 
my test program and its output too...

thanks,

-jason


--- linux-2.6.18/include/linux/lockdep.h.bak	2006-11-01 09:27:23.000000000 -0500
+++ linux-2.6.18/include/linux/lockdep.h	2006-11-06 10:32:14.000000000 -0500
@@ -132,6 +132,7 @@ struct lock_list {
 	struct list_head		entry;
 	struct lock_class		*class;
 	struct stack_trace		trace;
+	int				distance;
 };
 
 /*
--- linux-2.6.18/kernel/lockdep.c.bak	2006-11-01 08:57:22.000000000 -0500
+++ linux-2.6.18/kernel/lockdep.c	2006-11-06 10:33:16.000000000 -0500
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
@@ -2701,4 +2707,3 @@ void debug_show_held_locks(struct task_s
 }
 
 EXPORT_SYMBOL_GPL(debug_show_held_locks);
-
--- linux-2.6.18/kernel/lockdep_proc.c.bak	2006-11-01 08:57:32.000000000 -0500
+++ linux-2.6.18/kernel/lockdep_proc.c	2006-11-07 09:47:09.000000000 -0500
@@ -77,12 +77,29 @@ static unsigned long count_backward_deps
 	return ret;
 }
 
+static void print_name(struct seq_file *m, struct lock_class *class)
+{
+	char str[128];
+	const char *name = class->name;
+
+	if (!name) {
+		name = __get_key_name(class->key, str);
+		seq_printf(m, "%s", name);
+	} else{
+		seq_printf(m, "%s", name);
+		if (class->name_version > 1)
+			seq_printf(m, "#%d", class->name_version);
+		if (class->subclass)
+			seq_printf(m, "/%d", class->subclass);
+	}
+}	
+	
 static int l_show(struct seq_file *m, void *v)
 {
 	unsigned long nr_forward_deps, nr_backward_deps;
 	struct lock_class *class = m->private;
-	char str[128], c1, c2, c3, c4;
-	const char *name;
+	char c1, c2, c3, c4;
+	struct lock_list *entry;
 
 	seq_printf(m, "%p", class->key);
 #ifdef CONFIG_DEBUG_LOCKDEP
@@ -97,17 +114,17 @@ static int l_show(struct seq_file *m, vo
 	get_usage_chars(class, &c1, &c2, &c3, &c4);
 	seq_printf(m, " %c%c%c%c", c1, c2, c3, c4);
 
-	name = class->name;
-	if (!name) {
-		name = __get_key_name(class->key, str);
-		seq_printf(m, ": %s", name);
-	} else{
-		seq_printf(m, ": %s", name);
-		if (class->name_version > 1)
-			seq_printf(m, "#%d", class->name_version);
-		if (class->subclass)
-			seq_printf(m, "/%d", class->subclass);
+	seq_printf(m, ": ");
+	print_name(m, class);
+	seq_printf(m, ": ");
+
+	list_for_each_entry(entry, &class->locks_after, entry) {
+		if (entry->distance == 1) {
+			print_name(m, entry->class);
+			seq_puts(m, ",");
+		}
 	}
+
 	seq_puts(m, "\n");
 
 	return 0;



#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define MAX_LOCKS 1000
#define STR_LEN 64

struct node {
	struct link *graph_list;
	int component;
	struct node *ordered_list;
	int visited;
	char name[STR_LEN];
};

struct link {
	struct link *next_link;
	struct node *endpoint;
	int backlink;
};

int num_nodes = 0;
int num_components = 0;

struct node nodes[MAX_LOCKS];
struct node *ordered_list_array[MAX_LOCKS];

struct link *alloc_link() {

	struct link *new_link;	

	new_link = malloc(sizeof(struct link));
	memset(new_link, 0, sizeof(struct link));

	return new_link;

}

void add_link(struct node *start_node, struct node *end_node, int backlink) {

	//first check if we have it already:
	struct link *new_link;
	struct link *next_link = start_node->graph_list;	

	while (next_link) {
		if (next_link->endpoint == end_node) {
			printf("ERROR: duplicate link add attempted!\n");
			exit(-1);
		}
		next_link = next_link->next_link;
	}
	
	next_link = start_node->graph_list;	
	
	new_link = alloc_link();

	new_link->backlink = backlink;
	new_link->endpoint = end_node;
	new_link->next_link = next_link;
	start_node->graph_list = new_link;

}


void show_graph() {

	int i;
	struct link *next_link;

	printf("num_nodes: %i\n", num_nodes);
	printf("num_components: %i\n", num_components);

	for(i=0; i<num_nodes; i++) {
		printf("node %i: name: %s component: %i\n", i, nodes[i].name, nodes[i].component);
		next_link = nodes[i].graph_list;
		while(next_link != NULL) {
			printf("	link: %s back: %i\n" , next_link->endpoint->name, next_link->backlink);
			next_link = next_link->next_link;
		}
        }

}



struct node *find_node(char *nodename) {

	int i;

	for(i=0; i<num_nodes; i++) {
		if(strcmp(nodes[i].name, nodename) == 0)
			return &nodes[i];
	}

	return NULL;

}

struct node *register_node(char *nodename) {

	struct node *node;

	node = find_node(nodename);

	if(node)
		return node;

	strcpy(nodes[num_nodes++].name, nodename);
	
	return &nodes[num_nodes-1];

}

void create_graph(char *filename) {

	char *line;
	ssize_t read;
	size_t len = 0;
	FILE *fp;
	char *pos;
	char *lock_name, *start_name, node_name[STR_LEN];
	struct node *start_node, *end_node;

	if ((fp = fopen(filename, "r")) == NULL) {
		perror("Couldn't open file\n");
		exit(-1);
	}

	/* ignore the first line */
	read = getline(&line, &len, fp);

	while ((read = getline(&line, &len, fp)) != -1) {
		pos = strstr(line, ":");
		pos++;
		pos = strstr(pos, ":");
		pos++;
		pos = strstr(pos, ":");
		pos += 2;
		start_name = pos;
		pos = strstr(pos, ":");
		memcpy(node_name, start_name, pos - start_name);
		node_name[pos - start_name] = '\0';
		//printf("node name: %s\n", node_name);
		

		start_node = register_node(node_name);
		
		start_name = pos += 2;
		while((pos = strstr(start_name, ",")) != NULL) {
			memcpy(node_name, start_name, pos - start_name);
			node_name[pos - start_name] = '\0';
			//printf("link name: %s\n", node_name);
			end_node = register_node(node_name);
			add_link(start_node, end_node, 0);
			//add back link
			add_link(end_node, start_node, 1);
			start_name = pos+1;
		}	
		
	}	


}

void dfs_visit_component(struct node *node) {

	struct link *next_link;

	node->visited = 1;
	node->component = num_components;

	next_link = node->graph_list;

	while (next_link) {
		if (next_link->endpoint->visited == 0) 
			dfs_visit_component(next_link->endpoint);
		next_link = next_link->next_link;
	}

}


void label_connected_components() {

	int i;

	for (i=0;i<num_nodes;i++) {
		nodes[i].visited = 0;
		nodes[i].component = -1;
	}
	
	for (i=0;i<num_nodes;i++) {
		if (nodes[i].visited == 0) {
			dfs_visit_component(&nodes[i]);
			num_components++;
		}
	}

}

void dfs_order_components(struct node *node, int component) {

	struct link *next_link;
	struct node *next_node;	

	//sanity check:
	if (node->component != component) {
		printf("Error component mismatch\n");
		exit(-1);
	}

	node->visited = 1;

        next_link = node->graph_list;

        while (next_link) {
		if (next_link->endpoint->visited == 0 && (next_link->endpoint->component == component) && (next_link->backlink == 0)) {
                	dfs_order_components(next_link->endpoint, component);
		}
                next_link = next_link->next_link;
        }

	node->ordered_list = ordered_list_array[component];
	ordered_list_array[component] = node;

}

void order_components() {

	int i,j;

	for (i=0;i<num_nodes;i++) {
		nodes[i].visited = 0;
	}

	for(i=0;i<num_components;i++) {
		for(j=0;j<num_nodes;j++) {
			if (nodes[j].visited == 0 && nodes[j].component == i)
				dfs_order_components(&nodes[j], i);
		}
	}

}

void show_ordered_list_array() {

	int i, j;
	struct node *node;

	
	for(i=0;i<num_components;i++) {
		j = 0;
		node = ordered_list_array[i];
		while(node) {
			printf("%i: %s\n", j, node->name);
			j++;
			node = node->ordered_list;
		}
		printf("\n");
	}

}

int main(int argc, char **argv)
{

	if (argc != 2) {
		printf("usage: %s: <filename>\n", *argv);
		exit(-1);
	}

	create_graph(argv[1]);

	label_connected_components();

	order_components();
	
	show_ordered_list_array();

}



0: fib6_gc_lock
1: &ids->mutex
2: slock-AF_INET6/1
3: &atkbd->event_mutex
4: &tty->atomic_read_lock
5: (console_sem).wait.lock
6: &im->lock
7: &type->s_umount_key#21
8: &ep->sem
9: &file->f_ep_lock
10: &type->s_umount_key#20
11: &type->s_lock_key#11
12: &key->sem
13: key_construction_sem
14: old_style_spin_init#20
15: sk_lock-AF_PACKET
16: &po->bind_lock
17: sk_lock-AF_INET
18: af_callback_keys + sk->sk_family#4
19: tcp_hashinfo.lhash_wait.lock
20: ip_conntrack_lock
21: sk_lock-AF_INET6
22: nf_sockopt_mutex
23: &xt[i].mutex
24: &table->lock
25: udp_hash_lock
26: &sk->sk_dst_lock
27: tcp_hashinfo.lhash_lock
28: af_callback_keys + sk->sk_family#3
29: ipv6_sk_mc_lock
30: slock-AF_PACKET
31: &newsk->sk_dst_lock
32: slock-AF_INET6
33: &tcp_hashinfo.ehash[i].lock
34: &tcp_hashinfo.bhash[i].lock
35: &queue->syn_wait_lock
36: tcp_lock
37: addrconf_hash_lock
38: addrconf_verify_lock
39: &s->rwsem
40: &type->s_umount_key#19
41: disks_mutex
42: cm_sbs_mutex
43: registration_lock
44: parportlist_lock
45: &tmp->pardevice_lock
46: topology_lock
47: &card->power_lock
48: &card->controls_rwsem
49: &ac97->reg_mutex
50: rng_mutex
51: fdc_wait.lock
52: command_done.lock
53: floppy_lock
54: &grp->list_mutex
55: &grp->list_mutex/1
56: &grp->list_lock
57: register_mutex#4
58: core_lists
59: i2c_adapter_idr.lock
60: register_mutex#3
61: clients_lock
62: register_mutex#2
63: sound_oss_mutex
64: sound_loader_lock
65: sound_mutex
66: register_mutex
67: strings
68: info_mutex
69: &s->s_vfs_rename_mutex
70: &dev->up_mutex
71: &u->readlock
72: audit_cmd_mutex
73: &u->lock
74: &af_unix_sk_receive_queue_lock_key
75: &u->lock/1
76: af_callback_keys + sk->sk_family#2
77: unix_table_lock
78: &s->lock
79: load_mutex
80: sel_mutex
81: sel_netif_lock
82: audit_filter_mutex
83: &bdev->bd_mount_mutex
84: _event_lock
85: &type->s_umount_key#18
86: &journal->j_barrier
87: &md->map_lock
88: _hash_lock
89: old_style_spin_init#16
90: &dio->bio_lock
91: &p->lock
92: swapon_mutex
93: swap_lock
94: &shost->scan_mutex
95: sd_index_lock
96: sd_index_idr.lock
97: host_cmd_pool_mutex
98: module_mutex
99: &bdev->bd_mutex
100: &bdev->bd_mutex/1
101: sd_ref_mutex
102: &bdev->bd_mutex/2
103: _minor_lock
104: _minor_idr.lock
105: idecd_ref_mutex
106: &new->reconfig_mutex
107: open_lock
108: &namespace_sem
109: &tty->atomic_write_lock
110: uts_sem
111: old_style_spin_init#10
112: &mm->mmap_sem
113: &mm->mmap_sem/1
114: &mm->page_table_lock
115: __pte_lockptr(new)
116: __pte_lockptr(new)/1
117: &per_cpu(flush_state
118:  i).tlbstate_lock
119: &futex_queues[i].lock
120: &futex_queues[i].lock/1
121: &new->lock
122: tty_mutex
123: log_wait.lock
124: usb_bus_list_lock
125: hcd_data_lock
126: &urb->lock
127: device_state_lock
128: &new_driver->dynids.lock
129: &retval->lock
130: &uhci->lock
131: hcd_root_hub_lock
132: (usb_notifier_list).rwsem
133: &type->s_umount_key#17
134: &type->s_lock_key#8
135: deviceconndiscwq.lock
136: mon_lock
137: old_style_spin_init#13
138: &ehci->lock
139: &type->s_umount_key#16
140: &type->s_lock_key#7
141: pin_fs_lock
142: block_subsys_lock
143: serial_mutex
144: port_mutex
145: &state->mutex
146: probing_active
147: &irq_lists[i].lock
148: &tty->read_lock
149: &blocking_pool.lock
150: cpufreq_driver_lock
151: elv_list_lock
152: &type->s_umount_key#15
153: &type->s_umount_key#14
154: &type->s_lock_key#5
155: &type->s_umount_key#13
156: &type->s_umount_key#12
157: &type->s_lock_key#4
158: &type->s_umount_key#11
159: &type->s_umount_key#10
160: &type->s_umount_key#9
161: pdflush_lock
162: kprobe_mutex
163: serial_lock
164: audit_freelist_lock
165: &type->s_umount_key#8
166: bdev_lock
167: ptype_lock
168: serio_mutex
169: serio_event_lock
170: serio_wait.lock
171: &serio->drv_mutex
172: &dev->mutex
173: psmouse_mutex
174: &ps2dev->cmd_mutex/1
175: &serio->lock
176: i8042_lock
177: input_devices_poll_wait.lock
178: &type->s_umount_key#7
179: hub_event_lock
180: khubd_wait.lock
181: pci_bus_sem
182: old_style_spin_init#8
183: &k->k_lock
184: chrdevs_lock
185: init_mm.mmap_sem
186: old_style_spin_init#7
187: bus_type_sem
188: old_style_spin_init#6
189: &(per_cpu(listener_array, i).sem)
190: net_todo_run_mutex
191: rtnl_mutex
192: sequence_lock
193: qdisc_tree_lock
194: dev_base_lock
195: sysctl_lock
196: lweventlist_lock
197: addrconf_lock
198: &ndev->lock
199: &idev->mc_lock
200: &mc->mca_lock
201: &nlk->cb_lock
202: &list->lock
203: &dev->_xmit_lock
204: &dev->queue_lock#2
205: (inetaddr_chain).rwsem
206: fib_hash_lock
207: &tbl->lock
208: &n->lock
209: &list->lock#3
210: old_style_spin_init#19
211: &in_dev->mc_list_lock
212: &in_dev->mc_tomb_lock
213: rt_flush_lock
214: &rt_hash_locks[i]
215: fib_info_lock
216: &ifa->lock
217: rt6_lock
218: fib6_walker_lock
219: nl_table_wait.lock
220: nl_table_lock
221: &nonblocking_pool.lock
222: &type->s_umount_key#6
223: &k->list_lock
224: workqueue_mutex
225: &inode->i_mutex/1
226: cdev_lock
227: &inode->i_mutex/2
228: &sbi->s_next_gen_lock
229: &p->pi_lock
230: cpu_add_remove_lock
231: (cpu_chain).rwsem
232: old_style_spin_init#4
233: &sighand->siglock
234: &base->lock_key#2
235: &base->lock_key
236: &base->lock_key#4
237: &base->lock_key#3
238: pidmap_lock
239: smp_alt
240: &inode->i_mutex
241: &ei->xattr_sem
242: mb_cache_spinlock
243: (kernel_sem).wait.lock
244: &inode->inotify_mutex
245: &ih->mutex
246: &dev->ev_mutex
247: &type->s_umount_key#5
248: &type->s_lock_key#3
249: proc_subdir_lock
250: files_lock
251: proc_inum_lock
252: proc_inum_idr.lock
253: &type->s_umount_key#4
254: &type->s_lock_key#2
255: &type->s_umount_key#3
256: &type->s_umount_key#2
257: &sysfs_inode_imutex_key
258: &inode->i_alloc_sem
259: &inode->i_data.i_mmap_lock
260: &anon_vma->lock
261: &info->lock
262: &sbinfo->stat_lock
263: &type->s_lock_key#9
264: &journal->j_state_lock
265: modlist_lock
266: &transaction->t_handle_lock
267: &ei->truncate_mutex
268: &md->io_lock
269: cfq_exit_lock
270: ide_lock
271: &input_pool.lock
272: random_write_wait.lock
273: random_read_wait.lock
274: &q->__queue_lock
275: &sdev->list_lock
276: base_lock_keys + cpu#4
277: congestion_wqh[1].lock
278: &host_set->lock
279: &shost->default_lock
280: base_lock_keys + cpu#3
281: base_lock_keys + cpu#2
282: &tsk->delays->lock
283: &journal->j_revoke_lock
284: &bgl->locks[i].lock
285: &inode->i_lock
286: &f->f_owner.lock
287: &zone->lru_lock
288: &sbi->s_rsv_window_lock
289: &inode->i_data.private_lock
290: &journal->j_list_lock
291: &inode->i_data.tree_lock
292: fasync_lock
293: &type->s_umount_key
294: inode_lock
295: dcache_lock
296: vfsmount_lock
297: rename_lock
298: &dentry->d_lock
299: &dentry->d_lock/1
300: &sbsec->isec_lock
301: &s->s_dquot.dqonoff_mutex
302: dq_list_lock
303: &type->s_lock_key
304: sb_lock
305: unnamed_dev_lock
306: &idp->lock
307: sb_security_lock
308: root_session_keyring.sem
309: old_style_spin_init
310: keyring_serialise_link_sem
311: &candidate->lock
312: old_style_spin_init#21
313: old_style_spin_init#2
314: keyring_name_lock
315: callback_mutex
316: init_task.alloc_lock
317: cpu_bitmask_lock
318: cache_chain_mutex
319: &ptr->list_lock
320: &p->alloc_lock
321: &sem->wait_lock
322: notif_lock
323: &avc_cache.slots_lock[i]
324: &newf->file_lock
325: tasklist_lock
326: init_sighand.siglock
327: &sighand->siglock/1
328: &sig->stats_lock
329: &parent->list_lock
330: &on_slab_key
331: vmlist_lock
332: &cwq->lock
333: kthread_stop_lock
334: kretprobe_lock
335: pgd_lock
336: mtrr_mutex
337: call_lock
338: set_atomicity_lock
339: &zone->lock
340: &port_lock_key
341: &q->lock
342: logbuf_lock
343: vga_lock
344: tty_ldisc_lock
345: tty_ldisc_wait.lock
346: base_lock_keys + cpu
347: &irq_desc_lock_class
348: old_style_seqlock_init
349: clocksource_lock
350: &rq->rq_lock_key
351: &rq->rq_lock_key#2
352: &rq->rq_lock_key#3
353: &rq->rq_lock_key#4
354: resource_lock
355: ioapic_lock
356: i8259A_lock
357: init_mm.page_table_lock

0: index_init_lock

0: rtc_lock

0: kclist_lock

0: shrinker_rwsem
1: old_style_spin_init#3

0: file_systems_lock

0: old_style_rw_init

0: acpi_gbl_hardware_lock

0: init_task.file_lock

0: vector_lock

0: panic_notifier_list.lock

0: &rcu_ctrlblk.lock

0: binfmt_lock

0: proto_list_lock

0: net_family_lock

0: &fs->lock

0: (task_exit_notifier).rwsem
1: old_style_spin_init#5

0: pci_config_lock

0: sysrq_key_table_lock

0: acpi_gbl_gpe_lock

0: acpi_device_lock

0: tune_lock
1: pci_lock

0: acpi_prt_lock

0: acpi_link_lock

0: pnp_lock

0: &dev->queue_lock

0: notify_lock

0: &dma_list_mutex

0: qdisc_mod_lock

0: genl_mutex

0: cpufreq_governor_mutex

0: inet_proto_lock

0: inetsw_lock

0: neigh_tbl_lock

0: xfrm_state_afinfo_lock

0: xfrm_policy_afinfo_lock

0: raw_v4_lock

0: tcp_cong_list_lock

0: uidhash_lock

0: die_chain.lock

0: nls_lock

0: nf_hook_lock

0: &type->s_lock_key#6

0: crypto_alg_sem
1: old_style_spin_init#9

0: &drv->dynids.lock

0: triggers_list_lock

0: leds_list_lock

0: llc_sap_list_lock

0: afinfo_lock

0: xfrm_km_lock

0: packet_sklist_lock

0: rif_lock

0: redirect_lock

0: policy_rwlock

0: (munmap_notifier).rwsem
1: old_style_spin_init#11

0: af_callback_keys + sk->sk_family

0: (module_notify_list).rwsem
1: old_style_spin_init#12

0: (reboot_notifier_list).rwsem
1: old_style_spin_init#14

0: &shost->free_list_lock

0: _lock

0: old_style_spin_init#15

0: _lock#2

0: &per_cpu(flush_state, i).tlbstate_lock

0: init_signals.wait_chldexit.lock

0: slock-AF_UNIX

0: sk_lock-AF_UNIX

0: simple_transaction_lock

0: &list->lock#2

0: audit_backlog_wait.lock

0: kauditd_wait.lock

0: slock-AF_NETLINK

0: sk_lock-AF_NETLINK

0: sysfs_rename_sem
1: old_style_spin_init#17

0: snd_ioctl_rwsem
1: old_style_spin_init#18

0: &client->ports_mutex
1: &client->ports_lock

0: sg_dev_arr_lock

0: floppy_usage_lock

0: dma_spin_lock

0: floppy_hlt_lock

0: register_lock

0: snd_card_mutex

0: cdrom_lock

0: &card->ctl_files_rwlock

0: list_mutex

0: &chip->reg_lock

0: ops_mutex

0: (struct lock_class_key *)id

0: &card->files_lock

0: &ctl->read_lock

0: full_list_lock

0: ports_lock

0: &tmp->cad_lock

0: &tmp->waitlist_lock

0: all_mddevs_lock

0: &type->s_lock_key#10

0: &policy->lock
1: performance_mutex

0: disable_ratelimit_lock

0: inetsw6_lock

0: raw_v6_lock

0: inet6_proto_lock

0: ipv6_sk_ac_lock

0: ip6_ra_lock

0: slock-AF_INET

0: af_callback_keys + sk->sk_family#5

0: &adapter->stats_lock

0: &adapter->tx_queue_lock

0: &txdr->tx_lock

0: &rcu_bh_ctrlblk.lock

0: task_capability_lock

0: key_user_lock

0: key_serial_lock

0: &hh->hh_lock

0: cache_list_lock

0: &ep->lock

0: &fbc->lock

0: &ps->lock

0: hci_notifier.lock

0: hci_task_lock

0: sk_lock-AF_BLUETOOTH
1: old_style_rw_init#2

0: slock-AF_BLUETOOTH

0: hci_cb_list_lock

0: old_style_rw_init#3

0: af_callback_keys + sk->sk_family#6

0: &d->lock

0: &list->lock#4

0: old_style_rw_init#4

0: hci_dev_list_lock

0: acpi_system_event_lock

0: acpi_bus_event_queue.lock

0: &fbc->lock#2

0: &entry->access

0: vt_activate_queue.lock

0: i8253_beep_lock

0: allocated_ptys.lock

