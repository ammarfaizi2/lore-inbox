Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUFCKNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUFCKNi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 06:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUFCKNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 06:13:38 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:56327 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262538AbUFCKN2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 06:13:28 -0400
Date: Thu, 3 Jun 2004 20:13:13 +1000
To: len.brown@intel.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [APIC] Avoid change apic_id failure panic
Message-ID: <20040603101313.GB6578@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

I've received two reports at http://bugs.debian.org/251207 where
ioapic caused machines to lock up during booting due to the
change apic_id panic in arch/i386/kernel/io_apic.c.

Since it appears that we can avoid panicking at all, I think we
should replace the panic calls with the following patch which
attempts to continue after the failure.

I've also done the same thing to the other panic() call in the
same function.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/21 23:24:33+10:00 herbert@gondor.apana.org.au 
#   [APIC] Avoid panic in io_apic_get_unique_id.
# 
# arch/i386/kernel/mpparse.c
#   2004/05/21 23:24:02+10:00 herbert@gondor.apana.org.au +9 -2
#   Avoid panic in io_apic_get_unique_id.
# 
# arch/i386/kernel/io_apic.c
#   2004/05/21 23:24:02+10:00 herbert@gondor.apana.org.au +12 -7
#   Avoid panic in io_apic_get_unique_id.
# 
diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	2004-06-03 20:02:42 +10:00
+++ b/arch/i386/kernel/io_apic.c	2004-06-03 20:02:42 +10:00
@@ -2365,8 +2365,10 @@
 				break;
 		}
 
-		if (i == IO_APIC_MAX_ID)
-			panic("Max apic_id exceeded!\n");
+		if (i == IO_APIC_MAX_ID) {
+			printk(KERN_ERR "Max apic_id exceeded!\n");
+			return -1;
+		}
 
 		printk(KERN_WARNING "IOAPIC[%d]: apic_id %d already used, "
 			"trying %d\n", ioapic, apic_id, i);
@@ -2374,9 +2376,6 @@
 		apic_id = i;
 	} 
 
-	tmp = apicid_to_cpu_present(apic_id);
-	physids_or(apic_id_map, apic_id_map, tmp);
-
 	if (reg_00.bits.ID != apic_id) {
 		reg_00.bits.ID = apic_id;
 
@@ -2386,9 +2385,15 @@
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 
 		/* Sanity check */
-		if (reg_00.bits.ID != apic_id)
-			panic("IOAPIC[%d]: Unable change apic_id!\n", ioapic);
+		if (reg_00.bits.ID != apic_id) {
+			printk(KERN_ERR "IOAPIC[%d]: Unable change apic_id!\n",
+			       ioapic);
+			return -1;
+		}
 	}
+
+	tmp = apicid_to_cpu_present(apic_id);
+	physids_or(apic_id_map, apic_id_map, tmp);
 
 	printk(KERN_INFO "IOAPIC[%d]: Assigned apic_id %d\n", ioapic, apic_id);
 
diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	2004-06-03 20:02:41 +10:00
+++ b/arch/i386/kernel/mpparse.c	2004-06-03 20:02:41 +10:00
@@ -881,6 +881,7 @@
 	u32			gsi_base)
 {
 	int			idx = 0;
+	int			apicid;
 
 	if (nr_ioapics >= MAX_IO_APICS) {
 		printk(KERN_ERR "ERROR: Max # of I/O APICs (%d) exceeded "
@@ -893,14 +894,19 @@
 		return;
 	}
 
-	idx = nr_ioapics++;
+	idx = nr_ioapics;
 
 	mp_ioapics[idx].mpc_type = MP_IOAPIC;
 	mp_ioapics[idx].mpc_flags = MPC_APIC_USABLE;
 	mp_ioapics[idx].mpc_apicaddr = address;
 
 	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
-	mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
+	apicid = io_apic_get_unique_id(idx, id);
+	if (apicid < 0) {
+		clear_fixmap(FIX_IO_APIC_BASE_0 + idx);
+		return;
+	}
+	mp_ioapics[idx].mpc_apicid = apicid;
 	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);
 	
 	/* 
@@ -912,6 +918,7 @@
 	mp_ioapic_routing[idx].gsi_end = gsi_base + 
 		io_apic_get_redir_entries(idx);
 
+	nr_ioapics++;
 	printk("IOAPIC[%d]: apic_id %d, version %d, address 0x%lx, "
 		"GSI %d-%d\n", idx, mp_ioapics[idx].mpc_apicid, 
 		mp_ioapics[idx].mpc_apicver, mp_ioapics[idx].mpc_apicaddr,

--VbJkn9YxBvnuCH5J--
