Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSESFNW>; Sun, 19 May 2002 01:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314139AbSESFNW>; Sun, 19 May 2002 01:13:22 -0400
Received: from panda.sul.com.br ([200.219.150.4]:30212 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id <S314138AbSESFNQ>;
	Sun, 19 May 2002 01:13:16 -0400
Date: Sat, 18 May 2002 20:12:25 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>,
        "Peter J.Braam" <braam@clusterfs.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        kernel-janitor-discuss@lists.sourceforge.net
Subject: [BKPATCH] Re: AUDIT of 2.5.15 copy_to/from_user
Message-ID: <20020518231225.GA4164@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Peter J.Braam <braam@clusterfs.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <E179IA6-0002eQ-00@wagner.rustcorp.com.au> <20020518225535.GA4101@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, May 18, 2002 at 07:55:35PM -0300, Arnaldo C. Melo escreveu:
> Heads up: I'm finishing a bk changeset for intermezzo, will be submitting
> to Linus in some minutes.

Here is, Linus, if you think its ok, please pull it from:

http://kernel-acme.bkbits.net:8080/intermezzo-copy_tofrom_user-2.5

- Arnaldo

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.540   -> 1.541  
#	 fs/intermezzo/kml.c	1.1     -> 1.2    
#	fs/intermezzo/ext_attr.c	1.2     -> 1.3    
#	fs/intermezzo/psdev.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/19	acme@conectiva.com.br	1.541
# fs/intermezzo/ext_attr.c
# fs/intermezzo/kml.c
# fs/intermezzo/psdev.c
# 
# 	- fix copy_{to,from}_user error handling (thans to Rusty for pointing this out)
# --------------------------------------------
#
diff -Nru a/fs/intermezzo/ext_attr.c b/fs/intermezzo/ext_attr.c
--- a/fs/intermezzo/ext_attr.c	Sun May 19 02:07:36 2002
+++ b/fs/intermezzo/ext_attr.c	Sun May 19 02:07:36 2002
@@ -105,9 +105,8 @@
                         printk("InterMezzo: out of memory!!!\n");
                         return -ENOMEM;
                 }
-                error = copy_from_user(buf, buffer, buffer_len);
-                if (error) 
-                        return error;
+                if (copy_from_user(buf, buffer, buffer_len))
+                        return -EFAULT;
             } else 
                 buf = buffer;
         } else
diff -Nru a/fs/intermezzo/kml.c b/fs/intermezzo/kml.c
--- a/fs/intermezzo/kml.c	Sun May 19 02:07:36 2002
+++ b/fs/intermezzo/kml.c	Sun May 19 02:07:36 2002
@@ -31,10 +31,9 @@
 
         ENTRY;
         /* allocate buffer & copy it to kernel space */
-        error = copy_from_user(&input, (char *)arg, sizeof(input));
-        if ( error ) {
+        if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                 EXIT;
-                return error;
+                return -EFAULT;
         }
 
         if (input.reclen > kml_fsdata->kml_maxsize)
@@ -45,11 +44,10 @@
                 EXIT;
                 return -ENOMEM;
         }
-        error = copy_from_user(path, input.volname, input.namelen);
-        if ( error ) {
+        if (copy_from_user(path, input.volname, input.namelen)) {
                 PRESTO_FREE(path, input.namelen + 1);
                 EXIT;
-                return error;
+                return -EFAULT;
         }
         path[input.namelen] = '\0';
         fset = kml_getfset (path);
@@ -57,10 +55,9 @@
 
         kml_fsdata = FSET_GET_KMLDATA(fset);
         /* read the buf from user memory here */
-        error = copy_from_user(kml_fsdata->kml_buf, input.recbuf, input.reclen);
-        if ( error ) {
+        if (copy_from_user(kml_fsdata->kml_buf, input.recbuf, input.reclen)) {
                 EXIT;
-                return error;
+                return -EFAULT;
         }
         kml_fsdata->kml_len = input.reclen;
 
@@ -94,21 +91,19 @@
         struct presto_file_set *fset;
 
         ENTRY;
-        error = copy_from_user(&input, (char *)arg, sizeof(input));
-        if ( error ) {
+        if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                 EXIT;
-                return error;
+                return -EFAULT;
         }
         PRESTO_ALLOC(path, char *, input.namelen + 1);
         if ( !path ) {
                 EXIT;
                 return -ENOMEM;
         }
-        error = copy_from_user(path, input.volname, input.namelen);
-        if ( error ) {
+        if (copy_from_user(path, input.volname, input.namelen)) {
                 PRESTO_FREE(path, input.namelen + 1);
                 EXIT;
-                return error;
+                return -EFAULT;
         }
         path[input.namelen] = '\0';
         fset = kml_getfset (path);
@@ -138,7 +133,8 @@
                                 strlen (close->path) + 1, input.pathlen);
                         error = -ENOMEM;
                 }
-                copy_to_user((char *)arg, &input, sizeof (input));
+                if (copy_to_user((char *)arg, &input, sizeof (input)))
+			return -EFAULT;
         }
         return error;
 }
@@ -161,10 +157,9 @@
         char *path;
 
         ENTRY;
-        error = copy_from_user(&input, (char *)arg, sizeof(input));
-        if ( error ) {
+        if (copy_from_user(&input, (char *)arg, sizeof(input))) { 
                EXIT;
-               return error;
+               return -EFAULT;
         }
 
         PRESTO_ALLOC(path, char *, input.namelen + 1);
@@ -172,11 +167,11 @@
                 EXIT;
                 return -ENOMEM;
         }
-        error = copy_from_user(path, input.volname, input.namelen);
+        if (copy_from_user(path, input.volname, input.namelen)) {
         if ( error ) {
                 PRESTO_FREE(path, input.namelen + 1);
                 EXIT;
-                return error;
+                return -EFAULT;
         }
         path[input.namelen] = '\0';
         fset = kml_getfset (path);
@@ -193,7 +188,8 @@
 #if 0
         input.newpos = kml_upc->newpos;
         input.count = kml_upc->count;
-        copy_to_user((char *)arg, &input, sizeof (input));
+        if (copy_to_user((char *)arg, &input, sizeof (input)))
+		return -EFAULT;
 #endif
         return error;
 }
diff -Nru a/fs/intermezzo/psdev.c b/fs/intermezzo/psdev.c
--- a/fs/intermezzo/psdev.c	Sun May 19 02:07:36 2002
+++ b/fs/intermezzo/psdev.c	Sun May 19 02:07:36 2002
@@ -149,9 +149,8 @@
                 return -EINVAL;
         }
 
-        error = copy_from_user(&hdr, buf, sizeof(hdr));
-        if ( error )
-                return error;
+        if (copy_from_user(&hdr, buf, sizeof(hdr)))
+                return -EFAULT;
 
         CDEBUG(D_PSDEV, "(process,opc,uniq)=(%d,%d,%d)\n",
                current->pid, hdr.opcode, hdr.unique);
@@ -183,9 +182,8 @@
                        req->rq_bufsize, count, hdr.opcode, hdr.unique);
                 count = req->rq_bufsize; /* don't have more space! */
         }
-        error = copy_from_user(req->rq_data, buf, count);
-        if ( error )
-                return error;
+        if (copy_from_user(req->rq_data, buf, count))
+                return -EFAULT;
 
         /* adjust outsize: good upcalls can be aware of this */
         req->rq_rep_size = count;
@@ -280,14 +278,12 @@
                 char * tmp;
                 int error;
 
-                error = copy_from_user(&readmount, (void *)arg,
-                                       sizeof(readmount));
-                if ( error )  {
+                if (copy_from_user(&readmount, (void *)arg, sizeof(readmount)))
                         printk("psdev: can't copy %Zd bytes from %p to %p\n",
                                 sizeof(readmount), (struct readmount *) arg,
                                 &readmount);
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
 
                 len = readmount.io_len;
@@ -307,15 +303,16 @@
                  * I mean, let's let the compiler do a little work ...
                  * gcc suggested the extra ()
                  */
-                error = copy_to_user(readmount.io_string, tmp, outlen);
-                if ( error ) {
+                if (copy_to_user(readmount.io_string, tmp, outlen)) {
                         CDEBUG(D_PSDEV, "Copy_to_user string 0x%p failed\n",
                                readmount.io_string);
+			error = -EFAULT;
                 }
-                if ((!error) && (error = copy_to_user(&(user_readmount->io_len),
-                                                      &outlen, sizeof(int))) ) {
+                if (!error && copy_to_user(&(user_readmount->io_len),
+                                           &outlen, sizeof(int))) {
                         CDEBUG(D_PSDEV, "Copy_to_user len @0x%p failed\n",
                                &(user_readmount->io_len));
+			error = -EFAULT;
                 }
 
                 PRESTO_FREE(tmp, len);
@@ -360,10 +357,9 @@
                         int   path_len;
                 } input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
 
                 PRESTO_ALLOC(path, char *, input.path_len + 1);
@@ -371,11 +367,10 @@
                         EXIT;
                         return -ENOMEM;
                 }
-                error = copy_from_user(path, input.path, input.path_len);
-                if ( error ) {
+                if (copy_from_user(path, input.path, input.path_len)) {
                         PRESTO_FREE(path, input.path_len + 1);
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
                 path[input.path_len] = '\0';
                 CDEBUG(D_PSDEV, "clear_fsetroot: path %s\n", path);
@@ -401,10 +396,9 @@
                         int   path_len;
                 } input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
 
                 PRESTO_ALLOC(path, char *, input.path_len + 1);
@@ -412,11 +406,10 @@
                         EXIT;
                         return -ENOMEM;
                 }
-                error = copy_from_user(path, input.path, input.path_len);
-                if ( error ) {
+                if (copy_from_user(path, input.path, input.path_len)) {
                         PRESTO_FREE(path, input.path_len + 1);
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
                 path[input.path_len] = '\0';
                 CDEBUG(D_PSDEV, "clear_all_fsetroot: path %s\n", path);
@@ -440,10 +433,9 @@
                         int   path_len;
                 } input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
 
                 PRESTO_ALLOC(path, char *, input.path_len + 1);
@@ -451,11 +443,10 @@
                         EXIT;
                         return -ENOMEM;
                 }
-                error = copy_from_user(path, input.path, input.path_len);
-                if ( error ) {
+                if (copy_from_user(path, input.path, input.path_len)) {
                         PRESTO_FREE(path, input.path_len + 1);
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
                 path[input.path_len] = '\0';
                 CDEBUG(D_PSDEV, "get_kmlsize: len %d path %s\n", 
@@ -474,7 +465,9 @@
                 CDEBUG(D_PSDEV, "get_kmlsize: size = %Zd\n", size);
 
                 EXIT;
-                return copy_to_user((char *)arg, &input, sizeof(input));
+                if (copy_to_user((char *)arg, &input, sizeof(input)))
+			return -EFAULT;
+		return 0;
         }
 
         case PRESTO_GET_RECNO: {
@@ -488,10 +481,9 @@
                         int   path_len;
                 } input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
 
                 PRESTO_ALLOC(path, char *, input.path_len + 1);
@@ -499,11 +491,10 @@
                         EXIT;
                         return -ENOMEM;
                 }
-                error = copy_from_user(path, input.path, input.path_len);
-                if ( error ) {
+                if (copy_from_user(path, input.path, input.path_len)) {
                         PRESTO_FREE(path, input.path_len + 1);
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
                 path[input.path_len] = '\0';
                 CDEBUG(D_PSDEV, "get_recno: len %d path %s\n", 
@@ -522,7 +513,9 @@
                 CDEBUG(D_PSDEV, "get_recno: recno = %d\n", (int) recno);
 
                 EXIT;
-                return copy_to_user((char *)arg, &input, sizeof(input));
+                if (copy_to_user((char *)arg, &input, sizeof(input)))
+			return -EFAULT;
+		return 0;
         }
 
         case PRESTO_SET_FSETROOT: {
@@ -543,10 +536,9 @@
                         int   flags;
                 } input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
 
                 PRESTO_ALLOC(path, char *, input.path_len + 1);
@@ -554,9 +546,9 @@
                         EXIT;
                         return -ENOMEM;
                 }
-                error = copy_from_user(path, input.path, input.path_len);
-                if ( error ) {
+                if (copy_from_user(path, input.path, input.path_len)) {
                         EXIT;
+			error -EFAULT;
                         goto exit_free_path;
                 }
                 path[input.path_len] = '\0';
@@ -567,9 +559,9 @@
                         EXIT;
                         goto exit_free_path;
                 }
-                error = copy_from_user(fsetname, input.name, input.name_len);
-                if ( error ) {
+                if (copy_from_user(fsetname, input.name, input.name_len)) {
                         EXIT;
+			error = -EFAULT;
                         goto exit_free_fsetname;
                 }
                 fsetname[input.name_len] = '\0';
@@ -621,12 +613,11 @@
                 struct psdev_opt *user_opt = (struct psdev_opt *) arg;
                 int error;
 
-                error = copy_from_user(&kopt, (void *)arg, sizeof(kopt));
-                if ( error )  {
+                if (copy_from_user(&kopt, (void *)arg, sizeof(kopt))) {
                         printk("psdev: can't copyin %Zd bytes from %p to %p\n",
                                sizeof(kopt), (struct kopt *) arg, &kopt);
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
                 minor = minor(dev);
                 if (cmd == PRESTO_SETOPT)
@@ -650,12 +641,11 @@
                         return error;
                 }
 
-                error = copy_to_user(user_opt, &kopt, sizeof(kopt));
-                if ( error ) {
+                if (copy_to_user(user_opt, &kopt, sizeof(kopt))) {
                         CDEBUG(D_PSDEV, "Copy_to_user opt 0x%p failed\n",
                                user_opt);
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
                 CDEBUG(D_PSDEV, "dosetopt minor %d, opt %d, val %d return %d\n",
                          minor, kopt.optname, kopt.optval, error);
@@ -668,10 +658,9 @@
                 struct lento_input_attr input;
                 struct iattr iattr;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
                 iattr.ia_valid = input.valid;
                 iattr.ia_mode  = (umode_t)input.mode;
@@ -692,10 +681,9 @@
                 int error;
                 struct lento_input_mode input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
 
                 error = lento_create(input.name, input.mode, &input.info);
@@ -707,10 +695,9 @@
                 int error;
                 struct lento_input_old_new input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
 
                 error = lento_link(input.oldname, input.newname, &input.info);
@@ -722,10 +709,9 @@
                 int error;
                 struct lento_input input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
 
                 error = lento_unlink(input.name, &input.info);
@@ -737,10 +723,9 @@
                 int error;
                 struct lento_input_old_new input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
 
                 error = lento_symlink(input.oldname, input.newname,&input.info);
@@ -752,10 +737,9 @@
                 int error;
                 struct lento_input_mode input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
 
                 error = lento_mkdir(input.name, input.mode, &input.info);
@@ -767,10 +751,9 @@
                 int error;
                 struct lento_input input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
 
                 error = lento_rmdir(input.name, &input.info);
@@ -782,10 +765,9 @@
                 int error;
                 struct lento_input_dev input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
 
                 error = lento_mknod(input.name, input.mode,
@@ -798,10 +780,9 @@
                 int error;
                 struct lento_input_old_new input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
 
                 error = lento_rename(input.oldname, input.newname, &input.info);
@@ -817,30 +798,27 @@
                 char *name;
                 char *buffer;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) { 
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                     EXIT;
-                    return error;
+                    return -EFAULT;
                 }
 
                 /* Now setup the input parameters */
                 PRESTO_ALLOC(name, char *, input.name_len+1);
                 /* We need null terminated strings for attr names */
                 name[input.name_len] = '\0';
-                error=copy_from_user(name, input.name, input.name_len);
-                if ( error ) { 
+                if (copy_from_user(name, input.name, input.name_len)) {
                     EXIT;
                     PRESTO_FREE(name,input.name_len+1);
-                    return error;
+                    return -EFAULT;
                 }
 
                 PRESTO_ALLOC(buffer, char *, input.buffer_len+1);
-                error=copy_from_user(buffer, input.buffer, input.buffer_len);
-                if ( error ) { 
+                if (copy_from_user(buffer, input.buffer, input.buffer_len)) {
                     EXIT;
                     PRESTO_FREE(name,input.name_len+1);
                     PRESTO_FREE(buffer,input.buffer_len+1);
-                    return error;
+                    return -EFAULT;
                 }
                 /* Make null terminated for easy printing */
                 buffer[input.buffer_len]='\0';
@@ -869,21 +847,19 @@
                 struct lento_input_ext_attr input;
                 char *name;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) { 
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                     EXIT;
-                    return error;
+                    return -EFAULT;
                 }
 
                 /* Now setup the input parameters */
                 PRESTO_ALLOC(name, char *, input.name_len+1);
                 /* We need null terminated strings for attr names */
                 name[input.name_len] = '\0';
-                error=copy_from_user(name, input.name, input.name_len);
-                if ( error ) { 
+                if (copy_from_user(name, input.name, input.name_len)) {
                     EXIT;
                     PRESTO_FREE(name,input.name_len+1);
-                    return error;
+                    return -EFAULT;
                 }
 
                 CDEBUG(D_PSDEV," delextattr params: name %s,"
@@ -907,10 +883,9 @@
                 struct lento_input_iopen input;
                 int error;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
 
                 input.fd = lento_iopen(input.name, (ino_t)input.ino,
@@ -921,17 +896,18 @@
                         return input.fd;
                 }
                 EXIT;
-                return copy_to_user((char *)arg, &input, sizeof(input));
+                if (copy_to_user((char *)arg, &input, sizeof(input)))
+			return -EFAULT;
+		return 0;
         }
 
         case PRESTO_VFS_CLOSE: {
                 int error;
                 struct lento_input_close input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
 
                 CDEBUG(D_PIOCTL, "lento_close file descriptor: %d\n", input.fd);
@@ -952,10 +928,9 @@
                         struct presto_version remote_file_version;
                 } input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
                 user_path = input.path;
 
@@ -964,11 +939,10 @@
                         EXIT;
                         return -ENOMEM;
                 }
-                error = copy_from_user(input.path, user_path, input.path_len);
-                if ( error ) {
+                if (copy_from_user(input.path, user_path, input.path_len)) {
                         EXIT;
                         PRESTO_FREE(input.path, input.path_len + 1);
-                        return error;
+                        return -EFAULT;
                 }
                 input.path[input.path_len] = '\0';
 
@@ -996,10 +970,9 @@
                         struct lento_vfs_context info;
                 } input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
                 user_path = input.path;
 
@@ -1008,11 +981,10 @@
                         EXIT;
                         return -ENOMEM;
                 }
-                error = copy_from_user(input.path, user_path, input.path_len);
-                if ( error ) {
+                if (copy_from_user(input.path, user_path, input.path_len)) {
                         EXIT;
                         PRESTO_FREE(input.path, input.path_len + 1);
-                        return error;
+                        return -EFAULT;
                 }
                 input.path[input.path_len] = '\0';
 
@@ -1035,10 +1007,9 @@
                         __u32 path_len;
                 } input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
                 user_path = input.path;
 
@@ -1047,11 +1018,10 @@
                         EXIT;
                         return -ENOMEM;
                 }
-                error = copy_from_user(input.path, user_path, input.path_len);
-                if ( error ) {
+                if (copy_from_user(input.path, user_path, input.path_len)) {
                         EXIT;
                         PRESTO_FREE(input.path, input.path_len + 1);
-                        return error;
+                        return -EFAULT;
                 }
                 input.path[input.path_len] = '\0';
 
@@ -1072,10 +1042,9 @@
                         __u32 recno;
                 } input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
                 user_path = input.path;
 
@@ -1084,11 +1053,10 @@
                         EXIT;
                         return -ENOMEM;
                 }
-                error = copy_from_user(input.path, user_path, input.path_len);
-                if ( error ) {
+                if (copy_from_user(input.path, user_path, input.path_len)) {
                         EXIT;
                         PRESTO_FREE(input.path, input.path_len + 1);
-                        return error;
+                        return -EFAULT;
                 }
                 input.path[input.path_len] = '\0';
 
@@ -1111,10 +1079,9 @@
                         char *path;
                 } input;
 
-                error = copy_from_user(&input, (char *)arg, sizeof(input));
-                if ( error ) {
+                if (copy_from_user(&input, (char *)arg, sizeof(input))) {
                         EXIT;
-                        return error;
+                        return -EFAULT;
                 }
                 user_path = input.path;
 
@@ -1123,11 +1090,10 @@
                         EXIT;
                         return -ENOMEM;
                 }
-                error = copy_from_user(input.path, user_path, input.path_len);
-                if ( error ) {
+                if (copy_from_user(input.path, user_path, input.path_len)) {
                         EXIT;
                         PRESTO_FREE(input.path, input.path_len + 1);
-                        return error;
+                        return -EFAULT;
                 }
                 input.path[input.path_len] = '\0';
 
@@ -1190,7 +1156,9 @@
                 }
                 /* return the correct cookie to wait for */
                 input.mark_what = res;
-                return copy_to_user((char *)arg, &input, sizeof(input));
+                if (copy_to_user((char *)arg, &input, sizeof(input)))
+			return -EFAULT;
+		return 0;
         }
 
 #ifdef  CONFIG_KREINT
@@ -1211,11 +1179,10 @@
                         char *path;
                 } permit;
                 
-                error = copy_from_user(&permit, (char *)arg, sizeof(permit));
-                if ( error ) {
+                if (copy_from_user(&permit, (char *)arg, sizeof(permit))) {
                         EXIT;
-                        return error;
-                        }
+                        return -EFAULT;
+		}
                 user_path = permit.path;
                 
                 PRESTO_ALLOC(permit.path, char *, permit.path_len + 1);
@@ -1223,11 +1190,10 @@
                         EXIT;
                         return -ENOMEM;
                 }
-                error = copy_from_user(permit.path, user_path, permit.path_len);
-                if ( error ) {
+                if (copy_from_user(permit.path, user_path, permit.path_len)) {
                         EXIT;
                         PRESTO_FREE(permit.path, permit.path_len + 1);
-                        return error;
+                        return -EFAULT;
                 }
                 permit.path[permit.path_len] = '\0';
                 
@@ -1241,7 +1207,9 @@
                         return error;
                 }
                 /* return the correct cookie to wait for */
-                return copy_to_user((char *)arg, &permit, sizeof(permit));
+                if (copy_to_user((char *)arg, &permit, sizeof(permit)))
+			return -EFAULT;
+		return 0;
         }
         
         default:
