Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbUDTJU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbUDTJU7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 05:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbUDTJU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 05:20:59 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:38805 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S262454AbUDTJJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 05:09:29 -0400
Message-ID: <4084E8BF.2CEAE31F@nospam.org>
Date: Tue, 20 Apr 2004 11:09:19 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Dynamic System Calls & System Call Hijacking - demo syscall
Content-Type: multipart/mixed;
 boundary="------------8CCCCBBAB9EEE4142AA23BCE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8CCCCBBAB9EEE4142AA23BCE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

 
--------------8CCCCBBAB9EEE4142AA23BCE
Content-Type: text/plain; charset=us-ascii;
 name="foo.c"
Content-Disposition: inline;
 filename="foo.c"
Content-Transfer-Encoding: 7bit

/*
 * Demo dynamic syscall
 */


#include <linux/module.h>
#include <asm/dyn_syscall.h>


const char name[] = "foo";


asmlinkage long
sys_foo(const int cmd, const caddr_t address, const size_t length,
					const int node, const pid_t pid)
{
	printk("\nsys_foo(%d, 0x%p, 0x%lx, %d, %d)\n",
					cmd, address, length, node, pid);
	return 0;
}


int syscall;


static int __init
init_foo(void)
{
	int	rc;

	printk("\nModule Foo\n");
	rc = dyn_syscall_reg(name, 0, (dyn_syscall_t) sys_foo);
	printk("dyn_syscall_reg() returned: %d\n", rc);
	if (rc < 0)
		return rc;
	syscall = rc;
	rc = syscall_unlock(name, syscall);
	if (rc < 0)
		panic("syscall_unlock() returned: %d\n", rc);
	return 0;
}


static void __exit
exit_foo(void)
{
	printk("\nModule Foo getting unloaded\n");
	int	rc;
	rc = prep_restore_syscall(name, syscall);
	if (rc < 0)
		panic("prep_restore_syscall() returned: %d\n", rc);
	while((rc = syscall_trylock(name, syscall)) == -EAGAIN){
		/*
		 * Having some blocking syscalls? Don't just busy wait,
		 * wake them up, sleep a bit in the mean time.
		 */
	}
	if (rc < 0)
		panic("syscall_trylock() returned: %d\n", rc);
	rc = dyn_syscall_unreg(name, syscall);
	if (rc < 0)
		panic("dyn_syscall_unreg() returned: %d\n", rc);
}


module_init(init_foo);
module_exit(exit_foo);


--------------8CCCCBBAB9EEE4142AA23BCE--

