Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbUK0CLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbUK0CLy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbUK0CLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:11:19 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262791AbUKZThT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:37:19 -0500
Message-Id: <200411250842.iAP8gC6U011822@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc2-mm3-V0.7.31-3 memory leak (was Re: Debugging a memory leak
In-Reply-To: Your message of "Tue, 23 Nov 2004 15:38:58 PST."
             <20041123153858.6df49fde.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <200411231929.iANJTe4w031449@turing-police.cc.vt.edu>
            <20041123153858.6df49fde.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1291614600P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Nov 2004 03:42:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1291614600P
Content-Type: text/plain; charset=us-ascii

On Tue, 23 Nov 2004 15:38:58 PST, Andrew Morton said:
> Valdis.Kletnieks@vt.edu wrote:
> >
> > Any advice how to shoot this one?
> 
> Manfred's slab leak detector:

Ahh, many thanks - that helped quite a bit.  I tracked down the problem -
it was in Ingo's VP patch.

sys_ioperm() would allocate an 8K bitmap and save it in ->io_bitmap_ptr.
Then when we hit exit_thread(), Ingo's code would zero the pointer and *then*
pass the freshly-zero'ed pointer to kfree() - which of course did nothing
particularly interesting.  My fix was to save a copy of the pointer to
pass to kfree.  Am seeing no more leaks.

(Interestingly enough, I'd never have spotted this if it hadn't been for
a gkrellm/i8krellm bug that caused a fork-bomb of 50 or so 'i8kfan' processes
each time it trimmed the fan speed, and each i8kfan leaked an 8K io_bitmap...)

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

--- linux-2.6.10-rc2-mm3/arch/i386/kernel/process.c.memleak	2004-11-25 00:25:42.000000000 -0500
+++ linux-2.6.10-rc2-mm3/arch/i386/kernel/process.c	2004-11-25 02:15:09.000000000 -0500
@@ -344,10 +344,11 @@ void exit_thread(void)
 	if (unlikely(NULL != t->io_bitmap_ptr)) {
 		int cpu;
 		struct tss_struct *tss;
+		unsigned long *bitmap_ptr_copy = t->io_bitmap_ptr;
 
 		t->io_bitmap_ptr = NULL;
 		mb();
-		kfree(t->io_bitmap_ptr);
+		kfree(bitmap_ptr_copy);
 
 		cpu = get_cpu();
 		tss = &per_cpu(init_tss, cpu);


--==_Exmh_1291614600P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBpZrjcC3lWbTT17ARAq61AKC6xVuUqV2Y66hC6cJ1lmHL9g70hwCdHayR
S+4GtvvbRTCOMpift8tYnD4=
=mBv+
-----END PGP SIGNATURE-----

--==_Exmh_1291614600P--
