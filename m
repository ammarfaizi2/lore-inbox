Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129671AbQJaQM7>; Tue, 31 Oct 2000 11:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129713AbQJaQMt>; Tue, 31 Oct 2000 11:12:49 -0500
Received: from devserv.devel.redhat.com ([207.175.42.156]:1290 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129671AbQJaQMj>; Tue, 31 Oct 2000 11:12:39 -0500
Date: Tue, 31 Oct 2000 11:12:38 -0500
From: Crutcher Dunnavant <crutcher@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: update to SysRQ patch
Message-ID: <20001031111238.A23294@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Red Hat, Inc.
X-Department: OS Development
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, the second example module I posted did bad things on 
SMP based machines, so here is a respin of it:


#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/sysrq.h>

/*
 * This is a example of some of the more complex things that
 * the SysRQ registration patch makes possible
 */

void dumpfake_handler (int key, struct pt_regs *pt_regs,
			struct kbd_struct *kbd, struct tty_struct *tty) {
	int i = key - '0';
	printk("<1>Dump fake-device %d\n00 A2 F4 9C 8D 01 34 42\n", i);
}

struct sysrq_key_op dumpfake_op = {
	handler:	dumpfake_handler,
	help_msg:	"dump-fake0-9",
	action_msg:	"Dumping Fake Device\n"
};

struct sysrq_key_op *op_stash[10];
int overloaded = 0;

void overload_handler (int, struct pt_regs *, 
		struct kbd_struct *, struct tty_struct *);
struct sysrq_key_op overload_op = {
	handler:	overload_handler,
	help_msg:	"Fakemenu",
	action_msg:	"Loading Fake Meni\n"
};

/* 
 * keep in mind that this functions is called (ultimately) by
 * handle_sysrq, and as such, is already inside of the table
 * lock. (I forgot this the first time I wrote it, and tried
 * to lock here :)
 * Which works on non-SMP machines :( 
 */
void overload_handler (int key, struct pt_regs *pt_regs,
			struct kbd_struct *kbd, struct tty_struct *tty) {
	int i;
	if (overloaded) {
		overload_op.help_msg = "Fakemenu";
		overload_op.action_msg = "Loading Fake Menu\n";
		for (i=0;i<10;i++) __sysrq_put_key_op(i + '0', op_stash[i]);
		overloaded = 0;
	} else {
		overload_op.help_msg = "unloadFakemenu";
		overload_op.action_msg = "Unloading Fake Menu\n";
		for (i=0;i<10;i++) __sysrq_put_key_op(i + '0', &dumpfake_op);
		overloaded = 1;
	}
}
			
int init_module (void) {
	int i;
	__sysrq_table_lock();
	for (i=0;i<10;i++) op_stash[i] = __sysrq_get_key_op(i + '0');
	__sysrq_table_unlock();
	
	REGISTER_SYSRQ_KEY('f', &overload_op);
	printk("<1>overload example loaded\n");
	return 0;
}

void cleanup_module (void) {
	int i;
	if (overloaded) {
		__sysrq_table_lock();
		for (i=0;i<10;i++) __sysrq_put_key_op(i + '0', op_stash[i]);
		__sysrq_table_unlock();
	}
		
	UNREGISTER_SYSRQ_KEY('f', &overload_op);
	printk("<1>overload example unloaded\n");
}


-- 
"I may be a monkey,     Crutcher Dunnavant 
 but I'm a monkey       <crutcher@redhat.com>
 with ambition!"        Red Hat OS Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
