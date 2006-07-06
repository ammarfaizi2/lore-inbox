Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbWGFQRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWGFQRr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWGFQRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:17:47 -0400
Received: from 68-191-203-42.static.stls.mo.charter.com ([68.191.203.42]:64544
	"EHLO service.eng.exegy.net") by vger.kernel.org with ESMTP
	id S1030303AbWGFQRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:17:46 -0400
Message-ID: <44AD37C2.50601@exegy.com>
Date: Thu, 06 Jul 2006 11:18:10 -0500
From: "Mr. Berkley Shands" <bshands@exegy.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1.centos4 (X11/20060421)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Dave Lloyd <dlloyd@exegy.com>
Subject: 2.6.17 x86_64 regression - reboot fails due to deadlock
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jul 2006 16:17:45.0408 (UTC) FILETIME=[B70D9C00:01C6A117]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With a SuperMicro H8DC8 (nvidia chipset), Dual Opteron 285's, 16GB, 
Centos 4.3 -

Under 2.6.16 both the tyan 2895 and the supermicro H8DC8 both will 
reboot corectly,
in kernel/sys.c machine_restart() gets called. But with the changes to 
sys.c under 2.6.17,
a new path is introduced, calling void kernel_restart_prepare(char *cmd)
which calls blocking_notifier_call_chain(&reboot_notifier_list, 
SYS_RESTART, cmd); (line 588)
Which looks at the first element of the notifier list, and blocks 
forever. But ONLY on the supermicro.
The tyan, a very similar motherboard does not deadlock. It returns and 
still calls machine_restart().
So neither reboot nor "shutdown -fh now" actually get to the bios calls.

on the supermicro, (linux-2.6.17/kernel/sys.c)

static int __kprobes notifier_call_chain(struct notifier_block **nl,
                unsigned long val, void *v)
{
        int ret = NOTIFY_DONE;
        struct notifier_block *nb;

        nb = rcu_dereference(*nl);
        while (nb) {
                ret = nb->notifier_call(nb, val, v);         /* this is 
the deadlock for the first entry */
                if ((ret & NOTIFY_STOP_MASK) == NOTIFY_STOP_MASK)
                        break;
                nb = rcu_dereference(nb->next);
        }
        return ret;
}

I see that 2.6.18 reworks this code further.

If I want to hurt myself really, really badly, disabling the call to 
blocking_notifier_call_chain(&reboot_notifier_list,...
restores the reboot/power off functions.

In kdb, the system sits idle awaiting something to schedule, but nothing 
will schedule since there is
a deadlock on the supermicro. Any clues as to how to find which notifier 
is deadlocked?

berkley




