Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129326AbQJ3OSI>; Mon, 30 Oct 2000 09:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129355AbQJ3OSA>; Mon, 30 Oct 2000 09:18:00 -0500
Received: from devserv.devel.redhat.com ([207.175.42.156]:4364 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129326AbQJ3ORc>; Mon, 30 Oct 2000 09:17:32 -0500
Date: Mon, 30 Oct 2000 09:17:31 -0500
From: Crutcher Dunnavant <crutcher@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] update to SysRQ registration patch
Message-ID: <20001030091731.B11971@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Red Hat, Inc.
X-Department: OS Development
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently updated the SysRQ registration patch, which is still available at:
http://bama.ua.edu/~dunna001/sysrq-register/
to have a 2.4.0-test10-pre6 incarnation. I've also added a more complex module
example, showing some of the things that this patch makes possible, that is
available at the same site, and included later in this document.

To restate:

The SysRq registration patch allows code segments with special debugging
needs to register various dump, panic, and special purpose event handlers
with a clean and common interface. At the same time, no potential instability
is introduced to the kernel by this patch, save for that which may be
introduced by module writers improperly manipulating the registration system,
but such problems exist already, in the form of file_op registration, and of
syscall chaining, so it is a problem already dealt with; and no registered
pointer is followed if the sysrq system is turned off.

In the situation where a module is being written new, or debugged, it is a
simple matter to introduce and register a handler which dumps the status of
the module, resets some crucial state, or generally performs black magic upon
the code, with out having to introduce any special debugging code to the kernel
itself, or having to write some less direct interface (which might not be
available, due to the deadlock you are trying to nail down.)

The key purpose of this patch is not to provide a normal interface, and I would
look askance at any finished code or module that used this when debugging is
not turned on, but rather to make it easy to attach debugging events in
production kernels, without hacking strange things into the kernel, especially
in cases where kdb would be overkill. In short, simplicity and utility are
my goals.

The patch stores key events in structs having the following definition:
struct sysrq_key_op {
       void (*handler)(int, struct pt_regs *,
                       struct kbd_struct *, struct tty_struct *);
       char *help_msg;
       char *action_msg;
};

(the handler definition is directly lifted from 'handle_sysrq', as, well,
why throw anything away?)

pointers to such structures are stored in a 36 element array, 0-9, a-z,
though 'a' is not available on the sparc (but I chose to leave it in, as
it is a debugging interface, and most people aren't on sparcs, and want it;
we just can't put any standard, permanent interfaces on 'a')

an example piece of the table:
struct sysrq_key_op *sysrq_key_op_table[SYSRQ_KEY_OP_TABLE_LENGTH] = {
&sysrq_loglevel_op, /* 0 */
&sysrq_loglevel_op, /* 1 */
&sysrq_loglevel_op, /* 2 */
&sysrq_loglevel_op, /* 3 */
...
#ifdef CONFIG_VT
&sysrq_SAK_op, /* k */
#else
NULL, /* k */
#endif
&sysrq_killall_op, /* l */
&sysrq_showmem_op, /* m */
NULL, /* n */
NULL, /* o, This will often be registered as 'Off' at init time */
&sysrq_showregs_op, /* p */
...
};

and an example handler:
void sysrq_handle_killall(int key, struct pt_regs *pt_regs,
               struct kbd_struct *kbd, struct tty_struct *tty) {
       send_sig_all(SIGKILL, 1);
       console_loglevel = 8;
}
struct sysrq_key_op sysrq_killall_op = {
handler:       sysrq_handle_killall,
help_msg:      "killalL",
action_msg:    "Kill All Tasks (even init)\n",
};


This table is accessed by 3 functions, and has an associated spinlock, accessed
by two more functions; throw in one locking wrapper function, and we have
the following interface (exported to modules)

void handle_sysrq(int key, struct pt_regs *pt_regs,
                 struct kbd_struct *kbd, struct tty_struct *tty)
	The interface called by the keyboard handler, and exported to a few
	other locations (historical), it uses __sysrq_table_lock and
	__sysrq_table_unlock to wrap around:

void handle_sysrq_nolock(int key, struct pt_regs *pt_regs,
                 struct kbd_struct *kbd, struct tty_struct *tty)
	A lookup function, which checks the table to see if it has a handler
	registered on the appropriate key, and passes its parameters to that
	function if it does.
	Also prints help messages, in case it gets a keycode which isn't
	registered (or register-able)

void __sysrq_table_lock(void)
void __sysrq_table_unlock(void)
	Blocking lock/unlock pair. (wrapper around that spin lock, which I
	chose not to expose)

struct sysrq_key_op *__sysrq_get_key_op (int key)
void __sysrq_put_key_op (int key, struct sysrq_key_op *op_p)
	get and put function on the table, which I again, chose not to expose,
	they fail gracefully on out of bound key codes.

The normal register/unregister interface provide to client code is actually
a set of macros:

#define REGISTER_SYSRQ_KEY(KEY, OP_P) \
        __sysrq_table_lock(); \
        (__sysrq_get_key_op(KEY) == 0) ? ( { \
                __sysrq_put_key_op(KEY, OP_P); \
                __sysrq_table_unlock(); \
                0; \
        } ) : ( { \
                __sysrq_table_unlock(); \
                -1; \
        } )

#define UNREGISTER_SYSRQ_KEY(KEY, OP_P) \
        __sysrq_table_lock(); \
        (__sysrq_get_key_op(KEY) == OP_P) ? ( { \
                __sysrq_put_key_op(KEY, 0); \
                __sysrq_table_unlock(); \
                0; \
        } ) : ( { \
                __sysrq_table_unlock(); \
                -1; \
        } )

These macros are somewhat paranoid, and provide a good general interface to
the system, as used by a module like, say, this:

/* simple-example.c */
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/sysrq.h>

/*
 * This is a very simple registration/unregistration module
 * for demonstrating the use of the new SysRQ registration patch
 */

void example_handler (int key, struct pt_regs *pt_regs,
                        struct kbd_struct *kbd, struct tty_struct *tty) {
        printk("<1>Hello Sysrq!\n");
}

struct sysrq_key_op example_op = {
handler:        example_handler,
help_msg:       "Hellosysrq",
action_msg:     "Running Example\n"
};

int init_module (void) {
        REGISTER_SYSRQ_KEY('h', &example_op);
        printk("<1>example loaded\n");
        return 0;
}

void cleanup_module (void) {
        UNREGISTER_SYSRQ_KEY('h', &example_op);

        printk("<1>example unloaded\n");
}
/* End simple-example.c */


However, the interface also allows for the creation of far more complex
behaviors, as exampled by the following, (and probably insufficiently
paranoid, but very flexible) module:


/* overload-example.c */
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
void overload_handler (int key, struct pt_regs *pt_regs,
			struct kbd_struct *kbd, struct tty_struct *tty) {
	int i;
	__sysrq_table_lock();
	if (overloaded) {
		overload_op.help_msg = "Fakemenu";
		overload_op.action_msg = "Loading Fake Menu\n";
		overloaded = 0;
		for (i=0;i<10;i++) {
			__sysrq_put_key_op(i + '0', op_stash[i]);
		}
	} else {
		overload_op.help_msg = "unloadFakemenu";
		overload_op.action_msg = "Unloading Fake Menu\n";
		overloaded = 1;
		for (i=0;i<10;i++) {
			op_stash[i] = __sysrq_get_key_op(i + '0');
			__sysrq_put_key_op(i + '0', &dumpfake_op);
		}
	}
	__sysrq_table_unlock();
}
			
int init_module (void) {
	REGISTER_SYSRQ_KEY('f', &overload_op);
	printk("<1>overload example loaded\n");
	return 0;
}

void cleanup_module (void) {
	if (overloaded)
		overload_handler (0,0,0,0);
	
	UNREGISTER_SYSRQ_KEY('f', &overload_op);
	printk("<1>overload example unloaded\n");
}

/* End overload-example.c */

-- 
"I may be a monkey,     Crutcher Dunnavant 
 but I'm a monkey       <crutcher@redhat.com>
 with ambition!"        Red Hat OS Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
