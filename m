Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265740AbUAKDby (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 22:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265742AbUAKDby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 22:31:54 -0500
Received: from omrnat5.verisignmail.com ([216.168.230.164]:26251 "EHLO
	omr3.verisignmail.com") by vger.kernel.org with ESMTP
	id S265740AbUAKDbx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 22:31:53 -0500
From: <shai@ftcon.com>
Message-Id: <200401110331.BBB99015@ms6.verisignmail.com>
Reply-To: <shai@ftcon.com>
To: <linux-kernel@vger.kernel.org>
Subject: lowlatency patch question
Date: Sat, 10 Jan 2004 19:31:47 -0800
Organization: FT Consulting
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5329
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcPX8vFNTG/dFkmwS+SMhPXvIYwqfw==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think the following is a bug that can affect kernels patched with
lowlatency, such as Audio… and RedHat AS2.1.

lowlatency patch added conditional_schedule() to be called from
close_files(…) at kernel/exit.c, which seems to raise a problem if the
process had LDT entries.
If it had LDT, at the stage of close_files(…) the tsk->mm already zeroed
(__exit_mm(…), which comes before __exit_files(…) in do_exit(…)).  If
conditional_schedule() at close_files(…) will succeed, switching back into
this process (that now have zeroed tsk->mm) will fail since the kernel will
not use the right LDT (since tsk->mm was zeroed, so switch_mm(…) will not be
called to load the LDT at schedule()).

Switching back to a process that had a register that used the LDT will fail
since the register probably points to non-valid LDT entry (since we are
using the wrong LDT), which will lead to a segmentation fault.
 
--Shai


