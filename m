Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVA0JyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVA0JyA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 04:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVA0Jx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 04:53:59 -0500
Received: from master.debian.org ([146.82.138.7]:43701 "EHLO master.debian.org")
	by vger.kernel.org with ESMTP id S262536AbVA0Jx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 04:53:57 -0500
Date: Thu, 27 Jan 2005 03:53:50 -0600
From: Colin Watson <cjwatson@debian.org>
To: debian-amd64@lists.debian.org, linux-kernel@vger.kernel.org
Cc: discuss@x86-64.org
Subject: x86-64: PT_GNU_STACK exec bit broken under ia32 emulation?
Message-ID: <20050127095350.GA6638@master.debian.org>
Mail-Followup-To: Colin Watson <cjwatson@debian.org>,
	debian-amd64@lists.debian.org, linux-kernel@vger.kernel.org,
	discuss@x86-64.org
References: <299008303.20050111201628@gmx.net> <7772a2590501111121348a6ab@mail.gmail.com> <20050111215733.GB5049@frankengul.org> <41E4603C.20701@comcast.net> <20050112140833.GX10437@ns.snowman.net> <20050112145903.GA9336@frankengul.org> <20050112151350.GY10437@ns.snowman.net> <20050126114931.GA9784@master.debian.org> <20050127024523.GA6511@master.debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127024523.GA6511@master.debian.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 08:45:23PM -0600, Colin Watson wrote:
> On Wed, Jan 26, 2005 at 05:49:31AM -0600, Colin Watson wrote:
> > I had the exact same problem (on Ubuntu rather than Debian, but hey).
> > Debugging-by-printf revealed that grub segfaulted after calling
> > stage2/builtins.c:disk_read_savesect_func() through the disk_read_func
> > pointer in stage2/disk_io.c:rawread(); output from a printf before that
> > call was printed, while output from a printf at the beginning of the
> > disk_read_savesect_func() call was not printed. It *looks* like the text
> > of that function is corrupt in memory, although I'm not wholly convinced
> > that my debugging techniques were sound there because I'm having trouble
> > debugging a 32-bit binary.
> 
> I think this last sentence was indeed bogus.
> 
> Anyway, I've narrowed down the introduction of the problem to somewhere
> between 2.6.9-bk1 and 2.6.9-bk2. Suggestions for changesets in there
> that could have broken grub would be gratefully appreciated.

Context for LKML and discuss@x86-64; grub segfaults when running its
'install' command (via grub-install) on Debian and Ubuntu systems
running stock kernels >= 2.6.9-bk2, up to and including 2.6.11-rc2-bk3
(haven't tried 2.6.11-rc2-bk4 yet). grub is a 32-bit binary relying on
ia32 emulation. The implementation of the 'install' command in grub uses
nested functions, which require a stack trampoline, and therefore the
executable-stack bit is set on the binary:

  $ readelf -l /sbin/grub | grep STACK
  STACK          0x000000 0x00000000 0x00000000 0x00000 0x00000 RWE 0x4

However, booting with noexec=off cures the problem, so it would appear
that the executable stack bit isn't being checked properly at least
under ia32 emulation.

2.6.9-bk1 works fine, but noexec=on only became the default in
2.6.9-bk2; I haven't yet tried booting 2.6.9-bk1 with noexec=on, but I
can try that if it might be helpful.

Thanks,

-- 
Colin Watson                                       [cjwatson@debian.org]
