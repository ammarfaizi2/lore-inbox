Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbTGFQJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 12:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266682AbTGFQJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 12:09:57 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:39596 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262498AbTGFQJE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 12:09:04 -0400
Date: Sun, 6 Jul 2003 19:23:31 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: top stack users for 2.5.74
Message-ID: <20030706162331.GH24563@actcom.co.il>
References: <20030625163322.GB1770@wohnheim.fh-wedel.de> <20030706161654.GA25901@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YzDq+9le76OY47R0"
Content-Disposition: inline
In-Reply-To: <20030706161654.GA25901@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YzDq+9le76OY47R0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 06, 2003 at 06:16:54PM +0200, J?rn Engel wrote:

> 0xc02318b6 presto_get_fileid:                            sub    $0x119c,%=
esp
> 0xc0230076 presto_copy_kml_tail:                         sub    $0x1028,%=
esp
> 0xc0226096 presto_ioctl:                                 sub    $0x504,%e=
sp

Attached is the patch for these three. The intermezzo maintainers are
integrating it and should push it to Linus eventually, but if anyone
wants it until then...=20

Patch against 2.5.73, applies with a one line fuzz to
2.5.74. Compiles, not tested.=20

diff -Naur --exclude-from=3D/home/mulix/dontdiff linux-2.5/fs/intermezzo/di=
r.c linux-2.5.73-stack-lusers/fs/intermezzo/dir.c
--- linux-2.5/fs/intermezzo/dir.c	2003-03-22 04:25:29.000000000 +0200
+++ linux-2.5.73-stack-lusers/fs/intermezzo/dir.c	2003-06-25 23:02:34.00000=
0000 +0300
@@ -877,17 +877,19 @@
 int presto_ioctl(struct inode *inode, struct file *file,
                         unsigned int cmd, unsigned long arg)
 {
-        char buf[1024];
         struct izo_ioctl_data *data =3D NULL;
         struct presto_dentry_data *dd;
         int rc;
+        char* buf;=20
+        static const size_t bufsz =3D 1024;=20
=20
         ENTRY;
=20
         /* Try the filesystem's ioctl first, and return if it succeeded. */
         dd =3D presto_d2d(file->f_dentry);=20
         if (dd && dd->dd_fset) {=20
-                int (*cache_ioctl)(struct inode *, struct file *, unsigned=
 int, unsigned long ) =3D filter_c2cdfops(dd->dd_fset->fset_cache->cache_fi=
lter)->ioctl;
+                int (*cache_ioctl)(struct inode *, struct file *, unsigned=
 int, unsigned long);=20
+                cache_ioctl =3D filter_c2cdfops(dd->dd_fset->fset_cache->c=
ache_filter)->ioctl;
                 rc =3D -ENOTTY;
                 if (cache_ioctl)
                         rc =3D cache_ioctl(inode, file, cmd, arg);
@@ -902,47 +904,49 @@
                 return -EPERM;
         }
=20
-        memset(buf, 0, sizeof(buf));
-       =20
-        if (izo_ioctl_getdata(buf, buf + 1024, (void *)arg)) {=20
+        /* allocate a zero'd buffer for data */=20
+        PRESTO_ALLOC(buf, bufsz);=20
+        if (!buf) {=20
+                EXIT;=20
+                return -ENOMEM;=20
+        }=20
+
+        if (izo_ioctl_getdata(buf, buf + bufsz, (void *)arg)) {=20
                 CERROR("intermezzo ioctl: data error\n");
-                return -EINVAL;
+                rc =3D -EINVAL;=20
+                goto done;=20
         }
         data =3D (struct izo_ioctl_data *)buf;
        =20
         switch(cmd) {
         case IZO_IOC_REINTKML: {=20
-                int rc;
                 int cperr;
                 rc =3D kml_reint_rec(file, data);
=20
-                EXIT;
                 cperr =3D copy_to_user((char *)arg, data, sizeof(*data));
                 if (cperr) {=20
                         CERROR("WARNING: cperr %d\n", cperr);=20
                         rc =3D -EFAULT;
                 }
-                return rc;
+                goto done;=20
         }
=20
         case IZO_IOC_GET_RCVD: {
                 struct izo_rcvd_rec rec;
                 struct presto_file_set *fset;
-                int rc;
=20
                 fset =3D presto_fset(file->f_dentry);
                 if (fset =3D=3D NULL) {
-                        EXIT;
-                        return -ENODEV;
-                }
+                        rc =3D -ENODEV;=20
+                        goto done;=20
+                }=20
+
                 rc =3D izo_rcvd_get(&rec, fset, data->ioc_uuid);
-                if (rc < 0) {
-                        EXIT;
-                        return rc;
-                }
+                if (rc < 0)=20
+                        goto done;=20
=20
-                EXIT;
-                return copy_to_user((char *)arg, &rec, sizeof(rec))? -EFAU=
LT : 0;
+                rc =3D copy_to_user((char *)arg, &rec, sizeof(rec))? -EFAU=
LT : 0;
+                goto done;=20
         }
=20
         case IZO_IOC_REPSTATUS: {
@@ -951,12 +955,11 @@
                 struct izo_rcvd_rec rec;
                 struct presto_file_set *fset;
                 int minor;
-                int rc;
=20
                 fset =3D presto_fset(file->f_dentry);
                 if (fset =3D=3D NULL) {
-                        EXIT;
-                        return -ENODEV;
+                        rc =3D -ENODEV;=20
+                        goto done;=20
                 }
                 minor =3D presto_f2m(fset);
=20
@@ -965,13 +968,11 @@
=20
                 rc =3D izo_repstatus(fset, client_kmlsize,=20
                                        lr_client, &rec);
-                if (rc < 0) {
-                        EXIT;
-                        return rc;
-                }
+                if (rc < 0)=20
+                        goto done;=20
=20
-                EXIT;
-                return copy_to_user((char *)arg, &rec, sizeof(rec))? -EFAU=
LT : 0;
+                rc =3D copy_to_user((char *)arg, &rec, sizeof(rec))? -EFAU=
LT : 0;
+                goto done;=20
         }
=20
         case IZO_IOC_GET_CHANNEL: {
@@ -979,30 +980,28 @@
=20
                 fset =3D presto_fset(file->f_dentry);
                 if (fset =3D=3D NULL) {
-                        EXIT;
-                        return -ENODEV;
+                        rc =3D -ENODEV;=20
+                        goto done;=20
                 }
                =20
                 data->ioc_dev =3D fset->fset_cache->cache_psdev->uc_minor;
                 CDEBUG(D_PSDEV, "CHANNEL %d\n", data->ioc_dev);=20
-                EXIT;
-                return copy_to_user((char *)arg, data, sizeof(*data))? -EF=
AULT : 0;
+                rc =3D copy_to_user((char *)arg, data, sizeof(*data))? -EF=
AULT : 0;
+                goto done;=20
         }
=20
         case IZO_IOC_SET_IOCTL_UID:
                 izo_authorized_uid =3D data->ioc_uid;
-                EXIT;
-                return 0;
+                rc =3D 0;=20
+                goto done;=20
=20
         case IZO_IOC_SET_PID:
                 rc =3D izo_psdev_setpid(data->ioc_dev);
-                EXIT;
-                return rc;
+                goto done;=20
=20
         case IZO_IOC_SET_CHANNEL:
                 rc =3D izo_psdev_setchannel(file, data->ioc_dev);
-                EXIT;
-                return rc;
+                goto done;=20
=20
         case IZO_IOC_GET_KML_SIZE: {
                 struct presto_file_set *fset;
@@ -1010,14 +1009,14 @@
=20
                 fset =3D presto_fset(file->f_dentry);
                 if (fset =3D=3D NULL) {
-                        EXIT;
-                        return -ENODEV;
+                        rc =3D -ENODEV;=20
+                        goto done;=20
                 }
=20
                 kmlsize =3D presto_kml_offset(fset) + fset->fset_kml_logic=
al_off;
=20
-                EXIT;
-                return copy_to_user((char *)arg, &kmlsize, sizeof(kmlsize)=
)?-EFAULT : 0;
+                rc =3D copy_to_user((char *)arg, &kmlsize, sizeof(kmlsize)=
)?-EFAULT : 0;
+                goto done;=20
         }
=20
         case IZO_IOC_PURGE_FILE_DATA: {
@@ -1025,37 +1024,37 @@
=20
                 fset =3D presto_fset(file->f_dentry);
                 if (fset =3D=3D NULL) {
-                        EXIT;
-                        return -ENODEV;
+                        rc =3D -ENODEV;=20
+                        goto done;=20
                 }
=20
                 rc =3D izo_purge_file(fset, data->ioc_inlbuf1);
-                EXIT;
-                return rc;
+                goto done;=20
         }
=20
         case IZO_IOC_GET_FILEID: {
                 rc =3D izo_get_fileid(file, data);
-                EXIT;
                 if (rc)
-                        return rc;
-                return copy_to_user((char *)arg, data, sizeof(*data))? -EF=
AULT : 0;
+                        goto done;=20
+
+                rc =3D copy_to_user((char *)arg, data, sizeof(*data))? -EF=
AULT : 0;
+                goto done;=20
         }
=20
         case IZO_IOC_SET_FILEID: {
                 rc =3D izo_set_fileid(file, data);
-                EXIT;
                 if (rc)
-                        return rc;
-                return copy_to_user((char *)arg, data, sizeof(*data))? -EF=
AULT  : 0;
+                        goto done;=20
+                       =20
+                rc =3D copy_to_user((char *)arg, data, sizeof(*data))? -EF=
AULT  : 0;
+                goto done;=20
         }
=20
         case IZO_IOC_ADJUST_LML: {=20
                 struct lento_vfs_context *info;=20
                 info =3D (struct lento_vfs_context *)data->ioc_inlbuf1;
                 rc =3D presto_adjust_lml(file, info);=20
-                EXIT;
-                return rc;
+                goto done;=20
         }
=20
         case IZO_IOC_CONNECT: {
@@ -1064,16 +1063,15 @@
=20
                 fset =3D presto_fset(file->f_dentry);
                 if (fset =3D=3D NULL) {
-                        EXIT;
-                        return -ENODEV;
+                        rc =3D -ENODEV;
+                        goto done;=20
                 }
                 minor =3D presto_f2m(fset);
=20
                 rc =3D izo_upc_connect(minor, data->ioc_ino,
                                      data->ioc_generation, data->ioc_uuid,
                                      data->ioc_flags);
-                EXIT;
-                return rc;
+                goto done;=20
         }
=20
         case IZO_IOC_GO_FETCH_KML: {
@@ -1082,15 +1080,14 @@
=20
                 fset =3D presto_fset(file->f_dentry);
                 if (fset =3D=3D NULL) {
-                        EXIT;
-                        return -ENODEV;
+                        rc =3D -ENODEV;
+                        goto done;=20
                 }
                 minor =3D presto_f2m(fset);
=20
                 rc =3D izo_upc_go_fetch_kml(minor, fset->fset_name,
                                           data->ioc_uuid, data->ioc_kmlsiz=
e);
-                EXIT;
-                return rc;
+                goto done;=20
         }
=20
         case IZO_IOC_REVOKE_PERMIT:
@@ -1098,26 +1095,23 @@
                         rc =3D izo_revoke_permit(file->f_dentry, data->ioc=
_uuid);
                 else
                         rc =3D izo_revoke_permit(file->f_dentry, NULL);
-                EXIT;
-                return rc;
+                goto done;=20
=20
         case IZO_IOC_CLEAR_FSET:
                 rc =3D izo_clear_fsetroot(file->f_dentry);
-                EXIT;
-                return rc;
+                goto done;=20
=20
         case IZO_IOC_CLEAR_ALL_FSETS: {=20
                 struct presto_file_set *fset;
=20
                 fset =3D presto_fset(file->f_dentry);
                 if (fset =3D=3D NULL) {
-                        EXIT;
-                        return -ENODEV;
+                        rc =3D -ENODEV;
+                        goto done;=20
                 }
=20
                 rc =3D izo_clear_all_fsetroots(fset->fset_cache);
-                EXIT;
-                return rc;
+                goto done;=20
         }
=20
         case IZO_IOC_SET_FSET:
@@ -1127,9 +1121,7 @@
                 rc =3D presto_set_fsetroot_from_ioc(file->f_dentry,=20
                                                   data->ioc_inlbuf1,
                                                   data->ioc_flags);
-                EXIT;
-                return rc;
-
+                goto done;=20
=20
         case IZO_IOC_MARK: {
                 int res =3D 0;  /* resulting flags - returned to user */
@@ -1185,16 +1177,16 @@
                 }
=20
                 if (error) {=20
-                        EXIT;
-                        return error;
+                        rc =3D error;=20
+                        goto done;=20
                 }
                 data->ioc_mark_what =3D res;
                 CDEBUG(D_DOWNCALL, "mark inode: %ld, and: %x, or: %x, what=
 %x\n",
                        file->f_dentry->d_inode->i_ino, data->ioc_and_flag,
                        data->ioc_or_flag, data->ioc_mark_what);
=20
-                EXIT;
-                return copy_to_user((char *)arg, data, sizeof(*data))? -EF=
AULT : 0;
+                rc =3D copy_to_user((char *)arg, data, sizeof(*data))? -EF=
AULT : 0;
+                goto done;=20
         }
 #if 0
         case IZO_IOC_CLIENT_MAKE_BRANCH: {
@@ -1203,16 +1195,15 @@
=20
                 fset =3D presto_fset(file->f_dentry);
                 if (fset =3D=3D NULL) {
-                        EXIT;
-                        return -ENODEV;
+                        rc =3D -ENODEV;
+                        goto done;=20
                 }
                 minor =3D presto_f2m(fset);
=20
                 rc =3D izo_upc_client_make_branch(minor, fset->fset_name,
                                                 data->ioc_inlbuf1,
                                                 data->ioc_inlbuf2);
-                EXIT;
-                return rc;
+                goto done;=20
         }
 #endif
         case IZO_IOC_SERVER_MAKE_BRANCH: {
@@ -1221,14 +1212,14 @@
=20
                 fset =3D presto_fset(file->f_dentry);
                 if (fset =3D=3D NULL) {
-                        EXIT;
-                        return -ENODEV;
+                        rc =3D -ENODEV;
+                        goto done;=20
                 }
                 minor =3D presto_f2m(fset);
=20
                 izo_upc_server_make_branch(minor, data->ioc_inlbuf1);
-                EXIT;
-                return 0;
+                rc =3D 0;=20
+                goto done;=20
         }
         case IZO_IOC_SET_KMLSIZE: {
                 struct presto_file_set *fset;
@@ -1237,38 +1228,33 @@
=20
                 fset =3D presto_fset(file->f_dentry);
                 if (fset =3D=3D NULL) {
-                        EXIT;
-                        return -ENODEV;
+                        rc =3D -ENODEV;=20
+                        goto done;=20
                 }
                 minor =3D presto_f2m(fset);
=20
                 rc =3D izo_upc_set_kmlsize(minor, fset->fset_name, data->i=
oc_uuid,
                                          data->ioc_kmlsize);
=20
-                if (rc !=3D 0) {
-                        EXIT;
-                        return rc;
-                }
+                if (rc !=3D 0)=20
+                        goto done;=20
=20
                 rc =3D izo_rcvd_get(&rec, fset, data->ioc_uuid);
                 if (rc =3D=3D -EINVAL) {
                         /* We don't know anything about this uuid yet; no
                          * worries. */
                         memset(&rec, 0, sizeof(rec));
-                } else if (rc <=3D 0) {
+                } else if (rc <=3D 0) { /* do we really want to return 0 i=
f rc =3D=3D 0 here? */=20
                         CERROR("InterMezzo: error reading last_rcvd: %d\n"=
, rc);
-                        EXIT;
-                        return rc;
+                        goto done;=20
                 }
                 rec.lr_remote_offset =3D data->ioc_kmlsize;
                 rc =3D izo_rcvd_write(fset, &rec);
                 if (rc <=3D 0) {
                         CERROR("InterMezzo: error writing last_rcvd: %d\n"=
, rc);
-                        EXIT;
-                        return rc;
+                        goto done;=20
                 }
-                EXIT;
-                return rc;
+                goto done;=20
         }
         case IZO_IOC_BRANCH_UNDO: {
                 struct presto_file_set *fset;
@@ -1276,15 +1262,14 @@
=20
                 fset =3D presto_fset(file->f_dentry);
                 if (fset =3D=3D NULL) {
-                        EXIT;
-                        return -ENODEV;
+                        rc =3D -ENODEV;
+                        goto done;=20
                 }
                 minor =3D presto_f2m(fset);
=20
                 rc =3D izo_upc_branch_undo(minor, fset->fset_name,
                                          data->ioc_inlbuf1);
-                EXIT;
-                return rc;
+                goto done;=20
         }
         case IZO_IOC_BRANCH_REDO: {
                 struct presto_file_set *fset;
@@ -1292,28 +1277,33 @@
=20
                 fset =3D presto_fset(file->f_dentry);
                 if (fset =3D=3D NULL) {
-                        EXIT;
-                        return -ENODEV;
+                        rc =3D -ENODEV;
+                        goto done;=20
                 }
                 minor =3D presto_f2m(fset);
=20
                 rc =3D izo_upc_branch_redo(minor, fset->fset_name,
                                          data->ioc_inlbuf1);
-                EXIT;
-                return rc;
+                goto done;=20
         }
=20
         case TCGETS:
-                EXIT;
-                return -EINVAL;
+                rc =3D -EINVAL;=20
+                goto done;=20
=20
         default:
                 EXIT;
-                return -EINVAL;
-               =20
+                rc =3D -EINVAL;=20
+                goto done;=20
+
         }
+
+        rc =3D 0;=20
+
+ done:=20
+        PRESTO_FREE(buf, bufsz);=20
         EXIT;
-        return 0;
+        return rc;
 }
=20
 struct file_operations presto_dir_fops =3D {
diff -Naur --exclude-from=3D/home/mulix/dontdiff linux-2.5/fs/intermezzo/jo=
urnal.c linux-2.5.73-stack-lusers/fs/intermezzo/journal.c
--- linux-2.5/fs/intermezzo/journal.c	2002-12-14 03:57:54.000000000 +0200
+++ linux-2.5.73-stack-lusers/fs/intermezzo/journal.c	2003-06-25 23:32:50.0=
00000000 +0300
@@ -1239,12 +1239,16 @@
         return izo_rcvd_write(fset, &rec);
 }
=20
+/* we are called from presto_finish_kml_truncate, which is called */=20
+/* with fset->fset_kml.fd_lock held. Allocations must be GFP_ATOMIC */=20
 struct file * presto_copy_kml_tail(struct presto_file_set *fset,
                                    unsigned long int start)
 {
         struct file *f;
         int len;
         loff_t read_off, write_off, bytes;
+        char* buf;=20
+        size_t bufsz;=20
=20
         ENTRY;
=20
@@ -1258,21 +1262,31 @@
         write_off =3D 0;
         read_off =3D start;
         bytes =3D fset->fset_kml.fd_offset - start;
-        while (bytes > 0) {
-                char buf[4096];
-                int toread;
=20
-                if (bytes > sizeof(buf))
-                        toread =3D sizeof(buf);
-                else
-                        toread =3D bytes;
+        bufsz =3D bytes;=20
+        /* can't use PRESTO_ALLOC - alloction must be atomic */=20
+        buf =3D kmalloc(bufsz, GFP_ATOMIC);
+        if (!buf) {
+                CERROR("IZO: out of memory at %s:%d (trying to "
+                       "allocate %d)\n", __FILE__, __LINE__,=20
+                       bufsz);
+                filp_close(f, NULL);=20
+                EXIT;=20
+                return ERR_PTR(-ENOMEM);=20
+        }
+
+        presto_kmem_inc(buf, bufsz);
+        memset(buf, 0, bufsz);
=20
-                len =3D presto_fread(fset->fset_kml.fd_file, buf, toread,
+        while (bytes > 0) {
+                len =3D presto_fread(fset->fset_kml.fd_file, buf, bufsz,
                                    &read_off);
                 if (len <=3D 0)
                         break;
=20
                 if (presto_fwrite(f, buf, len, &write_off) !=3D len) {
+                        kfree(buf);
+                        presto_kmem_dec(buf, bufsz);
                         filp_close(f, NULL);
                         EXIT;
                         return ERR_PTR(-EIO);
@@ -1280,7 +1294,9 @@
=20
                 bytes -=3D len;
         }
-
+       =20
+        kfree(buf);
+        presto_kmem_dec(buf, bufsz);
         EXIT;
         return f;
 }
@@ -1589,11 +1605,12 @@
 {
         int opcode =3D KML_OPCODE_GET_FILEID;
         struct rec_info rec;
-        char *buffer, *path, *logrecord, record[4096]; /*include path*/
+        char *buffer, *path, *logrecord, *record; /*include path*/
         struct dentry *root;
         __u32 uid, gid, pathlen;
         int error, size;
         struct kml_suffix *suffix;
+        size_t record_size;=20
=20
         ENTRY;
=20
@@ -1609,9 +1626,13 @@
                 size_round(le32_to_cpu(pathlen)) +
                 sizeof(struct kml_suffix);
=20
+        record_size =3D max(4096, size);=20
+        error =3D -ENOMEM;=20
+        PRESTO_ALLOC(record, record_size);=20
+        if (!record)=20
+                goto free_buffer;=20
+
         CDEBUG(D_FILE, "kml size: %d\n", size);
-        if ( size > sizeof(record) )
-                CERROR("InterMezzo: BUFFER OVERFLOW in %s!\n", __FUNCTION_=
_);
=20
         memset(&rec, 0, sizeof(rec));
         rec.is_kml =3D 1;
@@ -1632,6 +1653,9 @@
                                    size_round(le32_to_cpu(pathlen)), path,
                                    fset->fset_name);
=20
+        PRESTO_FREE(record, record_size);=20
+
+ free_buffer:=20
         BUFF_FREE(buffer);
         EXIT;
         return error;

--=20
Muli Ben-Yehuda
http://www.mulix.org
http://www.livejournal.com/~mulix/


--YzDq+9le76OY47R0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/CE0CKRs727/VN8sRAm8gAJ9gMH3rJFLXqRhnrrWJaqmGtV9XgACeOtbA
/refPvXrdVleoAoFBS9WRZQ=
=ZvoZ
-----END PGP SIGNATURE-----

--YzDq+9le76OY47R0--
