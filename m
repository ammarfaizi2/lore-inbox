Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314690AbSEMXdf>; Mon, 13 May 2002 19:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314705AbSEMXde>; Mon, 13 May 2002 19:33:34 -0400
Received: from admin.nni.com ([216.107.0.51]:52494 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S314690AbSEMXdd>;
	Mon, 13 May 2002 19:33:33 -0400
Date: Mon, 13 May 2002 19:33:01 -0400
From: Andrew Rodland <lkml@hobbs.linuxguru.net>
To: linux-kernel@vger.kernel.org
Subject: Overlapping MTRRs
Message-Id: <20020513193301.20a018bc.lkml@hobbs.linuxguru.net>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.ddI9g8pe(y:tPR"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.ddI9g8pe(y:tPR
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__13_May_2002_19:33:01_-0400_08292898"


--Multipart_Mon__13_May_2002_19:33:01_-0400_08292898
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Questions, and answer.

First: Is it true what I here that MTRRs are getting a complete overhaul
for 2.5? If so, I'll probably just quit where I'm at now.

Anyway, I've got vesafb creating a WC MTRR at 0xf9000000, size 0x200000.
Then X goes and tries to create another (same type) at xf9000000 with
size 0x400000. With the standard code, it fails.

It looks to me that the code that's there was *supposed* to handle such
simple overlap cases, but it kinda doesn't.

So I wrote a patch for handling MTRRs. It's way oversimplified, but it
does the right thing in quite a few simple cases, so it might help some
other people who've got a problem similar to mine.

It has some limitations, especially, that it doesn't do any magic on
removes. I've been thinking on how to do this "right", and although it's
not *too* complicated, it's pretty hard anyway. I might try it, but if
someone else is working on it, I'll trust them over me. I'm no real
kernel hacker. ;)

Anyway, patch is inlined after the message. You probably want to apply
it with -p1. It should apply cleanly on all recent 2.4. It comes up with
30some lines of offset on 2.4.19pre7ac4 (which I'm running now), but
it's harmless.

--Andrew ("hobbs" on IRC) Rodland

P.S. I sent this to rgooch a while back, and got no reply. Dunno whether
he hated it or he was just busy, but I'm lettin' the world know this
time.


--- linux/arch/i386/kernel/mtrr.c	Fri Nov  9 16:58:02 2001
+++ linux-2.4.18+hobbs/arch/i386/kernel/mtrr.c	Sat Mar  9 23:12:18 2002
@@ -1222,8 +1222,11 @@
     [NOTE] This routine uses a spinlock.
 */
     int i, max;
+	 int ret;
     mtrr_type ltype;
     unsigned long lbase, lsize, last;
+	
+
 
     switch ( mtrr_if )
     {
@@ -1337,7 +1340,27 @@
 	    printk (KERN_WARNING "mtrr: 0x%lx000,0x%lx000 overlaps
existing" 		    " 0x%lx000,0x%lx000\n",
 		    base, size, lbase, lsize);
-	    return -EINVAL;
+		 if ( type == ltype ) {
+			 ret=-42;
+			 if (base < lbase) {
+				 printk (KERN_INFO "mtrr: creating new
0x%lx000,0x%lx000\n",base,lbase-base);+				
ret=mtrr_add_page(base, lbase-base, type, 0);+			 }
+			 if (base + size > lbase + lsize) {
+				 printk (KERN_INFO "mtrr: creating new
0x%lx000,0x%lx000\n",lbase+lsize,base+size-lbase-lsize);+				
ret=mtrr_add_page(lbase+lsize,base+size-lbase-lsize, type, 0);+			
}+			 if (ret == -42) {
+				 printk (KERN_INFO "mtrr: it must have been
contained.\n");+				 return i;
+			 }
+			 /* Okay, so it DID create a new one. */
+			 return ret;
+		 } else {
+			 printk (KERN_WARNING "mtrr: type mismatch (old: %s new: %s),
giving up.\n",+					 attrib_to_str(ltype),attrib_to_str(type));
+			 return -EINVAL;
+		 }
 	}
 	/*  New region is enclosed by an existing region  */
 	if (ltype != type)

--Multipart_Mon__13_May_2002_19:33:01_-0400_08292898
Content-Type: application/pgp-signature;
 name="00000000.mimetmp"
Content-Disposition: attachment;
 filename="00000000.mimetmp"
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuMC42IChHTlUv
TGludXgpCgppRDhEQlFFODM1Z3lRM01XWHhkd3ZWd1JBbzRCQUo5aGE5SVVrdmRDQjdrcklCZTNw
VWhmM3g1VHVRQ2ZVZCtiCnBYUkluWkJxaGZtcHZmQjMrZ3h2eGxJPQo9ZnBNeAotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0KDQo=

--Multipart_Mon__13_May_2002_19:33:01_-0400_08292898--

--=.ddI9g8pe(y:tPR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE84E0yQ3MWXxdwvVwRAjcwAJ9EtxzN21KzFxZxmxO1/pkQNBwusACfTcLu
yB0Qf4Q19dtpje0zLCBS6mk=
=CtzZ
-----END PGP SIGNATURE-----

--=.ddI9g8pe(y:tPR--

