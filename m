Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271634AbRHUK2L>; Tue, 21 Aug 2001 06:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271635AbRHUK2B>; Tue, 21 Aug 2001 06:28:01 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:15374 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S271634AbRHUK1s>;
	Tue, 21 Aug 2001 06:27:48 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Brian Dushaw <dushaw@apl.washington.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.8-ac8, agpgart, r128, and mtrr 
In-Reply-To: Your message of "Tue, 21 Aug 2001 05:01:53 MST."
             <Pine.LNX.4.33.0108210423110.3231-100000@munk.apl.washington.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Aug 2001 20:27:58 +1000
Message-ID: <2329.998389678@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001 05:01:53 -0700 (PDT), 
Brian Dushaw <dushaw@apl.washington.edu> wrote:
>I have an ATI Technologies Inc Rage 128 PF video card.
>The module r128.o needs to have agpgart loaded first and depmod
>does not seem to set this up properly.  I've added the line:
>"pre-install r128 modprobe agpgart " to my /etc/modules.conf file.

"before r128 agpgart" is better.

>I wouldn't have thought this would require user intervention like this.

modprobe and depmod only handle direct symbol dependencies between
modules.  The only symbols exported by agpgart are agp_free_memory,
agp_allocate_memory, agp_copy_info, agp_bind_memory, agp_unbind_memory,
agp_enable, agp_backend_acquire, agp_backend_release.  None of these
symbols are referenced by r128 so modprobe is quite correct, there is
no symbol dependency between agpgart and r128.  If you want it to be
automatic, then r128 must reference an agpgart symbol.

But the drm maintainers decided not to rely on agp.  If agp is present
it will be used, if agp is not present then drm runs without it.
drivers/char/drm/drm_agpsupport.h uses inter_module_get() to see if agp
is loaded and to extract agp data, if available.  This allows drm to
run without forcing agp to be present and loaded.  So if you want agp
before drm, it must be explicitly loaded.  Design decision.

>Aug 20 13:04:37 localhost modprobe: modprobe: Can't locate module block-major-33

block-major-33 is the third IDE hard disk/CD-ROM interface, for hd[ef].

>Aug 20 13:04:40 localhost modprobe: modprobe: Can't locate module char-major-226

char-major-226 is DRI (DRM_MAJOR).  That one puzzles me, I cannot see
where it is being triggered from.

