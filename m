Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWHGVLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWHGVLm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWHGVLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:11:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19397 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932389AbWHGVLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:11:39 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 early_param mem= fix
References: <Pine.LNX.4.64.0608061811030.19637@blonde.wat.veritas.com>
	<Pine.LNX.4.64.0608061829430.20012@blonde.wat.veritas.com>
Date: Mon, 07 Aug 2006 15:09:57 -0600
In-Reply-To: <Pine.LNX.4.64.0608061829430.20012@blonde.wat.veritas.com> (Hugh
	Dickins's message of "Sun, 6 Aug 2006 18:31:31 +0100 (BST)")
Message-ID: <m13bc8b6ca.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> writes:

> On Sun, 6 Aug 2006, Hugh Dickins wrote:
>> I was impressed by how fast 2.6.18-rc3-mm2 is under memory pressure,
>> until I noticed that my "mem=512M" boot option was doing nothing.  The
>> two fixes below got it working, but I wonder how many other early_param
>> "option=" args are wrong (e.g. "memmap=" in the same file): x86_64
>> shows many such, i386 shows only one, I've not followed it up further.
>
> Oh, and that's not enough for it to show up in x86_64's /proc/cmdline.

The /proc/cmdline part is easy.

Someone deleted the copy from saved_command_line to command_line.
Since kernel/params.c:parse_args called in init/main.c is destructive
if we don't do this we will never see a reasonable command line in /proc,
and /init implementations that parse /proc/command_line will choke horribly.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
index 3bc1ff4..37206a4 100644
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -378,7 +378,8 @@ #endif
        early_identify_cpu(&boot_cpu_data);
 
        parse_early_param();
-       *cmdline_p = saved_command_line;
+       memcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
+       *cmdline_p = command_line;
 
        finish_e820_parsing();
 
