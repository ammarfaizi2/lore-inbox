Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWDWUYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWDWUYb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 16:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWDWUYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 16:24:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63118 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750932AbWDWUYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 16:24:30 -0400
Date: Sun, 23 Apr 2006 16:24:28 -0400
From: Dave Jones <davej@redhat.com>
To: Yum Rayan <yum.rayan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] VBE DDC bios call stalls boot
Message-ID: <20060423202428.GC14680@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Yum Rayan <yum.rayan@gmail.com>, linux-kernel@vger.kernel.org
References: <df35dfeb0604231208x416b7ab0ya612d918bb239140@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df35dfeb0604231208x416b7ab0ya612d918bb239140@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2006 at 12:08:27PM -0700, Yum Rayan wrote:

 > There is a bios call to check if read EDID is supported. My first
 > thought was that before doing read EDID, video.S should first check to
 > see if the hardware supports the read EDID feature. Unfortunately that
 > bios call too ends up in the woods until I physically
 > disconnect/reconnect my CPU video output that feeds into the KVM.

Is this how your patch looked when you tried this ?

		Dave

--- linux-2.6.15/arch/i386/boot/video.S~	2006-01-06 01:26:06.000000000 -0500
+++ linux-2.6.15/arch/i386/boot/video.S	2006-01-06 01:28:40.000000000 -0500
@@ -1951,9 +1951,18 @@ store_edid:
 	stosl
 
 	movw	$0x4f15, %ax                    # do VBE/DDC
-	movw	$0x01, %bx
+	movw	$0x00, %bx                      # INSTALLATION CHECK / CAPABILITIES
 	movw	$0x00, %cx
-	movw    $0x00, %dx
+	movw	$0x00, %dx
+	movw	$0x140, %di
+	int		$0x10
+	cmpb	$0x01, %ah
+	je		no_edid
+
+	movw	$0x4f15, %ax                    # do VBE/DDC
+	movw	$0x01, %bx                      # READ_EDID
+	movw	$0x00, %cx
+	movw	$0x00, %dx
 	movw	$0x140, %di
 	int	$0x10
 
--- linux-2.6.15/arch/i386/boot/video.S~	2006-01-06 02:55:20.000000000 -0500
+++ linux-2.6.15/arch/i386/boot/video.S	2006-01-06 02:55:28.000000000 -0500
@@ -1966,6 +1966,7 @@ store_edid:
 	movw	$0x140, %di
 	int	$0x10
 
+no_edid:
 	popw	%di				# restore all registers
 	popw	%dx
 	popw	%cx

-- 
http://www.codemonkey.org.uk
