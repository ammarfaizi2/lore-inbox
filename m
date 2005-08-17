Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVHQQOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVHQQOH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 12:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVHQQOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 12:14:07 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:64778 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1751153AbVHQQOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 12:14:06 -0400
Message-ID: <43036243.5070100@rainbow-software.org>
Date: Wed, 17 Aug 2005 18:13:55 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_tic-45637-1124295239-0001-2"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: FPU-intensive programs crashing with floating point exception on
 Cyrix MII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_tic-45637-1124295239-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

My machine (Cyrix MII PR300 CPU, PCPartner TXB820DS board with i430TX 
chipset) exhibits a really weird problem:
When I run a program that uses FPU, it sometimes crashes with "flaoting 
point exception" - for example, when playing MP3 files using any player. 
Or with Prime95 - http://www.mersenne.org/freesoft.htm - the "torture 
test" does not crash but shows "fatal error" in less than 10 minutes.
It might be something like this:
http://lists.suse.com/archive/suse-linux-e/2000-Sep/1080.html
or this
http://lists.slug.org.au/archives/slug/2000/11/msg00343.html

The problem appears on 2.4.x kernels and 2.6.x kernels. It works fine in 
Windows 98 - it can play MP3s and run Prime95 for hours without any 
problems.
I've tracked it down to math_error() in arch/i386/kernel/traps.c and 
"fixed" it (I really don't know anything about FPU programming). The 
patch is attached. It fixes my system - with the patch, I can play MP3s 
fine and Prime95 runs without any problems too.

Does anyone know why these exceptions happen and/or what's the correct 
solution?

-- 
Ondrej Zary


--=_tic-45637-1124295239-0001-2
Content-Type: text/plain; name="cyrix-math.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cyrix-math.patch"

--- linux-2.6.10/arch/i386/kernel/traps.c~	2004-12-25 12:02:03.000000000 +0100
+++ linux-2.6.10/arch/i386/kernel/traps.c	2004-12-25 12:02:03.000000000 +0100
@@ -790,8 +790,11 @@
 	 */
 	cwd = get_fpu_cwd(task);
 	swd = get_fpu_swd(task);
+	printk("MATH ERROR %d\n",((~cwd) & swd & 0x3f) | (swd & 0x240));
 	switch (((~cwd) & swd & 0x3f) | (swd & 0x240)) {
-		case 0x000:
+		case 0x000: /* Hack for Cyrix problems */
+		case 0x200:
+			return;                                
 		default:
 			break;
 		case 0x001: /* Invalid Op */

--=_tic-45637-1124295239-0001-2--
