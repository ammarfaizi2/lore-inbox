Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSJPMDN>; Wed, 16 Oct 2002 08:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262398AbSJPMDN>; Wed, 16 Oct 2002 08:03:13 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:15329 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262394AbSJPMDA>; Wed, 16 Oct 2002 08:03:00 -0400
Date: Wed, 16 Oct 2002 08:08:06 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] mmap-speedup-2.5.42-C3
Message-ID: <20021016080806.F5659@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <m3u1jmpwty.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0210161144220.22365-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210161144220.22365-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Oct 16, 2002 at 11:47:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 11:47:32AM +0200, Ingo Molnar wrote:
> 
> On 16 Oct 2002, Andi Kleen wrote:
> 
> > You can argue against it, but it doesn't change the fact that
> > get_unmapped_area is a significant user of CPU on a KDE startup. [...]
> 
> i dont think anyone argued against anything - i'm trying to understand
> KDE's vma layout, and i dont think it's "wrong" in any way. It uses a
> reasonable layout, and the kernel should really be able to handle mmap()
> mappings when there are 100+ already existing mappings. Would you mind to
> check KDE under 2.5.43 with the attached patch, does it change the
> get_unmapped_area() cost?

Here is /proc/pid/maps from running konqueror on fully prelinked
distribution (prelink -avvm) on IA-32. As you can see, there is a bunch of
holes with different sizes. When ld.so loads the application up, it will
mmap a few anon pages at TASK_UNMAPPED_BASE and then all the libs linked
into the binary from PRELINK_BASE (0x41000000 on IA-32) up, but holes in
it (see e.g. hole between 0x41443000-0x4145c000 etc.).
Then dlopened libs and other mmaps come close to TASK_UNMAPPED_BASE, usually
without too many holes.
Now it depends on for which get_unmapped_area calls is Andi seeing in oprofile.
mmaping prelinked libraries should not be as expensive in the common case,
since mmap is called there with non-zero addr which is likely not used yet.
The next calls to mmap behave like if prelinking was not used at all, until
you fill up the TASK_UNMAPPED_BASE..PRELINK_BASE area, at which point unless
you're mmaping very small pages it is very likely there will be at least
one really small hole between some prelinked libs, so free_area_cache
would point to that hole all the time and get_unmapped_area would have
to walk all the vmas above it.

08048000-08049000 r-xp 00000000 03:05 1240393    /usr/bin/konqueror
08049000-08050000 rw-p 00000000 03:05 1240393    /usr/bin/konqueror
08050000-081c2000 rwxp 00000000 00:00 0
40000000-40003000 rw-p 00000000 00:00 0
40003000-40004000 r--p 0092f000 03:05 886177     /usr/lib/locale/locale-archive
40004000-40006000 r-xp 00000000 03:05 837382     /usr/X11R6/lib/X11/locale/common/xlcDef.so.2
40006000-40007000 rw-p 00001000 03:05 837382     /usr/X11R6/lib/X11/locale/common/xlcDef.so.2
40007000-40008000 rw-p 00000000 00:00 0
40008000-4000e000 r--s 00000000 03:05 1131670    /usr/lib/gconv/gconv-modules.cache
4000e000-40010000 r-xp 00000000 03:05 1131518    /usr/lib/gconv/ISO8859-1.so
40010000-40011000 rw-p 00001000 03:05 1131518    /usr/lib/gconv/ISO8859-1.so
40011000-4001a000 r-xp 00000000 03:05 1234808    /lib/libnss_files-2.2.93.so
4001a000-4001b000 rw-p 00008000 03:05 1234808    /lib/libnss_files-2.2.93.so
4001f000-40023000 rw-p 00000000 00:00 0
40023000-40223000 r--p 00000000 03:05 886177     /usr/lib/locale/locale-archive
40223000-40255000 r--p 008e1000 03:05 886177     /usr/lib/locale/locale-archive
40255000-40271000 r-xp 00000000 03:05 837381     /usr/X11R6/lib/X11/locale/common/ximcp.so.2
40271000-40273000 rw-p 0001b000 03:05 837381     /usr/X11R6/lib/X11/locale/common/ximcp.so.2
40273000-40283000 r-xp 00000000 03:05 837685     /usr/lib/qt-3.0.5/plugins/styles/bluecurve.so
40283000-40284000 rw-p 00010000 03:05 837685     /usr/lib/qt-3.0.5/plugins/styles/bluecurve.so
40284000-40296000 r--p 00000000 03:05 2772981    /usr/X11R6/lib/X11/fonts/Type1/l048013t.pfa
40296000-402fa000 r--s 00000000 03:05 1117838    /tmp/kde-root/ksycoca
402fa000-40310000 r-xp 00000000 03:05 3818307    /usr/lib/kde3/konq_iconview.so
40310000-40312000 rw-p 00016000 03:05 3818307    /usr/lib/kde3/konq_iconview.so
40312000-40324000 r--p 00000000 03:05 2772983    /usr/X11R6/lib/X11/fonts/Type1/l048016t.pfa
40324000-40330000 r-xp 00000000 03:05 3818525    /usr/lib/kde3/libdirfilterplugin.so
40330000-40331000 rw-p 0000c000 03:05 3818525    /usr/lib/kde3/libdirfilterplugin.so
40331000-40346000 r-xp 00000000 03:05 3818533    /usr/lib/kde3/libkimgallery.so
40346000-40347000 rw-p 00015000 03:05 3818533    /usr/lib/kde3/libkimgallery.so
40347000-40362000 r-xp 00000000 03:05 1366244    /usr/lib/libkjava.so.1.0.0
40362000-40364000 rw-p 0001a000 03:05 1366244    /usr/lib/libkjava.so.1.0.0
40364000-403f6000 r-xp 00000000 03:05 1364978    /usr/lib/libkdeprint.so.4.0.0
403f6000-403fd000 rw-p 00091000 03:05 1364978    /usr/lib/libkdeprint.so.4.0.0
403fd000-4040b000 r-xp 00000000 03:05 3818311    /usr/lib/kde3/konq_shellcmdplugin.so
4040b000-4040c000 rw-p 0000e000 03:05 3818311    /usr/lib/kde3/konq_shellcmdplugin.so
4040c000-40415000 r-xp 00000000 03:05 837386     /usr/X11R6/lib/X11/locale/common/xomGeneric.so.2
40415000-40416000 rw-p 00008000 03:05 837386     /usr/X11R6/lib/X11/locale/common/xomGeneric.so.2
41000000-41012000 r-xp 00000000 03:05 1241025    /lib/ld-2.2.93.so
41012000-41013000 rw-p 00012000 03:05 1241025    /lib/ld-2.2.93.so
41015000-4113b000 r-xp 00000000 03:05 1134855    /lib/i686/libc-2.2.93.so
4113b000-41140000 rw-p 00126000 03:05 1134855    /lib/i686/libc-2.2.93.so
41140000-41144000 rw-p 00000000 00:00 0
41146000-41167000 r-xp 00000000 03:05 1134856    /lib/i686/libm-2.2.93.so
41167000-41168000 rw-p 00021000 03:05 1134856    /lib/i686/libm-2.2.93.so
4116a000-4116c000 r-xp 00000000 03:05 1241026    /lib/libdl-2.2.93.so
4116c000-4116d000 rw-p 00001000 03:05 1241026    /lib/libdl-2.2.93.so
4116f000-4124a000 r-xp 00000000 03:05 1368552    /usr/X11R6/lib/libX11.so.6.2
4124a000-4124d000 rw-p 000da000 03:05 1368552    /usr/X11R6/lib/libX11.so.6.2
4124f000-4125c000 r-xp 00000000 03:05 1364772    /usr/X11R6/lib/libXext.so.6.4
4125c000-4125d000 rw-p 0000c000 03:05 1364772    /usr/X11R6/lib/libXext.so.6.4
4125f000-4126b000 r-xp 00000000 03:05 1364770    /usr/lib/libz.so.1.1.4
4126b000-4126d000 rw-p 0000b000 03:05 1364770    /usr/lib/libz.so.1.1.4
4126f000-41283000 r-xp 00000000 03:05 1364780    /usr/X11R6/lib/libICE.so.6.3
41283000-41284000 rw-p 00013000 03:05 1364780    /usr/X11R6/lib/libICE.so.6.3
41284000-41286000 rw-p 00000000 00:00 0
41288000-41290000 r-xp 00000000 03:05 1364766    /usr/X11R6/lib/libSM.so.6.0
41290000-41291000 rw-p 00007000 03:05 1364766    /usr/X11R6/lib/libSM.so.6.0
41293000-4135e000 r-xp 00000000 03:05 1231259    /lib/libcrypto.so.0.9.6b
4135e000-4136a000 rw-p 000cb000 03:05 1231259    /lib/libcrypto.so.0.9.6b
4136a000-4136d000 rw-p 00000000 00:00 0
4136e000-4137b000 r-xp 00000000 03:05 1130891    /lib/i686/libpthread-0.10.so
4137b000-4137e000 rw-p 0000d000 03:05 1130891    /lib/i686/libpthread-0.10.so
4137e000-4139e000 rw-p 00000000 00:00 0
413a0000-413cd000 r-xp 00000000 03:05 1233592    /lib/libssl.so.0.9.6b
413cd000-413d0000 rw-p 0002d000 03:05 1233592    /lib/libssl.so.0.9.6b
413d2000-413e1000 r-xp 00000000 03:05 1241029    /lib/libresolv-2.2.93.so
413e1000-413e2000 rw-p 0000e000 03:05 1241029    /lib/libresolv-2.2.93.so
413e2000-413e4000 rw-p 00000000 00:00 0
413e6000-41435000 r-xp 00000000 03:05 1364857    /usr/X11R6/lib/libXt.so.6.0
41435000-41439000 rw-p 0004e000 03:05 1364857    /usr/X11R6/lib/libXt.so.6.0
4143b000-41442000 r-xp 00000000 03:05 1241027    /lib/libgcc_s-3.2-20020903.so.1
41442000-41443000 rw-p 00007000 03:05 1241027    /lib/libgcc_s-3.2-20020903.so.1
4145c000-41471000 r-xp 00000000 03:05 1364800    /usr/X11R6/lib/libXmu.so.6.2
41471000-41472000 rw-p 00015000 03:05 1364800    /usr/X11R6/lib/libXmu.so.6.2
41474000-414b9000 r-xp 00000000 03:05 1364798    /usr/lib/libfreetype.so.6.3.1
414b9000-414bd000 rw-p 00045000 03:05 1364798    /usr/lib/libfreetype.so.6.3.1
414bf000-41559000 r-xp 00000000 03:05 1349720    /usr/lib/libstdc++.so.5.0.1
41559000-4156e000 rw-p 0009a000 03:05 1349720    /usr/lib/libstdc++.so.5.0.1
4156e000-41573000 rw-p 00000000 00:00 0
41575000-41591000 r-xp 00000000 03:05 1349581    /usr/lib/libexpat.so.0.3.0
41591000-41595000 rw-p 0001b000 03:05 1349581    /usr/lib/libexpat.so.0.3.0
41597000-415b8000 r-xp 00000000 03:05 1364878    /usr/lib/libfontconfig.so.1.0
415b8000-415bb000 rw-p 00021000 03:05 1364878    /usr/lib/libfontconfig.so.1.0
415bb000-415bc000 rw-p 00000000 00:00 0
415be000-415c2000 r-xp 00000000 03:05 1364788    /usr/X11R6/lib/libXrender.so.1.1
415c2000-415c3000 rw-p 00004000 03:05 1364788    /usr/X11R6/lib/libXrender.so.1.1
415c5000-415e7000 r-xp 00000000 03:05 1349436    /usr/lib/libpng12.so.0.1.2.2
415e7000-415e8000 rw-p 00022000 03:05 1349436    /usr/lib/libpng12.so.0.1.2.2
415ea000-41607000 r-xp 00000000 03:05 1349442    /usr/lib/libjpeg.so.62.0.0
41607000-41608000 rw-p 0001c000 03:05 1349442    /usr/lib/libjpeg.so.62.0.0
4160a000-4161b000 r-xp 00000000 03:05 1349559    /usr/lib/libXft.so.2.0
4161b000-4161c000 rw-p 00010000 03:05 1349559    /usr/lib/libXft.so.2.0
41657000-4166e000 r-xp 00000000 03:05 1365503    /usr/lib/libcups.so.2
4166e000-41670000 rw-p 00017000 03:05 1365503    /usr/lib/libcups.so.2
41670000-41671000 rw-p 00000000 00:00 0
41673000-416eb000 r-xp 00000000 03:05 1349596    /usr/X11R6/lib/libGL.so.1.2
416eb000-416ef000 rw-p 00077000 03:05 1349596    /usr/X11R6/lib/libGL.so.1.2
416ef000-416f2000 rw-p 00000000 00:00 0
416f4000-41736000 r-xp 00000000 03:05 1349497    /usr/lib/libmng.so.1.0.0
41736000-41738000 rw-p 00041000 03:05 1349497    /usr/lib/libmng.so.1.0.0
4173a000-41d4a000 r-xp 00000000 03:05 2527554    /usr/lib/qt-3.0.5/lib/libqt-mt.so.3.0.5
41d4a000-41d89000 rw-p 00610000 03:05 2527554    /usr/lib/qt-3.0.5/lib/libqt-mt.so.3.0.5
41d89000-41d90000 rw-p 00000000 00:00 0
41d92000-41d94000 r-xp 00000000 03:05 1237073    /lib/libutil-2.2.93.so
41d94000-41d95000 rw-p 00001000 03:05 1237073    /lib/libutil-2.2.93.so
41d97000-41dc4000 r-xp 00000000 03:05 1349438    /usr/lib/libDCOP.so.4.0.0
41dc4000-41dc6000 rw-p 0002d000 03:05 1349438    /usr/lib/libDCOP.so.4.0.0
41dc6000-41dc7000 rw-p 00000000 00:00 0
41dc9000-41f17000 r-xp 00000000 03:05 1364904    /usr/lib/libkdecore.so.4.0.0
41f17000-41f20000 rw-p 0014e000 03:05 1364904    /usr/lib/libkdecore.so.4.0.0
41f20000-41f22000 rw-p 00000000 00:00 0
41f24000-42133000 r-xp 00000000 03:05 1364934    /usr/lib/libkdeui.so.4.0.0
42133000-42153000 rw-p 0020e000 03:05 1364934    /usr/lib/libkdeui.so.4.0.0
42153000-42154000 rw-p 00000000 00:00 0
42156000-4217b000 r-xp 00000000 03:05 1364926    /usr/lib/libkdefx.so.4.0.0
4217b000-4217d000 rw-p 00024000 03:05 1364926    /usr/lib/libkdefx.so.4.0.0
421a5000-421bf000 r-xp 00000000 03:05 1357557    /usr/lib/libkdesu.so.4.0.0
421bf000-421c0000 rw-p 00019000 03:05 1357557    /usr/lib/libkdesu.so.4.0.0
421c2000-42426000 r-xp 00000000 03:05 1364950    /usr/lib/libkio.so.4.0.0
42426000-4243d000 rw-p 00263000 03:05 1364950    /usr/lib/libkio.so.4.0.0
4243f000-42476000 r-xp 00000000 03:05 1357912    /usr/lib/libkparts.so.2.0.0
42476000-4247b000 rw-p 00036000 03:05 1357912    /usr/lib/libkparts.so.2.0.0
4247d000-424e5000 r-xp 00000000 03:05 1357666    /usr/lib/libkonq.so.4.0.0
424e5000-424ea000 rw-p 00067000 03:05 1357666    /usr/lib/libkonq.so.4.0.0
424ec000-42585000 r-xp 00000000 03:05 1366032    /usr/lib/konqueror.so
42585000-4258c000 rw-p 00098000 03:05 1366032    /usr/lib/konqueror.so
425c8000-427b6000 r-xp 00000000 03:05 1364966    /usr/lib/libkhtml.so.4.0.0
427b6000-427dc000 rw-p 001ee000 03:05 1364966    /usr/lib/libkhtml.so.4.0.0
427dc000-427dd000 rw-p 00000000 00:00 0
bffeb000-c0000000 rwxp fffec000 00:00 0


	Jakub
