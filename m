Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267583AbTAQQlk>; Fri, 17 Jan 2003 11:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267588AbTAQQlk>; Fri, 17 Jan 2003 11:41:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27141 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267583AbTAQQlj>; Fri, 17 Jan 2003 11:41:39 -0500
Date: Fri, 17 Jan 2003 16:50:29 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Mikael Pettersson <mikpe@csd.uu.se>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
Message-ID: <20030117165029.B13888@flint.arm.linux.org.uk>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Mikael Pettersson <mikpe@csd.uu.se>, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org
References: <m1adhzg3fp.fsf@frodo.biederman.org> <Pine.LNX.4.44.0301171019220.15056-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0301171019220.15056-100000@chaos.physics.uiowa.edu>; from kai@tp1.ruhr-uni-bochum.de on Fri, Jan 17, 2003 at 10:24:42AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 10:24:42AM -0600, Kai Germaschewski wrote:
> Can both of you guys elaborate on what "break" means here

You've already realised my problem I think - if you set the address
of a section explicitly, symbols around that section are set "not
as expected" unless they are inside the section itself.

> Related issue: The linker will actually automatically emit
> __{start,stop}_SECTION symbols when SECTION is a C symbol (i.e.  
> letters,numbers,_), so things should actually work without explicitly
> defining those symbols. They do on i386 with my binutils, but I assume
> there's some reason why we don't just rely on that?

It doesn't seem to be guaranteed.  For instance:

c03dddc8 ? __ksymtab_linkwatch_fire_event
c03dddd0 ? __ksymtab_profile_event_register
c03dddd0 A __start___gpl_ksymtab
c03dddd0 A __stop___ksymtab
c03dddd8 ? __ksymtab_profile_event_unregister
c03ddde0 ? __ksymtab_dequeue_signal
...
c03ddec8 ? __ksymtab_xfrm_ealg_get_byname
c03dded0 ? __kstrtab_sa1100fb_backlight_power
c03dded0 A __stop___gpl_ksymtab
c03ddeec ? __kstrtab_sa1100fb_lcd_power
c03ddf00 ? __kstrtab_sa1100_request_dma
...
c03e51e0 ? __kstrtab_register_gifconf
c03e51f4 ? __kstrtab_softnet_data
c03e5204 ? __kstrtab_linkwatch_fire_event
c03e6000 D init_thread_union
c03e8000 d runqueues
c03e8940 D tasklist_lock

Note that __start___ksymtab_strings and __stop___ksymtab_strings don't
exist, despite __ksymtab_strings being C symbol-like.

The only __start_ / __stop_ symbols which appear in System.map are those
which are explicitly defined:

rmk@raistlin:[linux-sa1100]:<1004> grep '__start_\|__stop_' System.map 
c021d050 ? __start___param
c021d050 ? __stop___param
c03da0b0 ? __start___ex_table
c03daa48 ? __stop___ex_table
c03daa58 A __start___ksymtab
c03dddd0 A __start___gpl_ksymtab
c03dddd0 A __stop___ksymtab
c03dded0 A __stop___gpl_ksymtab
rmk@raistlin:[rmk]:<1005> 

The only time that I've seen the linker automatically generate the __start_
and __stop_ symbols for a section is when the section isn't explicitly
placed by the linker file.  When sections aren't explicitly placed, more
things go wrong (the linker places them at some random address way outside
the kernel image) so this isn't an unacceptable solution either.

(This is as seen with ARM ld versions 2.10.1, 2.11.2, 2.12.1)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

