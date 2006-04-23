Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWDWTI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWDWTI2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 15:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWDWTI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 15:08:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:36661 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751444AbWDWTI1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 15:08:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Tff4WynHDDlOtYUhsgQjLPurPoNyogk0fDDybsnqPyZ0q2Agu5SWe61eFl1WtwTIEV9DkLznlrKeD9X/ePSd8ObBr44ifWbqTE7tPymBGxudYGaS1tjhMGbdqhAl8ISlGHGsWg/iipAlXxiiEho5EUZxkryLqcpk954d6pC6yXU=
Message-ID: <df35dfeb0604231208x416b7ab0ya612d918bb239140@mail.gmail.com>
Date: Sun, 23 Apr 2006 12:08:27 -0700
From: "Yum Rayan" <yum.rayan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] VBE DDC bios call stalls boot
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my setup I have a monitor connected via a DLink KVM (DKVM 2K). The
boot stalls forever during early boot phase until I physically
disconnect the KVM from the video port at my CPU box and reconnect it.
I was able to trace it to the VBE/DDC call in video.S. The bios call
does not seem to return. When I disconnect the video, the bios call
returns with failure and boot picks it back from there. When I
directly connect my monitor bypassing the KVM, this issue does not
happen.

There is a bios call to check if read EDID is supported. My first
thought was that before doing read EDID, video.S should first check to
see if the hardware supports the read EDID feature. Unfortunately that
bios call too ends up in the woods until I physically
disconnect/reconnect my CPU video output that feeds into the KVM. I
see the same issue with user space programs such as read-edid and
xwindows that also attempt to read EDID. They simply stall at the DDC
call until I physically disconnect/reconnect my video.

I don't think boot should stall for any reason. Moreover given that
user space programs are doing these VBE/DDC calls, I don't see any
compelling reason why this code need to exist is such early boot
stage. If it absolutely needs to be called in the kernel, at least if
invoked sometime later, we could time out this call as a workaround.

Kindly suggest the best approach. The following patch works for me:

Thanks.

--- linux-2.6.15.4.a/arch/i386/boot/video.S	2006-02-09 23:22:48.000000000 -0800
+++ linux-2.6.15.4.b/arch/i386/boot/video.S	2006-04-23 11:19:01.000000000 -0700
@@ -1946,13 +1946,6 @@ store_edid:
 	rep
  	stosl

-	movw	$0x4f15, %ax                    # do VBE/DDC
-	movw	$0x01, %bx
-	movw	$0x00, %cx
-	movw    $0x00, %dx
-	movw	$0x140, %di
-	int	$0x10
-
  	popw	%di				# restore all registers
  	popw	%dx
  	popw	%cx
