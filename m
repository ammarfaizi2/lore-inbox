Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSFNVb5>; Fri, 14 Jun 2002 17:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSFNVb4>; Fri, 14 Jun 2002 17:31:56 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:53966 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S314459AbSFNVby>; Fri, 14 Jun 2002 17:31:54 -0400
Message-ID: <3D0A5E64.3020705@drugphish.ch>
Date: Fri, 14 Jun 2002 23:21:40 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: NFS (vfs-related) syscall logging
Content-Type: multipart/mixed;
 boundary="------------090806070602000605010000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090806070602000605010000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm trying to find a good way to log NFS syscalls related to direct file 
handling, such as for example nfsd_create_v3() or nfsd_unlink(). I've 
written up a patch (Al Viro, please close both your eyes) which is 
appended but somehow I don't know if this is the best way of doing it. I 
will extend it and add yet another proc-fs variable in /proc/sys/sunrpc/ 
which will represent a bitmask to selectively enable/disable which 
syscalls should be logged. Could someone please comment on following 
questions/ideas:

Wouldn't it be better to have such a logging facility on the VFS layer 
for all callback functions in general?

Could I maybe combine my effort with the LSM approach done for 
additional security hooks as seen in functions like 
security_ops->inode_ops->put_your_favourite syscall()?

Did I miss some part in the NFS code where this is already done but not 
enabled or has someone else already done something better and more 
efficient?

Either I was smoking too much pot or I've really sometimes seen 
nfs_create() followed by a nfs_create_v3(). Is this possible?

Sidenote: I've seen that in smbfs:smb_build_path() the pathname is built 
up with a helper function reverse_string(). As you can see I've made a 
recursive function which I think is easier to read and also faster and 
has smaller cache footprint. Is there a common makro somewhere defined 
on how to get the pathname as a string or is everyone writing up their 
own implementation of it? I'm talking about the

while(!IS_ROOT(dentry)) dentry=dentry->d_parent;

approach. It would be nice to have this a makro or a function. Maybe 
noone really needs it?

Please be kind with me because normally I don't fiddle around with (v)fs 
parts in the kernel ;)

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

--------------090806070602000605010000
Content-Type: text/plain;
 name="nfslog-2.4.19p10-3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nfslog-2.4.19p10-3.diff"

--- /usr/src/linux/fs/nfsd/vfs.c	Wed May  8 14:25:38 2002
+++ vfs.c	Fri Jun 14 15:24:05 2002
@@ -77,6 +77,15 @@
 static struct raparms *		raparml;
 static struct raparms *		raparm_cache;
 
+static void print_dirname(struct dentry *getdentry) {
+	if ((getdentry != NULL) && !IS_ROOT(getdentry)){
+		print_dirname(getdentry->d_parent);
+	}
+	if (!IS_ROOT(getdentry)) {
+		printk("/%s", getdentry->d_name.name);
+	}
+}
+
 /*
  * Look up one component of a pathname.
  * N.B. After this call _both_ fhp and resfh need an fh_put
@@ -490,6 +499,13 @@
 			 */
 			atomic_dec(&filp->f_count);
 		}
+		printk(KERN_INFO "NFSLOG UID=%d GID=%d FILE=",
+			rqstp->rq_cred.cr_uid,
+			rqstp->rq_cred.cr_gid);
+		print_dirname(dentry);
+		printk(" OP=%s IP=%d.%d.%d.%d\n",
+			__FUNCTION__,
+			NIPQUAD(rqstp->rq_addr.sin_addr.s_addr));
 	}
 out_nfserr:
 	if (err)
@@ -648,6 +664,14 @@
 		err = 0;
 	} else 
 		err = nfserrno(err);
+
+	printk(KERN_INFO "NFSLOG UID=%d GID=%d FILE=",
+		rqstp->rq_cred.cr_uid,
+		rqstp->rq_cred.cr_gid);
+	print_dirname(fhp->fh_dentry);
+	printk(" OP=%s IP=%d.%d.%d.%d\n",
+		__FUNCTION__,
+		NIPQUAD(rqstp->rq_addr.sin_addr.s_addr));
 out_close:
 	nfsd_close(&file);
 out:
@@ -769,6 +793,14 @@
 		err = 0;
 	else 
 		err = nfserrno(err);
+
+	printk(KERN_INFO "NFSLOG UID=%d GID=%d FILE=",
+		rqstp->rq_cred.cr_uid,
+		rqstp->rq_cred.cr_gid);
+	print_dirname(fhp->fh_dentry);
+	printk(" OP=%s IP=%d.%d.%d.%d\n",
+		__FUNCTION__,
+		NIPQUAD(rqstp->rq_addr.sin_addr.s_addr));
 out_close:
 	nfsd_close(&file);
 out:
@@ -925,6 +957,14 @@
 	 */
 	if (!err)
 		err = fh_update(resfhp);
+		printk(KERN_INFO "NFSLOG UID=%d GID=%d FILE=",
+			rqstp->rq_cred.cr_uid,
+			rqstp->rq_cred.cr_gid);
+		print_dirname(dentry);
+		printk("/%s", fname);
+		printk(KERN_INFO " OP=%s IP=%d.%d.%d.%d\n",
+			__FUNCTION__,
+			NIPQUAD(rqstp->rq_addr.sin_addr.s_addr));
 out:
 	return err;
 
@@ -1036,6 +1076,15 @@
 	if (err)
 		goto out;
 
+	printk(KERN_INFO "NFSLOG UID=%d GID=%d FILE=",
+		rqstp->rq_cred.cr_uid,
+		rqstp->rq_cred.cr_gid);
+	print_dirname(dentry);
+	printk("/%s", fname);
+	printk(" OP=%s IP=%d.%d.%d.%d\n",
+		__FUNCTION__,
+		NIPQUAD(rqstp->rq_addr.sin_addr.s_addr));
+
 	if (createmode == NFS3_CREATE_EXCLUSIVE) {
 		/* Cram the verifier into atime/mtime/mode */
 		iap->ia_valid = ATTR_MTIME|ATTR_ATIME
@@ -1103,6 +1152,13 @@
 		goto out_nfserr;
 	*lenp = err;
 	err = 0;
+	printk(KERN_INFO "NFSLOG UID=%d GID=%d FILE=",
+		rqstp->rq_cred.cr_uid,
+		rqstp->rq_cred.cr_gid);
+	print_dirname(dentry);
+	printk(" OP=%s IP=%d.%d.%d.%d\n",
+		__FUNCTION__,
+		NIPQUAD(rqstp->rq_addr.sin_addr.s_addr));
 out:
 	return err;
 
@@ -1163,6 +1219,13 @@
 
 	/* Compose the fh so the dentry will be freed ... */
 	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
+	printk(KERN_INFO "NFSLOG UID=%d GID=%d FILE=",
+		rqstp->rq_cred.cr_uid,
+		rqstp->rq_cred.cr_gid);
+	print_dirname(dentry);
+	printk(" OP=%s IP=%d.%d.%d.%d\n",
+		__FUNCTION__,
+		NIPQUAD(rqstp->rq_addr.sin_addr.s_addr));
 	if (err==0) err = cerr;
 out:
 	return err;
@@ -1302,6 +1365,14 @@
 	}
 	dput(ndentry);
 
+	printk(KERN_INFO "NFSLOG UID=%d GID=%d FILE=",
+		rqstp->rq_cred.cr_uid,
+		rqstp->rq_cred.cr_gid);
+	print_dirname(fdentry);
+	printk(" OP=%s IP=%d.%d.%d.%d\n",
+		__FUNCTION__,
+		NIPQUAD(rqstp->rq_addr.sin_addr.s_addr));
+
  out_dput_old:
 	dput(odentry);
  out_nfserr:
@@ -1373,6 +1444,15 @@
 		goto out_nfserr;
 	if (EX_ISSYNC(fhp->fh_export)) 
 		nfsd_sync_dir(dentry);
+
+	printk(KERN_INFO "NFSLOG UID=%d GID=%d FILE=",
+		rqstp->rq_cred.cr_uid,
+		rqstp->rq_cred.cr_gid);
+	print_dirname(dentry);
+	printk("/%s", fname);
+	printk(" OP=%s IP=%d.%d.%d.%d\n",
+		__FUNCTION__,
+		NIPQUAD(rqstp->rq_addr.sin_addr.s_addr)); //ratz
 
 out:
 	return err;

--------------090806070602000605010000--

