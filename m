Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264861AbUEJQfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264861AbUEJQfS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264864AbUEJQfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:35:16 -0400
Received: from cs-public.bu.edu ([128.197.12.2]:57775 "EHLO cs.bu.edu")
	by vger.kernel.org with ESMTP id S264861AbUEJQfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:35:05 -0400
Date: Mon, 10 May 2004 12:36:07 -0400
From: Gary Wong <gtw@cs.bu.edu>
To: linux-kernel@vger.kernel.org
Subject: Segmentation fault in i810_audio.c:__i810_update_lvi
Message-ID: <20040510123607.T9078@cs.bu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that buggy programs can cause a segmentation fault in the
i810_audio module.  (I noticed the problem in DRIVER_VERSION 0.23, and
a quick peek at the 0.24 source looks as if it is still present
there.)

The problem is that if somebody opens the DSP as O_RDONLY, and then
generates a SNDCTL_DSP_SETTRIGGER with both PCM_ENABLE_INPUT and
PCM_ENABLE_OUTPUT, dmabuf->trigger will have both of those two bits
set.  This doesn't cause an immediate problem, but once i810_release()
is eventually called, it will notice the PCM_ENABLE_OUTPUT bit and
call drain_dac(), which in turn calls i810_update_lvi(), and
__i810_update_lvi(), which will cause a segmentation fault
dereferencing dmabuf->write_channel->port (where write_channel is
NULL; the channel was never established, since file->f_mode does
not include FMODE_WRITE).

I believe that one of two fixes should be applied: either the
SNDCTL_DSP_SETTRIGGER ioctl handling should not enable the
PCM_ENABLE_{IN,OUT}PUT bits unless file->f_mode is compatible,
or i810_release() should ignore the PCM_ENABLE_* bits without
the corresponding FMODE_*.

I am happy to provide a patch to i810_audio.c implementing whichever
solution you prefer, or I can send a test case and oops and backtrace
information if it will help, but I wanted to check first to see if
you already have a report about the problem and if it is still present
in the latest revision.

Cheers,
Gary.
-- 
     Gary Wong          gtw@cs.bu.edu          http://cs-people.bu.edu/gtw/
