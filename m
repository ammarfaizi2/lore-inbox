Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWDUOma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWDUOma (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWDUOma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:42:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:8278 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932338AbWDUOm3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:42:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T4/VfnqkaH28LsZdEI9/Yr4EO18hjBTR2C6un9sOpmANmwkfJRd4W/Z58uu6rQpQ580cl+oWXzkYAbbCpcajh3AvflziHXoA/btvIL+yJjWhGMZycQ2sLoei0yMc25YcJvkhcC/yO3wVQfSuZM31fJxSH8dTCTntoAJvA1LKlpg=
Message-ID: <84144f020604210742j69222654s5ec68f34ea96999c@mail.gmail.com>
Date: Fri, 21 Apr 2006 17:42:28 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Michael Holzheu" <holzheu@de.ibm.com>
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
In-Reply-To: <20060421133541.37002378.holzheu@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060421133541.37002378.holzheu@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

I have included some review comments below.

                                    Pekka

On 4/21/06, Michael Holzheu <holzheu@de.ibm.com> wrote:
> diff -urpN linux-2.6.16/fs/hypfs/hypfs.h linux-2.6.16-hypfs/fs/hypfs/hypfs.h
> --- linux-2.6.16/fs/hypfs/hypfs.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.16-hypfs/fs/hypfs/hypfs.h	2006-04-21 12:56:58.000000000 +0200
> +static void inline remove_trailing_blanks(char *string)
> +{
> +	char *ptr;
> +	for (ptr = string + strlen(string) - 1; ptr > string; ptr--) {
> +		if (*ptr == ' ')
> +			*ptr = 0;
> +		else
> +			break;
> +	}
> +}

Please consider moving this to lib/string.c and perhaps renaming it to
strstrip().

> diff -urpN linux-2.6.16/fs/hypfs/hypfs_diag.c linux-2.6.16-hypfs/fs/hypfs/hypfs_diag.c
> --- linux-2.6.16/fs/hypfs/hypfs_diag.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.16-hypfs/fs/hypfs/hypfs_diag.c	2006-04-21 12:56:58.000000000 +0200
> +/* diag 204 subcodes */
> +typedef enum {
> +	SUBC_STIB4 = 4,
> +	SUBC_RSI = 5,
> +	SUBC_STIB6 = 6,
> +	SUBC_STIB7 = 7
> +} diag204_subc_t;
> +
> +/* The two available diag 204 data formats */
> +typedef enum {
> +	INFO_SIMPLE = 0,
> +	INFO_EXT = 0x00010000
> +} diag204_info_t;

Please kill the typedefs.

> +/* Time information block */
> +
> +struct info_blk_hdr {
> +	__u8  npar;
> +	__u8  flags;
> +	__u16 tslice;
> +	__u16 phys_cpus;
> +	__u16 this_part;
> +	__u64 curtod;
> +} __attribute__ ((packed));
> +
> +struct x_info_blk_hdr {
> +	__u8  npar;
> +	__u8  flags;
> +	__u16 tslice;
> +	__u16 phys_cpus;
> +	__u16 this_part;
> +	__u64 curtod1;
> +	__u64 curtod2;
> +	char reserved[40];
> +} __attribute__ ((packed));

Couldn't you use endianess annotated types for these?

> +/* Partition header */
> +
> +struct part_hdr {
> +	__u8 pn;
> +	__u8 cpus;
> +	char reserved[6];
> +	char part_name[LPAR_NAME_LEN];
> +} __attribute__ ((packed));
> +
> +struct x_part_hdr {
> +	__u8  pn;
> +	__u8  cpus;
> +	__u8  rcpus;
> +	__u8  pflag;
> +	__u32 mlu;
> +	char  part_name[LPAR_NAME_LEN];
> +	char  lpc_name[8];
> +	char  os_name[8];
> +	__u64 online_cs;
> +	__u64 online_es;
> +	__u8  upid;
> +	char  reserved1[3];
> +	__u32 group_mlu;
> +	char  group_name[8];
> +	char  reserved2[32];
> +} __attribute__ ((packed));

Same here.

> +
> +static inline int part_hdr__size(diag204_info_t type)

Please drop the extra underscore from function name.

> +static inline __u8 part_hdr__cpus(diag204_info_t type, void *hdr)

Ditto. Appears in various other places as well.

> +struct cpu_info {
> +	__u16 cpu_addr;
> +	char  reserved1[2];
> +	__u8  ctidx;
> +	__u8  cflag;
> +	__u16 weight;
> +	__u64 acc_time;
> +	__u64 lp_time;
> +} __attribute__ ((packed));
> +
> +struct x_cpu_info {
> +	__u16 cpu_addr;
> +	char  reserved1[2];
> +	__u8  ctidx;
> +	__u8  cflag;
> +	__u16 weight;
> +	__u64 acc_time;
> +	__u64 lp_time;
> +	__u16 min_weight;
> +	__u16 cur_weight;
> +	__u16 max_weight;
> +	char  reseved2[2];
> +	__u64 online_time;
> +	__u64 wait_time;
> +	__u32 pma_weight;
> +	__u32 polar_weight;
> +	char  reserved3[40];
> +} __attribute__ ((packed));

Endianess annotated types?

> +/* Physical header */
> +
> +struct phys_hdr {
> +	char reserved1[1];
> +	__u8 cpus;
> +	char reserved2[6];
> +	char mgm_name[8];
> +} __attribute__ ((packed));
> +
> +struct x_phys_hdr {
> +	char reserved1[1];
> +	__u8 cpus;
> +	char reserved2[6];
> +	char mgm_name[8];
> +	char reserved3[80];
> +} __attribute__ ((packed));

Here.

> +/* Physical CPU info block */
> +
> +struct phys_cpu {
> +	__u16 cpu_addr;
> +	char  reserved1[2];
> +	__u8  ctidx;
> +	char  reserved2[3];
> +	__u64 mgm_time;
> +	char  reserved3[8];
> +} __attribute__ ((packed));
> +
> +struct x_phys_cpu {
> +	__u16 cpu_addr;
> +	char  reserved1[2];
> +	__u8  ctidx;
> +	char  reserved2[3];
> +	__u64 mgm_time;
> +	char  reserved3[80];
> +} __attribute__ ((packed));

Here.

> +static inline int diag204(unsigned long subcode, unsigned long size, void *addr)
> +{
> +	register unsigned long _subcode asm("0") = subcode;
> +	register unsigned long _size asm("1") = size;
> +
> +	asm volatile ("   diag    %2,%0,0x204\n"
> +		      "0: \n" ".section __ex_table,\"a\"\n"
> +#ifndef __s390x__
> +		      "    .align 4\n"
> +		      "    .long  0b,0b\n"
> +#else
> +		      "    .align 8\n"
> +		      "    .quad  0b,0b\n"
> +#endif
> +		      ".previous":"+d" (_subcode), "+d"(_size)
> +		      :"d"(addr)
> +		      :"memory");

Please note that the above is a big clue for this fs to go into arch/s390/.

> +static int diag204_probe(void)
> +{
> +	void *buf;
> +	int pages, rc;
> +
> +	pages = diag204(SUBC_RSI | INFO_EXT, 0, 0);
> +	if (pages > 0) {
> +		if (!(buf = kmalloc(pages * PAGE_SIZE, GFP_KERNEL))) {

Please move the assignment out of the if expression for readability.

> +			rc = -ENOMEM;
> +			goto err_out;
> +		}
> +		if (diag204(SUBC_STIB7 | INFO_EXT, pages, buf) >= 0) {
> +			diag204_store_sc = SUBC_STIB7;
> +			diag204_info_type = INFO_EXT;
> +			goto out;
> +		}
> +		if (diag204(SUBC_STIB6 | INFO_EXT, pages, buf) >= 0) {
> +			diag204_store_sc = SUBC_STIB7;
> +			diag204_info_type = INFO_EXT;
> +			goto out;
> +		}
> +		kfree(buf);
> +	}
> +	if (!(buf = kmalloc(PAGE_SIZE, GFP_KERNEL))) {

Same here.

> +		rc = -ENOMEM;
> +		goto err_out;
> +	}
> +	if (diag204(SUBC_STIB4 | INFO_SIMPLE, pages, buf) >= 0) {
> +		diag204_store_sc = SUBC_STIB4;
> +		diag204_info_type = INFO_SIMPLE;
> +		goto out;
> +	} else {
> +		rc = -ENOSYS;
> +		goto err_out;
> +	}
> +      out:
> +	kfree(buf);
> +	return 0;
> +      err_out:
> +	kfree(buf);
> +	return rc;

Please drop the duplicate error path.

> +static void *diag204_store(void)
> +{
> +	void *buf;
> +	int pages;
> +
> +	if (diag204_store_sc == SUBC_STIB4)
> +		pages = 1;
> +	else
> +		pages = diag204(SUBC_RSI | diag204_info_type, 0, 0);
> +
> +	if (pages < 0)
> +		return ERR_PTR(-ENOSYS);
> +
> +	if (!(buf = kmalloc(pages * PAGE_SIZE, GFP_KERNEL)))

And here.

> diff -urpN linux-2.6.16/fs/hypfs/inode.c linux-2.6.16-hypfs/fs/hypfs/inode.c
> --- linux-2.6.16/fs/hypfs/inode.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.16-hypfs/fs/hypfs/inode.c	2006-04-21 12:56:58.000000000 +0200

> +static DECLARE_MUTEX(hypfs_lock); // XXX DEFINE_MUTEX in 2.6.16 !

Yes, please!

> +
> +/* start of list of all dentries, which have to be deleted on update */
> +static struct dentry *hypfs_last_dentry;
> +
> +static void hypfs_update_update(void)
> +{
> +	last_update_time = get_seconds();
> +	snprintf((char *)update_file_dentry->d_inode->u.generic_ip,
> +		 UPDATE_DATA_SIZE, "%ld\n", last_update_time);
> +	update_file_dentry->d_inode->i_size =
> +	    strlen((char *)update_file_dentry->d_inode->u.generic_ip);
> +	update_file_dentry->d_inode->i_atime =
> +	    update_file_dentry->d_inode->i_mtime =
> +	    update_file_dentry->d_inode->i_ctime = CURRENT_TIME;

Please introduce local variable for update_file_dentry->d_inode for
readability. Perhaps for generic_ip as well.

> +}
> +
> +/* directory tree removal functions */
> +
> +static void hypfs_add_dentry(struct dentry *dentry)
> +{
> +	dentry->d_fsdata = hypfs_last_dentry;
> +	hypfs_last_dentry = dentry;
> +}
> +
> +static void hypfs_delete_tree(struct dentry *root)
> +{
> +	while (hypfs_last_dentry) {
> +		struct dentry *parent, *next_dentry;
> +
> +		parent = hypfs_last_dentry->d_parent;
> +		if (S_ISDIR(hypfs_last_dentry->d_inode->i_mode))
> +			simple_rmdir(parent->d_inode, hypfs_last_dentry);
> +		else
> +			simple_unlink(parent->d_inode, hypfs_last_dentry);
> +		d_delete(hypfs_last_dentry);
> +		next_dentry = hypfs_last_dentry->d_fsdata;
> +		dput(hypfs_last_dentry);
> +		hypfs_last_dentry = next_dentry;
> +	}
> +}
> +
> +static struct inode *hypfs_make_inode(struct super_block *sb, int mode)
> +{
> +	struct inode *ret = new_inode(sb);
> +
> +	if (ret) {
> +		ret->i_mode = mode;
> +		ret->i_uid = ((struct hypfs_sb_info *)sb->s_fs_info)->uid;
> +		ret->i_gid = ((struct hypfs_sb_info *)sb->s_fs_info)->gid;

Reduce casting by introducing a local variable for hypfs_sb_info.

> +		ret->i_blksize = PAGE_CACHE_SIZE;
> +		ret->i_blocks = 0;
> +		ret->i_atime = ret->i_mtime = ret->i_ctime = CURRENT_TIME;
> +		if (mode & S_IFDIR)
> +			ret->i_nlink = 2;
> +		else
> +			ret->i_nlink = 1;
> +	}
> +	return ret;
> +}
> +
> +static void hypfs_drop_inode(struct inode *inode)
> +{
> +	kfree((void *)inode->u.generic_ip);

Please drop the redundant cast. Consider moving this to inode_ops->clear_inode.

> +	generic_delete_inode(inode);
> +}

> +static int hypfs_parse_options(char *options)
> +{
> +	char *str;
> +	substring_t args[MAX_OPT_ARGS];
> +
> +	if (!options)
> +		return 0;
> +	while ((str = strsep(&options, ",")) != NULL) {
> +		int token, option;
> +		if (!*str)
> +			continue;
> +		token = match_token(str, hypfs_tokens, args);
> +		switch (token) {
> +		case opt_uid:
> +			if (match_int(&args[0], &option))
> +				return -EINVAL;
> +			((struct hypfs_sb_info *)hypfs_sblk->s_fs_info)->uid
> +			    = option;
> +			break;
> +		case opt_gid:
> +			if (match_int(&args[0], &option))
> +				return -EINVAL;
> +			((struct hypfs_sb_info *)hypfs_sblk->s_fs_info)->gid
> +			    = option;

Please reduce casting by introducing a local variable for hypfs_sb_info.

> +static int hypfs_fill_super(struct super_block *sb, void *data, int silent)
> +{
> +	struct inode *root_inode;
> +	int rc = 0;
> +	struct hypfs_sb_info *sbi;
> +
> +	sbi = kmalloc(sizeof(struct hypfs_sb_info), GFP_KERNEL);
> +	if (!sbi)
> +		return -ENOMEM;
> +	sbi->uid = current->uid;
> +	sbi->gid = current->gid;
> +	sb->s_fs_info = sbi;
> +	sb->s_blocksize = PAGE_CACHE_SIZE;
> +	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
> +	sb->s_magic = HYPFS_MAGIC;
> +	sb->s_op = &hypfs_s_ops;
> +	if (hypfs_parse_options(data)) {
> +		rc = -EINVAL;
> +		goto err_alloc;
> +	}
> +	root_inode = hypfs_make_inode(sb, S_IFDIR | 0755);
> +	if (!root_inode) {
> +		rc = -ENOMEM;
> +		goto err_alloc;
> +	}
> +	root_inode->i_op = &simple_dir_inode_operations;
> +	root_inode->i_fop = &simple_dir_operations;
> +	sb->s_root = d_alloc_root(root_inode);
> +	if (!sb->s_root) {
> +		rc = -ENOMEM;
> +		goto err_inode;
> +	}
> +	hypfs_sblk = sb;
> +	rc = diag_create_files(hypfs_sblk, hypfs_sblk->s_root);
> +	if (rc)
> +		goto err_tree;
> +	update_file_dentry = hypfs_create_update_file(hypfs_sblk,
> +						      hypfs_sblk->s_root);
> +	if (IS_ERR(update_file_dentry)) {
> +		rc = PTR_ERR(update_file_dentry);
> +		goto err_tree;
> +	}
> +	hypfs_update_update();
> +	return 0;
> +
> +      err_tree:
> +	hypfs_delete_tree(hypfs_sblk->s_root);
> +	dput(hypfs_sblk->s_root);
> +      err_inode:
> +	hypfs_drop_inode(root_inode);

You should use iput() here.

> +      err_alloc:
> +	kfree(sbi);
> +	return rc;
> +}
> +static void hypfs_kill_super(struct super_block *sb)
> +{
> +	kfree(sb->s_fs_info);

Please use super_operations->put_super instead for freeing s_fs_info.

> +	kill_litter_super(sb);

> +/*
> + * init and exit
> + * *************
> + */

Consider dropping the above useless comment.

> +
> +static decl_subsys(hypervisor, NULL, NULL);
> +
> +static int __init hypfs_init(void)
> +{
> +	int rc;
> +
> +	if (MACHINE_IS_VM) {
> +		return -ENODATA;
> +	}
> +	if (diag_init()) {
> +		printk(KERN_ERR "hypfs: diag init failed.\n");
> +		return -ENODATA;
> +	}
> +	rc = subsystem_register(&hypervisor_subsys);
> +	if (rc) {
> +		diag_exit();
> +		return rc;
> +	}
> +	rc = register_filesystem(&hypfs_type);
> +	if (rc) {
> +		subsystem_unregister(&hypervisor_subsys);
> +		diag_exit();
> +		return rc;

Please use gotos for error handling here to reduce duplication.
