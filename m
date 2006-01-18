Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWARJM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWARJM0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 04:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWARJM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 04:12:26 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:14979 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030216AbWARJMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 04:12:25 -0500
Message-ID: <43CE0696.50407@openvz.org>
Date: Wed, 18 Jan 2006 12:12:54 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, dim@openvz.org,
       netfilter-devel@lists.netfilter.org, rusty@rustcorp.com.au,
       Andrew Morton <akpm@osdl.org>
Subject: [RFC][DRAFT][PATCH] iptables 32bit compat layer
Content-Type: multipart/mixed;
 boundary="------------090700070006030107030503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090700070006030107030503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

[PATCH] iptables 32bit compat layer
From: Mishin Dmitry <dim@openvz.org>

This patch extends current iptables compatibility layer in order to get
32bit iptables to work on 64bit kernel. Current layer is insufficient 
due to alignment checks both in kernel and user space tools. Current 
draft version works correctly with standard targets only 
(ACCEPT/DROP/FORWARD).

ToDo:
  - extend translation to include more matches and targets. Use arrays of
    structures like { name, size_diff, func_for_convert_data} for this
    purpose
  - extend get_info to return corrected size. Add size calculation to
    get_entries.

Kirill


--------------090700070006030107030503
Content-Type: text/plain;
 name="diff-ms-iptables-compat-20060118"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-iptables-compat-20060118"

--- ./net/compat.c.iptcompat	2006-01-11 15:10:16.000000000 +0300
+++ ./net/compat.c	2006-01-18 11:35:28.000000000 +0300
@@ -312,10 +312,55 @@ void scm_detach_fds_compat(struct msghdr
 	__scm_destroy(scm);
 }
 
-/*
- * For now, we assume that the compatibility and native version
- * of struct ipt_entry are the same - sfr.  FIXME
- */
+struct compat_ipt_counters
+{
+	u_int32_t cnt[4];
+};
+
+struct compat_ipt_entry
+{
+	struct ipt_ip ip;
+	compat_uint_t nfcache;
+	u_int16_t target_offset;
+	u_int16_t next_offset;
+	compat_uint_t comefrom;
+	struct compat_ipt_counters counters;
+	unsigned char elems[0];
+};
+
+struct compat_ipt_entry_target
+{
+	union {
+		struct {
+			u_int16_t target_size;
+			char name[IPT_FUNCTION_MAXNAMELEN];
+		} user;
+		u_int16_t target_size;
+	} u;
+	unsigned char data[0];
+};
+
+struct compat_ipt_standard_target
+{
+	struct compat_ipt_entry_target target;
+	compat_int_t verdict;
+};
+
+#define IPT_ST_OFFSET	(sizeof(struct ipt_standard_target) - \
+				sizeof(struct compat_ipt_standard_target))
+
+struct ipt_standard
+{
+	struct ipt_entry entry;
+	struct ipt_standard_target target;
+};
+
+struct compat_ipt_standard
+{
+	struct compat_ipt_entry entry;
+	struct compat_ipt_standard_target target;
+};
+
 struct compat_ipt_replace {
 	char			name[IPT_TABLE_MAXNAMELEN];
 	u32			valid_hooks;
@@ -325,9 +370,123 @@ struct compat_ipt_replace {
 	u32			underflow[NF_IP_NUMHOOKS];
 	u32			num_counters;
 	compat_uptr_t		counters;	/* struct ipt_counters * */
-	struct ipt_entry	entries[0];
+	struct compat_ipt_entry	entries[0];
 };
 
+static int calc_table_size(struct compat_ipt_entry __user *optval, int size)
+{
+	struct compat_ipt_entry __user *e;
+	struct compat_ipt_entry_target __user *t;
+	u_int16_t target_offset;
+	char name[IPT_FUNCTION_MAXNAMELEN];
+	u_int16_t next;
+	int i, ret;
+
+	for (i = 0, ret = size, next = 0; i < size; i += next) {
+		e = (void __user *)optval + i;
+		if (get_user(next, &e->next_offset))
+			goto out;
+		if (get_user(target_offset, &e->target_offset))
+			goto out;
+		t = (void __user *)e + target_offset;
+		if (__copy_from_user(name, &t->u.user.name, IPT_FUNCTION_MAXNAMELEN))
+			goto out;
+		if (!strcmp(name, IPT_STANDARD_TARGET))
+			ret += IPT_ST_OFFSET;
+	}
+	return ret;
+out:
+	return -EFAULT;
+}
+
+static int copy_entry(struct ipt_entry __user *e,
+		u_int16_t next, void __user **dstptr, compat_uint_t *size)
+{
+	struct compat_ipt_entry_target __user *t;
+	u_int16_t target_offset;
+	char name[IPT_FUNCTION_MAXNAMELEN];
+	int ret;
+
+	ret = -EFAULT;
+	if (__copy_in_user(*dstptr, e, next))
+		goto out;
+
+	if (get_user(target_offset, &e->target_offset))
+		goto out;
+	t = (void __user *)e + target_offset;
+	if (__copy_from_user(name, &t->u.user.name, IPT_FUNCTION_MAXNAMELEN))
+		goto out;
+	if (!strcmp(name, IPT_STANDARD_TARGET)) {
+		struct compat_ipt_standard_target compat_st;
+		struct ipt_standard_target st;
+		struct compat_ipt_entry etmp;
+
+		next += IPT_ST_OFFSET;
+		if (__copy_from_user(&etmp, (void __user *)e,
+				sizeof(struct compat_ipt_entry)))
+			goto out;
+		etmp.next_offset = next;	
+		if (__copy_to_user(*dstptr, &etmp, sizeof(struct compat_ipt_entry)))
+			goto out;
+		if (__copy_from_user(&compat_st, (void __user *)t,
+				sizeof(struct compat_ipt_standard_target)))
+			goto out;
+		memcpy(&st.target,  &compat_st.target,
+				sizeof(struct ipt_target));
+		st.verdict = compat_st.verdict;
+		st.target.u.user.target_size =
+			sizeof(struct ipt_standard_target);
+		if (__copy_to_user(*dstptr + target_offset, &st,
+				sizeof(struct ipt_standard_target)))
+			goto out;
+		*size += IPT_ST_OFFSET;
+	}
+	*dstptr	+= next;
+	ret = 0;
+out:
+	return ret;
+}
+
+static int compat_copy_entries(void __user *srcptr,
+		void __user *dstptr, compat_uint_t *size,
+		int (*copy_entry) (struct ipt_entry __user *,
+		u_int16_t, void __user **, compat_uint_t *))
+{
+	struct ipt_entry __user *entry;
+	compat_uint_t origsize;
+	u_int16_t next;
+	int i, ret;
+
+	origsize = *size;
+	for (i = 0, ret = 0, next = 0; i < origsize ; i += next) {
+		entry = (void __user *)srcptr + i;
+		if (get_user(next, &entry->next_offset))
+			return -EFAULT;
+		ret = copy_entry(entry, next, &dstptr, size);
+		if (ret)
+			break;
+		if (!next)
+			break;
+	}
+	return ret;
+}
+
+static int convert_hook(compat_uint_t __user *src, unsigned int __user *dst)
+{
+	compat_uint_t tmp;
+
+	if (__get_user(tmp, src))
+		return -EFAULT;
+	if (tmp && !(tmp % sizeof(struct compat_ipt_standard))) {
+		int k;
+		k = tmp / sizeof(struct compat_ipt_standard);
+		tmp += k * IPT_ST_OFFSET;
+	}	
+	if (__put_user(tmp, dst))
+		return -EFAULT;
+	return 0;		
+}
+
 static int do_netfilter_replace(int fd, int level, int optname,
 				char __user *optval, int optlen)
 {
@@ -348,16 +507,11 @@ static int do_netfilter_replace(int fd, 
 	if (optlen != sizeof(*urepl) + origsize)
 		return -ENOPROTOOPT;
 
-	/* XXX Assumes that size of ipt_entry is the same both in
-	 *     native and compat environments.
-	 */
-	repl_nat_size = sizeof(*repl_nat) + origsize;
+	repl_nat_size = calc_table_size(&urepl->entries[0], origsize);
+	repl_nat_size += sizeof(*repl_nat);
 	repl_nat = compat_alloc_user_space(repl_nat_size);
 
 	ret = -EFAULT;
-	if (put_user(origsize, &repl_nat->size))
-		goto out;
-
 	if (!access_ok(VERIFY_READ, urepl, optlen) ||
 	    !access_ok(VERIFY_WRITE, repl_nat, optlen))
 		goto out;
@@ -382,19 +536,21 @@ static int do_netfilter_replace(int fd, 
 	    __put_user(compat_ptr(ucntrs), &repl_nat->counters))
 		goto out;
 
-	if (__copy_in_user(&repl_nat->entries[0],
-			   &urepl->entries[0],
-			   origsize))
+	if (compat_copy_entries(&urepl->entries[0],
+			&repl_nat->entries[0], &origsize, copy_entry))
+		goto out;
+
+	if (put_user(origsize, &repl_nat->size))
 		goto out;
 
 	for (i = 0; i < NF_IP_NUMHOOKS; i++) {
-		if (__get_user(tmp32, &urepl->hook_entry[i]) ||
-		    __put_user(tmp32, &repl_nat->hook_entry[i]) ||
-		    __get_user(tmp32, &urepl->underflow[i]) ||
-		    __put_user(tmp32, &repl_nat->underflow[i]))
+		if (convert_hook(&urepl->hook_entry[i], &repl_nat->hook_entry[i]) ||
+		    convert_hook(&urepl->underflow[i], &repl_nat->underflow[i]))
 			goto out;
 	}
 
+	if (repl_nat_size != origsize + sizeof(*repl_nat))
+		printk("WARNING: %s: wrong size calculation!\n", __FUNCTION__);
 	/*
 	 * Since struct ipt_counters just contains two u_int64_t members
 	 * we can just do the access_ok check here and pass the (converted)
@@ -413,6 +569,45 @@ out:
 	return ret;
 }
 
+struct compat_ipt_counters_info
+{
+	char name[IPT_TABLE_MAXNAMELEN];
+	compat_uint_t num_counters;
+	struct compat_ipt_counters counters[0];
+};
+
+static int do_set_add_counters(int fd, int level, int optname,
+				char __user *optval, int optlen)
+{
+	long ret;
+	mm_segment_t old_fs;
+	struct ipt_counters_info *tmp;
+	struct compat_ipt_counters_info *user;
+
+	user = (struct compat_ipt_counters_info *)optval;
+	tmp = (struct ipt_counters_info*) vmalloc(optlen + 4);
+	if (tmp == NULL)
+		return -ENOMEM;
+	
+	ret = -EFAULT;
+	if (copy_from_user(tmp, user, sizeof(*user))!= 0)
+		goto out;
+	if (copy_from_user(tmp->counters, user + sizeof(*user),
+			optlen - sizeof(*user)) != 0)
+		goto out;
+
+	optlen += 4;
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = sys_setsockopt(fd, level, optname, (char *)tmp, optlen);
+	set_fs(old_fs);
+
+out:
+	vfree(tmp);
+
+	return ret;
+}
+
 /*
  * A struct sock_filter is architecture independent.
  */
@@ -473,6 +668,9 @@ asmlinkage long compat_sys_setsockopt(in
 					    optval, optlen);
 	if (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO)
 		return do_set_sock_timeout(fd, level, optname, optval, optlen);
+	if (level == SOL_IP && optname == IPT_SO_SET_ADD_COUNTERS)
+		return do_set_add_counters(fd, level, optname,
+					    optval, optlen);
 
 	return sys_setsockopt(fd, level, optname, optval, optlen);
 }
@@ -506,11 +704,199 @@ static int do_get_sock_timeout(int fd, i
 	return err;
 }
 
+struct compat_ipt_get_entries
+{
+	char name[IPT_TABLE_MAXNAMELEN];
+	compat_uint_t size;
+	struct compat_ipt_entry entrytable[0];
+};
+
+struct compat_ipt_getinfo
+{
+	char name[IPT_TABLE_MAXNAMELEN];
+	compat_uint_t valid_hooks;
+	compat_uint_t hook_entry[NF_IP_NUMHOOKS];
+	compat_uint_t underflow[NF_IP_NUMHOOKS];
+	compat_uint_t num_entries;
+	compat_uint_t size;
+};
+
+static int compat_convert_hook(unsigned int src, compat_uint_t __user *dst)
+{
+	if (src && !(src % sizeof(struct ipt_standard))) {
+		int k;
+		k = src / sizeof(struct ipt_standard);
+		src -= k * IPT_ST_OFFSET;
+	}	
+	if (__put_user(src, dst))
+		return -EFAULT;
+	return 0;		
+}
+
+static long do_ipt_get_info(int fd, int level, int optname,
+		char __user *optval, int __user *optlen) 
+{
+	struct compat_ipt_getinfo __user *user;
+	struct ipt_getinfo info;
+	mm_segment_t old_fs;
+	int len, ret, i;
+
+	user = (struct compat_ipt_getinfo __user *)optval;
+	ret = -EFAULT;
+	if (__copy_from_user(info.name, user->name, sizeof(user->name)))
+		goto out;
+
+	len = sizeof(struct ipt_getinfo);
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = sys_getsockopt(fd, level, optname, (char __user *)&info, &len);
+	set_fs(old_fs);
+	if (ret == 0) {
+		ret = -EFAULT;
+		if (__copy_to_user(user->name, info.name, sizeof(info.name)))
+			goto out;
+		if (__put_user(info.valid_hooks, &user->valid_hooks))
+			goto out;
+		if (__put_user(info.num_entries, &user->num_entries))
+			goto out;
+		if (__put_user(info.size, &user->size))
+			goto out;
+
+		for (i = 0; i < NF_IP_NUMHOOKS; i++) {
+			ret = compat_convert_hook(info.hook_entry[i],
+					&user->hook_entry[i]);
+			if (ret)
+				break;
+			ret = compat_convert_hook(info.underflow[i],
+					&user->underflow[i]);
+			if (ret)
+				break;
+		}	
+		ret = 0;	
+	}
+out:	
+	return ret;
+}
+
+static int compat_copy_entry(struct ipt_entry __user *e,
+		u_int16_t next, void __user **dstptr, compat_uint_t *size)
+{
+	struct ipt_entry_target __user *t;
+	u_int16_t target_offset;
+	char name[IPT_FUNCTION_MAXNAMELEN];
+	int ret;
+
+	ret = -EFAULT;
+	if (__copy_in_user(*dstptr, e, next))
+		goto out;
+
+	if (get_user(target_offset, &e->target_offset))
+		goto out;
+	t = (void __user *)e + target_offset;
+	if (__copy_from_user(name, &t->u.user.name, IPT_FUNCTION_MAXNAMELEN))
+		goto out;
+	if (!strcmp(name, IPT_STANDARD_TARGET)) {
+		struct compat_ipt_standard_target compat_st;
+		struct ipt_standard_target st;
+		struct ipt_entry etmp;
+
+		next -= IPT_ST_OFFSET;
+		if (__copy_from_user(&etmp, (void __user *)e,
+				sizeof(struct ipt_entry)))
+			goto out;
+		etmp.next_offset = next;	
+		if (__copy_to_user(*dstptr, &etmp, sizeof(struct ipt_entry)))
+			goto out;
+		if (__copy_from_user(&st, (void __user *)t,
+				sizeof(struct ipt_standard_target)))
+			goto out;
+		memcpy(&compat_st.target,  &st.target,
+				sizeof(struct ipt_target));
+		compat_st.verdict = st.verdict;
+		compat_st.target.u.user.target_size =
+			sizeof(struct compat_ipt_standard_target);
+		if (__copy_to_user(*dstptr + target_offset, &compat_st,
+				sizeof(struct compat_ipt_standard_target)))
+			goto out;
+		*size -= IPT_ST_OFFSET;
+	}
+	*dstptr	+= next;
+	ret = 0;
+out:
+	return ret;
+}
+
+static long do_ipt_get_entries(int fd, int level, int optname,
+		char __user *optval, int __user *optlen) 
+{
+	struct compat_ipt_get_entries __user *user;
+	struct ipt_get_entries __user *get;
+	long ret;
+	int len, off;
+	compat_uint_t size;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	if (len < sizeof(get))
+		return -EINVAL;
+
+	user = (struct compat_ipt_get_entries  *)optval;
+
+	off = sizeof(struct ipt_get_entries) -
+		sizeof(struct compat_ipt_get_entries);
+	get = compat_alloc_user_space(len + off);
+	if (get == NULL)
+		return -ENOMEM;
+	
+	ret = -EFAULT;
+	if (!access_ok(VERIFY_READ, user, len) ||
+	    !access_ok(VERIFY_READ, get, len+off) ||
+	    !access_ok(VERIFY_WRITE, get, len+off))
+		goto out;
+
+	if (__copy_in_user(get, user, sizeof(struct compat_ipt_get_entries)))
+		goto out;
+	if (__copy_in_user(get->entrytable,
+			user + sizeof(struct compat_ipt_get_entries),
+			len - sizeof(struct compat_ipt_get_entries)))
+		goto out;
+
+	len += off;
+	if (put_user(len, optlen))
+		goto out;
+
+	ret = sys_getsockopt(fd, level, optname, (char __user *)get, optlen);
+	if (ret == 0) {
+		ret = -EFAULT;
+		if (__copy_in_user(user, get,
+				sizeof(struct compat_ipt_get_entries)))
+			goto out;
+		if (get_user(size, &user->size))
+			goto out;
+		if (compat_copy_entries(get->entrytable, user->entrytable,
+					&size, compat_copy_entry))
+			goto out;
+		if (put_user(size, &user->size))
+			goto out;
+		len = size + sizeof(struct compat_ipt_get_entries);
+		if (put_user(len, optlen))
+			goto out;
+		ret = 0;
+	}
+out:
+	return ret;
+}
+
 asmlinkage long compat_sys_getsockopt(int fd, int level, int optname,
 				char __user *optval, int __user *optlen)
 {
 	if (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO)
 		return do_get_sock_timeout(fd, level, optname, optval, optlen);
+	if (level == SOL_IP && optname == IPT_SO_GET_INFO)
+		return do_ipt_get_info(fd, level, optname, optval, optlen);
+	if (level == SOL_IP && optname == IPT_SO_GET_ENTRIES)
+		return do_ipt_get_entries(fd, level, optname, optval, optlen);
 	return sys_getsockopt(fd, level, optname, optval, optlen);
 }
 


--------------090700070006030107030503--

