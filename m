Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSILHzm>; Thu, 12 Sep 2002 03:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSILHzl>; Thu, 12 Sep 2002 03:55:41 -0400
Received: from firewall.osb.hu ([193.224.234.1]:61958 "EHLO firewall")
	by vger.kernel.org with ESMTP id <S313305AbSILHzi>;
	Thu, 12 Sep 2002 03:55:38 -0400
Date: Thu, 12 Sep 2002 09:54:25 +0200 (CEST)
From: Soos Peter <sp@osb.hu>
To: linux-kernel@vger.kernel.org
Subject: spinlocks and polling
Message-ID: <Pine.LNX.4.44.0209120926230.3311-100000@sppc.intranet.osb.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello List,

I'm new to the list and not a native English speaker.

I develop a module for HP laptops and I have a problem. Most of 
(PIII/Celeron) HP laptops have some mutimedia buttons. After enabling them 
they generate scancodes expect on HP OmniBook XE3 GF/HP Pavilion N52xx. On 
these models the volume control buttons do not generate scancodes.
It is possible to get button press info from Embedded Controller as 
follows (only the substantial parts of the code):


#define OMNIBOOK_POLL                           50 * HZ / 1000

static struct timer_list omnibook_key_timer;
static spinlock_t omnibook_ec_lock = SPIN_LOCK_UNLOCKED;

int omnibook_ec_read(u8 addr, u8 *data)
{
        unsigned long flags;
        int retval;

        spin_lock_irqsave(&omnibook_ec_lock, flags);
        retval = omnibook_ec_wait(OMNIBOOK_EC_STAT_IBF);
        if (retval)
                goto end;
        omnibook_ec_write_command(OMNIBOOK_EC_CMD_READ);
        retval = omnibook_ec_wait(OMNIBOOK_EC_STAT_IBF);
        if (retval)
                goto end;
        omnibook_ec_write_data(addr);
        retval = omnibook_ec_wait(OMNIBOOK_EC_STAT_OBF);
        if (retval)
                goto end;
        *data = omnibook_ec_read_data();
end:
        spin_unlock_irqrestore(&omnibook_ec_lock, flags);
        return retval;
}

int omnibook_ec_write(u8 addr, u8 data)
{

        unsigned long flags;
        int retval;

        spin_lock_irqsave(&omnibook_ec_lock, flags);
        retval = omnibook_ec_wait(OMNIBOOK_EC_STAT_IBF);
        if (retval)
                goto end;
        omnibook_ec_write_command(OMNIBOOK_EC_CMD_WRITE);
        retval = omnibook_ec_wait(OMNIBOOK_EC_STAT_IBF);
        if (retval)
                goto end;
        omnibook_ec_write_data(addr);
        retval = omnibook_ec_wait(OMNIBOOK_EC_STAT_IBF);
        if (retval)
                goto end;
        omnibook_ec_write_data(data);
end:
        spin_unlock_irqrestore(&omnibook_ec_lock, flags);
        return retval;
}

static void xe3gc_key_poller(unsigned long dummy)
{
	u8 q0a;

	omnibook_ec_read(XE3GC_Q0A, &q0a);
	omnibook_ec_write(XE3GC_Q0A, 0);

	if (q0a & XE3GC_VOLD_MASK) {
		printk(KERN_INFO "%s: Fn-down arrow or Volume down pressed.\n", MODULE_NAME);
	}
	if (q0a & XE3GC_VOLU_MASK) {
		printk(KERN_INFO "%s: Fn-up arrow or Volume up pressed.\n", MODULE_NAME);
	}
	if (q0a & XE3GC_MUTE_MASK) {
		printk(KERN_INFO "%s: Fn+F7 - Volume mute pressed.\n", MODULE_NAME);
	}

	mod_timer(&omnibook_key_timer, jiffies + OMNIBOOK_POLL);
}


int __init module_init(void)
{
	...

	init_timer(&omnibook_key_timer);
	key_timer.data = 0;
	key_timer.function = xe3gc_key_poller;
	key_timer.expires = jiffies + OMNIBOOK_POLL;
	add_timer(&omnibook_key_timer);

	...
}

It is working but through spinlocks the interrupt sensible drives doesn't 
works (e.g. ppp interface have 5-80% of packet loss) when the OMNIBOOK_POLL
value is in the usable range. This is too high price for the volume 
control buttons.

Does anybody idea to solve this problem?

Thanks,
Peter

-- 
Soós Péter		Pannonhalmi Fõapátság / Archabbey of Pannonhalma
			H-9090 Pannonhalma, Vár 1.
			Tel: +3696570189, Fax: +3696470011







