Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWBYO03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWBYO03 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 09:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWBYO03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 09:26:29 -0500
Received: from mx5.mail.ru ([194.67.23.25]:18727 "EHLO mx5.mail.ru")
	by vger.kernel.org with ESMTP id S1030244AbWBYO02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 09:26:28 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: "Ghost" devices in /sys/firmware/edd
Date: Sat, 25 Feb 2006 17:26:21 +0300
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200602242214.46290.arvidjaar@mail.ru> <20060225050745.GA4796@lists.us.dell.com>
In-Reply-To: <20060225050745.GA4796@lists.us.dell.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602251726.23500.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 25 February 2006 08:07, Matt Domsch wrote:
[...]
> The code here is fine.  Immediately before the int13 is an stc
> instruction, so the carry flag is set.  sti and popw don't change CF.
> What this means is that your BIOS cleared CF in the int13 to a
> nonexistant disk, rather than setting CF (or leaving it unchanged).
> CF being clear means the command succeeded.  In your case, the BIOS
> cleared it, but shouldn't have.
>
> Care to share your system type / BIOS version, and if it's at all
> recent, file an bug with their support department?
>

This is Toshiba Portege 4000, BIOS 2.10 dated 15 Dec 2003. I'll try to find 
how to submit a bug report but I do not hold my breath.

[...]
>
> I'll look more next week, but what isn't ever happening is an int13
> AH=15h GET DISK TYPE probe to see if the disk is there.  The edd.S
> code just issue a READ SECTORS and expects that to fail (to set CF) if
> it's not there.  This has been working fine for most people.  In your
> case, it's not reporting a failure (CF is cleared by the int13).  Now,
> there's no guarantee your BIOS would respond properly to the GET DISK
> TYPE command either.  There are also notes that BIOS should set
> 0040h:0075h to the number of drives present, and the code isn't
> reading that value now either.  Either of these tests, if the BIOS
> isn't buggy for them, could result in reporting the right number of
> disks.
>

More simple solution may be the patch below. I am not sure if INT13 succeeded 
is always the same as status == 0; there appears to be at least one corner 
case 11h == "data ECC corrected". 

The patch fixed the issue here.

regards

- -andrey

Subject: [PATCH] Fix EDD to properly ignore signature of non-existing drives

From: Andrey Borzenkov <arvidjaar@mail.ru>

Some BIOSes do not always set CF on error before return from int13.
The patch adds additional check for status being zero (AH == 0).

Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>

- ---

 arch/i386/boot/edd.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/i386/boot/edd.S b/arch/i386/boot/edd.S
index d8d69f2..4b84ea2 100644
- --- a/arch/i386/boot/edd.S
+++ b/arch/i386/boot/edd.S
@@ -76,6 +76,8 @@ edd_mbr_sig_read:
 	popw	%es
 	popw	%bx
 	jc	edd_mbr_sig_done		# on failure, we're done.
+	cmpb	$0, %ah		# some BIOSes do not set CF
+	jne	edd_mbr_sig_done		# on failure, we're done.
 	movl	(EDDBUF+EDD_MBR_SIG_OFFSET), %eax # read sig out of the MBR
 	movl	%eax, (%bx)			# store success
 	incb	(EDD_MBR_SIG_NR_BUF)		# note that we stored something
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEAGkPR6LMutpd94wRAocYAJ4mRhgW0UOoK2+0bfQsh0+s1nUyIgCdGRrF
UCJpkIEPVEuUE2Gnfe7mG/Q=
=ij5i
-----END PGP SIGNATURE-----
