Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbTK0IaW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 03:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTK0IaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 03:30:22 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:57489 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264449AbTK0IaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 03:30:17 -0500
Date: Thu, 27 Nov 2003 17:28:02 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: [RFC] How drivers notice a HW error?
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Message-id: <023401c3b4c0$5fb40660$a8647c0a@seto>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain;	charset="iso-2022-jp"
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a request for comments, especially comments from driver developers.

On some platform, for example IA64, the chipset detects an error caused by
driver's operation such as I/O read, and reports it to kernel. Linux kernel
analyzes the error and decides to kill the driver or reboot at worst.
I want to convey the error information to the offending driver, and want to
enable the driver to recover the failed operation.

So, just a plan, I think about a readb_check function that has checking ability
enable it to return error value if error is occurred on read. Drivers could use
readb_check instead of usual readb, and could diagnosis whether a retry be
required or not, by the return value of readb_check.

To realize this, I consider following two images:

+ readb_check on driver (with Notifier)
  [Outline]:
    - Hardware error handler (for example in IA64, MCA handler) has a Notifier
      as hook point.
    - Driver may register a hook function to the Notifier.
    - Notifier calls over registered functions when error is occurred.
    - Called hook function checks address of error, and if the error seems
      to be concerned with the parent driver, ups internal error flag and
      stops Notifier by returning OK.
    - Hardware error handler regards state of Notifier, and decides the system
      to resume or not.
    - Restarted driver may refer the error flag after read, and may retry the
      read if flag is up.
  [Issue]:
    - Some interfaces such as register hooks would be required.
    - Coding a hook function would be a bother of developers.

+ readb_check on kernel
  [Outline]:
    - Kernel has readb_check function.
    - Drivers may use readb_check instead of usual readb.
    - Hardware error handler checks address of error, and if it occurs in
      readb_check, changes return value of readb_check and resumes
      interrupted context.
    - Driver may refer the return value to notice an error in last read
      procedure.
  [Issue]:
    - Overhead would be involved. (Possibly, it could say negligible since
      I/O reads are already horribly slow.)

IMO, this is a general-purpose function that should be available on many
platforms. I also hear that Solaris has some similar implementations like this.

If you have any comment about this feature or any idea different from this,
please tell me.


Best regards,

------

H.Seto <seto.hidetoshi@jp.fujitsu.com>

