Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVAWDXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVAWDXt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 22:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVAWDXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 22:23:49 -0500
Received: from mail.telester.ee ([194.204.18.108]:28611 "EHLO mail.telester.ee")
	by vger.kernel.org with ESMTP id S261195AbVAWDXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 22:23:46 -0500
Subject: Trying to fix radeonfb suspending on IBM Thinkpad T41
From: Antti Andreimann <Antti.Andreimann@mail.ee>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 23 Jan 2005 05:25:04 +0200
Message-Id: <1106450704.10594.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear community!

The aim of this post is to discuss the radeonfb driver power management
issues. Enabling this feature dramatically reduces power consumtion
during ACPI suspend to ram. I would appriciate comments from people who
are more familiar with Radeon HW programming.

Long and boring background
--------------------------
I have a beast called IBM ThinkPad T41. Model No. 2373-2FG
Since 2.6.9 ACPI suspend to RAM (S3) has been working nicely, but the
power consumption during sleep is unacceptably high: the battery will
run dry in about 5-6 hours in sleep mode.
The root cause of this is the fact that not all hardware is properly
turned off. Namely, at least ethernet adapter, USB and most notably
graphics accelerator chip (Radeon Mobility M7 LW) remain powered on.
Unfortunately current radeonfb driver is hardcoded to do power
management only on PPC platform.
Volker Braun has some kernels on his page
(http://www.sas.upenn.edu/~vbraun/computing/T41/kernel.html) that
incorporate his patch to enable PM on other platforms as well. He also
owns a T41, but It's a bit different model and those kernels do not
resume properly on my laptop: the machine crashes hard on resume.
After a few hours of hacking around in radeonfb sources I think I found
the problem and fixed it for my hardware. The results are promising: the
power consumption during sleep is about 4-5 times lower: 15min ACPI
sleep consumes 1100mW/h without radeonfb and only 230mW/h with properly
patched radeonfb driver loaded.

A question to anyone familiar with radeon hardware programming
--------------------------------------------------------------
The radeonfb driver has a power management implementation that is used
on PPC platform (Macintosh laptops ;). The same implementation seems to
work fine on some Thinkpads, but crashes on others. In
drivers/video/aty/radeon_pm.c resides a function called:
radeon_pm_setup_for_suspend. This function has a following section that
manages to crash at least my laptop:

/* AGP PLL control */
OUTREG(BUS_CNTL1, INREG(BUS_CNTL1) |  BUS_CNTL1__AGPCLK_VALID);

OUTREG(BUS_CNTL1,
     (INREG(BUS_CNTL1) & ~BUS_CNTL1__MOBILE_PLATFORM_SEL_MASK)
     | (2<<BUS_CNTL1__MOBILE_PLATFORM_SEL__SHIFT));  // 440BX
OUTREG(CRTC_OFFSET_CNTL, (INREG(CRTC_OFFSET_CNTL) &
      ~CRTC_OFFSET_CNTL__CRTC_STEREO_SYNC_OUT_EN));

clk_pin_cntl &= ~CLK_PIN_CNTL__CG_CLK_TO_OUTPIN;
clk_pin_cntl |= CLK_PIN_CNTL__XTALIN_ALWAYS_ONb;
OUTPLL( pllCLK_PIN_CNTL, clk_pin_cntl);

It can be seen from the comments that this code is specific to Intel
440BX or similar chipset and this is most probably the reason it manages
to crash machines that are based on a different chip.

What exactly does this piece of code do and is it needed after all? My
machine seems to work fine without it.
If it is needed, is it possible to make it more generic?

-- 
 Antti Andreimann - Security Consultant
      Using Linux since 1993
  Member of ELUG since 29.01.2000
