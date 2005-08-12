Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVHLRLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVHLRLh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVHLRLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:11:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2782 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750725AbVHLRLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:11:36 -0400
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: rddunlap@osdl.org, fastboot@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kexec and frame buffer
References: <42F219B3.6090502@gmail.com>
	<m17jf1zgnz.fsf@ebiederm.dsl.xmission.com>
	<42F4C6E8.1050605@gmail.com>
	<m13bpnyppq.fsf@ebiederm.dsl.xmission.com>
	<42F6266B.8000704@gmail.com> <42FCF00F.2040709@gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 12 Aug 2005 11:10:55 -0600
In-Reply-To: <42FCF00F.2040709@gmail.com> (Luca Falavigna's message of "Fri,
 12 Aug 2005 18:53:03 +0000")
Message-ID: <m1d5ojw068.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Falavigna <dktrkranz@gmail.com> writes:

> Luca Falavigna ha scritto:
>> Eric W. Biederman ha scritto:
>> 
>>>>Anyway I believe you also want to look at include/linux/tty.h
>>>>at the screen_info structure.  I believe that is where
>>>>all of that information is passed.
>> 
>> I noticed. Maybe if we fill struct x86_linux_param_header with some values
>> obtained from struct screen_info, we should be able to "score that mid-court
>> prayer" ;)
>> 
> I tried to implement a new ioctl command in fb_ioctl() in order to retrieve and
> store screen_info variables into struct x86_linux_param_header, but I got the
> same result: no messages shown in console, as I supposed.
Hmm. very odd.  Sounds very much like an implementation problem.

> After that I looked at video.S, especially an interesting label called "video":
>
> # This is the main entry point called by setup.S
> # %ds *must* be pointing to the bootsector
> video:	pushw	%ds		# We use different segments
> 	pushw	%ds		# FS contains original DS
> 	popw	%fs
> [...]
> #ifdef CONFIG_VIDEO_SELECT
> 	movw	%fs:(0x01fa), %ax		# User selected video mode
> 	cmpw	$ASK_VGA, %ax			# Bring up the menu
> 	jz	vid2
> [...]
>
> Video mode is stored (by bootloader, actually) at offset 0x01fa from a given
> boot sector, which should be located at physical address DEF_SETUPSEG (0x9020).
> Feel free to correct me if I'm wrong.
That is the default address, it can actually move quite a bit.

> If we could store current video mode before executing reboot_code_buffer,
> probably setup() function would take care of anything else. So we could
> implement a function (or an assembly stub) in machine_kexec which does this job.
> I think this is the best (and safest) solution.

That is why we have sys_kexec_load().
With a working ioctl (or other way to query the information) we
just need to populate screen_info from x86-linux-setup.c in /sbin/kexec.

Eric
