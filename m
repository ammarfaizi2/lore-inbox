Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266038AbUFJAHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266038AbUFJAHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 20:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUFJAHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 20:07:21 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:9856 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S266038AbUFJAGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 20:06:51 -0400
Date: Thu, 10 Jun 2004 02:06:41 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, joern@wohnheim.fh-wedel.de
Subject: [PATCH] Decrease stack usage in ncpfs's ioctl (was Re: [STACK] >3k call path in ncpfs)
Message-ID: <20040610000641.GA16558@vana.vc.cvut.cz>
References: <20040609122002.GD21168@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040609122002.GD21168@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 02:20:02PM +0200, Jörn Engel wrote:
> ncpfs has a few stack-hungry functions.  Could you try to put
> ncp_ioctl() and/or ncp_conn_logged_in() on a diet?  Example call path
> is below.
> 
> stackframes for call path too long (3004):
>     size  function
>      720  ncp_ioctl
>      616  ncp_conn_logged_in

Hi Andrew,
  please apply this. It decreases stack consumption in one of
ncpfs's paths from 3000 to 2200 bytes (and stack portion in ncpfs
ioctl code from 1336 to 452 bytes).
						Thanks,
							Petr Vandrovec

Decrease stack usage in ncpfs's ncp_ioctl: 
* some code used large structure (with embeded 256 bytes for filename) while
  it never passed filename around. Use something smaller in ncp_conn_logged_in.
  Decrease 616 => 300.
* gcc-3.3 is very bad when it comes to parallel blocks in ioctl. Split
  some branches from large switch to separate functions. ncp_ioctl now uses
  152 bytes of stack (instead of 720) and biggest child 64.

Signed-off-by: Petr Vandrovec <vandrove@vc.cvut.cz>

diff -urdN linux/fs/ncpfs/dir.c linux/fs/ncpfs/dir.c
--- linux/fs/ncpfs/dir.c	2004-06-09 19:25:01.000000000 +0000
+++ linux/fs/ncpfs/dir.c	2004-06-09 20:47:09.000000000 +0000
@@ -762,12 +762,12 @@
 int ncp_conn_logged_in(struct super_block *sb)
 {
 	struct ncp_server* server = NCP_SBP(sb);
-	struct nw_info_struct i;
 	int result;
 
 	if (ncp_single_volume(server)) {
 		int len;
 		struct dentry* dent;
+		__u32 volNumber, dirEntNum, DosDirNum;
 		__u8 __name[NCP_MAXPATHLEN + 1];
 
 		len = sizeof(__name);
@@ -776,7 +776,7 @@
 		if (result)
 			goto out;
 		result = -ENOENT;
-		if (ncp_lookup_volume(server, __name, &i)) {
+		if (ncp_get_volume_root(server, __name, &volNumber, &dirEntNum, &DosDirNum)) {
 			PPRINTK("ncp_conn_logged_in: %s not found\n",
 				server->m.mounted_vol);
 			goto out;
@@ -785,9 +785,9 @@
 		if (dent) {
 			struct inode* ino = dent->d_inode;
 			if (ino) {
-				NCP_FINFO(ino)->volNumber = i.volNumber;
-				NCP_FINFO(ino)->dirEntNum = i.dirEntNum;
-				NCP_FINFO(ino)->DosDirNum = i.DosDirNum;
+				NCP_FINFO(ino)->volNumber = volNumber;
+				NCP_FINFO(ino)->dirEntNum = dirEntNum;
+				NCP_FINFO(ino)->DosDirNum = DosDirNum;
 			} else {
 				DPRINTK("ncpfs: sb->s_root->d_inode == NULL!\n");
 			}
diff -urdN linux/fs/ncpfs/ioctl.c linux/fs/ncpfs/ioctl.c
--- linux/fs/ncpfs/ioctl.c	2004-06-09 19:25:01.000000000 +0000
+++ linux/fs/ncpfs/ioctl.c	2004-06-09 21:12:33.000000000 +0000
@@ -29,6 +29,155 @@
 /* maximum negotiable packet size */
 #define NCP_PACKET_SIZE_INTERNAL 65536
 
+static int
+ncp_get_fs_info(struct ncp_server* server, struct inode* inode, struct ncp_fs_info* arg)
+{
+	struct ncp_fs_info info;
+
+	if ((permission(inode, MAY_WRITE, NULL) != 0)
+	    && (current->uid != server->m.mounted_uid)) {
+		return -EACCES;
+	}
+	if (copy_from_user(&info, arg, sizeof(info)))
+		return -EFAULT;
+
+	if (info.version != NCP_GET_FS_INFO_VERSION) {
+		DPRINTK("info.version invalid: %d\n", info.version);
+		return -EINVAL;
+	}
+	/* TODO: info.addr = server->m.serv_addr; */
+	SET_UID(info.mounted_uid, server->m.mounted_uid);
+	info.connection		= server->connection;
+	info.buffer_size	= server->buffer_size;
+	info.volume_number	= NCP_FINFO(inode)->volNumber;
+	info.directory_id	= NCP_FINFO(inode)->DosDirNum;
+
+	if (copy_to_user(arg, &info, sizeof(info)))
+		return -EFAULT;
+	return 0;
+}
+
+static int
+ncp_get_fs_info_v2(struct ncp_server* server, struct inode* inode, struct ncp_fs_info_v2* arg)
+{
+	struct ncp_fs_info_v2 info2;
+
+	if ((permission(inode, MAY_WRITE, NULL) != 0)
+	    && (current->uid != server->m.mounted_uid)) {
+		return -EACCES;
+	}
+	if (copy_from_user(&info2, arg, sizeof(info2)))
+		return -EFAULT;
+
+	if (info2.version != NCP_GET_FS_INFO_VERSION_V2) {
+		DPRINTK("info.version invalid: %d\n", info2.version);
+		return -EINVAL;
+	}
+	info2.mounted_uid   = server->m.mounted_uid;
+	info2.connection    = server->connection;
+	info2.buffer_size   = server->buffer_size;
+	info2.volume_number = NCP_FINFO(inode)->volNumber;
+	info2.directory_id  = NCP_FINFO(inode)->DosDirNum;
+	info2.dummy1 = info2.dummy2 = info2.dummy3 = 0;
+
+	if (copy_to_user(arg, &info2, sizeof(info2)))
+		return -EFAULT;
+	return 0;
+}
+
+#ifdef CONFIG_NCPFS_NLS
+/* Here we are select the iocharset and the codepage for NLS.
+ * Thanks Petr Vandrovec for idea and many hints.
+ */
+static int
+ncp_set_charsets(struct ncp_server* server, struct ncp_nls_ioctl* arg)
+{
+	struct ncp_nls_ioctl user;
+	struct nls_table *codepage;
+	struct nls_table *iocharset;
+	struct nls_table *oldset_io;
+	struct nls_table *oldset_cp;
+			
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (server->root_setuped)
+		return -EBUSY;
+
+	if (copy_from_user(&user, arg, sizeof(user)))
+		return -EFAULT;
+
+	codepage = NULL;
+	user.codepage[NCP_IOCSNAME_LEN] = 0;
+	if (!user.codepage[0] || !strcmp(user.codepage, "default"))
+		codepage = load_nls_default();
+	else {
+		codepage = load_nls(user.codepage);
+		if (!codepage) {
+			return -EBADRQC;
+		}
+	}
+
+	iocharset = NULL;
+	user.iocharset[NCP_IOCSNAME_LEN] = 0;
+	if (!user.iocharset[0] || !strcmp(user.iocharset, "default")) {
+		iocharset = load_nls_default();
+		NCP_CLR_FLAG(server, NCP_FLAG_UTF8);
+	} else if (!strcmp(user.iocharset, "utf8")) {
+		iocharset = load_nls_default();
+		NCP_SET_FLAG(server, NCP_FLAG_UTF8);
+	} else {
+		iocharset = load_nls(user.iocharset);
+		if (!iocharset) {
+			unload_nls(codepage);
+			return -EBADRQC;
+		}
+		NCP_CLR_FLAG(server, NCP_FLAG_UTF8);
+	}
+
+	oldset_cp = server->nls_vol;
+	server->nls_vol = codepage;
+	oldset_io = server->nls_io;
+	server->nls_io = iocharset;
+
+	if (oldset_cp)
+		unload_nls(oldset_cp);
+	if (oldset_io)
+		unload_nls(oldset_io);
+
+	return 0;
+}
+
+static int
+ncp_get_charsets(struct ncp_server* server, struct ncp_nls_ioctl* arg)
+{		
+	struct ncp_nls_ioctl user;
+	int len;
+
+	memset(&user, 0, sizeof(user));
+	if (server->nls_vol && server->nls_vol->charset) {
+		len = strlen(server->nls_vol->charset);
+		if (len > NCP_IOCSNAME_LEN)
+			len = NCP_IOCSNAME_LEN;
+		strncpy(user.codepage, server->nls_vol->charset, len);
+		user.codepage[len] = 0;
+	}
+
+	if (NCP_IS_FLAG(server, NCP_FLAG_UTF8))
+		strcpy(user.iocharset, "utf8");
+	else if (server->nls_io && server->nls_io->charset) {
+		len = strlen(server->nls_io->charset);
+		if (len > NCP_IOCSNAME_LEN)
+			len = NCP_IOCSNAME_LEN;
+		strncpy(user.iocharset,	server->nls_io->charset, len);
+		user.iocharset[len] = 0;
+	}
+
+	if (copy_to_user(arg, &user, sizeof(user)))
+		return -EFAULT;
+	return 0;
+}
+#endif /* CONFIG_NCPFS_NLS */
+
 int ncp_ioctl(struct inode *inode, struct file *filp,
 	      unsigned int cmd, unsigned long arg)
 {
@@ -96,60 +245,10 @@
 		return ncp_conn_logged_in(inode->i_sb);
 
 	case NCP_IOC_GET_FS_INFO:
-		{
-			struct ncp_fs_info info;
-
-			if ((permission(inode, MAY_WRITE, NULL) != 0)
-			    && (current->uid != server->m.mounted_uid)) {
-				return -EACCES;
-			}
-			if (copy_from_user(&info, (struct ncp_fs_info *) arg, 
-				sizeof(info)))
-				return -EFAULT;
-
-			if (info.version != NCP_GET_FS_INFO_VERSION) {
-				DPRINTK("info.version invalid: %d\n", info.version);
-				return -EINVAL;
-			}
-			/* TODO: info.addr = server->m.serv_addr; */
-			SET_UID(info.mounted_uid, server->m.mounted_uid);
-			info.connection		= server->connection;
-			info.buffer_size	= server->buffer_size;
-			info.volume_number	= NCP_FINFO(inode)->volNumber;
-			info.directory_id	= NCP_FINFO(inode)->DosDirNum;
-
-			if (copy_to_user((struct ncp_fs_info *) arg, &info, 
-				sizeof(info))) return -EFAULT;
-			return 0;
-		}
+		return ncp_get_fs_info(server, inode, (struct ncp_fs_info *)arg);
 
 	case NCP_IOC_GET_FS_INFO_V2:
-		{
-			struct ncp_fs_info_v2 info2;
-
-			if ((permission(inode, MAY_WRITE, NULL) != 0)
-			    && (current->uid != server->m.mounted_uid)) {
-				return -EACCES;
-			}
-			if (copy_from_user(&info2, (struct ncp_fs_info_v2 *) arg, 
-				sizeof(info2)))
-				return -EFAULT;
-
-			if (info2.version != NCP_GET_FS_INFO_VERSION_V2) {
-				DPRINTK("info.version invalid: %d\n", info2.version);
-				return -EINVAL;
-			}
-			info2.mounted_uid   = server->m.mounted_uid;
-			info2.connection    = server->connection;
-			info2.buffer_size   = server->buffer_size;
-			info2.volume_number = NCP_FINFO(inode)->volNumber;
-			info2.directory_id  = NCP_FINFO(inode)->DosDirNum;
-			info2.dummy1 = info2.dummy2 = info2.dummy3 = 0;
-
-			if (copy_to_user((struct ncp_fs_info_v2 *) arg, &info2, 
-				sizeof(info2))) return -EFAULT;
-			return 0;
-		}
+		return ncp_get_fs_info_v2(server, inode, (struct ncp_fs_info_v2 *)arg);
 
 	case NCP_IOC_GETMOUNTUID2:
 		{
@@ -201,7 +300,7 @@
 	case NCP_IOC_SETROOT:
 		{
 			struct ncp_setroot_ioctl sr;
-			unsigned int vnum, de, dosde;
+			__u32 vnum, de, dosde;
 			struct dentry* dentry;
 
 			if (!capable(CAP_SYS_ADMIN))
@@ -219,15 +318,10 @@
 				dosde = 0;
 			} else if (sr.volNumber >= NCP_NUMBER_OF_VOLUMES) {
 				return -EINVAL;
-			} else {
-				struct nw_info_struct ni;
-				
-				if (ncp_mount_subdir(server, &ni, sr.volNumber,
-						sr.namespace, sr.dirEntNum))
-					return -ENOENT;
-				vnum = ni.volNumber;
-				de = ni.dirEntNum;
-				dosde = ni.DosDirNum;
+			} else if (ncp_mount_subdir(server, sr.volNumber,
+						sr.namespace, sr.dirEntNum,
+						&vnum, &de, &dosde)) {
+				return -ENOENT;
 			}
 			
 			dentry = inode->i_sb->s_root;
@@ -508,105 +602,14 @@
 		}
 
 #ifdef CONFIG_NCPFS_NLS
-/* Here we are select the iocharset and the codepage for NLS.
- * Thanks Petr Vandrovec for idea and many hints.
- */
 	case NCP_IOC_SETCHARSETS:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EACCES;
-		if (server->root_setuped)
-			return -EBUSY;
-
-		{
-			struct ncp_nls_ioctl user;
-			struct nls_table *codepage;
-			struct nls_table *iocharset;
-			struct nls_table *oldset_io;
-			struct nls_table *oldset_cp;
-			
-			if (copy_from_user(&user, (struct ncp_nls_ioctl*)arg,
-					sizeof(user)))
-				return -EFAULT;
-
-			codepage = NULL;
-			user.codepage[NCP_IOCSNAME_LEN] = 0;
-			if (!user.codepage[0] ||
-					!strcmp(user.codepage, "default"))
-				codepage = load_nls_default();
-			else {
-				codepage = load_nls(user.codepage);
-				if (!codepage) {
-					return -EBADRQC;
-				}
-			}
-
-			iocharset = NULL;
-			user.iocharset[NCP_IOCSNAME_LEN] = 0;
-			if (!user.iocharset[0] ||
-					!strcmp(user.iocharset, "default")) {
-				iocharset = load_nls_default();
-				NCP_CLR_FLAG(server, NCP_FLAG_UTF8);
-			} else {
-				if (!strcmp(user.iocharset, "utf8")) {
-					iocharset = load_nls_default();
-					NCP_SET_FLAG(server, NCP_FLAG_UTF8);
-				} else {
-					iocharset = load_nls(user.iocharset);
-					if (!iocharset) {
-						unload_nls(codepage);
-						return -EBADRQC;
-					}
-					NCP_CLR_FLAG(server, NCP_FLAG_UTF8);
-				}
-			}
-
-			oldset_cp = server->nls_vol;
-			server->nls_vol = codepage;
-			oldset_io = server->nls_io;
-			server->nls_io = iocharset;
-
-			if (oldset_cp)
-				unload_nls(oldset_cp);
-			if (oldset_io)
-				unload_nls(oldset_io);
-
-			return 0;
-		}
+		return ncp_set_charsets(server, (struct ncp_nls_ioctl *)arg);
 		
-	case NCP_IOC_GETCHARSETS: /* not tested */
-		{
-			struct ncp_nls_ioctl user;
-			int len;
-
-			memset(&user, 0, sizeof(user));
-			if (server->nls_vol && server->nls_vol->charset) {
-				len = strlen(server->nls_vol->charset);
-				if (len > NCP_IOCSNAME_LEN)
-					len = NCP_IOCSNAME_LEN;
-				strncpy(user.codepage,
-						server->nls_vol->charset, len);
-				user.codepage[len] = 0;
-			}
-
-			if (NCP_IS_FLAG(server, NCP_FLAG_UTF8))
-				strcpy(user.iocharset, "utf8");
-			else
-				if (server->nls_io && server->nls_io->charset) {
-					len = strlen(server->nls_io->charset);
-					if (len > NCP_IOCSNAME_LEN)
-						len = NCP_IOCSNAME_LEN;
-					strncpy(user.iocharset,
-						server->nls_io->charset, len);
-					user.iocharset[len] = 0;
-				}
-
-			if (copy_to_user((struct ncp_nls_ioctl*)arg, &user,
-					sizeof(user)))
-				return -EFAULT;
+	case NCP_IOC_GETCHARSETS:
+		return ncp_get_charsets(server, (struct ncp_nls_ioctl *)arg);
 
-			return 0;
-		}
 #endif /* CONFIG_NCPFS_NLS */
+
 	case NCP_IOC_SETDENTRYTTL:
 		if ((permission(inode, MAY_WRITE, NULL) != 0) &&
 				 (current->uid != server->m.mounted_uid))
diff -urdN linux/fs/ncpfs/ncplib_kernel.c linux/fs/ncpfs/ncplib_kernel.c
--- linux/fs/ncpfs/ncplib_kernel.c	2004-06-09 19:24:45.000000000 +0000
+++ linux/fs/ncpfs/ncplib_kernel.c	2004-06-09 21:10:25.000000000 +0000
@@ -536,37 +536,34 @@
 }
 
 int
-ncp_mount_subdir(struct ncp_server *server, struct nw_info_struct *i,
-			__u8 volNumber, __u8 srcNS, __u32 dirEntNum)
+ncp_mount_subdir(struct ncp_server *server,
+		 __u8 volNumber, __u8 srcNS, __u32 dirEntNum,
+		 __u32* volume, __u32* newDirEnt, __u32* newDosEnt)
 {
 	int dstNS;
 	int result;
-	__u32 newDirEnt;
-	__u32 newDosEnt;
 	
 	dstNS = ncp_get_known_namespace(server, volNumber);
 	if ((result = ncp_ObtainSpecificDirBase(server, srcNS, dstNS, volNumber, 
-				      dirEntNum, NULL, &newDirEnt, &newDosEnt)) != 0)
+				      dirEntNum, NULL, newDirEnt, newDosEnt)) != 0)
 	{
 		return result;
 	}
 	server->name_space[volNumber] = dstNS;
-	i->volNumber = volNumber;
-	i->dirEntNum = newDirEnt;
-	i->DosDirNum = newDosEnt;
+	*volume = volNumber;
 	server->m.mounted_vol[1] = 0;
 	server->m.mounted_vol[0] = 'X';
 	return 0;
 }
 
 int 
-ncp_lookup_volume(struct ncp_server *server, char *volname,
-		      struct nw_info_struct *target)
+ncp_get_volume_root(struct ncp_server *server, const char *volname,
+		    __u32* volume, __u32* dirent, __u32* dosdirent)
 {
 	int result;
-	int volnum;
+	__u8 volnum;
 
-	DPRINTK("ncp_lookup_volume: looking up vol %s\n", volname);
+	DPRINTK("ncp_get_volume_root: looking up vol %s\n", volname);
 
 	ncp_init_request(server);
 	ncp_add_byte(server, 22);	/* Subfunction: Generate dir handle */
@@ -585,16 +582,31 @@
 		ncp_unlock_server(server);
 		return result;
 	}
-	memset(target, 0, sizeof(*target));
-	target->DosDirNum = target->dirEntNum = ncp_reply_dword(server, 4);
-	target->volNumber = volnum = ncp_reply_byte(server, 8);
+	*dirent = *dosdirent = ncp_reply_dword(server, 4);
+	volnum = ncp_reply_byte(server, 8);
 	ncp_unlock_server(server);
-
+	*volume = volnum;
+	
 	server->name_space[volnum] = ncp_get_known_namespace(server, volnum);
-
+	
 	DPRINTK("lookup_vol: namespace[%d] = %d\n",
 		volnum, server->name_space[volnum]);
 
+	return 0;
+}
+
+int 
+ncp_lookup_volume(struct ncp_server *server, const char *volname,
+		  struct nw_info_struct *target)
+{
+	int result;
+
+	memset(target, 0, sizeof(*target));
+	result = ncp_get_volume_root(server, volname,
+			&target->volNumber, &target->dirEntNum, &target->DosDirNum);
+	if (result) {
+		return result;
+	}
 	target->nameLen = strlen(volname);
 	memcpy(target->entryName, volname, target->nameLen+1);
 	target->attributes = aDIR;
diff -urdN linux/fs/ncpfs/ncplib_kernel.h linux/fs/ncpfs/ncplib_kernel.h
--- linux/fs/ncpfs/ncplib_kernel.h	2004-06-09 19:24:13.000000000 +0000
+++ linux/fs/ncpfs/ncplib_kernel.h	2004-06-09 21:11:11.000000000 +0000
@@ -70,7 +70,9 @@
 int ncp_obtain_info(struct ncp_server *server, struct inode *, char *,
 		struct nw_info_struct *target);
 int ncp_obtain_nfs_info(struct ncp_server *server, struct nw_info_struct *target);
-int ncp_lookup_volume(struct ncp_server *, char *, struct nw_info_struct *);
+int ncp_get_volume_root(struct ncp_server *server, const char *volname, 
+			__u32 *volume, __u32 *dirent, __u32 *dosdirent);
+int ncp_lookup_volume(struct ncp_server *, const char *, struct nw_info_struct *);
 int ncp_modify_file_or_subdir_dos_info(struct ncp_server *, struct inode *,
 	 __u32, const struct nw_modify_dos_info *info);
 int ncp_modify_file_or_subdir_dos_info_path(struct ncp_server *, struct inode *,
@@ -111,8 +113,8 @@
 #endif	/* CONFIG_NCPFS_IOCTL_LOCKING */
 
 int
-ncp_mount_subdir(struct ncp_server *, struct nw_info_struct *,
-			__u8, __u8, __u32);
+ncp_mount_subdir(struct ncp_server *, __u8, __u8, __u32,
+		 __u32* volume, __u32* dirent, __u32* dosdirent);
 int ncp_dirhandle_alloc(struct ncp_server *, __u8 vol, __u32 dirent, __u8 *dirhandle);
 int ncp_dirhandle_free(struct ncp_server *, __u8 dirhandle);
 
