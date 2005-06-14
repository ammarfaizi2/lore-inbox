Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVFNH0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVFNH0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 03:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVFNH0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 03:26:10 -0400
Received: from smtp-auth.no-ip.com ([8.4.112.95]:41939 "HELO
	smtp-auth.no-ip.com") by vger.kernel.org with SMTP id S261294AbVFNHZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 03:25:48 -0400
From: dagit@codersbase.com
To: Shaohua Li <shaohua.li@intel.com>
Cc: stefandoesinger@gmx.at, acpi-dev <acpi-devel@lists.sourceforge.net>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was:
 Re: [ACPI] Resume from Suspend to RAM))
References: <200506061531.41132.stefandoesinger@gmx.at>
	<1118125410.3828.12.camel@linux-hp.sh.intel.com>
Organization: Coders' Base
Date: Tue, 14 Jun 2005 00:25:42 -0700
In-Reply-To: <1118125410.3828.12.camel@linux-hp.sh.intel.com> (Shaohua Li's
 message of "Tue, 07 Jun 2005 14:23:30 +0800")
Message-ID: <87ll5diemh.fsf@www.codersbase.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-REPORT-SPAM-TO: abuse@no-ip.com
X-NO-IP: codersbase.com@noip-smtp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Shaohua Li <shaohua.li@intel.com> writes:

> On Mon, 2005-06-06 at 23:31 +0800, stefandoesinger@gmx.at wrote:
>> Am Montag, 6. Juni 2005 11:06 schrieb Matthew Garrett: 
>> > Whoops. May have been a bit too hasty there. I'm not sure why that 
>> > doesn't reset it, but we've now got the following (really rather
>> odd) 
>> > serial output. Does anyone have any idea what might be triggering
>> this? 
>> > Shell builtins work fine, but anything else seems to explode very 
>> > messily. Memory corruption of some description?
>> 
>> <snip> 
>> So it does reach the kernel, right? I don't know if I remembered that
>> call  
>> correctly, but "lcall $0xffff,$0" should call the real mode BIOS
>> reset  
>> code... 
>> Anyone else who can correct me here?
>> 
>> Perhaps the disk driver is going mad? Has anyone tried to boot a
>> kernel  
>> without any disk drivers with a minimal root system on an initrd?
> For those who suffer from strange S3 resume problem such as resume hang,
> could you please try this debug patch.
> It uses machine_real_restart to switch to real mode, and soon jump to
> the S3 wakeup address. So it simulates how BIOS resume a system from S3,
> but completely bypasses BIOS. If the system lives after S3 with the
> patch, at least we can know the suspend/resume code path is ok and it's
> not a Linux driver issue.

If you've looked at this bug you will know that myself at and atleast
one other person experience a reboot on resume at a specific line in
the wakeup code:
http://bugme.osdl.org/show_bug.cgi?id=3586

One note about the code in the bug, my code for detecting PM is
backwards, so ignore it, what I say in this email is still valid.

Specifically, if I get rid of the pushl;popl then the computer does
not reboot.  See the attached diff.  The question is 1) is this
pushl;popl the final nail in the coffin? 2) Does windows not clear the
flags completely, but instead sets them to some "special value"?

The reason for (1) is because as I understand it, when a certain
number of illegal operations (3 iirc) are issued at certain times
(real mode iirc) the machine automatically reboots.  That could be
what we are seeing here.

The reason for (2) is because if I remove the pushl;popl, boot into
windows suspend/resume, and immeditaly boot into linux then the
suspend/resume works.  I have screen blanking issues, but I can type
blindly and the commands all work just fine (I can startx for
example).

Also, what flags are being cleared?  What is their meaning?  Can you
or someone on this list point me to the approriate documentation?  I'd
love to look at it and try to understand my hardware better.

I would encourage others following this thread to try my patch and
the the trick of doing a suspend/resume in windows followed by a
reboot into linux where you try suspend/resume.

Thanks,
Jason


--=-=-=
Content-Disposition: inline; filename=patch-popl.diff

--- /home/dagit/kernels/linux-2.6.12-rc6/arch/i386/kernel/acpi/wakeup.S	2005-03-01 23:37:49.000000000 -0800
+++ arch/i386/kernel/acpi/wakeup.S	2005-06-13 23:24:30.000000000 -0700
@@ -34,8 +34,8 @@
 	mov	$(wakeup_stack - wakeup_code), %sp		# Private stack is needed for ASUS board
 	movw	$0x0e00 + 'S', %fs:(0x12)
 
-	pushl	$0						# Kill any dangerous flags
-	popfl
+#	pushl	$0						# Kill any dangerous flags
+#	popfl
 
 	movl	real_magic - wakeup_code, %eax
 	cmpl	$0x12345678, %eax

--=-=-=--

