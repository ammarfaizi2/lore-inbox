Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261933AbTCLUbZ>; Wed, 12 Mar 2003 15:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261937AbTCLUbZ>; Wed, 12 Mar 2003 15:31:25 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:41889 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S261933AbTCLUbY>;
	Wed, 12 Mar 2003 15:31:24 -0500
Date: Wed, 12 Mar 2003 23:41:14 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl,
       torvalds@transmeta.com
Subject: Memleak in driver for the Specialix SX series cards.
Message-ID: <20030312204114.GA28438@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    I see there is a memleak in driver for the Specialix SX series cards
    on error exit path in sx_fw_ioctl() (both in 2.4 and 2.5).
    See the patch.
    Found with help of smatch + unfree script.

Bye,
    Oleg

===== drivers/char/sx.c 1.13 vs edited =====
--- 1.13/drivers/char/sx.c	Fri Nov  8 21:16:55 2002
+++ edited/drivers/char/sx.c	Wed Mar 12 23:38:33 2003
@@ -1734,8 +1734,10 @@
 				if (copy_from_user(tmp, (char *)data + i, 
 						   (i + SX_CHUNK_SIZE >
 						    nbytes) ? nbytes - i :
-						   	      SX_CHUNK_SIZE))
+						   	      SX_CHUNK_SIZE)) {
+					kfree (tmp);
 					return -EFAULT;
+				}
 				memcpy_toio    ((char *) (board->base2 + offset + i), tmp, 
 				                (i+SX_CHUNK_SIZE>nbytes)?nbytes-i:SX_CHUNK_SIZE);
 			}
