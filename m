Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbUKGUES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUKGUES (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 15:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbUKGUEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 15:04:15 -0500
Received: from linux.us.dell.com ([143.166.224.162]:24132 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261593AbUKGUEB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 15:04:01 -0500
Date: Sun, 7 Nov 2004 14:03:51 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davej@redhat.com, "Luck, Tony" <tony.luck@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: EFI partition code broken..
Message-ID: <20041107200351.GA3169@lists.us.dell.com>
References: <Pine.LNX.4.58.0411070959560.2223@ppc970.osdl.org> <Pine.LNX.4.58.0411071128240.24286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411071128240.24286@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 11:30:18AM -0800, Linus Torvalds wrote:
> There's a few reports of various USB storage devices locking up. The last 
> one was an iPod, but there's apparently others too.
> 
> The reason? They are unhappy if you access them past the end, and they 
> seem to have problems reporting their true size.
> 
> And the EFI partitioning code will happily just blindly try to access the 
> last sector, because that's where the EFI partition is. Boom. Immediately 
> dead iPod/whatever.
> 
> I'm going to make EFI depend on ia64. Does anybody else use them? 

It has been suggested on lkml that CONFIG_EFI_PARTITION (aka GUID
Partition Tables, or GPT), be used as a partitioning strategy
(assuming you want partitions instead of whole-disk LVM) for >2TB
non-boot block devices, on all architectures, not just on ia64.
Granted, you've got to have a RAID controller to get there today, but
SANs can.

Also, Intel is heavily pushing for Extensible Firmware Interface (EFI)
to be implemented in x86 and x86_64 environments in the next couple of
years, so it may become more widespread.
 
> Anyway, if anybody is interested in EFI tables on anything else, or if 
> ia64 people ever care about actually working in any interesting hw 
> situation, I'd strongly suggest EFI be fixed to not accept any random 
> crap. 
> 
> As far as I can tell from reading the source, the EFI driver already
> checks the first sector to see if it has a valid gpt, but apparently it
> happily ends up doing all the end-of-disk checks even if the GPT isn't
> there. Whatever the GPT is.

GPT = GUID Partition Table, that's the metadata as described in the
EFI Specification.  There's two copies, one at the front of the disk,
and one at the end of the disk, as a backup.  (why, I'm not too sure,
but that's the way it was specfied).  So the code needs to check both,
if it gets that far...
 
> Anyway, it is possible that the fix is to just exit EFI partition checking 
> early if the first sector isn't palatable. But I don't know what the EFI 
> rules are, and quite frankly, I think it's a hell of a lot more important 
> to not do random access patterns to a disk and confuse it than it is to 
> have EFI, so for now I'm just making it conditional on IA64.

The check for invalid primary master boot record (PMBR) needs to be
moved up ahead of the reads for the GPTs (primary at the start of the
disk, alternate/backup at the end of the disk).  When first written,
Intel didn't specify that the PMBR (a normal DOS-like MBR partition
table with a single entry of type 0xEE covering the whole disk) *had*
to exist, so we let the code try looking for GPTs first.  When the
PMBR test was added, it should have been added ahead of the GPT tests,
not after.  I'll work up a patch to do just that, and will then remove
the dependency on IA64.  Fair enough?
 
> Btw, USB devices are _not_ the only devices that don't necessarily know 
> their size very well. CD-roms tend to sometimes have the same issues. They 
> just don't have partitions on them, so people probably never cared. Also, 
> I think some things like nbd end up being "allocate on demand", and the 
> size is meaningless.
> 
> Basic rule of thumb: be _careful_ when accessing a disk. There are too 
> damn many buggy or strange setups out there.

Indeed.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
