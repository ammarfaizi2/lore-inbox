Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVFIEpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVFIEpY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 00:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVFIEpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 00:45:24 -0400
Received: from dvhart.com ([64.146.134.43]:50600 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262264AbVFIEpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 00:45:08 -0400
Date: Wed, 08 Jun 2005 21:44:41 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.12?
Message-ID: <563780000.1118292280@[10.10.2.4]>
In-Reply-To: <1046820000.1118271896@flay>
References: <42A0D88E.7070406@pobox.com> <20050603163843.1cf5045d.akpm@osdl.org> <394120000.1117895039@[10.10.2.4]> <20050604151120.46b51901.akpm@osdl.org> <418760000.1117983740@[10.10.2.4]> <971250000.1118168167@flay> <20050607122422.612759e4.akpm@osdl.org> <20050608125637.GL1683@muc.de> <549770000.1118260074@[10.10.2.4]> <1046820000.1118271896@flay>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--"Martin J. Bligh" <mbligh@mbligh.org> wrote (on Wednesday, June 08, 2005 16:04:57 -0700):

>>>> > >>> The one that worries me is that my x86_64 box won't boot since -rc3
>>>> > >>>  See:
>>>> > >>> 
>>>> > >>>  http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
>>>> > 
>>>> > HA. Found it. binary search reveals it's patch 182 out of 2.6.12-rc2-mm2.
>>>> > And the winner is .... <drum roll please> ....
>>>> > 
>>>> > x86_64-use-the-e820-hole-to-map-the-iommu-agp-aperture.patch
>>>> > 
>>>> 
>>>> hrm.  No useful messages in dmesg?
>>>> 
>>>> Andi, do we revert it?
>>> 
>>> Ok. For now. 
>>> 
>>> Actually it fixes some other bugs (e.g. one from Matt D.), but they are not
>>> very high priority.
>>> 
>>> I would like to debug it, but I am not sure I will still make it this week.
>>> But Martin, can you please send me the dmesg again? Maybe it is something
>>> stupid.
>> 
>> All the logs are linked off here:
>> 
>> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
>> 
>> Just click on the ABORT messages in hte left column. But I'm thinking maybe
>> I'm off by one, and it might be:
> 
> Nope, I was correct, just one of my scrawled notes was wrong. backing out
> 
> x86_64-use-the-e820-hole-to-map-the-iommu-agp-aperture.patch

OK, here's the patch to fix the boot problem, for reference (just the above
reversed).

http://mbligh.org/abat/no_hole

Now what's REALLY, REALLY wierd is that this fixes my hang problem
whilst trying to run kernbench:

http://mbligh.org/abat/no_hang

which is just reverting:

x86_64-use-a-common-function-to-find-code-segment-bases-fix.patch

But the patch is tiny, and it makes NO sense at all for this to fix
anything. All it does is:

diff -purN -X /home/mbligh/.diff.exclude 2.6.12-rc2-mm2/include/asm-x86_64/ptrace.h 2.6.12-rc2-mm2-no_hang/include/asm-x86_64/ptrace.h
--- 2.6.12-rc2-mm2/include/asm-x86_64/ptrace.h	2005-04-08 23:41:41.000000000 -0700
+++ 2.6.12-rc2-mm2-no_hang/include/asm-x86_64/ptrace.h	2005-06-08 16:25:01.000000000 -0700
@@ -86,8 +86,6 @@ struct pt_regs {
 extern unsigned long profile_pc(struct pt_regs *regs);
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
 
-struct task_struct;
-
 extern unsigned long
 convert_rip_to_linear(struct task_struct *child, struct pt_regs *regs);


How the hell can that possibly fix it? Boggle. But it does. I checked.
I ran a whole damned sequence of patches from your tree against the box,
then extracted the one where the failover started and retested it with
just that and the no_hole one. There's even a little green box to 
prove it about 4 down on the left here:

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html

My brain is now a small piece of silly-putty smushed against the far
wall of my study. Anything you can do to help me scrape up the remains
would be splendid. I can only speculate it's some wierd side-effect,
because I have no other explaination at all.

Humpf.

M.

