Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266987AbTGKWTX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 18:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266997AbTGKWTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 18:19:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40646 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266987AbTGKWTS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 18:19:18 -0400
Date: Fri, 11 Jul 2003 23:33:59 +0100
From: Matthew Wilcox <willy@debian.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: do_div vs sector_t
Message-ID: <20030711223359.GP20424@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# define do_div(n,base) ({                              \
        uint32_t __base = (base);                       \
        uint32_t __rem;                                 \
        if (likely(((n) >> 32) == 0)) {                 \

so if we call do_div() on a u32, the compiler emits nasal daemons.
and we do this -- in the antcipatory scheduler:

                if (aic->seek_samples) {
                        aic->seek_mean = aic->seek_total + 128;
                        do_div(aic->seek_mean, aic->seek_samples);
                }

seek_mean is a sector_t so sometimes it's 64-bit on a 32-bit platform.
so we can't avoid calling do_div().

This almost works (the warning is harmless since gcc optimises away the call)

# define do_div(n,base) ({                                              \
        uint32_t __base = (base);                                       \
        uint32_t __rem;                                                 \
        if ((sizeof(n) < 8) || (likely(((n) >> 32) == 0))) {            \
                __rem = (uint32_t)(n) % __base;                         \
                (n) = (uint32_t)(n) / __base;                           \
        } else                                                          \
                __rem = __div64_32(&(n), __base);                       \
        __rem;                                                          \
 })

Better ideas?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
