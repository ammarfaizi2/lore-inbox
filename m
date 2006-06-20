Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWFTOk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWFTOk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWFTOk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:40:56 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:26854 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751124AbWFTOkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:40:55 -0400
Date: Tue, 20 Jun 2006 11:40:32 -0300
From: Tony Rowe <ay986@chebucto.ns.ca>
To: linux-kernel@vger.kernel.org
Subject: Porting BSD console screensavers to Linux
Message-ID: <20060620144032.GA1919@chebucto.ns.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been wondering about this for a few years. Are there any 
[non-locking] screensavers for the Linux console like 'warp_saver' which 
is implemented in the BSD kernel I think?  Could the BSD syscons 
screensavers be implemented in the Linux kernel?  The warp_saver.c is 
included below.

Thanks for all the good work,
Tony Rowe

modules/syscons/warp/warp_saver.c     

http://freebsd.active-venture.com/FreeBSD-srctree/newsrc/modules/syscons/warp/warp_saver.c.html
 
/*-
 * Copyright (c) 1998 Dag-Erling Coïdan Smørgrav
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer
 *    in this position and unchanged.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $FreeBSD: src/sys/modules/syscons/warp/warp_saver.c,v 1.7.2.1 2000/05/10 16:
26:47 obrien Exp $
 */

#include <sys/param.h>
#include <sys/systm.h>
#include <sys/kernel.h>
#include <sys/module.h>
#include <sys/syslog.h>
#include <sys/consio.h>
#include <sys/fbio.h>
#include <sys/random.h>

#include <dev/fb/fbreg.h>
#include <dev/fb/splashreg.h>
#include <dev/syscons/syscons.h>

static u_char *vid;
static int blanked;

#define SCRW 320
#define SCRH 200
#define SPP 15
#define STARS (SPP*(1+2+4+8))

static int star[STARS];
static u_char warp_pal[768] = {
    0x00, 0x00, 0x00,
    0x66, 0x66, 0x66,
    0x99, 0x99, 0x99,
    0xcc, 0xcc, 0xcc,
    0xff, 0xff, 0xff
    /* the rest is zero-filled by the compiler */
};

static void
warp_update(void)
{
    int i, j, k, n;

    for (i = 1, k = 0, n = SPP*8; i < 5; i++, n /= 2)
        for (j = 0; j < n; j++, k++) {
            vid[star[k]] = 0;
            star[k] += i;
            if (star[k] > SCRW*SCRH)
                star[k] -= SCRW*SCRH;
            vid[star[k]] = i;
        }
}

static int
warp_saver(video_adapter_t *adp, int blank)
{
    int pl;

    if (blank) {
        /* switch to graphics mode */
        if (blanked <= 0) {
            pl = splhigh();
            set_video_mode(adp, M_VGA_CG320);
            load_palette(adp, warp_pal);
#if 0 /* XXX conflict */
            set_border(adp, 0);
#endif
            blanked++;
            vid = (u_char *)adp->va_window;
            splx(pl);
            bzero(vid, SCRW*SCRH);
        }

        /* update display */
        warp_update();

    } else {
        blanked = 0;
    }
    return 0;
}

static int
warp_init(video_adapter_t *adp)
{
    video_info_t info;
    int i;

    /* check that the console is capable of running in 320x200x256 */
    if (get_mode_info(adp, M_VGA_CG320, &info)) {
        log(LOG_NOTICE, "warp_saver: the console does not support M_VGA_CG320\n
");
        return ENODEV;
    }

    /* randomize the star field */
    for (i = 0; i < STARS; i++) {
        star[i] = random() % (SCRW*SCRH);
    }

    blanked = 0;

    return 0;
}

static int
warp_term(video_adapter_t *adp)
{
    return 0;
}

static scrn_saver_t warp_module = {
    "warp_saver", warp_init, warp_term, warp_saver, NULL,



