Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVDWAKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVDWAKn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 20:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVDWAKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 20:10:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25873 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261369AbVDWAIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 20:08:00 -0400
Date: Sat, 23 Apr 2005 02:07:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: neilb@cse.unsw.edu.au
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/nfsd/: possible cleanups
Message-ID: <20050423000755.GN4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- remove the following unused global function:
  - nfs4state.c: set_no_grace

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/nfsd/nfs4acl.c          |    4 +-
 fs/nfsd/nfs4callback.c     |    7 +--
 fs/nfsd/nfs4idmap.c        |   12 +++---
 fs/nfsd/nfs4state.c        |   65 +++++++++++++++++--------------------
 fs/nfsd/nfs4xdr.c          |    4 +-
 include/linux/nfsd/state.h |    8 ----
 6 files changed, 44 insertions(+), 56 deletions(-)

--- linux-2.6.12-rc2-mm3-full/fs/nfsd/nfs4acl.c.old	2005-04-20 23:57:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/nfsd/nfs4acl.c	2005-04-20 23:58:07.000000000 +0200
@@ -125,7 +125,7 @@
 static int _posix_to_nfsv4_one(struct posix_acl *, struct nfs4_acl *, unsigned int);
 static struct posix_acl *_nfsv4_to_posix_one(struct nfs4_acl *, unsigned int);
 int nfs4_acl_add_ace(struct nfs4_acl *, u32, u32, u32, int, uid_t);
-int nfs4_acl_split(struct nfs4_acl *, struct nfs4_acl *);
+static int nfs4_acl_split(struct nfs4_acl *, struct nfs4_acl *);
 
 struct nfs4_acl *
 nfs4_acl_posix_to_nfsv4(struct posix_acl *pacl, struct posix_acl *dpacl,
@@ -775,7 +775,7 @@
 	return pacl;
 }
 
-int
+static int
 nfs4_acl_split(struct nfs4_acl *acl, struct nfs4_acl *dacl)
 {
 	struct list_head *h, *n;
--- linux-2.6.12-rc2-mm3-full/fs/nfsd/nfs4callback.c.old	2005-04-20 23:58:22.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/nfsd/nfs4callback.c	2005-04-21 00:06:23.000000000 +0200
@@ -54,7 +54,6 @@
 
 /* declarations */
 static void nfs4_cb_null(struct rpc_task *task);
-extern spinlock_t recall_lock;
 
 /* Index of predefined Linux callback client operations */
 
@@ -329,12 +328,12 @@
         .p_bufsiz = MAX(NFS4_##argtype##_sz,NFS4_##restype##_sz) << 2,  \
 }
 
-struct rpc_procinfo     nfs4_cb_procedures[] = {
+static struct rpc_procinfo     nfs4_cb_procedures[] = {
     PROC(CB_NULL,      NULL,     enc_cb_null,     dec_cb_null),
     PROC(CB_RECALL,    COMPOUND,   enc_cb_recall,      dec_cb_recall),
 };
 
-struct rpc_version              nfs_cb_version4 = {
+static struct rpc_version       nfs_cb_version4 = {
         .number                 = 1,
         .nrprocs                = sizeof(nfs4_cb_procedures)/sizeof(nfs4_cb_procedures[0]),
         .procs                  = nfs4_cb_procedures
@@ -348,7 +347,7 @@
 /*
  * Use the SETCLIENTID credential
  */
-struct rpc_cred *
+static struct rpc_cred *
 nfsd4_lookupcred(struct nfs4_client *clp, int taskflags)
 {
         struct auth_cred acred;
--- linux-2.6.12-rc2-mm3-full/fs/nfsd/nfs4idmap.c.old	2005-04-20 23:59:38.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/nfsd/nfs4idmap.c	2005-04-21 00:00:46.000000000 +0200
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
+static int         nametoid_parse(struct cache_detail *, char *, int);
 
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
--- linux-2.6.12-rc2-mm3-full/include/linux/nfsd/state.h.old	2005-04-21 00:04:52.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/include/linux/nfsd/state.h	2005-04-21 00:10:17.000000000 +0200
@@ -61,11 +61,6 @@
 #define si_stateownerid   si_opaque.so_stateownerid
 #define si_fileid         si_opaque.so_fileid
 
-extern stateid_t zerostateid;
-extern stateid_t onestateid;
-
-#define ZERO_STATEID(stateid)       (!memcmp((stateid), &zerostateid, sizeof(stateid_t)))
-#define ONE_STATEID(stateid)        (!memcmp((stateid), &onestateid, sizeof(stateid_t)))
 
 struct nfs4_cb_recall {
 	u32			cbr_ident;
@@ -268,12 +263,9 @@
 	((err) != nfserr_stale_stateid) &&      \
 	((err) != nfserr_bad_stateid))
 
-extern time_t nfs4_laundromat(void);
 extern int nfsd4_renew(clientid_t *clid);
 extern int nfs4_preprocess_stateid_op(struct svc_fh *current_fh, 
 		stateid_t *stateid, int flags, struct file **filp);
-extern int nfs4_share_conflict(struct svc_fh *current_fh, 
-		unsigned int deny_type);
 extern void nfs4_lock_state(void);
 extern void nfs4_unlock_state(void);
 extern int nfs4_in_grace(void);
--- linux-2.6.12-rc2-mm3-full/fs/nfsd/nfs4state.c.old	2005-04-21 00:02:27.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/nfsd/nfs4state.c	2005-04-21 00:21:45.000000000 +0200
@@ -55,18 +55,22 @@
 static time_t lease_time = 90;     /* default lease time */
 static time_t old_lease_time = 90; /* past incarnation lease time */
 static u32 nfs4_reclaim_init = 0;
-time_t boot_time;
+static time_t boot_time;
 static time_t grace_end = 0;
 static u32 current_clientid = 1;
 static u32 current_ownerid = 1;
 static u32 current_fileid = 1;
 static u32 current_delegid = 1;
 static u32 nfs4_init;
-stateid_t zerostateid;             /* bits all 0 */
-stateid_t onestateid;              /* bits all 1 */
+static stateid_t zerostateid;             /* bits all 0 */
+static stateid_t onestateid;              /* bits all 1 */
+
+#define ZERO_STATEID(stateid)       (!memcmp((stateid), &zerostateid, sizeof(stateid_t)))
+#define ONE_STATEID(stateid)        (!memcmp((stateid), &onestateid, sizeof(stateid_t)))
+
 
 /* forward declarations */
-struct nfs4_stateid * find_stateid(stateid_t *stid, int flags);
+static struct nfs4_stateid * find_stateid(stateid_t *stid, int flags);
 static struct nfs4_delegation * find_delegation_stateid(struct inode *ino, stateid_t *stid);
 static void release_stateid_lockowners(struct nfs4_stateid *open_stp);
 
@@ -78,10 +82,10 @@
  */
 static DECLARE_MUTEX(client_sema);
 
-kmem_cache_t *stateowner_slab = NULL;
-kmem_cache_t *file_slab = NULL;
-kmem_cache_t *stateid_slab = NULL;
-kmem_cache_t *deleg_slab = NULL;
+static kmem_cache_t *stateowner_slab = NULL;
+static kmem_cache_t *file_slab = NULL;
+static kmem_cache_t *stateid_slab = NULL;
+static kmem_cache_t *deleg_slab = NULL;
 
 void
 nfs4_lock_state(void)
@@ -117,7 +121,7 @@
  */
 
 /* recall_lock protects the del_recall_lru */
-spinlock_t recall_lock;
+static spinlock_t recall_lock;
 static struct list_head del_recall_lru;
 
 static void
@@ -458,7 +462,7 @@
 	return 1;
 }
 
-void
+static void
 add_to_unconfirmed(struct nfs4_client *clp, unsigned int strhashval)
 {
 	unsigned int idhashval;
@@ -470,7 +474,7 @@
 	clp->cl_time = get_seconds();
 }
 
-void
+static void
 move_to_confirmed(struct nfs4_client *clp)
 {
 	unsigned int idhashval = clientid_hashval(clp->cl_clientid.cl_id);
@@ -546,7 +550,7 @@
 }
 
 /* parse and set the setclientid ipv4 callback address */
-int
+static int
 parse_ipv4(unsigned int addr_len, char *addr_val, unsigned int *cbaddrp, unsigned short *cbportp)
 {
 	int temp = 0;
@@ -582,7 +586,7 @@
 	return 1;
 }
 
-void
+static void
 gen_callback(struct nfs4_client *clp, struct nfsd4_setclientid *se)
 {
 	struct nfs4_callback *cb = &clp->cl_callback;
@@ -1177,7 +1181,7 @@
 	stp = NULL;
 }
 
-void
+static void
 move_to_close_lru(struct nfs4_stateowner *sop)
 {
 	dprintk("NFSD: move_to_close_lru nfs4_stateowner %p\n", sop);
@@ -1187,7 +1191,7 @@
 	sop->so_time = get_seconds();
 }
 
-void
+static void
 release_state_owner(struct nfs4_stateid *stp, int flag)
 {
 	struct nfs4_stateowner *sop = stp->st_stateowner;
@@ -1241,7 +1245,7 @@
 #define TEST_ACCESS(x) ((x > 0 || x < 4)?1:0)
 #define TEST_DENY(x) ((x >= 0 || x < 5)?1:0)
 
-void
+static void
 set_access(unsigned int *access, unsigned long bmap) {
 	int i;
 
@@ -1252,7 +1256,7 @@
 	}
 }
 
-void
+static void
 set_deny(unsigned int *deny, unsigned long bmap) {
 	int i;
 
@@ -1278,7 +1282,7 @@
  * Called to check deny when READ with all zero stateid or
  * WRITE with all zero or all one stateid
  */
-int
+static int
 nfs4_share_conflict(struct svc_fh *current_fh, unsigned int deny_type)
 {
 	struct inode *ino = current_fh->fh_dentry->d_inode;
@@ -1433,7 +1437,7 @@
 		return -EAGAIN;
 }
 
-struct lock_manager_operations nfsd_lease_mng_ops = {
+static struct lock_manager_operations nfsd_lease_mng_ops = {
 	.fl_break = nfsd_break_deleg_cb,
 	.fl_release_private = nfsd_release_deleg_cb,
 	.fl_copy_lock = nfsd_copy_lock_deleg_cb,
@@ -1878,7 +1882,7 @@
 	return status;
 }
 
-time_t
+static time_t
 nfs4_laundromat(void)
 {
 	struct nfs4_client *clp;
@@ -1957,7 +1961,7 @@
 /* search ownerid_hashtbl[] and close_lru for stateid owner
  * (stateid->si_stateownerid)
  */
-struct nfs4_stateowner *
+static struct nfs4_stateowner *
 find_openstateowner_id(u32 st_id, int flags) {
 	struct nfs4_stateowner *local = NULL;
 
@@ -2131,7 +2135,7 @@
 /* 
  * Checks for sequence id mutating operations. 
  */
-int
+static int
 nfs4_preprocess_seqid_op(struct svc_fh *current_fh, u32 seqid, stateid_t *stateid, int flags, struct nfs4_stateowner **sopp, struct nfs4_stateid **stpp, clientid_t *lockclid)
 {
 	int status;
@@ -2447,7 +2451,7 @@
 static struct list_head	lock_ownerstr_hashtbl[LOCK_HASH_SIZE];
 static struct list_head lockstateid_hashtbl[STATEID_HASH_SIZE];
 
-struct nfs4_stateid *
+static struct nfs4_stateid *
 find_stateid(stateid_t *stid, int flags)
 {
 	struct nfs4_stateid *local = NULL;
@@ -2511,7 +2515,7 @@
 		lock->fl_end = OFFSET_MAX;
 }
 
-int
+static int
 nfs4_verify_lock_stateowner(struct nfs4_stateowner *sop, unsigned int hashval)
 {
 	struct nfs4_stateowner *local = NULL;
@@ -2621,7 +2625,7 @@
 	return sop;
 }
 
-struct nfs4_stateid *
+static struct nfs4_stateid *
 alloc_init_lock_stateid(struct nfs4_stateowner *sop, struct nfs4_file *fp, struct nfs4_stateid *open_stp)
 {
 	struct nfs4_stateid *stp;
@@ -2652,7 +2656,7 @@
 	return stp;
 }
 
-int
+static int
 check_lock_length(u64 offset, u64 length)
 {
 	return ((length == 0)  || ((length != ~(u64)0) &&
@@ -3123,7 +3127,7 @@
 
 /*
  * called from OPEN, CLAIM_PREVIOUS with a new clientid. */
-struct nfs4_client_reclaim *
+static struct nfs4_client_reclaim *
 nfs4_find_reclaim_client(clientid_t *clid)
 {
 	unsigned int strhashval;
@@ -3239,13 +3243,6 @@
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
--- linux-2.6.12-rc2-mm3-full/fs/nfsd/nfs4xdr.c.old	2005-04-21 00:07:53.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/nfsd/nfs4xdr.c	2005-04-21 00:08:45.000000000 +0200
@@ -136,7 +136,7 @@
 	}					\
 } while (0)
 
-u32 *read_buf(struct nfsd4_compoundargs *argp, int nbytes)
+static u32 *read_buf(struct nfsd4_compoundargs *argp, int nbytes)
 {
 	/* We want more bytes than seem to be available.
 	 * Maybe we need a new page, maybe we have just run out
@@ -190,7 +190,7 @@
 	return 0;
 }
 
-char *savemem(struct nfsd4_compoundargs *argp, u32 *p, int nbytes)
+static char *savemem(struct nfsd4_compoundargs *argp, u32 *p, int nbytes)
 {
 	void *new = NULL;
 	if (p == argp->tmp) {

