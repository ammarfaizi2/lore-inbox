Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbTJ3PGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 10:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbTJ3PGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 10:06:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39379 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262573AbTJ3PFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 10:05:53 -0500
Message-ID: <3FA128C4.5040502@pobox.com>
Date: Thu, 30 Oct 2003 10:05:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Post-halloween doc updates.
References: <20031030141519.GA10700@redhat.com>
In-Reply-To: <20031030141519.GA10700@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> - An additional bug biting some people is that NICs fail to receive packets
>   (usually notable by a NIC not getting a DHCP lease for eg, despite being
>    sent one by the server). Booting with "noapic" "acpi=off" or a combination
>   of both fixes this for most people. Additional breakage reports should go
>   to Jeff Garzik <jgarzik@pobox.com>

As this is a symptom of irq routing failure, I dunno if bug reports 
should necessarily go to me :)



> Stuff needing forward porting from 2.4.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> - HFSPlus

I think Roman Zippel updated this recently?


> - Direct booting from floppy is no longer supported.
>   You should now use a boot loader program instead.

hmmm, what does this mean?

"make bzdisk" continues to work...  it requires syslinux, however, so 
that the makefile may install the syslinux bootloader on the floppy.



> Modules.
> ~~~~~~~~
> - For Red Hat users, there's another pitfall in "/etc/rc.sysinit".
>   During startup, the script sets up the binary used to dynamically load
>   modules stored at "/proc/sys/kernel/modprobe". The initscript looks
>   for "/proc/ksyms", but since it doesn't exist in 2.6 kernels, the
>   binary used is "/sbin/true" instead.
> 
>   This, eventually, will keep modules from working. Red Hat users will
>   have to patch the "/etc/rc.sysinit" script to set
>   "/proc/sys/kernel/modprobe" to "/sbin/modprobe", even
>   when "/proc/ksyms" doesn't exist.

Is this all still true?

Bill Nottingham graciously updated modutils to support 2.6.x, and 
locally all my Red Hat systems (with the updated modutils) work out of 
the box.


> IDE.
> ~~~~
> - The IDE code rewrite was subject to much criticism in early 2.5.x, which
>   put off a lot of people from testing. This work was then subsequently
>   dropped, and reverted back to a 2.4.18 IDE status.
>   Since then additional work has occurred, but not to the extent
>   of the first cleanup attempts.
> - Known problems with the current IDE code. 
>   o  Simplex IDE devices (eg Ali15x3) are missing DMA sometimes

I think this is fixed now...  Bart?


>   o  Most PCMCIA devices have unload races and may oops on eject
>   o  Modular IDE does not yet work, modular IDE PCI modules sometimes
>      oops on loading
>   o  ide_scsi is completely broken in 2.6 currently. Known problem.
>      If you need it either use 2.4 or fix it 8)

also perhaps add a mention of new and spiffy Serial ATA drivers :)



> CD Recording.
> ~~~~~~~~~~~~~
> - Jens Axboe added the ability to use DMA for writing CDs on
>   ATAPI devices. Writing CDs should be much faster than it
>   was in 2.4, and also less prone to buffer underruns and the like.
> - With a recent cdrecord, you also no longer need ide-scsi in order to use
>   an IDE CD writer.

Maybe add a pointer in the IDE section, pointing to this section?  Since 
they both mention ide-scsi...



> Generic VFS changes.
> ~~~~~~~~~~~~~~~~~~~~
> - Directories can now be marked as synchronous using chattr +S,
>   so that all changes will be immediately written to disk.
>   Note, this does not guarantee atomicity, at least not for all filesystems
>   and for all operations.  You *can* be guaranteed that system calls will
>   not return until the changes are on disk; note though that this does have
>   has some significant performance impacts.

Also, too, this is filesystem-specific, right?


> devfs.
> ~~~~~~
> - devfs got somewhat stripped down and a lot of duplicate functionality
>   got removed. You now need to enable CONFIG_DEVPTS_FS=y and mount
>   the devpts filesystem in the same manner you would if you were not
>   using devfs.

Wasn't this mentioned elsewhere in the document?



> Improved BIOS table support.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> - Linux now supports various new BIOS extensions.

This is a bit vague.  Even I have no idea what this refers to :)



> Power management.
> ~~~~~~~~~~~~~~~~~
> - 2.6 contains a more up to date snapshot of the ACPI driver. Should
>   you experience any problems booting, try booting with the argument
>   "acpi=off" to rule out any ACPI interaction. ACPI has a much more involved
>   role in bringing the system up in 2.6 than it did in 2.4
> - The old "acpismp=force" boot option is now obsolete, and will be ignored
>   due to the old "mini ACPI" parser being removed.
> - software suspend is still in development, and in need of more work.
>   Use with SMP and/or PREEMPT not advised.
> - The ACPI code will do basic sanity checks on the DMI structure in the BIOS
>   to determine the date it was written. BIOSes older than year 2000 are
>   assumed to be broken. In some circumstances, this assumption is wrong.
>   If you see a message saying ACPI is disabled for this reason, try booting
>   with acpi=force. If things work fine, send the output of dmidecode
>   (http://www.nongnu.org/dmidecode/) to acpi-devel@lists.sf.net
>   with an explanation of why your BIOS shouldn't be blacklisted.

I dunno how much there is to add, but I just have a general feeling that 
software suspend and ACPI sleep state support has progressed since this 
was written.



> Compiler issues.
> ~~~~~~~~~~~~~~~~
> - The recommended compiler (for x86) is still 2.95.3.

I'm not sure this is still the case, in practice.  Recent times have 
seen people breaking 2.95.x, which did not support the C99/C++ style of 
mixing variable declarations and code.  People would forget this, and we 
only find out a few days later that the 2.95.x build was broken.



> Networking.
> ~~~~~~~~~~~
> - Some applications may trigger the kernel to spit out warnings about
>   'process xxx using obsolete setsockopt SO_BSDCOMPAT' .
>   - Bind 9.2.2 checks for #ifdef SO_BSDCOMPAT in <asm/socket.h> correctly,
>     so a recompile is all that is needed.
>   - bind9-host from debian testing triggers, though the 'host' package doesn't.
>   - process `snmpd' is using obsolete setsockopt SO_BSDCOMPAT
>   - process `snmptrapd' is using obsolete setsockopt SO_BSDCOMPAT
>   - ntop uses obsolete (PF_INET,SOCK_PACKET)

Wasn't there a recent lkml thread relating to this?


