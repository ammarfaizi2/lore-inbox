Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWA1XCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWA1XCE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 18:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWA1XCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 18:02:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15256 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750765AbWA1XCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 18:02:02 -0500
Date: Sat, 28 Jan 2006 15:01:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Cc: eike-kernel@sf-tec.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-rc1-git4] accessfs: a permission managing
 filesystem
Message-Id: <20060128150137.5ba5af04.akpm@osdl.org>
In-Reply-To: <87mzhgyomh.fsf@goat.bogus.local>
References: <87ek3a8qpy.fsf@goat.bogus.local>
	<200601231257.28796@bilbo.math.uni-mannheim.de>
	<87mzhgyomh.fsf@goat.bogus.local>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de> wrote:
>
> Hi Andrew,
> 
> Can you please include this patch in -mm, to give it wider testing?

I doubt if it'll get a lot of runtime testing.

> Accessfs is a permission managing filesystem. It allows to control
> access to system resources, based on file permissions.  It also
> includes two modules.  One module allows granting capabilities based
> on user-/groupid. The second module allows to grant access to lower
> numbered IP ports based on user-/groupid.
> 

It seems to be network-centric?

Do these capabilities really need to be implemented via a brand-new
security infrastructure, rather then by enhancing the existing one(s)?

> +	  To use this option, you need to mount the access file system
> +	  and do a chown on the appropriate ports:
> +
> +	  # mount -t accessfs none /proc/access
> +	  # chown www /proc/access/net/ip/bind/80
> +	  # chown mail /proc/access/net/ip/bind/25

Documenting a feature in Kconfig is a bit odd.  I assume proper
Documentation is forthcoming?


> + */
> +
> +#include <linux/accessfs_fs.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/security.h>
> +
> +static struct access_attr caps[29];

				caps[ARRAY_SIZE(names)]

should work.

> +static const char *names[] = {
> +	"chown",
> +	"dac_override",
> +	"dac_read_search",
> +	"fowner",
> +	"fsetid",
> +	"kill",
> +	"setgid",
> +	"setuid",
> +	"setpcap",
> +	"linux_immutable",
> +	"net_bind_service",
> +	"net_broadcast",
> +	"net_admin",
> +	"net_raw",
> +	"ipc_lock",
> +	"ipc_owner",
> +	"sys_module",
> +	"sys_rawio",
> +	"sys_chroot",
> +	"sys_ptrace",
> +	"sys_pacct",
> +	"sys_admin",
> +	"sys_boot",
> +	"sys_nice",
> +	"sys_resource",
> +	"sys_time",
> +	"sys_tty_config",
> +	"mknod",
> +	"lease"
> +};
> +
>
> +static void unregister_capabilities(struct accessfs_direntry *dir, int n)
> +{
> +	int	i;
> +	for (i = 0; i < n; ++i) {
> +		accessfs_unregister(dir, names[i]);
> +	}
> +}

Unneeded braces.

> +static int __init init_capabilities(void)
> +{
> +	struct accessfs_direntry *dir;
> +	int i, err;
> +	dir = accessfs_make_dirpath("capabilities");
> +	if (dir == 0)
> +		return -ENOTDIR;
> +
> +	for (i = 0; i < sizeof(caps) / sizeof(caps[0]); ++i) {

ARRAY_SIZE()  (lots of instances)

> +static DECLARE_MUTEX(accessfs_sem);

Please use a `struct mutex'.

> +
> +static inline void accessfs_readdir_aux(struct file *filp, struct accessfs_direntry *dir, int start, void *dirent, filldir_t filldir)
> +{
> +	struct list_head *list;
> +	int i;
> +
> +	list = dir->children.next;
> +	for (i = 2; i < start && list != &dir->children; ++i)
> +		list = list->next;
> +
> +	while (list != &dir->children) {
> +		struct accessfs_entry *de;
> +		de = list_entry(list, struct accessfs_entry, siblings);
> +		if (filldir(dirent, de->name, strlen(de->name), filp->f_pos, de->ino, DT_UNKNOWN) < 0)
> +			break;
> +
> +		++filp->f_pos;
> +		list = list->next;
> +	}
> +}

Use standard list accessors?

Please fit code into 80 cols.

> +static int accessfs_readdir(struct file *filp, void *dirent, filldir_t filldir)
> +{
> +	int i;
> +	struct dentry *dentry = filp->f_dentry;
> +	struct accessfs_direntry *dir;
> +
> +	i = filp->f_pos;
> +	switch (i) {
> +	case 0:
> +		if (filldir(dirent, ".", 1, i, dentry->d_inode->i_ino, DT_DIR) < 0)
> +			break;
> +
> +		++i;
> +		++filp->f_pos;
> +		/* NO break; */
> +	case 1:
> +		if (filldir(dirent, "..", 2, i, dentry->d_parent->d_inode->i_ino, DT_DIR) < 0)
> +			break;
> +
> +		++i;
> +		++filp->f_pos;
> +		/* NO break; */
> +	default:
> +		down(&accessfs_sem);
> +		dir = (struct accessfs_direntry *) dentry->d_inode->u.generic_ip;

Unneeded typecast.

> +		accessfs_readdir_aux(filp, dir, i, dirent, filldir);
> +		up(&accessfs_sem);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +

> +static void accessfs_init_inode(struct inode *inode, struct accessfs_entry *pe)
> +{
> +	static const struct timespec epoch = {0, 0};

Unneeded initialiser (although it does make things clearer)

> +
> +static struct accessfs_direntry	*accessfs_mkdir(struct accessfs_direntry *parent, const char *name, size_t len)
> +{
> +	int err;
> +	struct accessfs_direntry *dir;
> +	dir = kmalloc(sizeof(struct accessfs_direntry), GFP_KERNEL);
> +	if (dir == NULL)
> +		return NULL;
> +
> +	dir->parent = parent;
> +	INIT_LIST_HEAD(&dir->children);
> +	err = accessfs_node_init(parent, &dir->node, name, len, &dir->attr, S_IFDIR | 0755);
> +	if (err) {
> +		kfree(dir);
> +		dir = 0;
> +	}
> +
> +	return dir;
> +}

Again, painful to read in 80-cols.

> +struct accessfs_direntry *accessfs_make_dirpath(const char *name)
> +{
> +	struct accessfs_direntry *dir = &accessfs_rootdir;
> +	const char *slash;
> +	down(&accessfs_sem);

Shouldn't that lock be per-superblock?

> +static void accessfs_read_inode(struct inode *inode)
> +{
> +	ino_t	ino = inode->i_ino;
> +	struct list_head	*list;
> +	down(&accessfs_sem);
> +	list_for_each(list, &hash) {
> +		struct accessfs_entry *pe;
> +		pe = list_entry(list, struct accessfs_entry, hash);
> +		if (pe->ino == ino) {
> +			accessfs_init_inode(inode, pe);
> +			break;
> +		}
> +	}

That's not a hash!

> +{
> +	unregister_filesystem(&accessfs_fs_type);
> +
> +#ifdef CONFIG_PROC_FS
> +	remove_proc_entry("access",&proc_root);
> +#endif
> +}

The CONFIG_PROC_FS ifdefs shouldn't be needed - we have stubs.

> +static int accessfs_ip6_prot_sock(struct socket *sock,
> +				  struct sockaddr *uaddr, int addr_len)
> +{
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)

That's a bit awkward, especially the CONFIG_IPV6_MODULE dependency.  Is it
possible to just unconditionally compile this in?

> +static int __init init_ip(void)
> +{
> +	struct accessfs_direntry *dir = accessfs_make_dirpath("net/ip/bind");
> +	int i;
> +	bind_to_port = kmalloc(max_prot_sock * sizeof(*bind_to_port), GFP_KERNEL);
> +	if (bind_to_port == 0)

Use NULL to avoid sparse warnings.

> +
> +#if  CONFIG_ACCESSFS_PROT_SOCK < PROT_SOCK
> +#define CONFIG_ACCESSFS_PROT_SOCK	PROT_SOCK
> +#elseif CONFIG_ACCESSFS_PROT_SOCK > 65536
> +#define CONFIG_ACCESSFS_PROT_SOCK	65536
> +#endif

Please don't redefine CONFIG_ variables like this.  I'd have expected the
compiler to have generated a warning about this, too.

>  	snum = ntohs(addr->sin_port);
>  	err = -EACCES;
> +#ifdef	CONFIG_NET_HOOKS
> +	if (net_ops->ip_prot_sock(sock, uaddr, addr_len))
> +#else
>  	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
> +#endif
>  		goto out;

Maybe some wrapper which hides the above?

>  	/*      We keep a pair of addresses. rcv_saddr is the one
> diff -urN a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> --- a/net/ipv6/af_inet6.c	Fri Jan 27 23:53:23 2006
> +++ b/net/ipv6/af_inet6.c	Sat Jan 28 12:47:19 2006
> @@ -260,7 +260,11 @@
>  		return -EINVAL;
>  
>  	snum = ntohs(addr->sin6_port);
> +#ifdef	CONFIG_NET_HOOKS
> +	if (net_ops->ip6_prot_sock(sock, uaddr, addr_len))
> +#else
>  	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
> +#endif
>  		return -EACCES;
>  

which could be used here as well.
