Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRAYQj7>; Thu, 25 Jan 2001 11:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129780AbRAYQju>; Thu, 25 Jan 2001 11:39:50 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:19469 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129101AbRAYQjo>;
	Thu, 25 Jan 2001 11:39:44 -0500
Date: Thu, 25 Jan 2001 17:38:37 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: bbp@via.ecp.fr
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linuxconsole-dev@lists.sourceforge.net
Subject: Fwd: bug report for matroxfb
Message-ID: <20010125173837.A14013@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
  I got following bugreport for matroxfb:

On 25 Jan 01 at 16:51, Brieuc Jeunhomme wrote:

> Hi ! I'm not sure you are the right person to report this problem,
> please excuse me if you aren't. I have noticed that the driver does not
> display the proper number of spaces when printing the second tabulation
> of the file I send in attachement with a simple cat command. It is not a
> bug of cat, because I had the same problem with a dummy program which
> 
> And the resolution is 200x75. I hope this may help.

Code inspection found that tab_stop[] array has only 160 elements, instead
of needed 200...

Do you see any reason why not apply this patch? This extends vc_tab_stop[]
array from 5x32 bits to 8x32 bits - 256 columns should be enough, as
some kernel parts use only 8bit for column number, so anything wider than
255 does not work reasonable anyway.

Patch was generated from 2.4.0-ac9, but should work also with other versions
(namely 2.4.1-pre10). And even without this patch we need some fixing,
as Esc...g (set tabstop) can modify palette instead of tabstops for
columns >160 :-(

This patch has one problem - it changes size of vc_data struct, so kernels
before patch and after patch are not binary compatible in console subsystem.
						Thanks,
							Petr Vandrovec
							vandrove@vc.cvut.cz


diff -urdN linux/drivers/char/console.c linux/drivers/char/console.c
--- linux/drivers/char/console.c	Mon Jan 15 11:13:24 2001
+++ linux/drivers/char/console.c	Thu Jan 25 16:20:59 2001
@@ -1411,7 +1411,10 @@
 	tab_stop[1]	=
 	tab_stop[2]	=
 	tab_stop[3]	=
-	tab_stop[4]	= 0x01010101;
+	tab_stop[4]	=
+	tab_stop[5]	=
+	tab_stop[6]	=
+	tab_stop[7]	= 0x01010101;
 
 	bell_pitch = DEFAULT_BELL_PITCH;
 	bell_duration = DEFAULT_BELL_DURATION;
@@ -1689,7 +1692,10 @@
 					tab_stop[1] =
 					tab_stop[2] =
 					tab_stop[3] =
-					tab_stop[4] = 0;
+					tab_stop[4] =
+					tab_stop[5] =
+					tab_stop[6] =
+					tab_stop[7] = 0;
 			}
 			return;
 		case 'm':
diff -urdN linux/include/linux/console_struct.h linux/include/linux/console_struct.h
--- linux/include/linux/console_struct.h	Mon Oct 16 19:53:18 2000
+++ linux/include/linux/console_struct.h	Thu Jan 25 16:19:59 2001
@@ -68,7 +68,7 @@
 	unsigned char	vc_utf		: 1;	/* Unicode UTF-8 encoding */
 	unsigned char	vc_utf_count;
 		 int	vc_utf_char;
-	unsigned int	vc_tab_stop[5];		/* Tab stops. 160 columns. */
+	unsigned int	vc_tab_stop[8];		/* Tab stops. 256 columns. */
 	unsigned char   vc_palette[16*3];       /* Colour palette for VGA+ */
 	unsigned short * vc_translate;
 	unsigned char 	vc_G0_charset;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
