Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316301AbSEOCxP>; Tue, 14 May 2002 22:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316302AbSEOCxO>; Tue, 14 May 2002 22:53:14 -0400
Received: from wombat.cs.rmit.edu.au ([131.170.24.41]:9393 "EHLO
	wombat.cs.rmit.edu.au") by vger.kernel.org with ESMTP
	id <S316301AbSEOCxM>; Tue, 14 May 2002 22:53:12 -0400
Message-ID: <3CE1CA10.F1778F41@operamail.com>
Date: Wed, 15 May 2002 12:38:08 +1000
From: Malcolm Smith <msmith@operamail.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
Subject: [RFC] FAT extension filters
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gordon/All,

(Sorry if I'm doing stupid things - I'm a newbie.  Send me a private
email and I'll fix them.)

This is a patch that adds an extra mount option for msdos/vfat
partitions, which allows you to specify a specific umask/uid/gid for
files with a particular extension.  Supports multiple filters using
linked list.  Note that this does not provide security on an inherently
insecure fs.

Use -o filter=ext[:[umask][:[uid][:[gid]]]]

This patch is for kernel 2.5.15
- Malcolm

diff -Nur linus-2.5/fs/fat/inode.c linux/fs/fat/inode.c
--- linus-2.5/fs/fat/inode.c    Tue May 14 21:38:20 2002
+++ linux/fs/fat/inode.c        Tue May 14 22:49:29 2002
@@ -169,6 +169,53 @@
        unlock_kernel();
 }

+/*
+ * Deletes all the elements from the linked list of filters.
+ */
+void fat_clear_filter(struct fat_filter_data *filter)
+{
+       struct fat_filter_data *this,*next;
+       this=filter;
+       while (this) {
+               next=this->next;
+               kfree(this);
+               this=next;
+       }
+}
+
+/*
+ * Loads a filter option into the filters linked list.
+ */
+void fat_load_filter(struct fat_filter_data *filter, char *value)
+{
+       char *tmp_pointer;
+       tmp_pointer = strchr(value, ':');
+       if (tmp_pointer) *tmp_pointer = '\0';
+       strncpy(filter->extension,value,3);
+       filter->next = NULL;
+       filter->mask_umask = 0;
+       filter->mask_uid = 0;
+       filter->mask_gid = 0;
+       if (tmp_pointer) {
+       if (tmp_pointer[1] != ':') {
+               filter->filter_umask = simple_strtoul(tmp_pointer + 1,
NULL, 8);
+               filter->mask_umask = 1;
+       }
+       tmp_pointer = strchr(tmp_pointer + 1, ':');
+       if (tmp_pointer) {
+       if (tmp_pointer[1] != ':') {
+               filter->filter_uid = simple_strtoul(tmp_pointer + 1,
NULL, 0);
+               filter->mask_uid = 1;
+       }
+       tmp_pointer = strchr(tmp_pointer + 1, ':');
+       if (tmp_pointer) {
+               filter->filter_gid = simple_strtoul(tmp_pointer + 1,
NULL, 0);
+               filter->mask_gid = 1;
+       }
+       }
+       }
+}
+
 void fat_put_super(struct super_block *sb)
 {
        struct msdos_sb_info *sbi = MSDOS_SB(sb);
@@ -196,6 +243,10 @@
                kfree(sbi->options.iocharset);
                sbi->options.iocharset = NULL;
        }
+       if (sbi->options.filter) {
+               fat_clear_filter(sbi->options.filter);
+               sbi->options.filter = NULL;
+       }
        sb->u.generic_sbp = NULL;
        kfree(sbi);
 }
@@ -220,6 +271,7 @@
        opts->shortname = 0;
        opts->utf8 = 0;
        opts->iocharset = NULL;
+       opts->filter = NULL;
        *debug = 0;

        if (!options)
@@ -256,6 +308,27 @@
                                opts->conversion = 'a';
                        else ret = 0;
                }
+               else if (!strcmp(this_char,"filter") && value) {
+                       struct fat_filter_data *cur_filter;
+                       /* Allocates memory in the list for a filter */
+                       if (opts->filter == NULL) {
+                               opts->filter = kmalloc(
+                                       sizeof(struct fat_filter_data),
+                                       GFP_KERNEL);
+                               cur_filter=opts->filter;
+                       } else {
+                               cur_filter = opts->filter;
+                               while (cur_filter->next != NULL)
+                                       cur_filter = cur_filter->next;
+                               cur_filter->next =
+                                       kmalloc(sizeof(struct
fat_filter_data),
+                                       GFP_KERNEL);
+                               cur_filter = cur_filter->next;
+                       }
+                       /* Processes the filter option itself */
+                       if (cur_filter)
+                               fat_load_filter(cur_filter, value);
+               }
                else if (!strcmp(this_char,"dots")) {
                        opts->dotsOK = 1;
                }
@@ -920,6 +993,10 @@
                unload_nls(sbi->nls_disk);
        if (sbi->options.iocharset)
                kfree(sbi->options.iocharset);
+       if (sbi->options.filter) {
+               fat_clear_filter(sbi->options.filter);
+               sbi->options.filter = NULL;
+       }
        if (sbi->private_data)
                kfree(sbi->private_data);
        sbi->private_data = NULL;
@@ -1001,6 +1078,7 @@
 {
        struct super_block *sb = inode->i_sb;
        struct msdos_sb_info *sbi = MSDOS_SB(sb);
+       struct fat_filter_data *filter;
        int error;

        MSDOS_I(inode)->i_location = 0;
@@ -1042,6 +1120,20 @@
                       !is_exec(de->ext))
                        ? S_IRUGO|S_IWUGO : S_IRWXUGO)
                    & ~sbi->options.fs_umask) | S_IFREG;
+               /* Check if the inode's extension needs special
treatment */
+               filter = fat_is_filtered(de->ext, &sbi->options);
+               if (filter) {
+                       if (filter->mask_uid)
+                               inode->i_uid = filter->filter_uid;
+                       if (filter->mask_gid)
+                               inode->i_gid = filter->filter_gid;
+                       if (filter->mask_umask)
+                               inode->i_mode = MSDOS_MKMODE(de->attr,
+                                   ((sbi->options.showexec &&
+                                      !is_exec(de->ext))
+                                       ? S_IRUGO|S_IWUGO : S_IRWXUGO)
+                                   & ~filter->filter_umask) | S_IFREG;
+               }
                MSDOS_I(inode)->i_start = CF_LE_W(de->start);
                if (sbi->fat_bits == 32) {
                        MSDOS_I(inode)->i_start |=
diff -Nur linus-2.5/fs/fat/misc.c linux/fs/fat/misc.c
--- linus-2.5/fs/fat/misc.c     Tue May 14 21:37:24 2002
+++ linux/fs/fat/misc.c Tue May 14 22:36:53 2002
@@ -80,6 +80,19 @@
        }
 }

+/*
+ * fat_is_filtered returns nonzero if the file should be treated
specially.
+ */
+
+struct fat_filter_data *fat_is_filtered(char *extension,
+       struct fat_mount_options * opts)
+{
+       struct fat_filter_data *walk;
+       for (walk = opts->filter; walk; walk = walk->next)
+               if (!strncmp(extension,walk->extension,3)) return walk;
+       return NULL;
+}
+
 void lock_fat(struct super_block *sb)
 {
        down(&(MSDOS_SB(sb)->fat_lock));
diff -Nur linus-2.5/include/linux/msdos_fs.h
linux/include/linux/msdos_fs.h
--- linus-2.5/include/linux/msdos_fs.h  Tue May 14 21:45:55 2002
+++ linux/include/linux/msdos_fs.h      Tue May 14 22:57:47 2002
@@ -299,6 +299,9 @@
 /* fat/misc.c */
 extern void fat_fs_panic(struct super_block *s, const char *fmt, ...);
 extern int fat_is_binary(char conversion, char *extension);
+extern struct fat_filter_data *
+fat_is_filtered(char *extension,
+               struct fat_mount_options *opts);
 extern void lock_fat(struct super_block *sb);
 extern void unlock_fat(struct super_block *sb);
 extern void fat_clusters_flush(struct super_block *sb);
diff -Nur linus-2.5/include/linux/msdos_fs_sb.h
linux/include/linux/msdos_fs_sb.h
--- linus-2.5/include/linux/msdos_fs_sb.h       Thu May  2 23:06:24 2002

+++ linux/include/linux/msdos_fs_sb.h   Tue May 14 22:54:32 2002
@@ -3,6 +3,20 @@
 #include<linux/fat_cvf.h>

 /*
+ * Specifies a filter to be applied to a specific file's extension.
+ */
+struct fat_filter_data {
+       char extension[4];              /* The extension to be filtered
*/
+       uid_t filter_uid;               /* The uid of this filter */
+       gid_t filter_gid;               /* The gid of this filter */
+       unsigned short filter_umask;    /* The umask of this filter */
+       unsigned mask_umask:1,          /* Is the umask applied? */
+                mask_uid:1,            /* Is the uid applied? */
+                mask_gid:1;            /* Is the gid applied? */
+       struct fat_filter_data *next;   /* The next filter */
+};
+
+/*
  * MS-DOS file system in-core superblock data
  */

@@ -12,6 +26,7 @@
        unsigned short fs_umask;
        unsigned short codepage;  /* Codepage for shortname conversions
*/
        char *iocharset;          /* Charset used for filename
input/display */
+       struct fat_filter_data *filter;  /* List of extensions to be
excised */
        unsigned short shortname; /* flags for shortname display/create
rule */
        unsigned char name_check; /* r = relaxed, n = normal, s = strict
*/
        unsigned char conversion; /* b = binary, t = text, a = auto */

