Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132861AbQLJCcJ>; Sat, 9 Dec 2000 21:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132860AbQLJCcA>; Sat, 9 Dec 2000 21:32:00 -0500
Received: from smtp1.ihug.co.nz ([203.109.252.7]:64018 "EHLO smtp1.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S132859AbQLJCbu>;
	Sat, 9 Dec 2000 21:31:50 -0500
Message-ID: <3A32E3D5.915481C3@ihug.co.nz>
Date: Sun, 10 Dec 2000 15:00:53 +1300
From: Gerard Sharp <gsharp@ihug.co.nz>
Reply-To: gsharp@ihug.co.nz
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] modutils 2.3.22 and kernel 2.4.0-test12-pre7
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I just upgraded to both of the above (from .21 and and test11-ac4
respectively); and 8139too.o and ntfs.o both failled to insmod;

insmod: /lib/modules/2.4.0-test12/kernel/fs/ntfs/ntfs.o
: symbol for parameter ntdebug not found

the problem in both cases appears to be a MODULE_PARM refering to a
symbol that doesn't exist (because the symbol has been #define'd out)

The following patch addresses this by bracketing the MODULE_PARM's with
#ifdef / #endif

There may be more files affected; I don't have time to go hunting :(

=== ntfs_nic.patch ===
diff -dur linux-2.4.0-test12-clean/drivers/net/8139too.c
linux-2.4.0-test12-fixe
d/drivers/net/8139too.c
--- linux-2.4.0-test12-clean/drivers/net/8139too.c      Sun Dec 10
12:55:42 2000
+++ linux-2.4.0-test12-fixed/drivers/net/8139too.c      Sun Dec 10
14:45:20 2000
@@ -74,6 +74,8 @@

                Tobias Ringström - Rx interrupt status checking
suggestion

+               Gerard Sharp - bug fix for MODULE_PARM
+
        Submitting bug reports:

                "rtl8139-diag -mmmaaavvveefN" output
@@ -536,7 +538,9 @@
 MODULE_DESCRIPTION ("RealTek RTL-8139 Fast Ethernet driver");
 MODULE_PARM (multicast_filter_limit, "i");
 MODULE_PARM (max_interrupt_work, "i");
+#ifdef RTL8139_DEBUG
 MODULE_PARM (debug, "i");
+#endif /*RTL8139_DEBUG*/
 MODULE_PARM (media, "1-" __MODULE_STRING(8) "i");

 static int read_eeprom (void *ioaddr, int location, int addr_len);
diff -dur linux-2.4.0-test12-clean/fs/ntfs/fs.c
linux-2.4.0-test12-fixed/fs/ntfs
/fs.c
--- linux-2.4.0-test12-clean/fs/ntfs/fs.c       Sun Dec 10 12:55:47 2000
+++ linux-2.4.0-test12-fixed/fs/ntfs/fs.c       Sun Dec 10 14:43:35 2000
@@ -963,9 +963,10 @@
 EXPORT_NO_SYMBOLS;
 MODULE_AUTHOR("Martin von Löwis");
 MODULE_DESCRIPTION("NTFS driver");
+#ifdef DEBUG
 MODULE_PARM(ntdebug, "i");
 MODULE_PARM_DESC(ntdebug, "Debug level");
-
+#endif /*DEBUG*/
+
 module_init(init_ntfs_fs)
 module_exit(exit_ntfs_fs)
 /*
=== ===


Good Day and Happy Hacking
Gerard Sharp
Two Penguins at 1024x768
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
