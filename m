Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274062AbRJNE0D>; Sun, 14 Oct 2001 00:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274064AbRJNEZx>; Sun, 14 Oct 2001 00:25:53 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:50950 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274062AbRJNEZg>;
	Sun, 14 Oct 2001 00:25:36 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <andrewm@uow.edu.au>
Subject: Recursive deadlock on die_lock
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Oct 2001 14:25:52 +1000
Message-ID: <27496.1003033552@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Typical die() code.

spinlock_t die_lock = SPIN_LOCK_UNLOCKED;

void die(const char * str, struct pt_regs * regs, long err)
{
        console_verbose();
        spin_lock_irq(&die_lock);
        bust_spinlocks(1);
        printk("%s: %04lx\n", str, err & 0xffff);
        show_registers(regs);
        bust_spinlocks(0);
        spin_unlock_irq(&die_lock);
        do_exit(SIGSEGV);
}

If show_registers() fails (which it does far too often on IA64) then
the system deadlocks trying to recursively obtain die_lock.  Also
die_lock is never used outside die(), it should be proc local.
Suggested fix:

void die(const char * str, struct pt_regs * regs, long err)
{
	static spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
	static int die_lock_owner = -1, die_lock_owner_depth = 0;

	if (die_lock_owner != smp_processor_id()) {
		console_verbose();
		spin_lock_irq(&die_lock);
		die_lock_owner = smp_processor_id();
		die_lock_owner_depth = 0;
		bust_spinlocks(1);
	}

	if (++die_lock_owner_depth < 3) {
		printk("%s: %04lx\n", str, err & 0xffff);
		show_registers(regs);
	}
	else
		printk(KERN_ERR "Recursive die() failure, registers suppressed\n");

	bust_spinlocks(0);
	die_lock_owner = -1;
	spin_unlock_irq(&die_lock);
        do_exit(SIGSEGV);
}

