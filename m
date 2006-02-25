Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932679AbWBYFHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbWBYFHv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 00:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbWBYFHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 00:07:51 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:31595 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S932679AbWBYFHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 00:07:50 -0500
X-IronPort-AV: i="4.02,145,1139205600"; 
   d="scan'208"; a="50424368:sNHT30749260"
Date: Fri, 24 Feb 2006 23:07:45 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: "Ghost" devices in /sys/firmware/edd
Message-ID: <20060225050745.GA4796@lists.us.dell.com>
References: <200602242214.46290.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602242214.46290.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 10:14:34PM +0300, Andrey Borzenkov wrote:
> I have single drive hda; still EDD shows valid and the _same_ MBR signature 
> for all possible 16 drives:
> 
> {pts/0}% cat /sys/firmware/edd/*/mbr_*
> 0x7fca3a0a
> 0x7fca3a0a
> 0x7fca3a0a
[snip]
> 
> other attributes are correctly present for the drive 0x80 only.
> 
> Not being expert in x86 assembly, but comparing main loops for signature and 
> other info:
> 
> signature:
>         int     $0x13
>         sti                     # work around buggy BIOSes
>         popw    %dx
>         popw    %es
>         popw    %bx
>         jc      edd_mbr_sig_done                # on failure, we're done.

The code here is fine.  Immediately before the int13 is an stc
instruction, so the carry flag is set.  sti and popw don't change CF.
What this means is that your BIOS cleared CF in the int13 to a
nonexistant disk, rather than setting CF (or leaving it unchanged).
CF being clear means the command succeeded.  In your case, the BIOS
cleared it, but shouldn't have.

Care to share your system type / BIOS version, and if it's at all
recent, file an bug with their support department?


> extended EDD info:
> 
> edd_check_ext:
>         movb    $CHECKEXTENSIONSPRESENT, %ah    # Function 41
>         movw    $EDDMAGIC1, %bx                 # magic
>         int     $0x13                           # make the call
>         jc      edd_done                        # no more BIOS devices
> 

Yet, it does properly set CF on int13 AH=41h to a nonexistant disk.
How annoying.


> Is it possible that carry flag is cleared between return from int 0x13 and 
> querying for it in the former case? This would perfectly explain that EDD 
> does not notice failure of reading sector and simply copies the same 
> signature from the very first drive.

I'll look more next week, but what isn't ever happening is an int13
AH=15h GET DISK TYPE probe to see if the disk is there.  The edd.S
code just issue a READ SECTORS and expects that to fail (to set CF) if
it's not there.  This has been working fine for most people.  In your
case, it's not reporting a failure (CF is cleared by the int13).  Now,
there's no guarantee your BIOS would respond properly to the GET DISK
TYPE command either.  There are also notes that BIOS should set
0040h:0075h to the number of drives present, and the code isn't
reading that value now either.  Either of these tests, if the BIOS
isn't buggy for them, could result in reporting the right number of
disks.

Thanks much for the report and for digging to find where the mistake
could be.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
