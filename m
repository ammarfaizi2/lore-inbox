Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbTEPCxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 22:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264342AbTEPCxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 22:53:38 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:5276 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264339AbTEPCxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 22:53:37 -0400
Message-Id: <200305160304.h4G34wGi016365@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] allow atm to be loaded as a module 
In-reply-to: Your message of "Thu, 15 May 2003 16:47:32 PDT."
             <20030515.164732.15245120.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 15 May 2003 23:04:58 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030515.164732.15245120.davem@redhat.com>,"David S. Miller" writes:
>space and no compiler is going to do this rearrangement for you.
>Yes, this means use gotos....

*sigh*.  how about this -- its safe to always call the exit stubs.  they
just call sock_unregister which always suceeds.  actually i see very 
few protocol families check the return code from sock_register() --
should i ignore the return code as well?

static int __init atm_init(void)
{
        int error;

        if ((error = atmpvc_init()) < 0) {
                printk(KERN_ERR "atmpvc_init() failed with %d\n", error);
                goto failure;
        }
        if ((error = atmsvc_init()) < 0) {
                printk(KERN_ERR "atmsvc_init() failed with %d\n", error);
                goto failure;
        }
#ifdef CONFIG_PROC_FS
        if ((error = atm_proc_init()) < 0) {
                printk(KERN_ERR "atm_proc_init() failed with %d\n",error);
                goto failure;
        }
#endif
        return 0;

failure:
        atmsvc_exit();
        atmpvc_exit();
        return error;
}
