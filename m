Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVADKim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVADKim (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 05:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVADKim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 05:38:42 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18580 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261589AbVADKi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 05:38:29 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 boot loader IDs
References: <41D31696.8050701@zytor.com>
	<m1vfadr65h.fsf@ebiederm.dsl.xmission.com>
	<41DA4BFB.7090800@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Jan 2005 03:37:17 -0700
In-Reply-To: <41DA4BFB.7090800@zytor.com>
Message-ID: <m17jmtqy3m.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> > I suspect /sbin/kexec could use one.  But I don't have the faintest
> > what you could do with the information after the kernel came up.
> >
> 
> Sounds incorrect, unless you're generating the zeropage information.

I do.  That is the format of the information the kernel expects,
so it is the easiest and simplest way to go.  And since it is relatively
simple to strip off the real mode code from the rest and enter
the kernel at 1MB in 32bit mode that is what I do.  

I even have code that will enter the kernel in 16bit and run the normal
setup code but that frequently hits BIOS calls that are confused by
having had a kernel running.  The plan when I get beyond booting
linux kernels similar things is to use a modified version of Bochs
BIOS code to provide the handful of BIOS calls that are needed to
boot most kernels.

The kexec on panic case is a little different and it requires
a kernel that is built to run at an address other than 1MB.  So I load
specially built vmlinux instead of messing with the bzImage at all.
And for booting it making BIOS calls is simply not an option, as the
machine is in a weird state.

> > I don't think enhancing the bootloader numeric parameter is the
> > right way to go.  Currently the value is a single byte with the low
> > nibble reserved for version number information.  With the
> > values already assigned we have 7 left.  If we assign a new value each for the
> 
> > bootloaders I know of that don't
> > yet have values assigned: pxelinux, isolinux, filo, /sbin/kexec,
> > redboot the pool of numbers is nearly exhausted.  With the addition of
> > bootloaders I can't recall or have not been written yet we will
> > quickly exhaust the pool of numbers.
> 
> pxelinux, isolinux and extlinux are syslinux derivatives (0x32, 0x33 and 0x34
> respectively.)  filo and redboot probably could use them, though.
> 
> > Even if using this mechanism is needed for supporting existing
> > bootloaders I suggest it be deprecated in favor of a kernel command
> > line option.  A command line option would be easier to maintain
> > being string based.  It would be portable to architectures besides
> > x86.  And it requires no additional code to implement, as you
> > can already read /proc/cmdline.
> 
> Unfortunately the command line is very squeezed.  With the newer protocol we can
> probably support longer command lines, though.

Hmm. It currently sits at 256 bytes.  Which is 2 to 3 lines of text
which is not too bad, and an easy limit to raise if it is a problem.

My impression is that the limit at 256 bytes is has always been a
kernel implementation issue rather than a protocol issue.  With
a little care even the old protocol could probably do 32K command
line.

> It's a significant boot loader change, though.  In the short term it's
> definitely desirable to be able to read it.

Agreed. You always get a can and mouse game with when you are
upgrading these things.  

However it would be simple to present user space with a single
interface, by doing something like:

        if (strstr(command_line, "BOOT_LOADER=") != 0) {
        	snprintf(command_line + strlen(command_line),
			COMMAND_LINE_SIZE, " BOOT_LOADER=0x%02x",
                        LOADER_TYPE);
        }

At which point a upgrading bootloaders could be done piecemeal with
user space simply needing to learn about the new bootloader strings.

Eric
