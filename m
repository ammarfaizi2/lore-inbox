Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVBFTB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVBFTB7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 14:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVBFTB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 14:01:58 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50704 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261282AbVBFSou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 13:44:50 -0500
Date: Sun, 6 Feb 2005 19:44:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/nfsd/: possible cleanups
Message-ID: <20050206184443.GV3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following possible cleanups:
- make some needlessly global code static
- #if 0 the following EXPORT_SYMBOL'ed but unused function:
  - nfs4acl.c: nfs4_acl_permission
- remove the following unused global function:
  - nfs4state.c: set_no_grace

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent om:
- 8 Jan 2005

 fs/nfsd/export.c           |   22 +++++-----
 fs/nfsd/lockd.c            |    2 
 fs/nfsd/nfs4acl.c          |    9 ++--
 fs/nfsd/nfs4callback.c     |    7 +--
 fs/nfsd/nfs4idmap.c        |   12 ++---
 fs/nfsd/nfs4state.c        |   75 ++++++++++++++++---------------------
 fs/nfsd/nfs4xdr.c          |    4 -
 fs/nfsd/nfsfh.c            |   11 ++---
 fs/nfsd/nfssvc.c           |    2 
 fs/nfsd/vfs.c              |    8 +--
 include/linux/nfs4_acl.h   |    2 
 include/linux/nfsd/state.h |    1 
 12 files changed, 75 insertions(+), 80 deletions(-)

--- linux-2.6.10-mm2-full/fs/nfsd/export.c.old	2005-01-08 16:50:29.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/nfsd/export.c	2005-01-08 16:52:01.000000000 +0100
@@ -79,9 +79,9 @@
 	}
 }
 
-void expkey_request(struct cache_detail *cd,
-		    struct cache_head *h,
-		    char **bpp, int *blen)
+static void expkey_request(struct cache_detail *cd,
+			   struct cache_head *h,
+			   char **bpp, int *blen)
 {
 	/* client fsidtype \xfsid */
 	struct svc_expkey *ek = container_of(h, struct svc_expkey, h);
@@ -95,7 +95,7 @@
 }
 
 static struct svc_expkey *svc_expkey_lookup(struct svc_expkey *, int);
-int expkey_parse(struct cache_detail *cd, char *mesg, int mlen)
+static int expkey_parse(struct cache_detail *cd, char *mesg, int mlen)
 {
 	/* client fsidtype fsid [path] */
 	char *buf;
@@ -284,9 +284,9 @@
 	}
 }
 
-void svc_export_request(struct cache_detail *cd,
-			struct cache_head *h,
-			char **bpp, int *blen)
+static void svc_export_request(struct cache_detail *cd,
+			       struct cache_head *h,
+			       char **bpp, int *blen)
 {
 	/*  client path */
 	struct svc_export *exp = container_of(h, struct svc_export, h);
@@ -345,7 +345,7 @@
 
 }
 
-int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
+static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 {
 	/* client path expiry [flags anonuid anongid fsid] */
 	char *buf;
@@ -515,8 +515,8 @@
 	return ek;
 }
 
-int exp_set_key(svc_client *clp, int fsid_type, u32 *fsidv, 
-		struct svc_export *exp)
+static int exp_set_key(svc_client *clp, int fsid_type, u32 *fsidv, 
+		       struct svc_export *exp)
 {
 	struct svc_expkey key, *ek;
 
@@ -1004,7 +1004,7 @@
 	exp_readunlock();
 }
 
-struct flags {
+static struct flags {
 	int flag;
 	char *name[2];
 } expflags[] = {
--- linux-2.6.10-mm2-full/fs/nfsd/lockd.c.old	2005-01-08 16:52:18.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/nfsd/lockd.c	2005-01-08 16:52:30.000000000 +0100
@@ -60,7 +60,7 @@
 	fput(filp);
 }
 
-struct nlmsvc_binding		nfsd_nlm_ops = {
+static struct nlmsvc_binding	nfsd_nlm_ops = {
 	.fopen		= nlm_fopen,		/* open file for locking */
 	.fclose		= nlm_fclose,		/* close file */
 };
--- linux-2.6.10-mm2-full/include/linux/nfs4_acl.h.old	2005-01-08 16:53:13.000000000 +0100
+++ linux-2.6.10-mm2-full/include/linux/nfs4_acl.h	2005-01-08 16:54:37.000000000 +0100
@@ -44,8 +44,10 @@
 int nfs4_acl_add_ace(struct nfs4_acl *, u32, u32, u32, int, uid_t);
 int nfs4_acl_get_whotype(char *, u32);
 int nfs4_acl_write_who(int who, char *p);
+#if 0
 int nfs4_acl_permission(struct nfs4_acl *acl, uid_t owner, gid_t group,
 		                        uid_t who, u32 mask);
+#endif
 
 #define NFS4_ACL_TYPE_DEFAULT	0x01
 #define NFS4_ACL_DIR		0x02
--- linux-2.6.10-mm2-full/fs/nfsd/nfs4acl.c.old	2005-01-08 16:53:33.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/nfsd/nfs4acl.c	2005-01-08 16:54:32.000000000 +0100
@@ -117,8 +117,7 @@
 static short ace2type(struct nfs4_ace *);
 static int _posix_to_nfsv4_one(struct posix_acl *, struct nfs4_acl *, unsigned int);
 static struct posix_acl *_nfsv4_to_posix_one(struct nfs4_acl *, unsigned int);
-int nfs4_acl_add_ace(struct nfs4_acl *, u32, u32, u32, int, uid_t);
-int nfs4_acl_split(struct nfs4_acl *, struct nfs4_acl *);
+static int nfs4_acl_split(struct nfs4_acl *, struct nfs4_acl *);
 
 struct nfs4_acl *
 nfs4_acl_posix_to_nfsv4(struct posix_acl *pacl, struct posix_acl *dpacl,
@@ -768,7 +767,7 @@
 	return pacl;
 }
 
-int
+static int
 nfs4_acl_split(struct nfs4_acl *acl, struct nfs4_acl *dacl)
 {
 	struct list_head *h, *n;
@@ -940,6 +939,7 @@
 	}
 }
 
+#if 0
 /* 0 = granted, -EACCES = denied; mask is an nfsv4 mask, not mode bits */
 int
 nfs4_acl_permission(struct nfs4_acl *acl, uid_t owner, gid_t group,
@@ -965,10 +965,11 @@
 	}
 	return -EACCES;
 }
+EXPORT_SYMBOL(nfs4_acl_permission);
+#endif  /*  0  */
 
 EXPORT_SYMBOL(nfs4_acl_new);
 EXPORT_SYMBOL(nfs4_acl_free);
 EXPORT_SYMBOL(nfs4_acl_add_ace);
 EXPORT_SYMBOL(nfs4_acl_get_whotype);
 EXPORT_SYMBOL(nfs4_acl_write_who);
-EXPORT_SYMBOL(nfs4_acl_permission);
--- linux-2.6.10-mm2-full/fs/nfsd/nfs4callback.c.old	2005-01-08 16:54:57.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/nfsd/nfs4callback.c	2005-01-08 17:03:54.000000000 +0100
@@ -53,7 +53,6 @@
 
 /* declarations */
 static void nfs4_cb_null(struct rpc_task *task);
-extern spinlock_t recall_lock;
 
 /* Index of predefined Linux callback client operations */
 
@@ -327,12 +326,12 @@
         .p_bufsiz = MAX(NFS4_##argtype##_sz,NFS4_##restype##_sz) << 2,  \
 }
 
-struct rpc_procinfo     nfs4_cb_procedures[] = {
+static struct rpc_procinfo	nfs4_cb_procedures[] = {
     PROC(CB_NULL,      NULL,     enc_cb_null,     dec_cb_null),
     PROC(CB_RECALL,    COMPOUND,   enc_cb_recall,      dec_cb_recall),
 };
 
-struct rpc_version              nfs_cb_version4 = {
+static struct rpc_version	nfs_cb_version4 = {
         .number                 = 1,
         .nrprocs                = sizeof(nfs4_cb_procedures)/sizeof(nfs4_cb_procedures[0]),
         .procs                  = nfs4_cb_procedures
@@ -346,7 +345,7 @@
 /*
  * Use the SETCLIENTID credential
  */
-struct rpc_cred *
+static struct rpc_cred *
 nfsd4_lookupcred(struct nfs4_client *clp, int taskflags)
 {
         struct auth_cred acred;
--- linux-2.6.10-mm2-full/fs/nfsd/nfs4idmap.c.old	2005-01-08 16:56:02.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/nfsd/nfs4idmap.c	2005-01-08 16:57:07.000000000 +0100
@@ -104,7 +104,7 @@
 	ent_init(new, itm);
 }
 
-void
+static void
 ent_put(struct cache_head *ch, struct cache_detail *cd)
 {
 	if (cache_put(ch, cd)) {
@@ -186,7 +186,7 @@
 static int         idtoname_parse(struct cache_detail *, char *, int);
 static struct ent *idtoname_lookup(struct ent *, int);
 
-struct cache_detail idtoname_cache = {
+static struct cache_detail idtoname_cache = {
 	.hash_size	= ENT_HASHMAX,
 	.hash_table	= idtoname_table,
 	.name		= "nfs4.idtoname",
@@ -277,7 +277,7 @@
 	return hash_str(ent->name, ENT_HASHBITS);
 }
 
-void
+static void
 nametoid_request(struct cache_detail *cd, struct cache_head *ch, char **bpp,
     int *blen)
 {
@@ -317,9 +317,9 @@
 }
 
 static struct ent *nametoid_lookup(struct ent *, int);
-int                nametoid_parse(struct cache_detail *, char *, int);
+static int nametoid_parse(struct cache_detail *, char *, int);
 
-struct cache_detail nametoid_cache = {
+static struct cache_detail nametoid_cache = {
 	.hash_size	= ENT_HASHMAX,
 	.hash_table	= nametoid_table,
 	.name		= "nfs4.nametoid",
@@ -330,7 +330,7 @@
 	.warn_no_listener = warn_no_idmapd,
 };
 
-int
+static int
 nametoid_parse(struct cache_detail *cd, char *buf, int buflen)
 {
 	struct ent ent, *res;
--- linux-2.6.10-mm2-full/include/linux/nfsd/state.h.old	2005-01-08 17:02:31.000000000 +0100
+++ linux-2.6.10-mm2-full/include/linux/nfsd/state.h	2005-01-08 17:02:35.000000000 +0100
@@ -279,7 +279,6 @@
 	((err) != nfserr_stale_stateid) &&      \
 	((err) != nfserr_bad_stateid))
 
-extern time_t nfs4_laundromat(void);
 extern int nfsd4_renew(clientid_t *clid);
 extern int nfs4_preprocess_stateid_op(struct svc_fh *current_fh, 
 		stateid_t *stateid, int flags);
--- linux-2.6.10-mm2-full/fs/nfsd/nfs4state.c.old	2005-01-08 16:57:21.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/nfsd/nfs4state.c	2005-01-08 17:10:54.000000000 +0100
@@ -55,7 +55,7 @@
 static time_t lease_time = 90;     /* default lease time */
 static time_t old_lease_time = 90; /* past incarnation lease time */
 static u32 nfs4_reclaim_init = 0;
-time_t boot_time;
+static time_t boot_time;
 static time_t grace_end = 0;
 static u32 current_clientid = 1;
 static u32 current_ownerid = 1;
@@ -66,22 +66,22 @@
 stateid_t onestateid;              /* bits all 1 */
 
 /* debug counters */
-u32 list_add_perfile = 0; 
-u32 list_del_perfile = 0;
-u32 add_perclient = 0;
-u32 del_perclient = 0;
-u32 alloc_file = 0;
-u32 free_file = 0;
-u32 alloc_sowner = 0;
-u32 free_sowner = 0;
-u32 vfsopen = 0;
-u32 vfsclose = 0;
-u32 alloc_lsowner= 0;
-u32 alloc_delegation= 0;
-u32 free_delegation= 0;
+static u32 list_add_perfile = 0; 
+static u32 list_del_perfile = 0;
+static u32 add_perclient = 0;
+static u32 del_perclient = 0;
+static u32 alloc_file = 0;
+static u32 free_file = 0;
+static u32 alloc_sowner = 0;
+static u32 free_sowner = 0;
+static u32 vfsopen = 0;
+static u32 vfsclose = 0;
+static u32 alloc_lsowner= 0;
+static u32 alloc_delegation= 0;
+static u32 free_delegation= 0;
 
 /* forward declarations */
-struct nfs4_stateid * find_stateid(stateid_t *stid, int flags);
+static struct nfs4_stateid * find_stateid(stateid_t *stid, int flags);
 static struct nfs4_delegation * find_delegation_stateid(struct inode *ino, stateid_t *stid);
 static void release_delegation(struct nfs4_delegation *dp);
 static void release_stateid_lockowner(struct nfs4_stateid *open_stp);
@@ -129,7 +129,7 @@
  */
 
 /* recall_lock protects the del_recall_lru */
-spinlock_t recall_lock;
+static spinlock_t recall_lock;
 static struct list_head del_recall_lru;
 
 static struct nfs4_delegation *
@@ -461,7 +461,7 @@
 	return 1;
 }
 
-void
+static void
 add_to_unconfirmed(struct nfs4_client *clp, unsigned int strhashval)
 {
 	unsigned int idhashval;
@@ -473,7 +473,7 @@
 	clp->cl_time = get_seconds();
 }
 
-void
+static void
 move_to_confirmed(struct nfs4_client *clp, unsigned int idhashval)
 {
 	unsigned int strhashval;
@@ -523,7 +523,7 @@
 }
 
 /* parse and set the setclientid ipv4 callback address */
-int
+static int
 parse_ipv4(unsigned int addr_len, char *addr_val, unsigned int *cbaddrp, unsigned short *cbportp)
 {
 	int temp = 0;
@@ -559,7 +559,7 @@
 	return 1;
 }
 
-void
+static void
 gen_callback(struct nfs4_client *clp, struct nfsd4_setclientid *se)
 {
 	struct nfs4_callback *cb = &clp->cl_callback;
@@ -1156,7 +1156,7 @@
 	kfree(fp);
 }	
 
-void
+static void
 move_to_close_lru(struct nfs4_stateowner *sop)
 {
 	dprintk("NFSD: move_to_close_lru nfs4_stateowner %p\n", sop);
@@ -1166,7 +1166,7 @@
 	sop->so_time = get_seconds();
 }
 
-void
+static void
 release_state_owner(struct nfs4_stateid *stp, struct nfs4_stateowner **sopp,
 		int flag)
 {
@@ -1243,7 +1243,7 @@
 #define TEST_ACCESS(x) ((x > 0 || x < 4)?1:0)
 #define TEST_DENY(x) ((x >= 0 || x < 5)?1:0)
 
-void
+static void
 set_access(unsigned int *access, unsigned long bmap) {
 	int i;
 
@@ -1254,7 +1254,7 @@
 	}
 }
 
-void
+static void
 set_deny(unsigned int *deny, unsigned long bmap) {
 	int i;
 
@@ -1399,7 +1399,7 @@
 	dp->dl_flock = new;
 }
 
-struct lock_manager_operations nfsd_lease_mng_ops = {
+static struct lock_manager_operations nfsd_lease_mng_ops = {
         .fl_break = nfsd_break_deleg_cb,
         .fl_release_private = nfsd_release_deleg_cb,
         .fl_copy_lock = nfsd_copy_lock_deleg_cb,
@@ -1838,7 +1838,7 @@
 	return status;
 }
 
-time_t
+static time_t
 nfs4_laundromat(void)
 {
 	struct nfs4_client *clp;
@@ -1914,7 +1914,7 @@
 /* search ownerid_hashtbl[] and close_lru for stateid owner
  * (stateid->si_stateownerid)
  */
-struct nfs4_stateowner *
+static struct nfs4_stateowner *
 find_openstateowner_id(u32 st_id, int flags) {
 	struct nfs4_stateowner *local = NULL;
 
@@ -2060,7 +2060,7 @@
 /* 
  * Checks for sequence id mutating operations. 
  */
-int
+static int
 nfs4_preprocess_seqid_op(struct svc_fh *current_fh, u32 seqid, stateid_t *stateid, int flags, struct nfs4_stateowner **sopp, struct nfs4_stateid **stpp, clientid_t *lockclid)
 {
 	int status;
@@ -2192,7 +2192,7 @@
  * eventually, this will perform an upcall to the 'state daemon' as well as
  * set the cl_first_state field.
  */
-void
+static void
 first_state(struct nfs4_client *clp)
 {
 	if (!clp->cl_first_state)
@@ -2383,7 +2383,7 @@
 static struct list_head	lock_ownerstr_hashtbl[LOCK_HASH_SIZE];
 static struct list_head lockstateid_hashtbl[STATEID_HASH_SIZE];
 
-struct nfs4_stateid *
+static struct nfs4_stateid *
 find_stateid(stateid_t *stid, int flags)
 {
 	struct nfs4_stateid *local = NULL;
@@ -2456,7 +2456,7 @@
 		lock->fl_end = OFFSET_MAX;
 }
 
-int
+static int
 nfs4_verify_lock_stateowner(struct nfs4_stateowner *sop, unsigned int hashval)
 {
 	struct nfs4_stateowner *local = NULL;
@@ -2569,7 +2569,7 @@
 	return sop;
 }
 
-struct nfs4_stateid *
+static struct nfs4_stateid *
 alloc_init_lock_stateid(struct nfs4_stateowner *sop, struct nfs4_file *fp, struct nfs4_stateid *open_stp)
 {
 	struct nfs4_stateid *stp;
@@ -2601,7 +2601,7 @@
 	return stp;
 }
 
-int
+static int
 check_lock_length(u64 offset, u64 length)
 {
 	return ((length == 0)  || ((length != ~(u64)0) &&
@@ -3079,7 +3079,7 @@
 
 /*
  * called from OPEN, CLAIM_PREVIOUS with a new clientid. */
-struct nfs4_client_reclaim *
+static struct nfs4_client_reclaim *
 nfs4_find_reclaim_client(clientid_t *clid)
 {
 	unsigned int idhashval = clientid_hashval(clid->cl_id);
@@ -3189,13 +3189,6 @@
 	return get_seconds() < grace_end;
 }
 
-void
-set_no_grace(void)
-{
-	printk("NFSD: ERROR in reboot recovery.  State reclaims will fail.\n");
-	grace_end = get_seconds();
-}
-
 time_t
 nfs4_lease_time(void)
 {
--- linux-2.6.10-mm2-full/fs/nfsd/nfs4xdr.c.old	2005-01-08 17:06:41.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/nfsd/nfs4xdr.c	2005-01-08 17:07:27.000000000 +0100
@@ -251,7 +251,7 @@
 	}					\
 } while (0)
 
-u32 *read_buf(struct nfsd4_compoundargs *argp, int nbytes)
+static u32 *read_buf(struct nfsd4_compoundargs *argp, int nbytes)
 {
 	/* We want more bytes than seem to be available.
 	 * Maybe we need a new page, maybe we have just run out
@@ -305,7 +305,7 @@
 	return 0;
 }
 
-char *savemem(struct nfsd4_compoundargs *argp, u32 *p, int nbytes)
+static char *savemem(struct nfsd4_compoundargs *argp, u32 *p, int nbytes)
 {
 	void *new = NULL;
 	if (p == argp->tmp) {
--- linux-2.6.10-mm2-full/fs/nfsd/nfsfh.c.old	2005-01-08 17:07:44.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/nfsd/nfsfh.c	2005-01-08 17:08:25.000000000 +0100
@@ -41,7 +41,7 @@
  * if not, require that we can walk up to exp->ex_dentry
  * doing some checks on the 'x' bits
  */
-int nfsd_acceptable(void *expv, struct dentry *dentry)
+static int nfsd_acceptable(void *expv, struct dentry *dentry)
 {
 	struct svc_export *exp = expv;
 	int rv;
@@ -280,8 +280,8 @@
  * an inode.  In this case a call to fh_update should be made
  * before the fh goes out on the wire ...
  */
-inline int _fh_update(struct dentry *dentry, struct svc_export *exp,
-		      __u32 *datap, int *maxsize)
+static inline int _fh_update(struct dentry *dentry, struct svc_export *exp,
+			     __u32 *datap, int *maxsize)
 {
 	struct export_operations *nop = exp->ex_mnt->mnt_sb->s_export_op;
 	
@@ -297,8 +297,9 @@
 /*
  * for composing old style file handles
  */
-inline void _fh_update_old(struct dentry *dentry, struct svc_export *exp,
-			   struct knfsd_fh *fh)
+static inline void _fh_update_old(struct dentry *dentry,
+				  struct svc_export *exp,
+				  struct knfsd_fh *fh)
 {
 	fh->ofh_ino = ino_t_to_u32(dentry->d_inode->i_ino);
 	fh->ofh_generation = dentry->d_inode->i_generation;
--- linux-2.6.10-mm2-full/fs/nfsd/nfssvc.c.old	2005-01-08 17:08:55.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/nfsd/nfssvc.c	2005-01-08 17:09:07.000000000 +0100
@@ -60,7 +60,7 @@
 	struct list_head 	list;
 	struct task_struct	*task;
 };
-struct list_head nfsd_list = LIST_HEAD_INIT(nfsd_list);
+static struct list_head nfsd_list = LIST_HEAD_INIT(nfsd_list);
 
 /*
  * Maximum number of nfsd processes
--- linux-2.6.10-mm2-full/fs/nfsd/vfs.c.old	2005-01-08 17:09:19.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/nfsd/vfs.c	2005-01-08 17:09:58.000000000 +0100
@@ -704,8 +704,8 @@
  * As this calls fsync (not fdatasync) there is no need for a write_inode
  * after it.
  */
-inline void nfsd_dosync(struct file *filp, struct dentry *dp, 
-			struct file_operations *fop)
+static inline void nfsd_dosync(struct file *filp, struct dentry *dp, 
+			       struct file_operations *fop)
 {
 	struct inode *inode = dp->d_inode;
 	int (*fsync) (struct file *, struct dentry *, int);
@@ -717,7 +717,7 @@
 }
 	
 
-void
+static void
 nfsd_sync(struct file *filp)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
@@ -727,7 +727,7 @@
 	up(&inode->i_sem);
 }
 
-void
+static void
 nfsd_sync_dir(struct dentry *dp)
 {
 	nfsd_dosync(NULL, dp, dp->d_inode->i_fop);

