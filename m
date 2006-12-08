Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164347AbWLHBOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164347AbWLHBOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164346AbWLHBOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:14:34 -0500
Received: from ns2.suse.de ([195.135.220.15]:47253 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164322AbWLHBON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:14:13 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:14:25 +1100
Message-Id: <1061208011425.30701@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 012 of 18] knfsd: nfsd4: don't inline nfsd4 compound op functions
References: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

The inlining contributes to bloating the stack of nfsd4_compound, and
I want to change the compound op functions to function pointers anyway.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4proc.c |   43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff .prev/fs/nfsd/nfs4proc.c ./fs/nfsd/nfs4proc.c
--- .prev/fs/nfsd/nfs4proc.c	2006-12-08 12:09:27.000000000 +1100
+++ ./fs/nfsd/nfs4proc.c	2006-12-08 12:09:29.000000000 +1100
@@ -33,13 +33,6 @@
  *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * Note: some routines in this file are just trivial wrappers
- * (e.g. nfsd4_lookup()) defined solely for the sake of consistent
- * naming.  Since all such routines have been declared "inline",
- * there shouldn't be any associated overhead.  At some point in
- * the future, I might inline these "by hand" to clean up a
- * little.
  */
 
 #include <linux/param.h>
@@ -161,7 +154,7 @@ do_open_fhandle(struct svc_rqst *rqstp, 
 }
 
 
-static inline __be32
+static __be32
 nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	   struct nfsd4_open *open)
 {
@@ -264,7 +257,7 @@ out:
 /*
  * filehandle-manipulating ops.
  */
-static inline __be32
+static __be32
 nfsd4_getfh(struct nfsd4_compound_state *cstate, struct svc_fh **getfh)
 {
 	if (!cstate->current_fh.fh_dentry)
@@ -274,7 +267,7 @@ nfsd4_getfh(struct nfsd4_compound_state 
 	return nfs_ok;
 }
 
-static inline __be32
+static __be32
 nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	    struct nfsd4_putfh *putfh)
 {
@@ -285,7 +278,7 @@ nfsd4_putfh(struct svc_rqst *rqstp, stru
 	return fh_verify(rqstp, &cstate->current_fh, 0, MAY_NOP);
 }
 
-static inline __be32
+static __be32
 nfsd4_putrootfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate)
 {
 	__be32 status;
@@ -296,7 +289,7 @@ nfsd4_putrootfh(struct svc_rqst *rqstp, 
 	return status;
 }
 
-static inline __be32
+static __be32
 nfsd4_restorefh(struct nfsd4_compound_state *cstate)
 {
 	if (!cstate->save_fh.fh_dentry)
@@ -306,7 +299,7 @@ nfsd4_restorefh(struct nfsd4_compound_st
 	return nfs_ok;
 }
 
-static inline __be32
+static __be32
 nfsd4_savefh(struct nfsd4_compound_state *cstate)
 {
 	if (!cstate->current_fh.fh_dentry)
@@ -319,7 +312,7 @@ nfsd4_savefh(struct nfsd4_compound_state
 /*
  * misc nfsv4 ops
  */
-static inline __be32
+static __be32
 nfsd4_access(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     struct nfsd4_access *access)
 {
@@ -331,7 +324,7 @@ nfsd4_access(struct svc_rqst *rqstp, str
 			   &access->ac_supported);
 }
 
-static inline __be32
+static __be32
 nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     struct nfsd4_commit *commit)
 {
@@ -434,7 +427,7 @@ nfsd4_create(struct svc_rqst *rqstp, str
 	return status;
 }
 
-static inline __be32
+static __be32
 nfsd4_getattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	      struct nfsd4_getattr *getattr)
 {
@@ -454,7 +447,7 @@ nfsd4_getattr(struct svc_rqst *rqstp, st
 	return nfs_ok;
 }
 
-static inline __be32
+static __be32
 nfsd4_link(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	   struct nfsd4_link *link)
 {
@@ -488,7 +481,7 @@ nfsd4_lookupp(struct svc_rqst *rqstp, st
 			   "..", 2, &cstate->current_fh);
 }
 
-static inline __be32
+static __be32
 nfsd4_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     struct nfsd4_lookup *lookup)
 {
@@ -497,7 +490,7 @@ nfsd4_lookup(struct svc_rqst *rqstp, str
 			   &cstate->current_fh);
 }
 
-static inline __be32
+static __be32
 nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	   struct nfsd4_read *read)
 {
@@ -527,7 +520,7 @@ out:
 	return status;
 }
 
-static inline __be32
+static __be32
 nfsd4_readdir(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	      struct nfsd4_readdir *readdir)
 {
@@ -551,7 +544,7 @@ nfsd4_readdir(struct svc_rqst *rqstp, st
 	return nfs_ok;
 }
 
-static inline __be32
+static __be32
 nfsd4_readlink(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	       struct nfsd4_readlink *readlink)
 {
@@ -560,7 +553,7 @@ nfsd4_readlink(struct svc_rqst *rqstp, s
 	return nfs_ok;
 }
 
-static inline __be32
+static __be32
 nfsd4_remove(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     struct nfsd4_remove *remove)
 {
@@ -579,7 +572,7 @@ nfsd4_remove(struct svc_rqst *rqstp, str
 	return status;
 }
 
-static inline __be32
+static __be32
 nfsd4_rename(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     struct nfsd4_rename *rename)
 {
@@ -612,7 +605,7 @@ nfsd4_rename(struct svc_rqst *rqstp, str
 	return status;
 }
 
-static inline __be32
+static __be32
 nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	      struct nfsd4_setattr *setattr)
 {
@@ -639,7 +632,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, st
 	return status;
 }
 
-static inline __be32
+static __be32
 nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	    struct nfsd4_write *write)
 {
