Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753768AbWKFS1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbWKFS1R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 13:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbWKFS1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 13:27:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57362 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1753768AbWKFS1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 13:27:16 -0500
Date: Mon, 6 Nov 2006 19:27:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: dvb_frontend_swzigzag(): uninitialized variable usage
Message-ID: <20061106182714.GA8099@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted the following in 
drivers/media/dvb/dvb-core/dvb_frontend.c:

<--  snip  -->

...
static void dvb_frontend_swzigzag(struct dvb_frontend *fe)
{
        fe_status_t s;
        struct dvb_frontend_private *fepriv = fe->frontend_priv;

        /* if we've got no parameters, just keep idling */
        if (fepriv->state & FESTATE_IDLE) {
                fepriv->delay = 3*HZ;
                fepriv->quality = 0;
                return;
        }

        /* in SCAN mode, we just set the frontend when asked and leave it alone */
        if (fepriv->tune_mode_flags & FE_TUNE_MODE_ONESHOT) {
                if (fepriv->state & FESTATE_RETUNE) {
                        if (fe->ops.set_frontend)
                                fe->ops.set_frontend(fe, &fepriv->parameters);
                        fepriv->state = FESTATE_TUNED;
                }
                fepriv->delay = 3*HZ;
                fepriv->quality = 0;
                return;
        }

        /* get the frontend status */
        if (fepriv->state & FESTATE_RETUNE) {
                s = 0;
        } else {
                if (fe->ops.read_status)
                        fe->ops.read_status(fe, &s);
                if (s != fepriv->status) {
                        dvb_frontend_add_event(fe, s);
                        fepriv->status = s;
                }
        }
...

<--  snip  -->

Note that in the "if (s != fepriv->status)", "s" could be used 
uninitialized.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

