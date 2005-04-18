Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVDRBqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVDRBqQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 21:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVDRBqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 21:46:16 -0400
Received: from alt.aurema.com ([203.217.18.57]:57757 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261585AbVDRBqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 21:46:06 -0400
Date: Mon, 18 Apr 2005 11:29:51 +1000
From: Kingsley Cheung <kingsley@aurema.com>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org
Subject: Relayfs Question: Use of relay_reset().  Potential race?
Message-ID: <20050418012951.GC4846@aurema.com>
Mail-Followup-To: Tom Zanussi <zanussi@us.ibm.com>,
	Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org
References: <20050323090254.GA10630@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323090254.GA10630@aurema.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 08:02:54PM +1100, kingsley@aurema.com wrote:
> Hi 
> 
> I'm using relayfs to relay data from a kernel module to user space on
> a SuSE 2.6.5 kernel.  I'm not absolutely sure what version of relayfs
> has been back ported to it.

Hi Tom,

Could you please have a look at the following use of relay_reset() in
a kernel module as follows (compiled against pre-redux relayfs):

static int
exec_fileop_notify(int rchan_id, struct file *filp, enum relay_fileop op)
{
        if (unlikely(rchan_id != exec_cid)) {
                printk(KERN_ERR "%s - bad file number\n", __FUNCTION__);
                return -EBADF;
        }

        switch (op) {
        case RELAY_FILE_OPEN:
                atomic_inc(&exec_client_cnt);
                break;
        case RELAY_FILE_CLOSE:
                if (atomic_dec_and_test(&exec_client_cnt) == 0)
                        relay_reset(exec_cid); <---
                break;
        default:
                /* do nothing */
                break;
        }

        return 0;
}

Is that legitimate?  The reason I ask is because I've been seeing
garbled oopses with keventd and I've narrowed it to two things:

1) Inadequate locking on my part in the kernel module, which I have
addressed separately.

2) A race with relay_reset() and keventd, which is probably of
interest to you if you're still maintaining the pre-redux patches.

The race is due to the use of INIT_WORK in _reset_relay():

INIT_WORK(&rchan->wake_readers, NULL, NULL);
INIT_WORK(&rchan->wake_writers, NULL, NULL);

However, at the time relay_reset() is called, it is possible that
these work structures are still being used by keventd when under heavy
loads.  The workaround I've used to fix this is to call
flush_scheduled_work() before calling reset_relay() in the kernel
module.  Perhaps that needs to be called in relay_reset() or
_relay_reset()?

As well I'm not sure about the uses of INIT_WORK in
_relay_realloc_buffer() and relay_release() - perhaps they need
attention too.  I understand, however, that flush_schedule_work()
blocks and thus it probably shouldn't be used in certain areas of the
relayfs code.

My thanks,
-- 
		Kingsley
