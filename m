Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264045AbSIVLE6>; Sun, 22 Sep 2002 07:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264051AbSIVLE6>; Sun, 22 Sep 2002 07:04:58 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:55774 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S264045AbSIVLEv>;
	Sun, 22 Sep 2002 07:04:51 -0400
Date: Sun, 22 Sep 2002 13:10:00 +0200
From: bert hubert <ahu@ds9a.nl>
To: Eran Man <eran@nbase.co.il>
Cc: linux-kernel@vger.kernel.org, bart.de.schuymer@pandora.be
Subject: Re: Kernel 2.5.38 EBTables breakage
Message-ID: <20020922111000.GA17169@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Eran Man <eran@nbase.co.il>, linux-kernel@vger.kernel.org,
	bart.de.schuymer@pandora.be
References: <3D8D8660.80905@nbase.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8D8660.80905@nbase.co.il>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 11:59:12AM +0300, Eran Man wrote:
> It seems like the EBTables merge in 2.5.38 is incomplete:

With the following patch it at least compiles in 2.5.38

--- /dev/null	Thu Aug 24 11:00:32 2000
+++ linux-2.5.35-ebtables/include/linux/netfilter_bridge/ebtables.h	Mon Sep 16 08:42:31 2002
@@ -0,0 +1,358 @@
+/*
+ *  ebtables
+ *
+ *	Authors:
+ *	Bart De Schuymer		<bart.de.schuymer@pandora.be>
+ *
+ *  ebtables.c,v 2.0, April, 2002
+ *
+ *  This code is stongly inspired on the iptables code which is
+ *  Copyright (C) 1999 Paul `Rusty' Russell & Michael J. Neuling
+ */
+
+#ifndef __LINUX_BRIDGE_EFF_H
+#define __LINUX_BRIDGE_EFF_H
+#include <linux/if.h>
+#include <linux/netfilter_bridge.h>
+#include <linux/if_ether.h>
+
+#define EBT_TABLE_MAXNAMELEN 32
+#define EBT_CHAIN_MAXNAMELEN EBT_TABLE_MAXNAMELEN
+#define EBT_FUNCTION_MAXNAMELEN EBT_TABLE_MAXNAMELEN
+
+// [gs]etsockopt numbers
+#define EBT_BASE_CTL            128
+
+#define EBT_SO_SET_ENTRIES      (EBT_BASE_CTL)
+#define EBT_SO_SET_COUNTERS     (EBT_SO_SET_ENTRIES+1)
+#define EBT_SO_SET_MAX          (EBT_SO_SET_COUNTERS+1)
+
+#define EBT_SO_GET_INFO         (EBT_BASE_CTL)
+#define EBT_SO_GET_ENTRIES      (EBT_SO_GET_INFO+1)
+#define EBT_SO_GET_INIT_INFO    (EBT_SO_GET_ENTRIES+1)
+#define EBT_SO_GET_INIT_ENTRIES (EBT_SO_GET_INIT_INFO+1)
+#define EBT_SO_GET_MAX          (EBT_SO_GET_INIT_ENTRIES+1)
+
+// verdicts >0 are "branches"
+#define EBT_ACCEPT   -1
+#define EBT_DROP     -2
+#define EBT_CONTINUE -3
+#define EBT_RETURN   -4
+#define NUM_STANDARD_TARGETS   4
+
+// return values for match() functions
+#define EBT_MATCH 0
+#define EBT_NOMATCH 1
+
+struct ebt_counter
+{
+	uint64_t pcnt;
+};
+
+struct ebt_entries {
+	// this field is always set to zero
+	// See EBT_ENTRY_OR_ENTRIES.
+	// Must be same size as ebt_entry.bitmask
+	unsigned int distinguisher;
+	// the chain name
+	char name[EBT_CHAIN_MAXNAMELEN];
+	// counter offset for this chain
+	unsigned int counter_offset;
+	// one standard (accept, drop, return) per hook
+	int policy;
+	// nr. of entries
+	unsigned int nentries;
+	// entry list
+	char data[0];
+};
+
+// used for the bitmask of struct ebt_entry
+
+// This is a hack to make a difference between an ebt_entry struct and an
+// ebt_entries struct when traversing the entries from start to end.
+// Using this simplifies the code alot, while still being able to use
+// ebt_entries.
+// Contrary, iptables doesn't use something like ebt_entries and therefore uses
+// different techniques for naming the policy and such. So, iptables doesn't
+// need a hack like this.
+#define EBT_ENTRY_OR_ENTRIES 0x01
+// these are the normal masks
+#define EBT_NOPROTO 0x02
+#define EBT_802_3 0x04
+#define EBT_SOURCEMAC 0x08
+#define EBT_DESTMAC 0x10
+#define EBT_F_MASK (EBT_NOPROTO | EBT_802_3 | EBT_SOURCEMAC | EBT_DESTMAC \
+   | EBT_ENTRY_OR_ENTRIES)
+
+#define EBT_IPROTO 0x01
+#define EBT_IIN 0x02
+#define EBT_IOUT 0x04
+#define EBT_ISOURCE 0x8
+#define EBT_IDEST 0x10
+#define EBT_ILOGICALIN 0x20
+#define EBT_ILOGICALOUT 0x40
+#define EBT_INV_MASK (EBT_IPROTO | EBT_IIN | EBT_IOUT | EBT_ILOGICALIN \
+   | EBT_ILOGICALOUT | EBT_ISOURCE | EBT_IDEST)
+
+struct ebt_entry_match
+{
+	union {
+		char name[EBT_FUNCTION_MAXNAMELEN];
+		struct ebt_match *match;
+	} u;
+	// size of data
+	unsigned int match_size;
+	unsigned char data[0];
+};
+
+struct ebt_entry_watcher
+{
+	union {
+		char name[EBT_FUNCTION_MAXNAMELEN];
+		struct ebt_watcher *watcher;
+	} u;
+	// size of data
+	unsigned int watcher_size;
+	unsigned char data[0];
+};
+
+struct ebt_entry_target
+{
+	union {
+		char name[EBT_FUNCTION_MAXNAMELEN];
+		struct ebt_target *target;
+	} u;
+	// size of data
+	unsigned int target_size;
+	unsigned char data[0];
+};
+
+#define EBT_STANDARD_TARGET "standard"
+struct ebt_standard_target
+{
+	struct ebt_entry_target target;
+	int verdict;
+};
+
+// one entry
+struct ebt_entry {
+	// this needs to be the first field
+	unsigned int bitmask;
+	unsigned int invflags;
+	uint16_t ethproto;
+	// the physical in-dev
+	char in[IFNAMSIZ];
+	// the logical in-dev
+	char logical_in[IFNAMSIZ];
+	// the physical out-dev
+	char out[IFNAMSIZ];
+	// the logical out-dev
+	char logical_out[IFNAMSIZ];
+	unsigned char sourcemac[ETH_ALEN];
+	unsigned char sourcemsk[ETH_ALEN];
+	unsigned char destmac[ETH_ALEN];
+	unsigned char destmsk[ETH_ALEN];
+	// sizeof ebt_entry + matches
+	unsigned int watchers_offset;
+	// sizeof ebt_entry + matches + watchers
+	unsigned int target_offset;
+	// sizeof ebt_entry + matches + watchers + target
+	unsigned int next_offset;
+	unsigned char elems[0];
+};
+
+struct ebt_replace
+{
+	char name[EBT_TABLE_MAXNAMELEN];
+	unsigned int valid_hooks;
+	// nr of rules in the table
+	unsigned int nentries;
+	// total size of the entries
+	unsigned int entries_size;
+	// start of the chains
+	struct ebt_entries *hook_entry[NF_BR_NUMHOOKS];
+	// nr of counters userspace expects back
+	unsigned int num_counters;
+	// where the kernel will put the old counters
+	struct ebt_counter *counters;
+	char *entries;
+};
+
+#ifdef __KERNEL__
+
+struct ebt_match
+{
+	struct list_head list;
+	const char name[EBT_FUNCTION_MAXNAMELEN];
+	// 0 == it matches
+	int (*match)(const struct sk_buff *skb, const struct net_device *in,
+	   const struct net_device *out, const void *matchdata,
+	   unsigned int datalen);
+	// 0 == let it in
+	int (*check)(const char *tablename, unsigned int hookmask,
+	   const struct ebt_entry *e, void *matchdata, unsigned int datalen);
+	void (*destroy)(void *matchdata, unsigned int datalen);
+	struct module *me;
+};
+
+struct ebt_watcher
+{
+	struct list_head list;
+	const char name[EBT_FUNCTION_MAXNAMELEN];
+	void (*watcher)(const struct sk_buff *skb, const struct net_device *in,
+	   const struct net_device *out, const void *watcherdata,
+	   unsigned int datalen);
+	// 0 == let it in
+	int (*check)(const char *tablename, unsigned int hookmask,
+	   const struct ebt_entry *e, void *watcherdata, unsigned int datalen);
+	void (*destroy)(void *watcherdata, unsigned int datalen);
+	struct module *me;
+};
+
+struct ebt_target
+{
+	struct list_head list;
+	const char name[EBT_FUNCTION_MAXNAMELEN];
+	// returns one of the standard verdicts
+	int (*target)(struct sk_buff **pskb, unsigned int hooknr,
+	   const struct net_device *in, const struct net_device *out,
+	   const void *targetdata, unsigned int datalen);
+	// 0 == let it in
+	int (*check)(const char *tablename, unsigned int hookmask,
+	   const struct ebt_entry *e, void *targetdata, unsigned int datalen);
+	void (*destroy)(void *targetdata, unsigned int datalen);
+	struct module *me;
+};
+
+// used for jumping from and into user defined chains (udc)
+struct ebt_chainstack
+{
+	struct ebt_entries *chaininfo; // pointer to chain data
+	struct ebt_entry *e; // pointer to entry data
+	unsigned int n; // n'th entry
+};
+
+struct ebt_table_info
+{
+	// total size of the entries
+	unsigned int entries_size;
+	unsigned int nentries;
+	// pointers to the start of the chains
+	struct ebt_entries *hook_entry[NF_BR_NUMHOOKS];
+	// room to maintain the stack used for jumping from and into udc
+	struct ebt_chainstack **chainstack;
+	char *entries;
+	struct ebt_counter counters[0] ____cacheline_aligned;
+};
+
+struct ebt_table
+{
+	struct list_head list;
+	char name[EBT_TABLE_MAXNAMELEN];
+	struct ebt_replace *table;
+	unsigned int valid_hooks;
+	rwlock_t lock;
+	// e.g. could be the table explicitly only allows certain
+	// matches, targets, ... 0 == let it in
+	int (*check)(const struct ebt_table_info *info,
+	   unsigned int valid_hooks);
+	// the data used by the kernel
+	struct ebt_table_info *private;
+};
+
+extern int ebt_register_table(struct ebt_table *table);
+extern void ebt_unregister_table(struct ebt_table *table);
+extern int ebt_register_match(struct ebt_match *match);
+extern void ebt_unregister_match(struct ebt_match *match);
+extern int ebt_register_watcher(struct ebt_watcher *watcher);
+extern void ebt_unregister_watcher(struct ebt_watcher *watcher);
+extern int ebt_register_target(struct ebt_target *target);
+extern void ebt_unregister_target(struct ebt_target *target);
+extern unsigned int ebt_do_table(unsigned int hook, struct sk_buff **pskb,
+   const struct net_device *in, const struct net_device *out,
+   struct ebt_table *table);
+
+   // Used in the kernel match() functions
+#define FWINV(bool,invflg) ((bool) ^ !!(info->invflags & invflg))
+// True if the hook mask denotes that the rule is in a base chain,
+// used in the check() functions
+#define BASE_CHAIN (hookmask & (1 << NF_BR_NUMHOOKS))
+// Clear the bit in the hook mask that tells if the rule is on a base chain
+#define CLEAR_BASE_CHAIN_BIT (hookmask &= ~(1 << NF_BR_NUMHOOKS))
+// True if the target is not a standard target
+#define INVALID_TARGET (info->target < -NUM_STANDARD_TARGETS || info->target >= 0)
+
+#endif /* __KERNEL__ */
+
+// blatently stolen from ip_tables.h
+// fn returns 0 to continue iteration
+#define EBT_MATCH_ITERATE(e, fn, args...)                   \
+({                                                          \
+	unsigned int __i;                                   \
+	int __ret = 0;                                      \
+	struct ebt_entry_match *__match;                    \
+	                                                    \
+	for (__i = sizeof(struct ebt_entry);                \
+	     __i < (e)->watchers_offset;                    \
+	     __i += __match->match_size +                   \
+	     sizeof(struct ebt_entry_match)) {              \
+		__match = (void *)(e) + __i;                \
+		                                            \
+		__ret = fn(__match , ## args);              \
+		if (__ret != 0)                             \
+			break;                              \
+	}                                                   \
+	if (__ret == 0) {                                   \
+		if (__i != (e)->watchers_offset)            \
+			__ret = -EINVAL;                    \
+	}                                                   \
+	__ret;                                              \
+})
+
+#define EBT_WATCHER_ITERATE(e, fn, args...)                 \
+({                                                          \
+	unsigned int __i;                                   \
+	int __ret = 0;                                      \
+	struct ebt_entry_watcher *__watcher;                \
+	                                                    \
+	for (__i = e->watchers_offset;                      \
+	     __i < (e)->target_offset;                      \
+	     __i += __watcher->watcher_size +               \
+	     sizeof(struct ebt_entry_watcher)) {            \
+		__watcher = (void *)(e) + __i;              \
+		                                            \
+		__ret = fn(__watcher , ## args);            \
+		if (__ret != 0)                             \
+			break;                              \
+	}                                                   \
+	if (__ret == 0) {                                   \
+		if (__i != (e)->target_offset)              \
+			__ret = -EINVAL;                    \
+	}                                                   \
+	__ret;                                              \
+})
+
+#define EBT_ENTRY_ITERATE(entries, size, fn, args...)       \
+({                                                          \
+	unsigned int __i;                                   \
+	int __ret = 0;                                      \
+	struct ebt_entry *__entry;                          \
+	                                                    \
+	for (__i = 0; __i < (size);) {                      \
+		__entry = (void *)(entries) + __i;          \
+		__ret = fn(__entry , ## args);              \
+		if (__ret != 0)                             \
+			break;                              \
+		if (__entry->bitmask != 0)                  \
+			__i += __entry->next_offset;        \
+		else                                        \
+			__i += sizeof(struct ebt_entries);  \
+	}                                                   \
+	if (__ret == 0) {                                   \
+		if (__i != (size))                          \
+			__ret = -EINVAL;                    \
+	}                                                   \
+	__ret;                                              \
+})
+
+#endif
--- /dev/null	Thu Aug 24 11:00:32 2000
+++ linux-2.5.35-ebtables/include/linux/netfilter_bridge/ebt_arp.h	Mon Sep 16 08:42:31 2002
@@ -0,0 +1,26 @@
+#ifndef __LINUX_BRIDGE_EBT_ARP_H
+#define __LINUX_BRIDGE_EBT_ARP_H
+
+#define EBT_ARP_OPCODE 0x01
+#define EBT_ARP_HTYPE 0x02
+#define EBT_ARP_PTYPE 0x04
+#define EBT_ARP_SRC_IP 0x08
+#define EBT_ARP_DST_IP 0x10
+#define EBT_ARP_MASK (EBT_ARP_OPCODE | EBT_ARP_HTYPE | EBT_ARP_PTYPE | \
+   EBT_ARP_SRC_IP | EBT_ARP_DST_IP)
+#define EBT_ARP_MATCH "arp"
+
+struct ebt_arp_info
+{
+	uint16_t htype;
+	uint16_t ptype;
+	uint16_t opcode;
+	uint32_t saddr;
+	uint32_t smsk;
+	uint32_t daddr;
+	uint32_t dmsk;
+	uint8_t  bitmask;
+	uint8_t  invflags;
+};
+
+#endif
--- /dev/null	Thu Aug 24 11:00:32 2000
+++ linux-2.5.35-ebtables/include/linux/netfilter_bridge/ebt_ip.h	Mon Sep 16 08:42:31 2002
@@ -0,0 +1,24 @@
+#ifndef __LINUX_BRIDGE_EBT_IP_H
+#define __LINUX_BRIDGE_EBT_IP_H
+
+#define EBT_IP_SOURCE 0x01
+#define EBT_IP_DEST 0x02
+#define EBT_IP_TOS 0x04
+#define EBT_IP_PROTO 0x08
+#define EBT_IP_MASK (EBT_IP_SOURCE | EBT_IP_DEST | EBT_IP_TOS | EBT_IP_PROTO)
+#define EBT_IP_MATCH "ip"
+
+// the same values are used for the invflags
+struct ebt_ip_info
+{
+	uint32_t saddr;
+	uint32_t daddr;
+	uint32_t smsk;
+	uint32_t dmsk;
+	uint8_t  tos;
+	uint8_t  protocol;
+	uint8_t  bitmask;
+	uint8_t  invflags;
+};
+
+#endif
--- /dev/null	Thu Aug 24 11:00:32 2000
+++ linux-2.5.35-ebtables/include/linux/netfilter_bridge/ebt_vlan.h	Mon Sep 16 08:42:31 2002
@@ -0,0 +1,20 @@
+#ifndef __LINUX_BRIDGE_EBT_VLAN_H
+#define __LINUX_BRIDGE_EBT_VLAN_H
+
+#define EBT_VLAN_ID	0x01
+#define EBT_VLAN_PRIO	0x02
+#define EBT_VLAN_ENCAP	0x04
+#define EBT_VLAN_MASK (EBT_VLAN_ID | EBT_VLAN_PRIO | EBT_VLAN_ENCAP)
+#define EBT_VLAN_MATCH "vlan"
+
+struct ebt_vlan_info {
+	uint16_t id;		/* VLAN ID {1-4095} */
+	uint8_t prio;		/* VLAN User Priority {0-7} */
+	uint16_t encap;		/* VLAN Encapsulated frame code {0-65535} */
+	uint8_t bitmask;		/* Args bitmask bit 1=1 - ID arg,
+				   bit 2=1 User-Priority arg, bit 3=1 encap*/
+	uint8_t invflags;		/* Inverse bitmask  bit 1=1 - inversed ID arg, 
+				   bit 2=1 - inversed Pirority arg */
+};
+
+#endif
--- /dev/null	Thu Aug 24 11:00:32 2000
+++ linux-2.5.35-ebtables/include/linux/netfilter_bridge/ebt_log.h	Mon Sep 16 08:42:31 2002
@@ -0,0 +1,17 @@
+#ifndef __LINUX_BRIDGE_EBT_LOG_H
+#define __LINUX_BRIDGE_EBT_LOG_H
+
+#define EBT_LOG_IP 0x01 // if the frame is made by ip, log the ip information
+#define EBT_LOG_ARP 0x02
+#define EBT_LOG_MASK (EBT_LOG_IP | EBT_LOG_ARP)
+#define EBT_LOG_PREFIX_SIZE 30
+#define EBT_LOG_WATCHER "log"
+
+struct ebt_log_info
+{
+	uint8_t loglevel;
+	uint8_t prefix[EBT_LOG_PREFIX_SIZE];
+	uint32_t bitmask;
+};
+
+#endif
--- /dev/null	Thu Aug 24 11:00:32 2000
+++ linux-2.5.35-ebtables/include/linux/netfilter_bridge/ebt_nat.h	Mon Sep 16 08:42:31 2002
@@ -0,0 +1,13 @@
+#ifndef __LINUX_BRIDGE_EBT_NAT_H
+#define __LINUX_BRIDGE_EBT_NAT_H
+
+struct ebt_nat_info
+{
+	unsigned char mac[ETH_ALEN];
+	// EBT_ACCEPT, EBT_DROP, EBT_CONTINUE or EBT_RETURN
+	int target;
+};
+#define EBT_SNAT_TARGET "snat"
+#define EBT_DNAT_TARGET "dnat"
+
+#endif
--- /dev/null	Thu Aug 24 11:00:32 2000
+++ linux-2.5.35-ebtables/include/linux/netfilter_bridge/ebt_redirect.h	Mon Sep 16 08:42:31 2002
@@ -0,0 +1,11 @@
+#ifndef __LINUX_BRIDGE_EBT_REDIRECT_H
+#define __LINUX_BRIDGE_EBT_REDIRECT_H
+
+struct ebt_redirect_info
+{
+	// EBT_ACCEPT, EBT_DROP or EBT_CONTINUE or EBT_RETURN
+	int target;
+};
+#define EBT_REDIRECT_TARGET "redirect"
+
+#endif
--- /dev/null	Thu Aug 24 11:00:32 2000
+++ linux-2.5.35-ebtables/include/linux/netfilter_bridge/ebt_mark_m.h	Mon Sep 16 08:42:31 2002
@@ -0,0 +1,15 @@
+#ifndef __LINUX_BRIDGE_EBT_MARK_M_H
+#define __LINUX_BRIDGE_EBT_MARK_M_H
+
+#define EBT_MARK_AND 0x01
+#define EBT_MARK_OR 0x02
+#define EBT_MARK_MASK (EBT_MARK_AND | EBT_MARK_OR)
+struct ebt_mark_m_info
+{
+	unsigned long mark, mask;
+	uint8_t invert;
+	uint8_t bitmask;
+};
+#define EBT_MARK_MATCH "mark_m"
+
+#endif
--- /dev/null	Thu Aug 24 11:00:32 2000
+++ linux-2.5.35-ebtables/include/linux/netfilter_bridge/ebt_mark_t.h	Mon Sep 16 08:42:31 2002
@@ -0,0 +1,12 @@
+#ifndef __LINUX_BRIDGE_EBT_MARK_T_H
+#define __LINUX_BRIDGE_EBT_MARK_T_H
+
+struct ebt_mark_t_info
+{
+	unsigned long mark;
+	// EBT_ACCEPT, EBT_DROP or EBT_CONTINUE or EBT_RETURN
+	int target;
+};
+#define EBT_MARK_TARGET "mark"
+
+#endif


> ....
>   gcc -Wp,-MD,./.ebtables.o.d -D__KERNEL__ 
> -I/usr/src/linux-2.5.25/include -Wall -Wstrict-prototypes -Wno-trigraphs 
> -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=i686 
> -I/usr/src/linux-2.5.25/arch/i386/mach-generic -nostdinc -iwithprefix 
> include -DMODULE   -DKBUILD_BASENAME=ebtables -DEXPORT_SYMTAB  -c -o 
> ebtables.o ebtables.c
> ebtables.c:25:45: linux/netfilter_bridge/ebtables.h: No such file or 
> directory
> ebtables.c:85: variable `ebt_standard_target' has initializer but 
> incomplete type
> ebtables.c:86: extra brace group at end of initializer
> ebtables.c:86: (near initialization for `ebt_standard_target')
> ebtables.c:86: warning: excess elements in struct initializer
> ebtables.c:86: warning: (near initialization for `ebt_standard_target')
> ebtables.c:86: `EBT_STANDARD_TARGET' undeclared here (not in a function)
> ebtables.c:86: warning: excess elements in struct initializer
> ebtables.c:86: warning: (near initialization for `ebt_standard_target')
> ebtables.c:86: warning: excess elements in struct initializer
> ebtables.c:86: warning: (near initialization for `ebt_standard_target')
> ebtables.c:86: warning: excess elements in struct initializer
> ebtables.c:86: warning: (near initialization for `ebt_standard_target')
> ebtables.c:86: warning: excess elements in struct initializer
> ebtables.c:86: warning: (near initialization for `ebt_standard_target')
> ebtables.c:86: warning: excess elements in struct initializer
> ebtables.c:86: warning: (near initialization for `ebt_standard_target')
> ebtables.c:90: warning: `struct ebt_entry_watcher' declared inside 
> parameter list
> ebtables.c:90: warning: its scope is only this definition or 
> declaration, which is probably not what you want.
> ebtables.c: In function `ebt_do_watcher':
> ebtables.c:92: dereferencing pointer to incomplete type
> ebtables.c:92: dereferencing pointer to incomplete type
> ebtables.c:93: dereferencing pointer to incomplete type
> ebtables.c: At top level:
> ebtables.c:100: warning: `struct ebt_entry_match' declared inside 
> parameter list
> ebtables.c: In function `ebt_do_match':
> ebtables.c:102: dereferencing pointer to incomplete type
> ebtables.c:102: dereferencing pointer to incomplete type
> ebtables.c:103: dereferencing pointer to incomplete type
> .....
> This goes on for a couple more pages...
> On the otherhand, there is no real sign of the ebtables in include/linux:
> [eran@eran linux-2.5]$ grep -ri EBT_STANDARD_TARGET include/linux/
> [eran@eran linux-2.5]$ grep -ri ebtables include/linux/
> include/linux/netfilter_bridge.h:/* Not really a hook, but used for the 
> ebtables broute table */
> include/linux/autoconf.h:#undef  CONFIG_BRIDGE_NF_EBTABLES
> [eran@eran linux-2.5]$
> -- 
> Eran Mann                 Direct  : 972-4-9936297
> Senior Software Engineer  Fax     : 972-4-9890430
> Optical Access            Email   : emann@opticalaccess.com
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
