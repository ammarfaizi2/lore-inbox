Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271809AbRIMPtQ>; Thu, 13 Sep 2001 11:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271810AbRIMPtG>; Thu, 13 Sep 2001 11:49:06 -0400
Received: from pop.gmx.de ([213.165.64.20]:30591 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S271809AbRIMPst>;
	Thu, 13 Sep 2001 11:48:49 -0400
Message-ID: <3BA0D2BA.8B972B51@gmx.de>
Date: Thu, 13 Sep 2001 17:37:30 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        vojtech@ucw.cz, Hamera Erik <HAMERAE@cs.felk.cvut.cz>
Subject: Re: Booting linux using Novell NetWare Remote Program Loader
In-Reply-To: <20010909220921.A19145@bug.ucw.cz> <20010909170206.A3245@redhat.com> <20010909230920.A23392@atrey.karlin.mff.cuni.cz> <9nh5p0$3qt$1@cesium.transmeta.com> <20010911005318.C822@bug.ucw.cz> <3BA04514.D65EDF98@gmx.de> <20010913120706.C25204@atrey.karlin.mff.cuni.cz>
Content-Type: multipart/mixed;
 boundary="------------E4B8CE9ADBC36EB01B80FE59"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E4B8CE9ADBC36EB01B80FE59
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> 
> > I removed the autoprobing from bootsect.S and fixed it to 1.44MB format
> > et voila, it worked perfectly.
> 
> Do you have patch to do that?

I have a patch for 2.0.x only.  But it should be enough to change the
disksizes table at the end of bootsect.S to:

disksizes: .byte 18,18,18,18

Ciao, ET.
--------------E4B8CE9ADBC36EB01B80FE59
Content-Type: text/plain; charset=us-ascii;
 name="boot-diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot-diff"

--- /usr/src/2.0.36/arch/i386/boot/bootsect.S	Sat Mar  9 12:31:42 1996
+++ /tmp/q/bootsect.S	Thu Aug 23 21:42:20 2001
@@ -102,6 +102,7 @@
 
 ! cx contains 0 from rep movsw above
 
+#if 0 /* ET: let the DPT alone */
 	mov	fs,cx
 	mov	bx,#0x78		! fs:bx is parameter table address
 	push	ds
@@ -124,6 +125,7 @@
 	mov	(bx),di
 	seg fs
 	mov	2(bx),es
+#endif
 
 ! load the setup-sectors directly after the bootblock.
 ! Note that 'es' is already set up.
@@ -170,6 +172,7 @@
 ! 36 sectors if sector 36 can be read, 18 sectors if sector 18 can be read,
 ! 15 if sector 15 can be read.  Otherwise guess 9.
 
+#if 0 /* ET: no autoprobing.  asume 1.44mb disk */
 	mov	si,#disksizes		! table of sizes to try
 
 probe_loop:
@@ -187,6 +190,7 @@
 	mov	ax,#0x0201		! service 2, 1 sector
 	int	0x13
 	jc	probe_loop		! try next value
+#endif
 
 #endif
 
@@ -438,10 +442,12 @@
 	ret
 
 sectors:
-	.word 0
+	.word 18
 
+#if 0 /* ET: no autoprobing.  fixed at 18 sectors */
 disksizes:
 	.byte 36,18,15,9
+#endif
 
 msg1:
 	.byte 13,10

--------------E4B8CE9ADBC36EB01B80FE59--


