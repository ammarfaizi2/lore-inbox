Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264131AbUCZTlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 14:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUCZTlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 14:41:23 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:6323 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S264131AbUCZTlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 14:41:12 -0500
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Missing return value check on do_write_mem
Date: Thu, 25 Mar 2004 20:03:52 +0100
User-Agent: KMail/1.5
References: <200403081246.33897.blaisorblade_spam@yahoo.it> <200403132049.54554.blaisorblade_spam@yahoo.it> <20040313161500.72a7d098.akpm@osdl.org>
In-Reply-To: <20040313161500.72a7d098.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Y0yYABJ3D3a2fn8"
Message-Id: <200403252003.52209.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Y0yYABJ3D3a2fn8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 01:15, domenica 14 marzo 2004, Andrew Morton ha scritto:
> BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
> > Alle 22:46, marted=EC 9 marzo 2004, Andrew Morton ha scritto:
> >  > BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
> >  > > In drivers/char/mem.c do_write_mem can return -EFAULT but write_km=
em
> >  > > forgets this and goes blindly.
>
> Actually, you converted this code from "wrong" to "still wrong".  How's
> this?
[...]
Sorry for not answering soon, but there is a *bug*:
+                               written =3D copy_from_user(kbuf, buf, len);
+                               if (written !=3D len) {

On success copy_from_user returns 0, so you should check
"if (written !=3D 0)".

The attached patch addresses also this and renames the var to "unwritten".

> - Return correct value from kmem writes() when a fault is encountered.  A
>   write()-style syscall's return values are:
>
>    0: nothing was written and there was no error (someone tried to write
>    zero bytes)
>
>    >0: the number of bytes copied, whether or not there was an error.
>
>    Userspace detects errors by noting that the write() return value is le=
ss
>    than was requested.

=2D I've checked the code of 2.4 do_generic_file_write() which complies wit=
h=20
your description, but man 2 write is not clear on this (this is possibly wh=
y=20
who wrote that code missed this).

=2D Also, it seems read() should have the same return values (I checked 2.4=
 and=20
2.6 generic_file_read() ); so even the read_kmem() and read_mem must be=20
fixed. I'm attaching the fix which also creates a do_read_mem() like=20
do_write_mem().

=2D More important, this check is at least strange:

#if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
                /* we don't have page 0 mapped on sparc and m68k.. */
                if (p < PAGE_SIZE) {

This is checked both when p is a physical address and when it is a virtual=
=20
one, for both write() and read(). The non existing page 0 is the physical=20
page 0 or the virtual page 0? I've not changed it, however.

=2D Also, generic_file_write() (both 2.4 and 2.6) calls down(&inode->i_sem)=
;,=20
while write_mem() and write_kmem() do not; shouldn't they be fixed?

=2D Finally, do_write_mem() does *ppos +=3D written; since ppos could have =
been=20
changed, this is wrong, or not? It has no effect for write_kmem() that sets=
 a=20
correct value after, but seems a bug for write_mem().

By the way: I've sent your first write() fix, just adapted a bit for 2.4, t=
o=20
Marcelo Tosatti. I'll post this second one for 2.4 if it's Ok for you.

CC me as I'm not subscribed, please.

Thanks a lot for your attention!
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_Y0yYABJ3D3a2fn8
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="do_write_mem-return-check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="do_write_mem-return-check.patch"

--- ./drivers/char/mem.c.fix	2004-03-23 16:40:49.000000000 +0100
+++ ./drivers/char/mem.c	2004-03-25 20:01:05.000000000 +0100
@@ -105,35 +105,62 @@ static inline int valid_phys_addr_range(
 static ssize_t do_write_mem(void *p, unsigned long realp,
 			    const char * buf, size_t count, loff_t *ppos)
 {
-	ssize_t written;
-	unsigned long copied;
+	ssize_t written = 0;
+	unsigned long uncopied;
 
-	written = 0;
 #if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
 	/* we don't have page 0 mapped on sparc and m68k.. */
 	if (realp < PAGE_SIZE) {
-		unsigned long sz = PAGE_SIZE-realp;
-		if (sz > count) sz = count; 
+		unsigned long sz = PAGE_SIZE - realp;
+		if (sz > count)
+			sz = count; 
 		/* Hmm. Do something? */
-		buf+=sz;
-		p+=sz;
-		count-=sz;
-		written+=sz;
+		buf += sz;
+		p += sz;
+		count -= sz;
+		written += sz;
 	}
 #endif
-	copied = copy_from_user(p, buf, count);
-	if (copied) {
-		ssize_t ret = written + (count - copied);
-
-		if (ret)
-			return ret;
-		return -EFAULT;
+	uncopied = copy_from_user(p, buf, count);
+	if (uncopied) {
+		ssize_t ret = written + (count - uncopied);
+		return ret ? ret : -EFAULT;
 	}
 	written += count;
 	*ppos += written;
 	return written;
 }
 
+static ssize_t do_read_mem(void *p, unsigned long realp,
+			   char * buf, size_t count, loff_t *ppos)
+{
+	ssize_t read = 0;
+	unsigned long uncopied;
+
+#if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
+	/* we don't have page 0 mapped on sparc and m68k.. */
+	if (realp < PAGE_SIZE) {
+		size_t sz = PAGE_SIZE - realp;
+		if (sz > count)
+			sz = count;
+		if (clear_user(buf, sz))
+			return -EFAULT;
+		buf += sz;
+		p += sz;
+		count -= sz;
+		read += sz;
+	}
+#endif
+	uncopied = copy_to_user(buf, (char *)p, count);
+	if (uncopied) {
+		ssize_t ret = read + (count - uncopied);
+		return ret ? ret : -EFAULT;
+	}
+	read += count;
+	*ppos += read;
+	return read;
+}
+
 
 /*
  * This funcion reads the *physical* memory. The f_pos points directly to the 
@@ -143,32 +170,10 @@ static ssize_t read_mem(struct file * fi
 			size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	ssize_t read;
 
 	if (!valid_phys_addr_range(p, &count))
 		return -EFAULT;
-	read = 0;
-#if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
-	/* we don't have page 0 mapped on sparc and m68k.. */
-	if (p < PAGE_SIZE) {
-		unsigned long sz = PAGE_SIZE-p;
-		if (sz > count) 
-			sz = count; 
-		if (sz > 0) {
-			if (clear_user(buf, sz))
-				return -EFAULT;
-			buf += sz; 
-			p += sz; 
-			count -= sz; 
-			read += sz; 
-		}
-	}
-#endif
-	if (copy_to_user(buf, __va(p), count))
-		return -EFAULT;
-	read += count;
-	*ppos += read;
-	return read;
+	return do_read_mem(__va(p), p, buf, count, ppos);
 }
 
 static ssize_t write_mem(struct file * file, const char * buf, 
@@ -222,25 +227,14 @@ static ssize_t read_kmem(struct file *fi
 	char * kbuf; /* k-addr because vread() takes vmlist_lock rwlock */
 		
 	if (p < (unsigned long) high_memory) {
-		read = count;
+		ssize_t toread = count;
 		if (count > (unsigned long) high_memory - p)
-			read = (unsigned long) high_memory - p;
+			toread = (unsigned long) high_memory - p;
+
+		read = do_read_mem((void*)p, p, buf, toread, ppos);
+		if (read != toread)
+			return read;
 
-#if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
-		/* we don't have page 0 mapped on sparc and m68k.. */
-		if (p < PAGE_SIZE && read > 0) {
-			size_t tmp = PAGE_SIZE - p;
-			if (tmp > read) tmp = read;
-			if (clear_user(buf, tmp))
-				return -EFAULT;
-			buf += tmp;
-			p += tmp;
-			read -= tmp;
-			count -= tmp;
-		}
-#endif
-		if (copy_to_user(buf, (char *)p, read))
-			return -EFAULT;
 		p += read;
 		buf += read;
 		count -= read;
@@ -252,15 +246,20 @@ static ssize_t read_kmem(struct file *fi
 			return -ENOMEM;
 		while (count > 0) {
 			int len = count;
+			ssize_t unwritten;
 
 			if (len > PAGE_SIZE)
 				len = PAGE_SIZE;
 			len = vread(kbuf, (char *)p, len);
 			if (!len)
 				break;
-			if (copy_to_user(buf, kbuf, len)) {
+			unwritten = copy_to_user(buf, kbuf, len);
+			if (unwritten != 0) {
+				ssize_t ret;
+
 				free_page((unsigned long)kbuf);
-				return -EFAULT;
+				ret = read + virtr + (len - unwritten);
+				return ret ? ret : -EFAULT;
 			}
 			count -= len;
 			buf += len;
@@ -282,19 +281,19 @@ static ssize_t write_kmem(struct file * 
 	unsigned long p = *ppos;
 	ssize_t wrote = 0;
 	ssize_t virtr = 0;
-	ssize_t written;
 	char * kbuf; /* k-addr because vwrite() takes vmlist_lock rwlock */
 
 	if (p < (unsigned long) high_memory) {
+		ssize_t towrite;
 
-		wrote = count;
+		towrite = count;
 		if (count > (unsigned long) high_memory - p)
-			wrote = (unsigned long) high_memory - p;
+			towrite = (unsigned long) high_memory - p;
+
+		wrote = do_write_mem((void*)p, p, buf, towrite, ppos);
+		if (wrote != towrite)
+			return wrote;
 
-		written = do_write_mem((void*)p, p, buf, wrote, ppos);
-		if (written != wrote)
-			return written;
-		wrote = written;
 		p += wrote;
 		buf += wrote;
 		count -= wrote;
@@ -310,12 +309,12 @@ static ssize_t write_kmem(struct file * 
 			if (len > PAGE_SIZE)
 				len = PAGE_SIZE;
 			if (len) {
-				written = copy_from_user(kbuf, buf, len);
-				if (written != len) {
+				ssize_t unwritten = copy_from_user(kbuf, buf, len);
+				if (unwritten != 0) {
 					ssize_t ret;
 
 					free_page((unsigned long)kbuf);
-					ret = wrote + virtr + (len - written);
+					ret = wrote + virtr + (len - unwritten);
 					return ret ? ret : -EFAULT;
 				}
 			}

--Boundary-00=_Y0yYABJ3D3a2fn8--

