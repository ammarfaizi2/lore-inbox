Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbUCMTqP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 14:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbUCMTqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 14:46:15 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:22426 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263176AbUCMTqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 14:46:05 -0500
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Missing return value check on do_write_mem
Date: Sat, 13 Mar 2004 20:49:54 +0100
User-Agent: KMail/1.5
References: <200403081246.33897.blaisorblade_spam@yahoo.it> <20040309134648.61e3cb9f.akpm@osdl.org>
In-Reply-To: <20040309134648.61e3cb9f.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iX2UArXpowtJjYN"
Message-Id: <200403132049.54554.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_iX2UArXpowtJjYN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 22:46, marted=EC 9 marzo 2004, Andrew Morton ha scritto:
> BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
> > In drivers/char/mem.c do_write_mem can return -EFAULT but write_kmem
> > forgets this and goes blindly.

=46irst: do not forget this first fix.

> > Also, do_write_mem takes two unused params and is static - so I've
> > removed those.

The "file" parameter is anyway unused - so it can be removed; for the ppos=
=20
parameter your reasoning holds. I'm posting the patch for these two things=
=20
against 2.6.4 (now I do not remove realp so I avoid the race you describe).

Thanks for answering me - you never lose a patch!

> >  I actually double-checked this - however please test
> > compilation on Sparc/m68k, since there are some #ifdef.
>
> It's a small thing, but:
> > --- ./drivers/char/mem.c.fix	2004-02-20 16:27:21.000000000 +0100
> > +++ ./drivers/char/mem.c	2004-03-08 12:17:23.000000000 +0100
> > @@ -96,13 +96,14 @@
> >  }
> >  #endif
> >
> > -static ssize_t do_write_mem(struct file * file, void *p, unsigned long
> > realp, -			    const char * buf, size_t count, loff_t *ppos)
> > +static ssize_t do_write_mem(void *p, const char * buf, size_t count,
> > +			    loff_t *ppos)
> >  {
> > -	ssize_t written;
> > +	ssize_t written =3D 0;
> >
> > -	written =3D 0;
> >  #if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
> > +	unsigned long realp =3D *ppos;
> > +
>
> A thread which shares this fd can alter the value at *ppos at any time via
> lseek() .

Well, you are right (not found any locking). I've understood that lseek() i=
s=20
known to be racy, and that the bug in my patch is just the range check that=
=20
does not work any more; but anyway the marked line in the 2.6.3/2.6.4 kerne=
l=20
is racy, too, and I'm unsure if that is allowed; i.e. man 2 write claims ev=
en=20
that "POSIX requires  that  a
       read()  which  can  be  proved  to  occur  after a write() has retur=
ned
       returns the new data. Note that not all file systems  are  POSIX  co=
n-
       forming." which would imply that write is not racy. Or not?

static ssize_t do_write_mem(struct file * file, void *p, unsigned long real=
p,
                            const char * buf, size_t count, loff_t *ppos)
{
        ssize_t written;

        written =3D 0;
#if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
//[...]
#endif
        if (copy_from_user(p, buf, count))
                return -EFAULT;
        written +=3D count;
        *ppos +=3D written;				/*If a second thread lseek()'d between when =
we=20
read realp and this line, we have a race*/
        return written;
}



=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_iX2UArXpowtJjYN
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="Fix-kmem-return-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Fix-kmem-return-v2.patch"

--- ./drivers/char/mem.c.fix	2004-03-13 17:56:09.000000000 +0100
+++ ./drivers/char/mem.c	2004-03-13 20:36:35.000000000 +0100
@@ -102,7 +102,7 @@
 }
 #endif
 
-static ssize_t do_write_mem(struct file * file, void *p, unsigned long realp,
+static ssize_t do_write_mem(void *p, unsigned long realp,
 			    const char * buf, size_t count, loff_t *ppos)
 {
 	ssize_t written;
@@ -171,7 +171,7 @@
 
 	if (!valid_phys_addr_range(p, &count))
 		return -EFAULT;
-	return do_write_mem(file, __va(p), p, buf, count, ppos);
+	return do_write_mem(__va(p), p, buf, count, ppos);
 }
 
 static int mmap_mem(struct file * file, struct vm_area_struct * vma)
@@ -282,7 +282,9 @@
 		if (count > (unsigned long) high_memory - p)
 			wrote = (unsigned long) high_memory - p;
 
-		wrote = do_write_mem(file, (void*)p, p, buf, wrote, ppos);
+		wrote = do_write_mem((void*)p, p, buf, wrote, ppos);
+		if (wrote < 0)
+			return wrote;
 
 		p += wrote;
 		buf += wrote;

--Boundary-00=_iX2UArXpowtJjYN--

