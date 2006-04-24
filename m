Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWDXRTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWDXRTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWDXRTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:19:06 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:47157 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750978AbWDXRTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:19:04 -0400
In-Reply-To: <84144f020604210742j69222654s5ec68f34ea96999c@mail.gmail.com>
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
To: penberg@cs.helsinki.fi, ioe-lkml@rameria.de
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       joern@wohnheim.fh-wedel.de
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF5DE8BD95.A1102FF1-ON4225715A.005B8089-4225715A.005F20AD@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Mon, 24 Apr 2006 19:19:02 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 24/04/2006 19:20:06
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka, Hi Ingo,

I included your comments in my new patch
(which comes with the next posting):

penberg@gmail.com wrote on 04/21/2006 04:42:28 PM:
> I have included some review comments below.
>
> On 4/21/06, Michael Holzheu <holzheu@de.ibm.com> wrote:
> > diff -urpN linux-2.6.16/fs/hypfs/hypfs.h
linux-2.6.16-hypfs/fs/hypfs/hypfs.h
> > --- linux-2.6.16/fs/hypfs/hypfs.h   1970-01-01 01:00:00.000000000 +0100
> > +++ linux-2.6.16-hypfs/fs/hypfs/hypfs.h   2006-04-21 12:56:58.
> 000000000 +0200
> > +static void inline remove_trailing_blanks(char *string)
> > +{
> > +   char *ptr;
> > +   for (ptr = string + strlen(string) - 1; ptr > string; ptr--) {
> > +      if (*ptr == ' ')
> > +         *ptr = 0;
> > +      else
> > +         break;
> > +   }
> > +}
>
> Please consider moving this to lib/string.c and perhaps renaming it to
> strstrip().

I Implemented a strrtrim() function in string.c

> > diff -urpN linux-2.6.16/fs/hypfs/hypfs_diag.c linux-2.6.16-
> hypfs/fs/hypfs/hypfs_diag.c
> > --- linux-2.6.16/fs/hypfs/hypfs_diag.c   1970-01-01 01:00:00.000000000
+0100
> > +++ linux-2.6.16-hypfs/fs/hypfs/hypfs_diag.c   2006-04-21 12:56:
> 58.000000000 +0200
> > +/* diag 204 subcodes */
> > +typedef enum {
> > +   SUBC_STIB4 = 4,
> > +   SUBC_RSI = 5,
> > +   SUBC_STIB6 = 6,
> > +   SUBC_STIB7 = 7
> > +} diag204_subc_t;
> > +
> > +/* The two available diag 204 data formats */
> > +typedef enum {
> > +   INFO_SIMPLE = 0,
> > +   INFO_EXT = 0x00010000
> > +} diag204_info_t;
>
> Please kill the typedefs.

Done.

> > +/* Time information block */
> > +
> > +struct info_blk_hdr {
> > +   __u8  npar;
> > +   __u8  flags;
> > +   __u16 tslice;
> > +   __u16 phys_cpus;
> > +   __u16 this_part;
> > +   __u64 curtod;
> > +} __attribute__ ((packed));
> > +
> > +struct x_info_blk_hdr {
> > +   __u8  npar;
> > +   __u8  flags;
> > +   __u16 tslice;
> > +   __u16 phys_cpus;
> > +   __u16 this_part;
> > +   __u64 curtod1;
> > +   __u64 curtod2;
> > +   char reserved[40];
> > +} __attribute__ ((packed));
>
> Couldn't you use endianess annotated types for these?

Since we have a s390 only implementation, I think this is not
necessary.

> > +static inline __u8 part_hdr__cpus(diag204_info_t type, void *hdr)
>
> Ditto. Appears in various other places as well.

I used the extra underscore for the "getter" functions to
separate the member part from the rest of the function name.
E.g. "part_hdr" is the structure name and "cpus" is the
member name. I really would like to keep that.

> > +static inline int diag204(unsigned long subcode, unsigned long
> size, void *addr)
> > +{
> > +   register unsigned long _subcode asm("0") = subcode;
> > +   register unsigned long _size asm("1") = size;
> > +
> > +   asm volatile ("   diag    %2,%0,0x204\n"
> > +            "0: \n" ".section __ex_table,\"a\"\n"
> > +#ifndef __s390x__
> > +            "    .align 4\n"
> > +            "    .long  0b,0b\n"
> > +#else
> > +            "    .align 8\n"
> > +            "    .quad  0b,0b\n"
> > +#endif
> > +            ".previous":"+d" (_subcode), "+d"(_size)
> > +            :"d"(addr)
> > +            :"memory");
>
> Please note that the above is a big clue for this fs to go into
arch/s390/.

Right! I moved the code to arch/s390/hypfs.

>
> > +static int diag204_probe(void)
> > +{
> > +   void *buf;
> > +   int pages, rc;
> > +
> > +   pages = diag204(SUBC_RSI | INFO_EXT, 0, 0);
> > +   if (pages > 0) {
> > +      if (!(buf = kmalloc(pages * PAGE_SIZE, GFP_KERNEL))) {
>
> Please move the assignment out of the if expression for readability.

Done.

> > +         rc = -ENOMEM;
> > +         goto err_out;
> > +      }
> > +      if (diag204(SUBC_STIB7 | INFO_EXT, pages, buf) >= 0) {
> > +         diag204_store_sc = SUBC_STIB7;
> > +         diag204_info_type = INFO_EXT;
> > +         goto out;
> > +      }
> > +      if (diag204(SUBC_STIB6 | INFO_EXT, pages, buf) >= 0) {
> > +         diag204_store_sc = SUBC_STIB7;
> > +         diag204_info_type = INFO_EXT;
> > +         goto out;
> > +      }
> > +      kfree(buf);
> > +   }
> > +   if (!(buf = kmalloc(PAGE_SIZE, GFP_KERNEL))) {
>
> Same here.

Done.

> > +      rc = -ENOMEM;
> > +      goto err_out;
> > +   }
> > +   if (diag204(SUBC_STIB4 | INFO_SIMPLE, pages, buf) >= 0) {
> > +      diag204_store_sc = SUBC_STIB4;
> > +      diag204_info_type = INFO_SIMPLE;
> > +      goto out;
> > +   } else {
> > +      rc = -ENOSYS;
> > +      goto err_out;
> > +   }
> > +      out:
> > +   kfree(buf);
> > +   return 0;
> > +      err_out:
> > +   kfree(buf);
> > +   return rc;
>
> Please drop the duplicate error path.

Done. I use now "rc = 0" for the good path.

> > +static void *diag204_store(void)
> > +{
> > +   void *buf;
> > +   int pages;
> > +
> > +   if (diag204_store_sc == SUBC_STIB4)
> > +      pages = 1;
> > +   else
> > +      pages = diag204(SUBC_RSI | diag204_info_type, 0, 0);
> > +
> > +   if (pages < 0)
> > +      return ERR_PTR(-ENOSYS);
> > +
> > +   if (!(buf = kmalloc(pages * PAGE_SIZE, GFP_KERNEL)))
>
> And here.

Done.

> > diff -urpN linux-2.6.16/fs/hypfs/inode.c
linux-2.6.16-hypfs/fs/hypfs/inode.c
> > --- linux-2.6.16/fs/hypfs/inode.c   1970-01-01 01:00:00.000000000 +0100
> > +++ linux-2.6.16-hypfs/fs/hypfs/inode.c   2006-04-21 12:56:58.
> 000000000 +0200
>
> > +static DECLARE_MUTEX(hypfs_lock); // XXX DEFINE_MUTEX in 2.6.16 !
>
> Yes, please!

Done.

> > +
> > +/* start of list of all dentries, which have to be deleted on update
*/
> > +static struct dentry *hypfs_last_dentry;
> > +
> > +static void hypfs_update_update(void)
> > +{
> > +   last_update_time = get_seconds();
> > +   snprintf((char *)update_file_dentry->d_inode->u.generic_ip,
> > +       UPDATE_DATA_SIZE, "%ld\n", last_update_time);
> > +   update_file_dentry->d_inode->i_size =
> > +       strlen((char *)update_file_dentry->d_inode->u.generic_ip);
> > +   update_file_dentry->d_inode->i_atime =
> > +       update_file_dentry->d_inode->i_mtime =
> > +       update_file_dentry->d_inode->i_ctime = CURRENT_TIME;
>
> Please introduce local variable for update_file_dentry->d_inode for
> readability. Perhaps for generic_ip as well.

Done. Much better now!

> > +}
> > +
> > +/* directory tree removal functions */
> > +
> > +static void hypfs_add_dentry(struct dentry *dentry)
> > +{
> > +   dentry->d_fsdata = hypfs_last_dentry;
> > +   hypfs_last_dentry = dentry;
> > +}
> > +
> > +static void hypfs_delete_tree(struct dentry *root)
> > +{
> > +   while (hypfs_last_dentry) {
> > +      struct dentry *parent, *next_dentry;
> > +
> > +      parent = hypfs_last_dentry->d_parent;
> > +      if (S_ISDIR(hypfs_last_dentry->d_inode->i_mode))
> > +         simple_rmdir(parent->d_inode, hypfs_last_dentry);
> > +      else
> > +         simple_unlink(parent->d_inode, hypfs_last_dentry);
> > +      d_delete(hypfs_last_dentry);
> > +      next_dentry = hypfs_last_dentry->d_fsdata;
> > +      dput(hypfs_last_dentry);
> > +      hypfs_last_dentry = next_dentry;
> > +   }
> > +}
> > +
> > +static struct inode *hypfs_make_inode(struct super_block *sb, int
mode)
> > +{
> > +   struct inode *ret = new_inode(sb);
> > +
> > +   if (ret) {
> > +      ret->i_mode = mode;
> > +      ret->i_uid = ((struct hypfs_sb_info *)sb->s_fs_info)->uid;
> > +      ret->i_gid = ((struct hypfs_sb_info *)sb->s_fs_info)->gid;
>
> Reduce casting by introducing a local variable for hypfs_sb_info.

Done.

> > +      ret->i_blksize = PAGE_CACHE_SIZE;
> > +      ret->i_blocks = 0;
> > +      ret->i_atime = ret->i_mtime = ret->i_ctime = CURRENT_TIME;
> > +      if (mode & S_IFDIR)
> > +         ret->i_nlink = 2;
> > +      else
> > +         ret->i_nlink = 1;
> > +   }
> > +   return ret;
> > +}
> > +
> > +static void hypfs_drop_inode(struct inode *inode)
> > +{
> > +   kfree((void *)inode->u.generic_ip);
>
> Please drop the redundant cast. Consider moving this to
> inode_ops->clear_inode.

I removed the cast, but I keep the code in drop_inode() until
someone tells me that this terribly wrong.

> > +static int hypfs_parse_options(char *options)
> > +{
> > +   char *str;
> > +   substring_t args[MAX_OPT_ARGS];
> > +
> > +   if (!options)
> > +      return 0;
> > +   while ((str = strsep(&options, ",")) != NULL) {
> > +      int token, option;
> > +      if (!*str)
> > +         continue;
> > +      token = match_token(str, hypfs_tokens, args);
> > +      switch (token) {
> > +      case opt_uid:
> > +         if (match_int(&args[0], &option))
> > +            return -EINVAL;
> > +         ((struct hypfs_sb_info *)hypfs_sblk->s_fs_info)->uid
> > +             = option;
> > +         break;
> > +      case opt_gid:
> > +         if (match_int(&args[0], &option))
> > +            return -EINVAL;
> > +         ((struct hypfs_sb_info *)hypfs_sblk->s_fs_info)->gid
> > +             = option;
>
> Please reduce casting by introducing a local variable for hypfs_sb_info.

Done.

> > +static int hypfs_fill_super(struct super_block *sb, void *data, int
silent)
> > +{
> > +   struct inode *root_inode;
> > +   int rc = 0;
> > +   struct hypfs_sb_info *sbi;
> > +
> > +   sbi = kmalloc(sizeof(struct hypfs_sb_info), GFP_KERNEL);
> > +   if (!sbi)
> > +      return -ENOMEM;
> > +   sbi->uid = current->uid;
> > +   sbi->gid = current->gid;
> > +   sb->s_fs_info = sbi;
> > +   sb->s_blocksize = PAGE_CACHE_SIZE;
> > +   sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
> > +   sb->s_magic = HYPFS_MAGIC;
> > +   sb->s_op = &hypfs_s_ops;
> > +   if (hypfs_parse_options(data)) {
> > +      rc = -EINVAL;
> > +      goto err_alloc;
> > +   }
> > +   root_inode = hypfs_make_inode(sb, S_IFDIR | 0755);
> > +   if (!root_inode) {
> > +      rc = -ENOMEM;
> > +      goto err_alloc;
> > +   }
> > +   root_inode->i_op = &simple_dir_inode_operations;
> > +   root_inode->i_fop = &simple_dir_operations;
> > +   sb->s_root = d_alloc_root(root_inode);
> > +   if (!sb->s_root) {
> > +      rc = -ENOMEM;
> > +      goto err_inode;
> > +   }
> > +   hypfs_sblk = sb;
> > +   rc = diag_create_files(hypfs_sblk, hypfs_sblk->s_root);
> > +   if (rc)
> > +      goto err_tree;
> > +   update_file_dentry = hypfs_create_update_file(hypfs_sblk,
> > +                        hypfs_sblk->s_root);
> > +   if (IS_ERR(update_file_dentry)) {
> > +      rc = PTR_ERR(update_file_dentry);
> > +      goto err_tree;
> > +   }
> > +   hypfs_update_update();
> > +   return 0;
> > +
> > +      err_tree:
> > +   hypfs_delete_tree(hypfs_sblk->s_root);
> > +   dput(hypfs_sblk->s_root);
> > +      err_inode:
> > +   hypfs_drop_inode(root_inode);
>
> You should use iput() here.

Done.

> > +      err_alloc:
> > +   kfree(sbi);
> > +   return rc;
> > +}
> > +static void hypfs_kill_super(struct super_block *sb)
> > +{
> > +   kfree(sb->s_fs_info);
>
> Please use super_operations->put_super instead for freeing s_fs_info.

Done.

> > +/*
> > + * init and exit
> > + * *************
> > + */
>
> Consider dropping the above useless comment.

Done.

> > +
> > +static decl_subsys(hypervisor, NULL, NULL);
> > +
> > +static int __init hypfs_init(void)
> > +{
> > +   int rc;
> > +
> > +   if (MACHINE_IS_VM) {
> > +      return -ENODATA;
> > +   }
> > +   if (diag_init()) {
> > +      printk(KERN_ERR "hypfs: diag init failed.\n");
> > +      return -ENODATA;
> > +   }
> > +   rc = subsystem_register(&hypervisor_subsys);
> > +   if (rc) {
> > +      diag_exit();
> > +      return rc;
> > +   }
> > +   rc = register_filesystem(&hypfs_type);
> > +   if (rc) {
> > +      subsystem_unregister(&hypervisor_subsys);
> > +      diag_exit();
> > +      return rc;
>
> Please use gotos for error handling here to reduce duplication.

Done.

