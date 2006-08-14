Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbWHNXdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWHNXdE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 19:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbWHNXdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 19:33:03 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36359 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965053AbWHNXdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 19:33:01 -0400
Date: Tue, 15 Aug 2006 01:33:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Hans Verkuil <hverkuil@xs4all.nl>, mchehab@infradead.org
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: drivers/media/video/tvp5150.c:tvp5150_selmux() looks wrong
Message-ID: <20060814233300.GA3543@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted this very strange code introduced by commit 
c7c0b34c27bbf0671807e902fbfea6270c8f138d:

<--  snip  -->

...
static inline void tvp5150_selmux(struct i2c_client *c)
{
        int opmode=0;
        struct tvp5150 *decoder = i2c_get_clientdata(c);
        int input = 0;

        if ((decoder->route.output & TVP5150_BLACK_SCREEN) || !decoder->enable)
                input = 8;

        switch (input) {
        case TVP5150_COMPOSITE1:
                input |= 2;
                /* fall through */
        case TVP5150_COMPOSITE0:
                opmode=0x30;            /* TV Mode */
                break;
        case TVP5150_SVIDEO:
        default:
                input |= 1;
                opmode=0;               /* Auto Mode */
                break;
        }

        tvp5150_write(c, TVP5150_OP_MODE_CTL, opmode);
        tvp5150_write(c, TVP5150_VD_IN_SRC_SEL_1, input);
};
...

<--  snip  -->

What is done with "input" looks really buggy (e.g. it's either 0 or 8 
and the switch checks for 0, 1, 2).

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

