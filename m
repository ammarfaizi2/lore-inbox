Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279824AbRKAWjl>; Thu, 1 Nov 2001 17:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279829AbRKAWjb>; Thu, 1 Nov 2001 17:39:31 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:27155 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S279824AbRKAWjR>;
	Thu, 1 Nov 2001 17:39:17 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Sven Heinicke <sven@research.nj.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: undefined reference in 2.2.19 build with Reiserfs (was: Google's mm problem - not reproduced on 2.4.13) 
In-Reply-To: Your message of "Thu, 01 Nov 2001 11:56:04 CDT."
             <15329.32420.468485.681104@abasin.nj.nec.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 02 Nov 2001 09:39:05 +1100
Message-ID: <1180.1004654345@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001 11:56:04 -0500 (EST), 
Sven Heinicke <sven@research.nj.nec.com> wrote:
>fs/filesystems.a(reiserfs.o): In function `ip_check_balance':
>reiserfs.o(.text+0x9cc2): undefined reference to `memset'
>drivers/scsi/scsi.a(aic7xxx.o): In function `aic7xxx_load_seeprom':
>aic7xxx.o(.text+0x117ff): undefined reference to `memcpy'

The aic7xxx reference to memcpy is a gcc feature.  If you do an
assignment of a complete structure then gcc may convert that into a
call to memcpy().  Alas gcc does the conversion using the "standard"
version of memcpy, not the "optimized by cpp" version that the kernel
uses.  Try this patch

Index: 19.1/drivers/scsi/aic7xxx.c
--- 19.1/drivers/scsi/aic7xxx.c Tue, 13 Feb 2001 08:26:08 +1100 kaos (linux-2.2/d/b/43_aic7xxx.c 1.1.1.3.2.1.3.1.1.3 644)
+++ 19.1(w)/drivers/scsi/aic7xxx.c Fri, 02 Nov 2001 09:36:49 +1100 kaos (linux-2.2/d/b/43_aic7xxx.c 1.1.1.3.2.1.3.1.1.3 644)
@@ -9190,7 +9190,7 @@ aic7xxx_load_seeprom(struct aic7xxx_host
         p->flags |= AHC_TERM_ENB_SE_LOW | AHC_TERM_ENB_SE_HIGH;
       }
     }
-    p->sc = *sc;
+    memcpy(&(p->sc), sc, sizeof(p->sc));
   }
 
   p->discenable = 0;

Cannot help with the reiserfs problem, the code is not in the pristine
2.2.19 tree.

