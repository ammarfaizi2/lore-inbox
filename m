Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWDXH11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWDXH11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 03:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWDXH11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 03:27:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:48857 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751039AbWDXH11 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 03:27:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N7Y9ZNBkSNBpAD6infZwQzIeIOpD50/B/jX1bkmqXV/asuSDEDHxDLxT7fzmN8iv/AelXVxatIjdLiNmpNaYWQbXwJ/MgE+NBcfQ2UKULvC69t6hVC0FbIiSvDQOWl1qeUhhKLDpZeBFirt7/vgAjKOqXapE7H0pk/X76VNHCvY=
Message-ID: <df35dfeb0604240027u799e1aafu2d86ebc8085ef379@mail.gmail.com>
Date: Mon, 24 Apr 2006 00:27:25 -0700
From: "Yum Rayan" <yum.rayan@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [RFC] VBE DDC bios call stalls boot
Cc: "Dave Jones" <davej@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <444C1211.8090505@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <df35dfeb0604231208x416b7ab0ya612d918bb239140@mail.gmail.com>
	 <20060423202428.GC14680@redhat.com> <444C1211.8090505@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is this how your patch looked when you tried this ?
>
> I've discovered that checking for availability does not give any added benefit,
> but this is the correct approach and I have to agree with this patch.

My patch was similar. I referenced
http://www.vesa.org/public/VBE/VBEDDC11.PDF. Differences were the
finer look up of the ambiguous status code and setting up ES:DI to be
NULL before call to INT 10h, as follows:

--- linux-2.6.15.4.a/arch/i386/boot/video.S	2006-02-09 23:22:48.000000000 -0800
+++ linux-2.6.15.4.b/arch/i386/boot/video.S	2006-04-24 00:07:08.000000000 -0700
@@ -1946,6 +1946,22 @@ store_edid:
 	rep
  	stosl

+	pushw	%es
+	movw	$0x4f15, %ax                    # report VBE/DDC capabilities
+	xorw	%bx, %bx
+	xorw	%cx, %cx
+	xorw	%di, %di
+	pushw	%di
+	popw	%es
+	int	$0x10
+	popw	%es
+
+	cmpb	$0x0, %ah			# function call failed
+	jne	no_edid
+
+	cmpb	$0x4f, %al			# function not supported
+	jne	no_edid
+
  	movw	$0x4f15, %ax                    # do VBE/DDC
  	movw	$0x01, %bx
  	movw	$0x00, %cx
@@ -1953,6 +1969,7 @@ store_edid:
  	movw	$0x140, %di
 	int	$0x10

+no_edid:
  	popw	%di				# restore all registers
  	popw	%dx
  	popw	%cx


> This option is new and not yet available in 2.6.15, so you may have
> to use your patch temporarily.

I was able to download a more recent kernel and configure
CONFIG_FB_FIRMWARE_EDID. Thanks.
