Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272370AbRIKKB5>; Tue, 11 Sep 2001 06:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272357AbRIKKBr>; Tue, 11 Sep 2001 06:01:47 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:54024 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S272371AbRIKKB2>; Tue, 11 Sep 2001 06:01:28 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Date: Tue, 11 Sep 2001 20:01:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15261.57578.370849.948314@notabene.cse.unsw.edu.au>
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: nfs is stupid ("getfh failed")
In-Reply-To: message from Jamie Lokier on Tuesday September 11
In-Reply-To: <002b01c136e1$3bb36a80$81d4870a@cartman>
	<20010907025947.E7329@kushida.degree2.com>
	<15261.47090.893483.500877@notabene.cse.unsw.edu.au>
	<20010911105532.A20301@kushida.degree2.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday September 11, lk@tantalophile.demon.co.uk wrote:
> 
> Yes, I'm doing the second of those.  No alternative -- I need write
> access from some hosts, and read access to all the rest (who are
> dynamically allocated) on the subnet.
> 
> It's clearly a bug in the NFS server then.

Actually, it's a bug in nfs-utils, that I have a patch for, but
haven't got arround to commiting it to the CVS on sourceforge yet.

NeilBrown


Index: utils/mountd/auth.c
===================================================================
RCS file: /cvsroot/nfs/nfs-utils/utils/mountd/auth.c,v
retrieving revision 1.6
diff -u -r1.6 auth.c
--- utils/mountd/auth.c	2000/11/27 23:46:35	1.6
+++ utils/mountd/auth.c	2001/07/24 10:38:37
@@ -78,20 +78,10 @@
 	}
 	auth_fixpath(path);
 
-	/* First try it w/o doing a hostname lookup... */
-	*hpp = get_hostent((const char *)&addr, sizeof(addr), AF_INET);
-	exp = export_find(*hpp, path);
-
-	if (!exp) {
-	    /* Ok, that didn't fly.  Try it with a reverse lookup. */
-	    free (*hpp);
-	    *hpp = gethostbyaddr((const char *)&addr, sizeof(addr),
-				 AF_INET);
-	    if (!(*hpp)) {
-		*error = no_entry;
-		*hpp = get_hostent((const char *)&addr, sizeof(addr), AF_INET);
-		return NULL;
-	    } else {
+	if (!(*hpp = gethostbyaddr((const char *)&addr, sizeof(addr), AF_INET)))
+		*hpp = get_hostent((const char *)&addr, sizeof(addr),
+				   AF_INET);
+	else {
 		/* must make sure the hostent is authorative. */
 		char **sp;
 		struct hostent *forward = NULL;
@@ -123,14 +113,12 @@
 			*error = no_forward_dns;
 			return NULL;
 		}
-	    }
+	}
 
-	    if (!(exp = export_find(*hpp, path))) {
+	if (!(exp = export_find(*hpp, path))) {
 		*error = no_entry;
 		return NULL;
-	    }
 	}
-
 	if (!exp->m_mayexport) {
 		*error = not_exported;
 		return NULL;

