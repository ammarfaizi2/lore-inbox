Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266021AbTLIQas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbTLIQar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:30:47 -0500
Received: from rose.csi.cam.ac.uk ([131.111.8.13]:64987 "EHLO
	rose.csi.cam.ac.uk") by vger.kernel.org with ESMTP id S266021AbTLIQaa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:30:30 -0500
Subject: Re: 2.4.23-bk bogus edd changeset - Re: 2.4.23 compile error in edd
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20031208222322.A21354@lists.us.dell.com>
References: <Pine.SOL.4.58.0312042225300.26114@yellow.csi.cam.ac.uk>
	 <Pine.LNX.4.44.0312051109580.1782-100000@logos.cnet>
	 <20031205113619.A20371@lists.us.dell.com> <1070901250.4508.1.camel@imp>
	 <20031208222322.A21354@lists.us.dell.com>
Content-Type: text/plain
Organization: University of Cambridge
Message-Id: <1070987393.3447.64.camel@imp>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 16:29:53 +0000
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-09 at 04:23, Matt Domsch wrote:
> > With latest 2.4-BK which includes your compile fix, compiling the kernel
> > with the attached .config, installing and attempting to boot the kernel
> > causes immediate reboot on my workstation.
> > 
> > Disabling EDD in the .config, recompiling and installing the kernel
> > makes it boot just fine.
> > 
> > Let me know if you want me to test any patches, need any more
> > information, etc...
> 
> Ok, I'm betting that your BIOS doesn't like the int13 call in setup.S for some
> reason.
> 
> #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
> # Read the first sector of device 80h and store the 4-byte signature
>         movl    $0xFFFFFFFF, %eax
>         movl    %eax, (DISK80_SIG_BUFFER)       # assume failure
>         movb    $READ_SECTORS, %ah
>         movb    $1, %al                         # read 1 sector
>         movb    $0x80, %dl                      # from device 80
>         movb    $0, %dh                         # at head 0
>         movw    $1, %cx                         # cylinder 0, sector 0
>         pushw   %es
>         pushw   %ds
>         popw    %es
>         movw    $EDDBUF, %bx
>         int     $0x13
>         jc      disk_sig_done
>         movl    (EDDBUF+MBR_SIG_OFFSET), %eax
>         movl    %eax, (DISK80_SIG_BUFFER)       # store success
> disk_sig_done:
>         popw    %es
> 
> 
> To test this, would you mind #if 0'ing everything starting with
> movb $READ_SECTORS, %ah   through the popw %es at the end?  That
> should leave you with a file in /proc/bios/int13_dev80/mbr_signature
> that says 0xFFFFFFFF, but a booting system.

No, still reboots.

> I'm wondering if %eax shouldn't be zeroed before the int13.  The
> bottom word gets set properly, but the top word is 0xFFFF which your
> BIOS may not like?  That would be another test, add an
> 
>  xor %eax, %eax
> 
> before the movb $READ_SECTORS, %ah.

No, still reboots.

> My BIOSs I've seen this on work, so it could be BIOS-dependent;
> clearing eax before setting the lower bytes would be OK if that fixes
> it.

No.  The higher 16 bits are irrelevant.  I played with this today by
inserting debugging into the EDD archi/i386/boot/setup.S code as well as
into the EDD arch/i386/kernel/setup.c code.  I will give you details
below but here is what I believe is the conclusion:

The ds segment is not pointing to the correct segment AND/OR the offsets
into the segment used for the writes are bogus.  You write straight into
ds and ds:si referenced memory but you never setup ds in the first
place.  So the writes done by the EDD code corrupt the loaded compressed
kernel and the decompression fails.

I may be wrong of course.  (-:

Now the experiments I did:

1) 

Disable the entirety of the memory writes done by EDD code in setup.S
with destination ds:si as well as the initial ds:DISK80_SIG_BUFFER.
Basically I just did #if 0 #endif arround the whole EDD code!

To match this, edit setup.c::copy_edd() and add these lines at the end:

	eddnr = 0;
	edd_disk80_sig = -1;

This makes my kernel boot just fine and EDD tells me that no devices are
present.

Thus it is likely that the setup.S EDD code is what kills us.

2)

Leaving the setup as in experiment 1) with only one modification; in
setup.S move the top two EDD lines above the #if 0, i.e.:

	movl    $0xFFFFFFFF, %eax
	movl    %eax, (DISK80_SIG_BUFFER)       # assume failure

Booting this kernel now causes an immediate reboot!

3)

I added a readkey (ah = 0, int 0x16) at the end of the EDD code in
setup.S so that I need to press a key to continue.  This allowed me to
tell when the computer is rebooting.  This also allows the graphics card
to have changed graphics mode and I can see messages on screen before
the reboot happens.

Repeating experiment 2 with my readkey code added, the kernel waits for
my key press (after having done the write to (DISK80_SIG_BUFFER), then
displays "Decompressing kernel..." and then reboots, i.e. it never
completes kernel decompression.

This is what leads me to believe that the kernel image has been
corrupted by the above memory write.

-- end of experiments --

I haven't really spent time thinking about ds and offsets and what they
should be set to but I hope I have given you enough information to fix
this yourself.  (-:

Please also note that you may want to consider adding this around your
first int 0x13 call (the one to read the MBR):

movb	$READ_SECTORS, %ah
[snip]
pushw	%dx		# work around buggy BIOSes
stc			# work around buggy BIOSes
int	$0x13
sti			# work around buggy BIOSes
popw	%dx

This is what Microsoft uses apparently to work around various buggy BIOS
implementations - ref: Ralf Brown's Interrupt list 61, which I consider
the ultimate and definite guide to interrupts. (-:

Further, at the Getdeviceparameters int 0x13 call, you may want to zero
the two bytes following the EDDPARMSIZE in %ds:(%si) before doing the
interrupt as your own company's PhoneixBIOS 4.0 Release 6.0 machines
didn't work unless this was the case (ref: Ralf Brown's Interrupt list
61).

Finally, would it not be prudent to check the result of
checkextensionspresent int 0x13 call before doing the
getdeviceparameters int 0x13 call?  For example this would do just that:

[snip]
movw	%cx, %ds:-2(%si)		# store extensions
[snip]                                                                                        testw	$7, %cx				# Is Function 48 supported?
jz	edd_skip_getdevparms		# If not, skip the call...

movb	$GETDEVICEPARAMETERS, %ah	# Function 48
int	$0x13				# make the call
					# Don't check for fail return
					# it doesn't matter.
edd_skip_getdevparms:

Just a few thoughts.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/

