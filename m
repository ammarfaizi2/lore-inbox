Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261688AbSJNOHI>; Mon, 14 Oct 2002 10:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbSJNOHI>; Mon, 14 Oct 2002 10:07:08 -0400
Received: from internet.prism.co.za ([196.41.175.253]:63179 "EHLO
	penguin.wetton.prism.co.za") by vger.kernel.org with ESMTP
	id <S261688AbSJNOHG>; Mon, 14 Oct 2002 10:07:06 -0400
Date: Mon, 14 Oct 2002 16:11:41 +0200
From: Bernd Jendrissek <berndj@prism.co.za>
To: James Morris <jmorris@intercode.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is "recvmsg bug: copied 870A11AD seq 0"?  (2.2.19)
Message-ID: <20021014161141.C17659@prism.co.za>
References: <20021014115341.A22933@prism.co.za> <Mutt.LNX.4.44.0210142313470.21746-100000@blackbird.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Mutt.LNX.4.44.0210142313470.21746-100000@blackbird.intercode.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 11:16:05PM +1000, James Morris wrote:
> On Mon, 14 Oct 2002, Bernd Jendrissek wrote:
> 
> > Hello all
> > 
> > What does it mean if the last 9 items in dmesg from a 2.2.19 kernel say
> > "recvmsg bug: copied 870A11AD seq 0"?  Same sequence number each time.
> > 
> > A kernel (known) bug?  Some bogus TCP segments?
> 
> It's been reported a few times, but I'm not sure if it's been resolved.
> 
> Can you please post the version of the compiler which compiled the kernel, 
> what kind of hardware you're running on, and if it's a stock kernel or has 
> vendor/other patches applied.

$ cat /proc/version
Linux version 2.2.19 (berndj@penguin.wetton.prism.co.za) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #2 Wed Aug 1 13:51:15 SAST 2001

$ lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:08.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01)

$ cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 0
cpu MHz		: 334.094
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 666.82

Network card, hmm, some ne2k type ISA card.  The phrase "8390" also springs
to mind.

$ less /var/log/dmesg
...
ne.c:v1.10 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)
NE*000 ethercard probe at 0x300: 00 00 e8 2f b9 ca
eth0: NE2000 found at 0x300, using IRQ 5.
...

Stock kernel.  No patches.  Unfortunately I've lost .config

BTW ipv6 module is loaded, for extra coolness points.  Not that I use it! :)

I can provide a dissassembly of tcp_recvmsg; please quote "c0162daf" - that
is where the inews's were all sleeping.

Hmm, curiouser and curiouser.  I haven't booted the (this) machine since
77 days ago; and now dmesg shows another couple of messages:

recvmsg bug: copied 870A11AD seq 0
recvmsg bug: copied 870A11AD seq 0
tcp_close: socket already locked!

Same "copied" sequence number!  Pity the kernel doesn't timestamp its
messages.  Why doesn't syslog catch these messages into /var/log/messages?

I'll leave the machine running (unless it gets *very* weird) so we can peek
its memory.  Is it too late to copy /proc/kcore now?

Hah!  I bet this has *something* to do with the whole spiel:
$ netstat -nt |grep human-brain
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        6      0 127.0.0.1:3287          127.0.0.1:119           CLOSE       

When I su to root and add netstat's -p option, this socket doesn't have an
owner process.  And I use rtin, not some pthread-monster, so it's not that.

[I'd greatly appreciate Cc'ed replies]
-- 
berndfoobar@users.sourceforge.net is probably better to bookmark than any
employer-specific email address I may have appearing in the headers.
  Vanity page: http://www.tsct.co.za/~berndj/
