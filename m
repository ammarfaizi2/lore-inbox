Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTKSC3f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 21:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263853AbTKSC3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 21:29:35 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:36284 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263823AbTKSC3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 21:29:34 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Date: Wed, 19 Nov 2003 13:29:29 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16314.54665.18373.588780@wombat.disy.cse.unsw.edu.au>
Subject: Why lock_kernel() in drivers/pci/proc.c (2.6.0-test9)??
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	What is the BKL protecting in
drivers/pci/proc.c:proc_bus_pci_lseek() ?

It looks useless to me, as file->f_pos is changed outside the lock
anyway, and all the other variables inside the locked region are
effectively constants for the purpose of this code.

So unless something subtle's going on, I suggest this:



--- linux-2.6.0-test9/drivers/pci/proc.c 2003-11-19 13:28:10.000000000 +1100
+++ new/drivers/pci/proc.c	2003-11-19 13:28:00.000000000 +1100
@@ -25,7 +25,6 @@
 {
 	loff_t new = -1;
 
-	lock_kernel();
 	switch (whence) {
 	case 0:
 		new = off;
@@ -37,7 +36,7 @@
 		new = PCI_CFG_SPACE_SIZE + off;
 		break;
 	}
-	unlock_kernel();
+
 	if (new < 0 || new > PCI_CFG_SPACE_SIZE)
 		return -EINVAL;
	return (file->f_pos = new);
