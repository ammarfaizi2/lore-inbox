Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268560AbRHFOua>; Mon, 6 Aug 2001 10:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268675AbRHFOuV>; Mon, 6 Aug 2001 10:50:21 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:46726 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S268560AbRHFOuM>; Mon, 6 Aug 2001 10:50:12 -0400
Date: Mon, 6 Aug 2001 16:48:47 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mark Hemment <markhe@veritas.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Molnar <mingo@chiara.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: booting SMP P6 kernel on P4 hangs.
In-Reply-To: <Pine.LNX.4.33.0108031140410.26125-200000@alloc.wat.veritas.com>
Message-ID: <Pine.GSO.3.96.1010806161212.14836C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Mark Hemment wrote:

>   The problem is the MP table contains no configuration blocks, and a zero
> local APIC address.  I've attached the full boot messages.
> 
>   The work around is trap that there are no config blocks, and fall back
> to UP.  Patch attached.

 The following patch should be better -- all the handling is performed at
the table parsing stage as it should.  Could you please test it?  It
applies to -ac7 cleanly as well. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.7-null_apic-4
diff -up --recursive --new-file linux-2.4.7.macro/arch/i386/kernel/mpparse.c linux-2.4.7/arch/i386/kernel/mpparse.c
--- linux-2.4.7.macro/arch/i386/kernel/mpparse.c	Thu Jul  5 12:21:27 2001
+++ linux-2.4.7/arch/i386/kernel/mpparse.c	Mon Aug  6 10:16:54 2001
@@ -273,24 +273,26 @@ static int __init smp_read_mpc(struct mp
 	int count=sizeof(*mpc);
 	unsigned char *mpt=((unsigned char *)mpc)+count;
 
-	if (memcmp(mpc->mpc_signature,MPC_SIGNATURE,4))
-	{
+	if (memcmp(mpc->mpc_signature,MPC_SIGNATURE,4)) {
 		panic("SMP mptable: bad signature [%c%c%c%c]!\n",
 			mpc->mpc_signature[0],
 			mpc->mpc_signature[1],
 			mpc->mpc_signature[2],
 			mpc->mpc_signature[3]);
-		return 1;
+		return 0;
 	}
-	if (mpf_checksum((unsigned char *)mpc,mpc->mpc_length))
-	{
+	if (mpf_checksum((unsigned char *)mpc,mpc->mpc_length)) {
 		panic("SMP mptable: checksum error!\n");
-		return 1;
+		return 0;
 	}
-	if (mpc->mpc_spec!=0x01 && mpc->mpc_spec!=0x04)
-	{
-		printk("Bad Config Table version (%d)!!\n",mpc->mpc_spec);
-		return 1;
+	if (mpc->mpc_spec!=0x01 && mpc->mpc_spec!=0x04) {
+		printk(KERN_ERR "SMP mptable: bad table version (%d)!!\n",
+			mpc->mpc_spec);
+		return 0;
+	}
+	if (!mpc->mpc_lapic) {
+		printk(KERN_ERR "SMP mptable: null local APIC address!\n");
+		return 0;
 	}
 	memcpy(str,mpc->mpc_oem,8);
 	str[8]=0;
@@ -358,6 +360,8 @@ static int __init smp_read_mpc(struct mp
 			}
 		}
 	}
+	if (!num_processors)
+		printk(KERN_ERR "SMP mptable: no processors registered!\n");
 	return num_processors;
 }
 
@@ -508,8 +512,12 @@ void __init get_smp_config (void)
 		 * Read the physical hardware table.  Anything here will
 		 * override the defaults.
 		 */
-		smp_read_mpc((void *)mpf->mpf_physptr);
-
+		if (!smp_read_mpc((void *)mpf->mpf_physptr)) {
+			smp_found_config = 0;
+			printk(KERN_ERR "BIOS bug, MP table errors detected!...\n");
+			printk(KERN_ERR "... disabling SMP support. (tell your hw vendor)\n");
+			return;
+		}
 		/*
 		 * If there are no explicit MP IRQ entries, then we are
 		 * broken.  We set up most of the low 16 IO-APIC pins to

