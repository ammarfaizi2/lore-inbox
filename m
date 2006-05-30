Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751530AbWE3QBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbWE3QBB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 12:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWE3QBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 12:01:00 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:44690 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1751528AbWE3QBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 12:01:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=PbhDnpSgn6Eu9rfuPX8cq/ov3tSc4yinF4k/h9U6bOgrHAXJkjkfnV4iV/KD52Nh/GjsIkyffu/I6vV+7DBRHpcxwA9ECAyWOt2V2ciWDycTZAr2alrEh9GgU9RKsHusUSh+aLOMR5713IcnpvYeuQ2TEbF7eQ4hJNSAlVFIBZY=;
Date: Tue, 30 May 2006 20:00:24 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@vger.kernel.org,
       alan@redhat.com
Subject: Re: [patch, -rc5-mm1] lock validator: remove softirq.c WARN_ON
Message-ID: <20060530160024.GA8987@ms2.inr.ac.ru>
References: <20060530022925.8a67b613.akpm@osdl.org> <447C261E.1090202@gmail.com> <20060530115545.GA7025@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530115545.GA7025@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> ok, that WARN_ON is over-eager. Fix is below:

Nevertheless, I cannot figure out what's happening here.

This local_bh_disable() is called right after schedule().
No way irqs can be disabled there. What is wrong?


static void netlink_table_grab(void)
{
        write_lock_bh(&nl_table_lock);

        if (atomic_read(&nl_table_users)) {
                DECLARE_WAITQUEUE(wait, current);

                add_wait_queue_exclusive(&nl_table_wait, &wait);
                for(;;) {
                        set_current_state(TASK_UNINTERRUPTIBLE);
                        if (atomic_read(&nl_table_users) == 0)
                                break;
                        write_unlock_bh(&nl_table_lock);
                        schedule();
                        write_lock_bh(&nl_table_lock);
                }

                __set_current_state(TASK_RUNNING);
                remove_wait_queue(&nl_table_wait, &wait);
        }
}


Alexey
