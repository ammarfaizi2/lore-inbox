Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVHDEWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVHDEWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 00:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVHDEWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 00:22:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:31417 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261760AbVHDEWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 00:22:54 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: "Christopher Friesen" <cfriesen@nortel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: question on memory map of process on i386 
In-reply-to: Your message of "Wed, 03 Aug 2005 17:28:38 CST."
             <42F15326.6000402@nortel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Aug 2005 14:22:39 +1000
Message-ID: <7276.1123129359@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Aug 2005 17:28:38 -0600, 
"Christopher Friesen" <cfriesen@nortel.com> wrote:
>
>On i386, /proc/<pid>/maps shows the following entry:
>
>ffffe000-fffff000 ---p 00000000 00:00 0
>
>This page of memory is way up above TASK_SIZE (which is 0xc0000000), so 
>how is it visible to userspace?
>
>Just to complicate things,  I seem to find the vma for this page using 
>find_vma_prev().
>
>Can anyone explain what's going on?

The gate page is a section of code that is generated as part of the
kernel build.  At run time, the gate page is mapped into all the user
space processes.  There is also a virtual dynamic .so (vdso) file that
is created by the kernel and picked up by the linker, the vdso maps the
kernel entries in the gate page.  Run this command and look for "gate".

  ldd -v `which cat`

Once all the dots are joined by the linker, a program can use the vdso
to directly access the gate page, even though the vdso and the
underlying page belongs to the kernel.  This direct access does not
incur any of the overhead associated with a syscall, so it can be very
fast.

What is in the gate page varies from one architecture to another, glibc
hides the arch differences from the program.  Some sample uses for the
gate page -

i386: select between int 0x80 or sysenter to enter the kernel.
ia64: select between break 0x100000 or epc to enter the kernel, epc is
      significantly faster.  On ia64, the gate page also contains the
      signal delivery trampoline.

