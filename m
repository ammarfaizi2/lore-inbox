Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261547AbRFKRwU>; Mon, 11 Jun 2001 13:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbRFKRwK>; Mon, 11 Jun 2001 13:52:10 -0400
Received: from intranet.resilience.com ([209.245.157.33]:1670 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S261547AbRFKRv7>; Mon, 11 Jun 2001 13:51:59 -0400
Message-ID: <3B25068B.53F2968A@resilience.com>
Date: Mon, 11 Jun 2001 10:57:31 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with arch/i386/kernel/apm.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I've been debugging a problem I've been having with APM.  When I
initiate an "apm --suspend" command, my Tulip card doesn't work
anymore.  However, if I then execute "ifconfig eth0 down ; ifconfig eth0
up" then everything is fine again.

I initially thought the problem was on the Tulip driver side, so I
instrumented the code and found that the driver was correctly processing
incoming and outgoing packets, but it appeared the tx ring was out of
sync with the driver.

Since the tulip_suspend, and tulip_resume functions were basically doing
the same thing as what "ifconfig eth0 down/up" (WRT to the Tulip driver)
I began to look elsewhere.  I think I've tracked the problem down to the
following code:

static int suspend(void)
{
        int             err;
        struct apm_user *as;
 
	...
        cli();
        err = apm_set_power_state(APM_STATE_SUSPEND);
	...
        send_event(APM_NORMAL_RESUME);
        sti();
	...
        return err;
}                                                                                       

So it seems that drivers are suspended before the cli(), yet they are
resumed before the sti().  It seems to me that the sti() should come
before apm::send_event(APM_NORMAL_RESUME), and, in fact, if I swap the
two, Tulip survives suspend/resume

Please let me know if this is correct, I can provide a simple patch if
needed.  What I am really desiring to know is if there are any devices
that depend on the apm::send_event(APM_NORMAL_RESUME) happening while
interrupts are disabled.

-Jeff

-- 
Jeff Golds
Sr. Software Engineer
jgolds@resilience.com
