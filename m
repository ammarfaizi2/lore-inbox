Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbUD1Uq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUD1Uq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUD1Uqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:46:39 -0400
Received: from gprs214-227.eurotel.cz ([160.218.214.227]:46720 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261258AbUD1UnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 16:43:00 -0400
Date: Wed, 28 Apr 2004 22:42:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: Something wrong with mouse timeouts
Message-ID: <20040428204246.GB1390@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Code is at least *very* confusing in psmouse_command; I think its
buggy:

        if (command == PSMOUSE_CMD_RESET_BAT)
B =>             timeout = 4000000; /* 4 sec */

        /* initialize cmdbuf with preset values from param */
        if (receive)
           for (i = 0; i < receive; i++)
                psmouse->cmdbuf[(receive - 1) - i] = param[i];

        if (command & 0xff)
                if (psmouse_sendbyte(psmouse, command & 0xff))
                        return (psmouse->cmdcnt = 0) - 1;

        for (i = 0; i < send; i++)
                if (psmouse_sendbyte(psmouse, param[i]))
                        return (psmouse->cmdcnt = 0) - 1;

        while (psmouse->cmdcnt && timeout--) {

C =>            if (psmouse->cmdcnt == 1 && command == PSMOUSE_CMD_RESET_BAT &&
                                timeout > 100000) /* do not run in a endless loop */
A =>	                  timeout = 100000; /* 1 sec */


                if (psmouse->cmdcnt == 1 && command == PSMOUSE_CMD_GETID &&
                    psmouse->cmdbuf[1] != 0xab && psmouse->cmdbuf[1] != 0xac) {
                        psmouse->cmdcnt = 0;
                        break;
                }

                udelay(1);
        }

In A), it says that it sets timeout to 1 sec, when it in fact sets it
to 100msec. Whats more, for CMD_RESET_BAT, timeout is explicitely set
to 4sec B); but in C), there is extra code to reset it to 100msec?
Why? Is it trying to set shorter timeout for last byte of reply or
something similar?

It speaks about endless loops, but 4 sec is certainly not endless if
you ask me.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
