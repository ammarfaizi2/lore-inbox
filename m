Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264407AbTEJPws (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 11:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264410AbTEJPws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 11:52:48 -0400
Received: from [212.156.4.132] ([212.156.4.132]:3038 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id S264407AbTEJPwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 11:52:47 -0400
Date: Sat, 10 May 2003 19:04:28 +0300
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: linux-kernel@vger.kernel.org
Cc: mochel@osdl.org
Subject: [PATCH] 2.5.69: mtrr: MTRR 2 not used, Bug #564
Message-ID: <20030510160428.GA5415@ttnet.net.tr>
Mail-Followup-To: linux-kernel@vger.kernel.org, mochel@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: 15 C0 AA 31 59 F9 DE 4F 7D A6 C7 D8 A0 D5 67 73
X-PGP-Key-ID: 0x5C447959
X-PGP-Key-Size: 2048 bits
X-Editor: GNU Emacs 21.2.1
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one-liner fixes the mtrr not used bug, and addresses Bug #564
of Bugzilla.

mtrr_file_del was not decreasing the mtrr usage count so when
XFree86 was exiting, mtrr_close was trying to delete an already 
deleted memory type region with the freed mtrr.


Index: arch/i386/kernel/cpu/mtrr/if.c
===================================================================
RCS file: /home/faiku/cvs/linux-2.5/arch/i386/kernel/cpu/mtrr/if.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 if.c
--- arch/i386/kernel/cpu/mtrr/if.c      10 May 2003 07:06:50 -0000      1.1.1.1
+++ arch/i386/kernel/cpu/mtrr/if.c      10 May 2003 15:14:00 -0000
@@ -49,7 +49,7 @@
              struct file *file, int page)
 {
        int reg;
-       unsigned int *fcount = file->private_data;
+       unsigned int *fcount = FILE_FCOUNT(file);

        if (!page) {
                if ((base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1)))
