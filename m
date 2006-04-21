Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWDUOWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWDUOWo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWDUOWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:22:44 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:40872 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S932215AbWDUOWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:22:43 -0400
Date: Fri, 21 Apr 2006 18:22:23 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
       Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, rth@twiddle.net
Subject: Re: strncpy (maybe others) broken on Alpha
Message-ID: <20060421182223.C19738@jurassic.park.msu.ru>
References: <20060421095028.GA8818@bigip.bigip.mine.nu> <20060421114149.24F5EDBA1@gherkin.frus.com> <20060421115556.GA14178@bigip.bigip.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060421115556.GA14178@bigip.bigip.mine.nu>; from mchouque@free.fr on Fri, Apr 21, 2006 at 01:55:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 01:55:56PM +0200, Mathieu Chouquet-Stringer wrote:
> I've attached to this email a tarball of what I use to test the
> compiler/binutils.  It's faster than recompiling the whole kernel on
> these slow machines!

Oops. I was using a wrong copy of strncpy.S (remained from previous
__stxncpy() debugging). What's why I wasn't able to reproduce that...

It seems that the registers $24 and $27 are mixed up in strncpy().
This fixes your test case, please check if it fixes kernel problem
as well.

Ivan.

--- strncpy_debug/strncpy.S	Thu Apr 20 14:18:05 2006
+++ strncpy.S	Fri Apr 21 17:52:04 2006
@@ -43,8 +43,8 @@
 
 	.align	4
 $multiword:
-	subq	$24, 1, $2	# clear the final bits in the prev word
-	or	$2, $24, $2
+	subq	$27, 1, $2	# clear the final bits in the prev word
+	or	$2, $27, $2
 	zapnot	$1, $2, $1
 	subq	$18, 1, $18
 
@@ -70,8 +70,8 @@
 	bne	$18, 0b
 
 1:	ldq_u	$1, 0($16)	# clear the leading bits in the final word
-	subq	$27, 1, $2
-	or	$2, $27, $2
+	subq	$24, 1, $2
+	or	$2, $24, $2
 
 	zap	$1, $2, $1
 	stq_u	$1, 0($16)
