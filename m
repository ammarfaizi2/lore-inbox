Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270659AbTHADw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 23:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275027AbTHADw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 23:52:29 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:8157 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S270659AbTHADwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 23:52:20 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Wakko Warner <wakko@animx.eu.org>
Date: Fri, 1 Aug 2003 13:51:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16169.58331.996181.236352@gargle.gargle.HOWL>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x NFS and NFSD
In-Reply-To: message from Wakko Warner on Wednesday July 30
References: <20030730185115.B16021@animx.eu.org>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday July 30, wakko@animx.eu.org wrote:
> Anyone had any luck with either of these?
> 

some.

> 2.6.x as a server:
> I'm using nfs-kernel-server v1.0.5-1 (debian).
> Config Ops:
> CONFIG_NFSD=m
> CONFIG_NFSD_V3=y
> # CONFIG_NFSD_V4 is not set
> CONFIG_NFSD_TCP=y
> CONFIG_LOCKD=m
> CONFIG_LOCKD_V4=y   << I didn't configure this, where'd it come
> from?

If either NFS_V3 or NFSD_V3, then LOCKD_V4 is automatically added.

> CONFIG_EXPORTFS=m
> CONFIG_SUNRPC=m
> This is in /etc/exports:
> / vegeta(rw,no_root_squash,async,nohide)

"nohide" is incorrect here.
"nohide" applies to a child filesystem and says that if some client
mounts the parent filesystem and looks at the mount point, then the
child should not be hidden (as it normally would be with NFS). As
'/' is never a child, it is meaningless to have "nohide" for it.
It should cause problems  (though it would hurt to remove it and see
if it makes a difference).

> 
> on the machine vegeta, I mount this machine (kingkai:/ /mnt), cd to /mnt, do
> ls, and ls hangs.  client uses kernel 2.4.20 with NFSv3 enabled and it was
> mounted v3.

I have a hunch what this might be, and it'll require fixing both the
kernel and nfs-utils ;-(

Could you try using
   mount -t nfsd nfsd /proc/fs/nfs

before starting the nfs-kernel-server (particularly before starting
mountd or running exportfs).

Also, if you are brave, could you try with the following two patches,
one against linux-2.6.0-test2 and one against nfs-utils.  Then run the
nfs kernel server *without* mounting /proc/fs/nfs first.

Thanks,
NeilBrown

First patch against the kernel.
========================================================================
Make sure sunrpc/cache doesn't confuse writers with readers.

When a sunrpc/cache channel is not open for reading, the
cache doesn't bother making and waiting for up-calls.

However it doesn't currently distingish between open-for-read/write
and open-for-write, so an op-for-write will look like a reader
and will cause inappropriate waiting.

This patch checks if a file is open-for-read and will only register
a file as a reader if it really is one.


 ----------- Diffstat output ------------
 ./net/sunrpc/cache.c |   69 +++++++++++++++++++++++++++------------------------
 1 files changed, 37 insertions(+), 32 deletions(-)

diff ./net/sunrpc/cache.c~current~ ./net/sunrpc/cache.c
--- ./net/sunrpc/cache.c~current~	2003-08-01 13:22:58.000000000 +1000
+++ ./net/sunrpc/cache.c	2003-08-01 13:31:58.000000000 +1000
@@ -738,19 +738,22 @@ cache_ioctl(struct inode *ino, struct fi
 static int
 cache_open(struct inode *inode, struct file *filp)
 {
-	struct cache_reader *rp;
-	struct cache_detail *cd = PDE(inode)->data;
+	struct cache_reader *rp = NULL;
 
-	rp = kmalloc(sizeof(*rp), GFP_KERNEL);
-	if (!rp)
-		return -ENOMEM;
-	rp->page = NULL;
-	rp->offset = 0;
-	rp->q.reader = 1;
-	atomic_inc(&cd->readers);
-	spin_lock(&queue_lock);
-	list_add(&rp->q.list, &cd->queue);
-	spin_unlock(&queue_lock);
+	if (filp->f_mode & FMODE_READ) {
+		struct cache_detail *cd = PDE(inode)->data;
+
+		rp = kmalloc(sizeof(*rp), GFP_KERNEL);
+		if (!rp)
+			return -ENOMEM;
+		rp->page = NULL;
+		rp->offset = 0;
+		rp->q.reader = 1;
+		atomic_inc(&cd->readers);
+		spin_lock(&queue_lock);
+		list_add(&rp->q.list, &cd->queue);
+		spin_unlock(&queue_lock);
+	}
 	filp->private_data = rp;
 	return 0;
 }
@@ -761,29 +764,31 @@ cache_release(struct inode *inode, struc
 	struct cache_reader *rp = filp->private_data;
 	struct cache_detail *cd = PDE(inode)->data;
 
-	spin_lock(&queue_lock);
-	if (rp->offset) {
-		struct cache_queue *cq;
-		for (cq= &rp->q; &cq->list != &cd->queue;
-		     cq = list_entry(cq->list.next, struct cache_queue, list))
-			if (!cq->reader) {
-				container_of(cq, struct cache_request, q)
-					->readers--;
-				break;
-			}
-		rp->offset = 0;
-	}
-	list_del(&rp->q.list);
-	spin_unlock(&queue_lock);
+	if (rp) {
+		spin_lock(&queue_lock);
+		if (rp->offset) {
+			struct cache_queue *cq;
+			for (cq= &rp->q; &cq->list != &cd->queue;
+			     cq = list_entry(cq->list.next, struct cache_queue, list))
+				if (!cq->reader) {
+					container_of(cq, struct cache_request, q)
+						->readers--;
+					break;
+				}
+			rp->offset = 0;
+		}
+		list_del(&rp->q.list);
+		spin_unlock(&queue_lock);
 
-	if (rp->page)
-		kfree(rp->page);
+		if (rp->page)
+			kfree(rp->page);
 
-	filp->private_data = NULL;
-	kfree(rp);
+		filp->private_data = NULL;
+		kfree(rp);
 
-	cd->last_close = get_seconds();
-	atomic_dec(&cd->readers);
+		cd->last_close = get_seconds();
+		atomic_dec(&cd->readers);
+	}
 	return 0;
 }
 


=======================
Second patch, against nfs-utils 1.0.5


=======================================================================
--- ./support/nfs/nfsexport.c	2003/08/01 03:47:47	1.1
+++ ./support/nfs/nfsexport.c	2003/08/01 03:48:19
@@ -93,7 +93,7 @@ nfsexport(struct nfsctl_export *exp)
 {
 	struct nfsctl_arg	arg;
 	int fd;
-	if ((fd=open("/proc/net/rpc/nfsd.fh/channel", O_RDWR))>= 0) {
+	if ((fd=open("/proc/net/rpc/nfsd.fh/channel", O_WRONLY))>= 0) {
 		close(fd);
 		return exp_unexp(exp, 1);
 	}
@@ -108,7 +108,7 @@ nfsunexport(struct nfsctl_export *exp)
 	struct nfsctl_arg	arg;
 
 	int fd;
-	if ((fd=open("/proc/net/rpc/nfsd.fh/channel", O_RDWR))>= 0) {
+	if ((fd=open("/proc/net/rpc/nfsd.fh/channel", O_WRONLY))>= 0) {
 		close(fd);
 		return exp_unexp(exp, 0);
 	}
--- ./utils/mountd/cache.c	2003/08/01 03:46:53	1.1
+++ ./utils/mountd/cache.c	2003/08/01 03:47:02
@@ -320,7 +320,7 @@ int cache_process_req(fd_set *readfds) 
 void cache_export_ent(char *domain, struct exportent *exp)
 {
 
-	FILE *f = fopen("/proc/net/rpc/nfsd.export/channel", "r+");
+	FILE *f = fopen("/proc/net/rpc/nfsd.export/channel", "w");
 	if (!f)
 		return;
 
@@ -340,7 +340,7 @@ void cache_export(nfs_export *exp)
 {
 	FILE *f;
 
-	f = fopen("/proc/net/rpc/auth.unix.ip/channel", "r+");
+	f = fopen("/proc/net/rpc/auth.unix.ip/channel", "w");
 	if (!f)
 		return;
 
@@ -367,6 +367,7 @@ cache_get_filehandle(nfs_export *exp, in
 	FILE *f = fopen("/proc/fs/nfs/filehandle", "r+");
 	char buf[200];
 	char *bp = buf;
+	char *fg;
 	static struct nfs_fh_len fh;
 	if (!f)
 		return NULL;
@@ -376,7 +377,9 @@ cache_get_filehandle(nfs_export *exp, in
 	qword_printint(f, len);	
 	qword_eol(f);
 	
-	if (fgets(buf, sizeof(buf), f) == NULL)
+	fg =fgets(buf, sizeof(buf), f);
+	fclose(f);
+	if (fg == NULL)
 		return NULL;
 	memset(fh.fh_handle, 0, sizeof(fh.fh_handle));
 	fh.fh_size = qword_get(&bp, fh.fh_handle, NFS3_FHSIZE);
