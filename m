Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUAKN57 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 08:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265883AbUAKN57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 08:57:59 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:42723 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265137AbUAKN4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 08:56:47 -0500
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
From: Karl Dahlke <eklhad@comcast.net>
Reply-to: Karl Dahlke <eklhad@comcast.net>
Subject: PATCH, accessibility, adaptive modules, 2.6.0
Date: Sun, 11 Jan 2004 08:57:02
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=nextpart-eb-163871
Content-Transfer-Encoding: 7bit
Message-Id: <S265137AbUAKN4r/20040111135647Z+27556@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--nextpart-eb-163871
Content-type: text/plain
Content-Transfer-Encoding: quoted-printable

Type of change:

Make LInux easily accessible to people with various disabilities.

I can tell you, from personal experience,
that trying to patch and build and install a new kernel,
*before* I receive any feedback whatsoever from the computer,
is nearly impossible.
Yet that's what we must do today, if we want a kernel-resident adapter.

This patch has been "in the works" for four years,
and I have used the system, 8 hours a day, for all that time.
Of course it has moved through many versions.
This is the patch for version 2.6.0.

Note that this patch does not install any specific adapters.
Rather, it makes the kernel "accessible".
Thus it is ready for adaptive modules,
just as the kernel stands ready to acccept ethernet drivers,
sound card drivers, etc.
It is my hope that people will develop all sorts of adapters,
for blind, blind-deaf, motor impaired, etc.

Since this introduces a new capability, the patch includes
Documentation/accessibility.txt
Best to read that file in the patch below;
no point in me copying all that info again up here.

This isn't a large patch, if you set aside the aforementioned =
documentation,
but it is pretty complex, and subtle.
I spent a lot of time working with Alan Cox (and others),
trying to get it right.
I appreciate all the help I received from the Linux development team.

Finally, I know you are pressed for time.
New hardware, new features, new routing algorithms, etc.
Still, I hope this can fit into your busy schedules.
Making Linux accessible is very important;
it might even be the law in certain situations.
And with this patch in place, all sorts of people can write
various adapters for many different disabilities.
It's just my opinion, but I believe this approach is more flexible
than embeding specific adapters into the Linux kernel,
as we have tried to do in the past.
Better to apply one patch, this patch,
and write and distribute as many loadable modules as we wish.

This patch just crosses the 40K size limit,
as described in Documentation/SubmittingPatches,
but I think I'll include it inline anyways.
It's only a tad over, and I think a lot of people will want to see it.
But it you want to apply the patch, probably best to get it here.
http://www.eklhad.net/linux/jupiter-base/kernel-2.6.0.patch
Apply this patch via
patch -b -p0 <patchfile
from the top of your source tree.

I thank you in advance for your time.
Karl Dahlke
eklhad@comcast.net

--- MAINTAINERS	2004-01-11 06:10:42.000000000 -0500
+++ MAINTAINERS.new	2004-01-11 06:10:42.000000000 -0500
@@ -139,6 +139,12 @@
 L:	linux-aio@kvack.org
 S:	Supported
=20
+ACCESSIBILITY, ADAPTERS FOR THE DISABLED
+P:	Karl Dahlke
+M:	karl@eklhad.net
+W:	http://www.eklhad.net/linux/jupiter
+S:	Maintained
+
 ACENIC DRIVER
 P:	Jes Sorensen
 M:	jes@trained-monkey.org
--- init/Kconfig	2004-01-11 06:10:42.000000000 -0500
+++ init/Kconfig.new	2004-01-11 06:10:42.000000000 -0500
@@ -65,6 +65,24 @@
=20
 menu "General setup"
=20
+config ACCESSIBILITY
+	bool "Support for accessibility adapters for disabled users"
+	default y
+	help
+	An adapter is a peripheral device and/or a specialized device driver
+	that makes Linux accessible to a disabled user.
+	Some adapters redirect output to a speech synthesizer or braille =
device
+	for the blind.  Other adapters modify keyboard input
+	for the motor impaired.  In any case, the adapter must somehow
+	intercept keyboard input and tty output.
+	These streams are generally hidden deep within the kernel.
+	If you say y here, kernel modules will have access to keyboard
+	input and tty output.  Adapters can then be loaded as modules,
+	without patching and rebuilding the kernel.
+	The effect on kernel size and performance is negligible,
+	so you should probably say y here.
+	Review Documentation/accessibility.txt for more information.
+
 config SWAP
 	bool "Support for paging of anonymous memory"
 	depends on MMU
--- Documentation/accessibility.txt	2004-01-11 06:10:42.000000000 -0500
+++ Documentation/accessibility.txt.new	2004-01-11 06:10:42.000000000 =
-0500
@@ -0,0 +1,428 @@
+		Linux Accessibility For Disabled Users
+
+As Linux matures and proliferates, the disabled community is asking =
how they
+too can access this important operating system.
+We have a legal and moral obligation
+to make Linux accessible to as many individuals as possible.
+Disabilities may include blindness (can't read the output),
+and motor impaired (can't type the input), to name just two.
+
+Given the difficulty of programming in the kernel,
+and maintaining patches while versions of Linux march along,
+we are not surprised to find an assortment of adapted applications.
+It is relatively easy to make a user program send its output to a =
synthesizer,
+or read from an alternate peripheral (rather than the keyboard).
+EmacsSpeak for the blind is a good example.
+However, we must remember that a program is being adapted, not the =
computer.
+Often the program is extremely powerful, such as emacs or bash,
+but it is a program nonetheless. There will always be some users who =
would
+rather adapt the entire computer, as has been done for Dos and Windows.
+
+Fortunately this task has become much easier,
+thanks to a standard interface that supports adaptive modules.
+When you run `make config', say yes to "accessibility adapters",
+and the resulting kernel will support adaptive modules.
+By definition, an adaptive module redirects or restructures keyboard =
input
+or console output in a manner that compensates for a particular =
disability.
+These streams were not available to loadable modules in earlier =
versions of Linux,
+but they are now.  Here are some sample adapters.
+
+    Blind: send console output to a speech synthesizer.
+    Function keys allow the user to review the contents of screen =
memory.
+
+    Blind-deaf: send console output to a braille device.
+
+    One hand: Keys are remapped to minimize cross-keyboard movements.
+    This may include key chords, which cannot be implemented via =
loadkeys.
+
+    No hands: A sip and puff peripheral sends a limited set of scan =
codes to
+    the keyboard input port.  An adapter reads them in sequence and
+    translates them into characters.  This may include
+    word completion/prediction algorithms and user defined macros.
+
+The accessibility interface is defined in linux/accessibility.h.
+Module developers should include this header file, along with module.h
+and any other files needed for consistency.
+After you've read this document, please review accessibility.h.
+
+The adaptive module defines a set of operations, actually functions,
+that the kernel invokes.
+These are similar to file operations or inode operations,
+but they are driven by console output and keyboard input.
+These "callback" functions are defined below.
+
+        	void (*tty_start)(int minor);
+        	void (*tty_stop)(int minor);
+
+These functions are called when a tty is allocated or freed, =
respectively.
+A tty is allocated when it is opened for the first time.
+This action invokes tty_start(),
+passing the minor device number of the newly created tty.
+Subsequent processes may open and close this tty,
+but that will not trigger any adapter operations,
+until the last process closes the tty.
+That frees the tty and invokes tty_stop().
+
+Some adapters use tty_start() to allocate a structure for each open =
tty.
+This can be thought of as an extention to struct tty_struct,
+but it isn't defined in linux/tty.h; it is defined by the adapter.
+Tty_stop() can then be used to free the structure and stop any
+reading that might be in progress on that tty.
+
+Developers may want to think carefully before deallocating resources
+inside tty_stop(). Under Redhat, the first tty driver, tty1,
+is opened to run rc.sysinit, then closed.
+Then all the virtual terminals are opened as you enter a higher run =
level.
+If you deallocate resources when tty1 closes,
+there will be no log of the output of rc_sysinit.
+This is probably not what you want. My adapter allocates its buffers =
through
+tty_start(), but basically ignores tty_stop().
+It then deallocates everything it knows about in cleanup_module().
+
+        	int (*tty_out)(int minor, unsigned char c, int isEcho);
+
+This function is called whenever an output character is generated.
+The first parameter holds the minor device number, which is between 1 =
and 63.
+The second parameter is the output character.
+It's high order bit may be significant.
+Finally, the third parameter determines whether this character
+is an echo of an input character,
+according to the line discipline of the tty.
+I use this information to generate a unique sound when the user is =
typing capital letters,
+thus the user will not type a paragraph in caps lock by mistake.
+You wouldn't want these tones to appear whenever the computer
+prints capital letters,
+so I only generate the tones when isecho is nonzero.
+
+The return value is a bit map as follows.
+
+01send the character on to the screen, or virtual screen
+(virtual terminals are fully supported).
+If the character is eaten as part of a recognized escape sequence,
+this function should return 0.
+
+02Send an escape to the screen before sending this character.
+This is used when we thought we were running a talking escape sequence,
+but then we didn't get the right follow-on character,
+so we want the tty to send the escape that was swallowed earlier.
+
+04Take a realtime break.
+It took a while to process this particular character, for whatever =
reason,
+and we don't want to monopolize the CPU.
+My system sets this bit after it generates the sound associated with
+the return character.
+The sound is made using CPU cycles -- quite a few of them --
+so it is best to let another process have a turn.
+
+        	int (*keystroke)(unsigned int *key_p, int *shiftstate_p, int =
upflag) ;
+
+The key code and shift state are passed into this routine.
+Keycodes are fairly (though not entirely) standard
+representations of keys on the keyboard,
+and the bits of shiftstate,
+indicating shift, control, alt, etc,
+are documented in the Linux manual.
+See dumpkeys(1), showkey(1), and loadkeys(1).
+Upflag is set if the key is being released.
+Most adapters simply return if this flag is set.
+they are only interested in key press events.
+But if you want to recognize key chords
+that activate specialized functions, this interface will support that.
+
+Note that key and state are passed by reference.
+The adapter can change the key and shiftstate,
+and Linux will process the new key and state,
+as though that were entered at the keyboard.
+This is rarely done however.
+In fact you have to be very careful with this.
+If you change x to y with upflag off,
+you'll want to do the same with upflag on,
+press and release, so that Linux can maintain its bookkeeping.
+As I say, most adapters don't change the key codes.
+But they sometimes eat the keystroke, as described below.
+
+The return value is boolean.
+If zero is returned, the key has been eaten by the adapter.
+For example, the keystroke might cause the module to begin reading.
+The running process doesn't need to see it.
+Conversely, a nonzero return routes the key to its destination.
+This is usually a process reading from /dev/console,
+but it could be a meta function
+such as changing virtual terminals or the famous control-alt-delete =
reboot.
+
+WARNING!!
+Unlike the previous functions,
+this one is invoked as part of an interrupt routine.
+Specifically, it is called from the bottom half of the keyboard =
interrupt.
+Hardware interrupts are not disabled,
+so you won't lose data from a serial port or ethernet connection,
+but some Linux functions are suspended while inside this software =
interrupt.
+You should not hold the CPU for too long.
+When a speech function cannot be executed right away,
+because the synthesizer is busy (for instance),
+put it on a pending queue and deal with it later.
+
+Because this routine is triggered by a keystroke,
+it is entirely asynchronous with respect to the kernel.
+As a result there are certain operations you cannot perform,
+such as allocating memory or other resources.
+The tty_start() routine is a better place
+to allocate all the resources you will need to perform your functions.
+
+	void scroll(int minor, int t, int b, int nr) ;
+	void cursorloc(int minor, int x, int y) ;
+
+When a console screen, or section thereof, scrolls up or down,
+the kernel calls scroll(), passing the top and bottom of the region,
+and the number of rows that the region has scrolled up.
+A negative number means the region has scrolled down.
+If the adapter is reading from screen memory,
+it may want to move its reading cursor accordingly,
+to keep in step with the moving text.
+
+Whenever the cursor moves, the kernel calls cursorloc(),
+passing the new x and y coordinates.
+In a typical sequence, a program generates output,
+the tty driver passes the output character to the adapter,
+the adapter returns 1, the tty driver sends the character on to the =
console,
+the console prints it, and moves the cursor one to the right,
+or down to the next line if we wrap,
+then sends the new cursor location to the adapter via cursorloc().
+
+	void (*polling)(void);
+
+Most adapters employ an asynchronous thread to implement
+continuous reading.
+This thread monitors the speech synthesizer and transmits text
+while Linux executes other processes.
+Thus the blind user can sit back and listen to a screen full of =
information
+while somebody else computes the first million digits of pi.
+For simplicity, this thread is usually implemented by a polling =
function.
+In other words, a function wakes up ten times a second,
+checks the status of the synthesizer,
+and if the unit is not busy, sends it more words to speak.
+This is not the most efficient design,
+but we don't really need to mess with interrupts for events
+that only come two or three times a second.
+The adapter supplies the polling function and the period.
+
+	extern int register_accessibility_device(struct accessibility_device =
*dev);
+	extern void unregister_accessibility_device(struct =
accessibility_device *dev);
+
+The adaptive module calls a register function to attach itself to the =
kernel,
+and an unregister function to detach itself from the kernel.
+This is usually done from init_module() and cleanup_module() =
respectively.
+The function pointers are passed to register() and unregister()
+inside a structure that describes the adapter.
+See accessibility.h for more details.
+
+Register() could fail if another adaptive module is currently loaded.
+Otherwise it sets the function pointers as you indicate
+and calls tty_start() for each open tty.
+Similarly, unregister() calls tty_stop() for each open tty,
+and restores the kernel to its original behavior.
+Obviously the open ttys aren't going away,
+but the adapter is,
+and this seems like a simple way to clean things up.
+
+The adaptive module, like any other module,
+is limited to the symbols that have been exported by the kernel.
+This list is growing all the time, and most of the symbols needed by a =
speech
+adapter should be availble.  These include functions to access the =
serial port,
+for speech synthesizers on ttyS0 through ttyS3.
+However, if you are writing an unusual adapter,
+you might find you need a function or variable that has not been =
exported.
+In this case you may indeed need to patch the kernel,
+but it is a simple patch,
+and you should have no trouble incorporating it into the next release =
of Linux.
+
+In addition to exporting preexisting symbols,
+I have added some functions to the base kernel --
+functions that most adaptive modules will need --
+functions that developers don't want to reinvent and maintain
+over and over again.  Future releases will include more
+functions that are common to many adapters.
+
+	        extern void kd_mknotes(const short *notes);
+
+An array of notes is pushed onto an internal sound fifo.
+These notes are then played by an asynchronous thread, using the PC =
speaker.
+If the fifo is full, the incoming tones are discarded.
+Thus if a program issues 100 note strings in rapid sequence
+the first dozen fill the fifo and the rest are silently lost.
+The fifo then drains over the next few seconds.
+Of course this isn't likely to happen in practice.
+Normally we place beeps and tones into a near-empty
+fifo, whence they are played immediately.
+If the computer has no toggle speaker, this function is a stub.
+Future versions will send sin waves to the sound card.
+
+The parameter *notes is an array of shorts.
+Each note consists of two shorts: frequency and duration.
+A frequency of -1 is a rest.
+A frequency of zero ends the list of notes.
+Duration is measured in hundredths of a second,
+and frequency is given in hurtz.
+
+	        extern int vc_screenParams(int minor,
+	        short *nlines, short *ncols, short *x, short *y);
+	        extern int vc_screenimage(int minor, short *dest, int =
destsize);
+	extern int vc_screenItem(int minor, int x, int y);
+
+The first function retrieves parameters for the designated console,
+returning -ENODEV if the minor number is not associated with an active =
tty.
+The adapter may wish to allocate a buffer of shorts, nlines*ncols in =
size,
+then use the second function to retrieve a copy of screen memory, =
frozen in time.
+Alternatively, the adapter can use the third function to read
+individual characters off the screen.
+
+	extern void tty_putc(int minor, int ch);
+	extern void tty_puts(int minor, char *cp);
+
+These are simple wrappers around the put_queue and puts_queue routines
+in keyboard.h.  The interface is simplified, so you don't need to know
+about struct vc_data (which may change anyways); you only need pass the
+minor number and the character(s).
+This is used to implement macros.
+A keystroke can invoke a macro, which simulates an entire
+string of characters typed at the keyboard.
+See the example code at the bottom of this page.
+
+	/proc
+
+Adapters can make use of the /proc file system
+to pass information back to the user, or on to the synthesizer.
+This is generally more flexible than new ioctl directives or system =
calls.
+The directory /proc/accessibility is intended to house various =
adapters.
+Create a subdirectory for your adapter,
+then add more files under this subdirectory as you see fit.
+
+For example, my Jupiter adapter makes the text buffers available
+under /proc/accessibility/jupiter,
+so your ineractive session can be saved to a file
+at any time.  The session associated with tty3
+is captured in /proc/accessibility/jupiter/buf3.
+To prevent others from evesdropping on your work, this file is
+owned by root, or by you, if you pass your uid as a module parameter.
+This is merely an example; each adapter can add its own files
+under /proc/accessibility/xxx, for various purposes.
+
+Below is a sample adapter.
+It prints messages when it attaches and detaches itself,
+intersepts shift F5, and swallows escape q.
+
+----------------------------------------------------------------------
+
+/*********************************************************************
+
+adapter_generic.c: skeleton for an adaptive module.
+
+Compile this using the C flags
+that correspond to kernel modules on your system.
+The following flags will probably work.
+CFLAGS =3D -D__KERNEL__ -I/usr/src/linux/include -Wall =
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe =
-fno-strength-reduce -m386 -DCPU=3D386 -DMODULE
+
+Then run insmod on the resulting object file.
+insmod adapter_generic.o period=3D7
+Run rmmod when you want to remove the module.
+
+*********************************************************************/
+
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/accessibility.h>
+
+int period;
+MODULE_PARM(period, "i"); /* i means integer */
+
+/* Make a little beep every period seconds, or not, if period =3D 0. */
+static void pollFunction(struct accessibility_device *dev)
+{
+	static const short beep[] =3D {
+		3000,3,0,0	};
+	kd_mknotes(beep);
+}
+
+static void tty_start(struct accessibility_device *dev, int minor)
+{
+	printk("tty start %d\n", minor);
+}
+
+static void tty_stop(struct accessibility_device *dev, int minor)
+{
+	printk("tty stop %d\n", minor);
+}
+
+/* Eat escape q, as though it invoked a particular function */
+static int tty_out(struct accessibility_device *dev,
+int minor, unsigned char c, int isecho)
+{
+	static int escstate =3D 0;
+	if(escstate) {
+		escstate =3D 0;
+		if(c =3D=3D 'q') {
+			/* perform the function */
+			printk("escape q function\n");
+			/* Return 4 if it took a while to run this function */
+			return 4;
+		}
+		return 3; /* print escape and the current character */
+	}
+	if(c =3D=3D '\33') {
+		escstate =3D 1;
+		return 0;
+	}
+	return 1;
+}
+
+/* Let shift F5 perform a special function */
+/* Let alt m be a macro */
+static int keystroke(struct accessibility_device *dev,
+int key, int shiftstate)
+{
+	if(key =3D=3D 0x3f && shiftstate =3D=3D 1) {
+		/* perform the function */
+		printk("f5 function\n");
+		return 0;
+	}
+	if(key =3D=3D 0x32 && shiftstate =3D=3D 2) {
+		tty_puts(fg_console+1, "macro");
+		return 0;
+	}
+	return 1;
+}
+
+static struct accessibility_operations myops =3D {
+	tty_start,
+	tty_stop,
+	tty_out,
+	keystroke,
+	NULL, /* scroll function */
+	NULL, /* cursor location function */
+	NULL, /* might become pollFunction */
+	0,
+};
+
+static struct accessibility_device mydev =3D {
+ops: &myops,
+};
+
+int init_module(void)
+{
+if(period) {
+myops.polling =3D pollFunction;
+myops.period =3D period*100;
+}
+	return register_accessibility_device(&mydev);
+}
+
+void cleanup_module(void)
+{
+	unregister_accessibility_device(&mydev);
+}
+
+----------------------------------------------------------------------
+
+Written and maintained by Karl Dahlke.
+karl@eklhad.net
--- include/linux/accessibility.h	2004-01-11 06:10:42.000000000 -0500
+++ include/linux/accessibility.h.new	2004-01-11 06:10:42.000000000 =
-0500
@@ -0,0 +1,89 @@
+/*********************************************************************
+
+accessibility.h: interface to various adapters for disabled users.
+
+Copyright (C) Karl Dahlke, 2001.
+This software may be freely distributed under the GPL, general public =
license,
+as articulated by the Free Software Foundation.
+
+Maintained by Karl Dahlke,  karl@eklhad.net.
+
+This header file defines the interface between the Linux kernel and the
+accessibility modules.
+See Documentation/accessibility.txt for more details.
+
+*********************************************************************/
+
+#ifndef LINUX_ACCESSIBILITY_H
+#define LINUX_ACCESSIBILITY_H 1
+
+#include <linux/config.h>
+#include <linux/proc_fs.h>
+#include <linux/timer.h>
+
+#ifdef CONFIG_ACCESSIBILITY
+
+/*
+ * Accessibility device structure.  This is a placeholder for now.
+ * We'll probably need it in the future.
+ */
+
+struct accessibility_device
+{
+	struct accessibility_operations *ops;
+#ifdef CONFIG_PROC_FS
+	struct proc_dir_entry *proc;
+#endif
+	struct pci_device *dev;
+	void *data; /* each adapter links its own structure here */
+	struct timer_list polltime;
+	char pollrunning;
+	char tty_out_status;
+};
+
+/*
+ * Here are the operations performed by an accessibility adapter.
+ * Any of these function pointers may be left null, for the default =
kernel behavior.
+ */
+
+struct accessibility_operations
+{
+	void (*tty_start) (struct accessibility_device *dev,
+		int minor);
+	void (*tty_stop) (struct accessibility_device *dev,
+		int minor);
+	int (*tty_out) (struct accessibility_device *dev,
+		int minor, unsigned char c, int echo);
+	int (*keystroke) (struct accessibility_device *dev,
+		unsigned int *key, int *shiftstate, int up_flag);
+	void (*scroll) (struct accessibility_device *dev,
+		int minor, int t, int b, int nr);
+	void (*cursorloc) (struct accessibility_device *dev,
+		int minor, int x, int y);
+	void (*polling) (struct accessibility_device *dev);
+	int period;
+};
+
+extern int register_accessibility_device(struct accessibility_device =
*dev);
+extern void unregister_accessibility_device(struct =
accessibility_device *dev);
+
+extern void tty_putc(int minor, int ch);
+extern void tty_puts(int minor, char *cp);
+extern int vc_screenParams(int minor, short *nrows, short *ncols, =
short *x, short *y);
+extern int vc_screenItem(int minor, int x, int y);
+extern int vc_screenImage(int minor, short *dest, int destsize);
+extern void kd_mknotes(const short *data);
+
+/* For internal use only - not accessible from adapters. */
+
+#ifndef MODULE
+
+/* For now, there is one and only one adapter active at any one time. =
*/
+extern struct accessibility_device *accdev;
+extern struct accessibility_operations *accops;
+
+#endif
+
+#endif
+
+#endif
--- include/linux/proc_fs.h	2004-01-11 06:10:42.000000000 -0500
+++ include/linux/proc_fs.h.new	2004-01-11 06:10:42.000000000 -0500
@@ -84,6 +84,7 @@
 extern struct proc_dir_entry proc_root;
 extern struct proc_dir_entry *proc_root_fs;
 extern struct proc_dir_entry *proc_net;
+extern struct proc_dir_entry *proc_accessibility;
 extern struct proc_dir_entry *proc_bus;
 extern struct proc_dir_entry *proc_root_driver;
 extern struct proc_dir_entry *proc_root_kcore;
--- drivers/Makefile	2004-01-11 06:10:42.000000000 -0500
+++ drivers/Makefile.new	2004-01-11 06:10:42.000000000 -0500
@@ -49,3 +49,12 @@
 obj-$(CONFIG_MCA)		+=3D mca/
 obj-$(CONFIG_EISA)		+=3D eisa/
 obj-$(CONFIG_CPU_FREQ)		+=3D cpufreq/
+
+#  Best to leave this at the end -
+#  some adaptive modules may need to look back and see which char =
devices
+#  are available.
+#  Builtin adapters are not yet implemented.
+#  I don't think it would be hard to do, we just haven't done it yet.
+#obj-y				+=3D accessibility/
+obj-m				+=3D accessibility/
+
--- drivers/Kconfig	2004-01-11 06:10:42.000000000 -0500
+++ drivers/Kconfig.new	2004-01-11 06:10:42.000000000 -0500
@@ -38,6 +38,8 @@
=20
 source "drivers/char/Kconfig"
=20
+source "drivers/accessibility/Kconfig"
+
 # source "drivers/misc/Kconfig"
=20
 source "drivers/media/Kconfig"
--- drivers/char/keyboard.c	2004-01-11 06:10:42.000000000 -0500
+++ drivers/char/keyboard.c.new	2004-01-11 06:10:42.000000000 -0500
@@ -33,6 +33,7 @@
 #include <linux/string.h>
 #include <linux/random.h>
 #include <linux/init.h>
+#include <linux/accessibility.h>
 #include <linux/slab.h>
=20
 #include <linux/kbd_kern.h>
@@ -41,6 +42,8 @@
 #include <linux/sysrq.h>
 #include <linux/input.h>
=20
+#include <asm/io.h>
+
 static void kbd_disconnect(struct input_handle *handle);
 extern void ctrl_alt_del(void);
=20
@@ -262,6 +265,80 @@
 }
=20
 /*
+ * Push notes onto a sound fifo and play them via an asynchronous =
thread.
+ */
+
+#define SF_LEN 32 /* length of sound fifo */
+static short sf_fifo[SF_LEN];
+static short sf_head, sf_tail;
+
+#define PORT_SPEAKER 0x61
+#define PORT_TIMER2 0x43
+#define PORT_TIMERVAL 0x42
+
+/* Pop the next sound out of the sound fifo. */
+static void popfifo(unsigned long );
+static struct timer_list note_timer =3D
+		TIMER_INITIALIZER(popfifo, 0, 0);
+static void popfifo(unsigned long notUsed)
+{
+	short i, freq, duration;
+
+	/* Apparently it's ok to delete a timer that has expired, */
+	/* or has never been added in the first place. */
+	/* kd_mksound() does it, so can we. */
+	del_timer(&note_timer);
+
+	if((i =3D sf_tail) =3D=3D sf_head) {
+		/* turn off singing speaker */
+		outb(inb_p(PORT_SPEAKER)&0xFC, PORT_SPEAKER);
+		return; /* sound fifo is empty */
+	}
+
+	/* First short holds the frequency */
+	freq =3D sf_fifo[i++];
+	if(i =3D=3D SF_LEN) i =3D 0; /* wrap around */
+	duration =3D sf_fifo[i++];
+	if(i =3D=3D SF_LEN) i =3D 0;
+	sf_tail =3D i;
+
+	mod_timer(&note_timer, jiffies + duration*(HZ/100));
+
+	cli();
+	if(freq < 0) {
+		outb(inb_p(PORT_SPEAKER)&0xFC, PORT_SPEAKER);
+	} else {
+		duration =3D 1193180 / freq;
+		outb_p(inb_p(PORT_SPEAKER)|3, PORT_SPEAKER);
+		/* set command for counter 2, 2 byte write */
+		outb_p(0xB6, PORT_TIMER2);
+		outb_p(duration & 0xff, PORT_TIMERVAL);
+		outb((duration >> 8) & 0xff, PORT_TIMERVAL);
+	}
+	sti();
+} /* popfifo */
+
+/* Put a string of notes into the sound fifo. */
+void kd_mknotes(const short *p)
+{
+	short i;
+
+	cli();
+	i =3D sf_head;
+	/* Copy shorts into the fifo, until the terminating zero. */
+	while(*p) {
+		sf_fifo[i++] =3D *p++;
+		if(i =3D=3D SF_LEN) i =3D 0; /* wrap around */
+		if(i =3D=3D sf_tail) { sti(); return; }
+	}
+	sf_head =3D i;
+	sti();
+
+	/* first sound,  get things started. */
+	if(!timer_pending(&note_timer)) popfifo(0);
+} /* kd_mknotes */
+
+/*
  * Setting the keyboard rate.
  */
=20
@@ -316,6 +393,19 @@
 	con_schedule_flip(tty);
 }
=20
+/* Pass characters to the tty, e.g. invoking a macro with a singel =
keystroke */
+void tty_putc(int minor, int ch)
+{
+	struct vc_data *c =3D vc_cons[minor-1].d;
+	put_queue(c, ch);
+} /* tty_putc */
+
+void tty_puts(int minor, char *cp)
+{
+	struct vc_data *c =3D vc_cons[minor-1].d;
+	puts_queue(c, cp);
+} /* tty_puts */
+
 static void applkey(struct vc_data *vc, int key, char mode)
 {
 	static char buf[] =3D { 0x1b, 'O', 0x00, 0x00 };
@@ -1082,6 +1172,13 @@
 		raw_mode =3D 1;
 	}
=20
+#ifdef CONFIG_ACCESSIBILITY
+	if(accops && accops->keystroke && !raw_mode) {
+		if(!accops->keystroke(accdev, &keycode, &shift_state, !down))
+			return; /* eaten by the adapter */
+	}
+#endif
+
 	if (down)
 		set_bit(keycode, key_down);
 	else
@@ -1231,3 +1328,8 @@
=20
 	return 0;
 }
+
+EXPORT_SYMBOL(getledstate);
+EXPORT_SYMBOL(tty_putc);
+EXPORT_SYMBOL(tty_puts);
+EXPORT_SYMBOL(kd_mknotes);
--- drivers/char/tty_io.c	2004-01-11 06:10:42.000000000 -0500
+++ drivers/char/tty_io.c.new	2004-01-11 06:10:42.000000000 -0500
@@ -86,8 +86,8 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
-#include <linux/proc_fs.h>
 #include <linux/init.h>
+#include <linux/accessibility.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
@@ -771,6 +771,98 @@
 	up(&tty_sem);
 }
=20
+#ifdef CONFIG_ACCESSIBILITY
+
+/*
+ * The accessibility device.
+ * At this point there is only one.
+ * For more information, see Documentation/accessibility.txt.
+ */
+
+struct accessibility_device *accdev;
+struct accessibility_operations *accops;
+
+/* wrapper to call the adapter's polling function */
+static void accessibility_polling_wrapper(unsigned long arg)
+{
+	struct accessibility_device *dev =3D (struct accessibility_device =
*)arg;
+	/* First thing we're going to do is re-enable the timer. */
+	mod_timer(&dev->polltime, jiffies + dev->ops->period);
+	if(dev->pollrunning) return; /* reentrant lock */
+	/* Now call the function in the adapter */
+	dev->pollrunning =3D 1;
+	dev->ops->polling(dev);
+	dev->pollrunning =3D 0;
+} /* accessibility_polling_wrapper */
+
+int register_accessibility_device(struct accessibility_device *dev)
+{
+	if(accdev) return -EBUSY;
+
+	/* call tty_start for each open tty */
+	if(dev->ops && dev->ops->tty_start) {
+		int index, minor;
+		dev_t ttydev;
+		struct tty_driver *driver;
+		for(minor=3D1; minor<=3DMAX_NR_CONSOLES; ++minor) {
+			ttydev =3D MKDEV(TTY_MAJOR, minor);
+			driver =3D get_tty_driver(ttydev, &index);
+			if(!driver) continue;
+			if(!driver->ttys[index]) continue;
+			dev->ops->tty_start(dev, minor);
+		} /* loop over possible consoles */
+	} /* tty_start method was provided */
+
+	/* make the link */
+	accdev =3D dev;
+	accops =3D dev->ops;
+
+	/* start the user polling function */
+	if(accops && accops->polling && accops->period) {
+		static struct timer_list sample_polltime =3D
+			TIMER_INITIALIZER(accessibility_polling_wrapper, 0, 0);
+		memcpy(&dev->polltime, &sample_polltime, sizeof(sample_polltime));
+		dev->polltime.data =3D (unsigned long)dev;
+		dev->pollrunning =3D 0;
+		accessibility_polling_wrapper((unsigned long)dev);
+	}
+
+	return 0; /* adapter is attached */
+} /* register_accessibility_device */
+
+void unregister_accessibility_device(struct accessibility_device *dev)
+{
+	if(!dev || dev !=3D accdev) return;
+
+	/* kill the polling function */
+	if(accops && accops->polling && accops->period) {
+		del_timer(&dev->polltime);
+		dev->polltime.function =3D 0;
+	}
+
+	accops =3D 0;
+	accdev =3D 0;
+
+	/* Call tty_stop for each open tty. */
+	if(dev->ops && dev->ops->tty_stop) {
+		int index, minor;
+		dev_t ttydev;
+		struct tty_driver *driver;
+		for(minor=3D1; minor<=3DMAX_NR_CONSOLES; ++minor) {
+			ttydev =3D MKDEV(TTY_MAJOR, minor);
+			driver =3D get_tty_driver(ttydev, &index);
+			if(!driver) continue;
+			if(!driver->ttys[index]) continue;
+			dev->ops->tty_stop(dev, minor);
+		} /* loop over possible consoles */
+	} /* tty_stop method was provided */
+} /* unregister_accessibility_device */
+
+EXPORT_SYMBOL(register_accessibility_device);
+EXPORT_SYMBOL(unregister_accessibility_device);
+
+#endif
+
 static void release_mem(struct tty_struct *tty, int idx);
=20
 static inline void tty_line_name(struct tty_driver *driver, int index, =
char *p)
@@ -791,6 +883,7 @@
 	struct termios *tp, **tp_loc, *o_tp, **o_tp_loc;
 	struct termios *ltp, **ltp_loc, *o_ltp, **o_ltp_loc;
 	int retval=3D0;
+	int minor;
=20
 	/*=20
 	 * Check whether we need to acquire the tty semaphore to avoid
@@ -898,6 +991,16 @@
 	 */
 	driver->ttys[idx] =3D tty;
 =09
+	/* tty created, notify the adapter */
+#ifdef CONFIG_ACCESSIBILITY
+	minor =3D driver->minor_start + idx;
+	if(accops && accops->tty_start &&
+	driver->major =3D=3D TTY_MAJOR &&
+	minor > 0 && minor < MAX_NR_CONSOLES) {
+		accops->tty_start(accdev, minor);
+	} /* console device */
+#endif
+
 	if (!*tp_loc)
 		*tp_loc =3D tp;
 	if (!*ltp_loc)
@@ -994,6 +1097,16 @@
 {
 	struct tty_struct *o_tty;
 	struct termios *tp;
+	int minor;
+
+#ifdef CONFIG_ACCESSIBILITY
+	minor =3D tty->driver->minor_start + idx;
+	if(accops && accops->tty_stop &&
+	tty->driver->major =3D=3D TTY_MAJOR &&
+	minor > 0 && minor < MAX_NR_CONSOLES) {
+		accops->tty_stop(accdev, minor);
+	} /* console device */
+#endif
=20
 	if ((o_tty =3D tty->link) !=3D NULL) {
 		o_tty->driver->ttys[idx] =3D NULL;
--- drivers/char/n_tty.c	2004-01-11 06:10:42.000000000 -0500
+++ drivers/char/n_tty.c.new	2004-01-11 06:10:42.000000000 -0500
@@ -45,6 +45,8 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
+#include <linux/config.h>
+#include <linux/accessibility.h>
=20
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -173,10 +175,44 @@
 }
=20
 /*
+ * put_char() wrapper, modified by Karl Dahlke, Jan 2004.
+ * This wrapper use to call driver->put_char(), and nothing more.
+ * Now if calls the accessibility adapter if appropriate.
+ */
+static void put_char(unsigned char c, struct tty_struct *tty, int =
isecho)
+{
+#ifdef CONFIG_ACCESSIBILITY
+	int major =3D tty->driver->major;
+	int minor =3D tty->driver->minor_start + tty->index;
+	if(accops && accops->tty_out &&
+	major =3D=3D TTY_MAJOR &&
+	minor > 0 && minor < MAX_NR_CONSOLES) {
+		accdev->tty_out_status &=3D ~3;
+		accdev->tty_out_status |=3D accops->tty_out(accdev, minor, c, =
isecho);
+		if(!(accdev->tty_out_status&1)) return; /* do not display */
+		if(accdev->tty_out_status&2) {
+			/* I'll assume the driver has room for escape c.
+			 * We've already tested ahead of time;
+			 * it has room for C, or we would have blocked.
+			 * Does it have room for both characters?
+			 * On a serial or ethernet port, maybe not,
+			 * but on a console screen, it should.
+			 * There's no flow control -- nothing should block.
+			 * So I'm running on faith --
+			 * trying to keep the programming simple. */
+			tty->driver->put_char(tty, '\33');
+		} /* display previous escape */
+	} /* an adapted tty */
+#endif
+
+	tty->driver->put_char(tty, c);
+} /* put_char */
+
+/*
  * Perform OPOST processing.  Returns -1 when the output device is
  * full and the character must be retried.
  */
-static int opost(unsigned char c, struct tty_struct *tty)
+static int opost(unsigned char c, struct tty_struct *tty, int isecho)
 {
 	int	space, spaces;
=20
@@ -192,7 +228,7 @@
 			if (O_ONLCR(tty)) {
 				if (space < 2)
 					return -1;
-				tty->driver->put_char(tty, '\r');
+				put_char('\r', tty, 0);
 				tty->column =3D 0;
 			}
 			tty->canon_column =3D tty->column;
@@ -211,10 +247,13 @@
 		case '\t':
 			spaces =3D 8 - (tty->column & 7);
 			if (O_TABDLY(tty) =3D=3D XTABS) {
+				int minor =3D tty->driver->minor_start + tty->index;
 				if (space < spaces)
 					return -1;
 				tty->column +=3D spaces;
-				tty->driver->write(tty, 0, "        ", spaces);
+				if(minor > 0 && minor < MAX_NR_CONSOLES) {
+					while(spaces--) put_char(' ', tty, 0);
+				} else tty->driver->write(tty, 0, "        ", spaces);
 				return 0;
 			}
 			tty->column +=3D spaces;
@@ -231,7 +270,7 @@
 			break;
 		}
 	}
-	tty->driver->put_char(tty, c);
+	put_char(c, tty, isecho);
 	return 0;
 }
=20
@@ -300,28 +339,22 @@
 }
=20
=20
-
-static inline void put_char(unsigned char c, struct tty_struct *tty)
-{
-	tty->driver->put_char(tty, c);
-}
-
 /* Must be called only when L_ECHO(tty) is true. */
=20
 static void echo_char(unsigned char c, struct tty_struct *tty)
 {
 	if (L_ECHOCTL(tty) && iscntrl(c) && c !=3D '\t') {
-		put_char('^', tty);
-		put_char(c ^ 0100, tty);
+		put_char('^', tty, 0);
+		put_char(c ^ 0100, tty, 0);
 		tty->column +=3D 2;
 	} else
-		opost(c, tty);
+		opost(c, tty, 1);
 }
=20
 static inline void finish_erasing(struct tty_struct *tty)
 {
 	if (tty->erasing) {
-		put_char('/', tty);
+		put_char('/', tty, 0);
 		tty->column++;
 		tty->erasing =3D 0;
 	}
@@ -334,7 +367,7 @@
 	unsigned long flags;
=20
 	if (tty->read_head =3D=3D tty->canon_head) {
-		/* opost('\a', tty); */		/* what do you think? */
+		/* opost('\a', tty, 0); */		/* what do you think? */
 		return;
 	}
 	if (c =3D=3D ERASE_CHAR(tty))
@@ -360,7 +393,7 @@
 			echo_char(KILL_CHAR(tty), tty);
 			/* Add a newline if ECHOK is on and ECHOKE is off. */
 			if (L_ECHOK(tty))
-				opost('\n', tty);
+				opost('\n', tty, 0);
 			return;
 		}
 		kill_type =3D KILL;
@@ -384,7 +417,7 @@
 		if (L_ECHO(tty)) {
 			if (L_ECHOPRT(tty)) {
 				if (!tty->erasing) {
-					put_char('\\', tty);
+					put_char('\\', tty, 0);
 					tty->column++;
 					tty->erasing =3D 1;
 				}
@@ -415,22 +448,22 @@
 				/* Now backup to that column. */
 				while (tty->column > col) {
 					/* Can't use opost here. */
-					put_char('\b', tty);
+					put_char('\b', tty, 0);
 					if (tty->column > 0)
 						tty->column--;
 				}
 			} else {
 				if (iscntrl(c) && L_ECHOCTL(tty)) {
-					put_char('\b', tty);
-					put_char(' ', tty);
-					put_char('\b', tty);
+					put_char('\b', tty, 0);
+					put_char(' ', tty, 0);
+					put_char('\b', tty, 0);
 					if (tty->column > 0)
 						tty->column--;
 				}
 				if (!iscntrl(c) || L_ECHOCTL(tty)) {
-					put_char('\b', tty);
-					put_char(' ', tty);
-					put_char('\b', tty);
+					put_char('\b', tty, 0);
+					put_char(' ', tty, 0);
+					put_char('\b', tty, 0);
 					if (tty->column > 0)
 						tty->column--;
 				}
@@ -541,7 +574,7 @@
 		tty->lnext =3D 0;
 		if (L_ECHO(tty)) {
 			if (tty->read_cnt >=3D N_TTY_BUF_SIZE-1) {
-				put_char('\a', tty); /* beep if no space */
+				put_char('\a', tty, 0); /* beep if no space */
 				return;
 			}
 			/* Record the column of first canon char. */
@@ -598,8 +631,8 @@
 			if (L_ECHO(tty)) {
 				finish_erasing(tty);
 				if (L_ECHOCTL(tty)) {
-					put_char('^', tty);
-					put_char('\b', tty);
+					put_char('^', tty, 0);
+					put_char('\b', tty, 0);
 				}
 			}
 			return;
@@ -610,7 +643,7 @@
=20
 			finish_erasing(tty);
 			echo_char(c, tty);
-			opost('\n', tty);
+			opost('\n', tty, 0);
 			while (tail !=3D tty->read_head) {
 				echo_char(tty->read_buf[tail], tty);
 				tail =3D (tail+1) & (N_TTY_BUF_SIZE-1);
@@ -620,10 +653,10 @@
 		if (c =3D=3D '\n') {
 			if (L_ECHO(tty) || L_ECHONL(tty)) {
 				if (tty->read_cnt >=3D N_TTY_BUF_SIZE-1) {
-					put_char('\a', tty);
+					put_char('\a', tty, 0);
 					return;
 				}
-				opost('\n', tty);
+				opost('\n', tty, 0);
 			}
 			goto handle_newline;
 		}
@@ -640,7 +673,7 @@
 			 */
 			if (L_ECHO(tty)) {
 				if (tty->read_cnt >=3D N_TTY_BUF_SIZE-1) {
-					put_char('\a', tty);
+					put_char('\a', tty, 0);
 					return;
 				}
 				/* Record the column of first canon char. */
@@ -672,11 +705,11 @@
 	finish_erasing(tty);
 	if (L_ECHO(tty)) {
 		if (tty->read_cnt >=3D N_TTY_BUF_SIZE-1) {
-			put_char('\a', tty); /* beep if no space */
+			put_char('\a', tty, 0); /* beep if no space */
 			return;
 		}
 		if (c =3D=3D '\n')
-			opost('\n', tty);
+			opost('\n', tty, 0);
 		else {
 			/* Record the column of first canon char. */
 			if (tty->canon_head =3D=3D tty->read_head)
@@ -1163,6 +1196,8 @@
 	DECLARE_WAITQUEUE(wait, current);
 	int c;
 	ssize_t retval =3D 0;
+	int major =3D tty->driver->major;
+	int minor =3D tty->driver->minor_start + tty->index;
=20
 	/* Job control check -- must be done at start (POSIX.1 7.1.1.4). */
 	if (L_TOSTOP(tty) && file->f_op->write !=3D redirected_tty_write) {
@@ -1182,6 +1217,37 @@
 			retval =3D -EIO;
 			break;
 		}
+
+/* If this is a talking tty, we must run everything through put_char. =
*/
+#ifdef CONFIG_ACCESSIBILITY
+if(accops && accops->tty_out &&
+major =3D=3D TTY_MAJOR &&
+minor > 0 && minor < MAX_NR_CONSOLES) {
+	accdev->tty_out_status =3D 0;
+	while(nr > 0) {
+		int oval;
+		get_user(c, b);
+/* If we interrupt the swoop of a carriage return, */
+/* it really sounds weird! */
+		if(c =3D=3D '\r') set_current_state(TASK_UNINTERRUPTIBLE);
+		oval =3D opost(c, tty, 0);
+		if(c =3D=3D '\r') set_current_state(TASK_INTERRUPTIBLE);
+		if(oval < 0) break;
+		++b, --nr;
+		if (tty->driver->flush_chars)
+			tty->driver->flush_chars(tty);
+		if(accdev->tty_out_status&4) {
+/* I just don't understand why I have to set this to RUNNING, */
+/* but I do! */
+			current->state =3D TASK_RUNNING;
+			break;
+		}
+	} /* loop putting characters */
+} else {
+#endif
+
+/* non-accessibility code follows -- takes advantage of opost_block() =
*/
+
 		if (O_OPOST(tty) && !(test_bit(TTY_HW_COOK_OUT, &tty->flags))) {
 			while (nr > 0) {
 				ssize_t num =3D opost_block(tty, b, nr);
@@ -1196,7 +1262,7 @@
 				if (nr =3D=3D 0)
 					break;
 				get_user(c, b);
-				if (opost(c, tty) < 0)
+				if (opost(c, tty, 0) < 0)
 					break;
 				b++; nr--;
 			}
@@ -1211,6 +1277,11 @@
 			b +=3D c;
 			nr -=3D c;
 		}
+
+#ifdef CONFIG_ACCESSIBILITY
+} /* preexisting code or accessibility code */
+#endif
+
 		if (!nr)
 			break;
 		if (file->f_flags & O_NONBLOCK) {
--- drivers/char/vt.c	2004-01-11 06:10:42.000000000 -0500
+++ drivers/char/vt.c.new	2004-01-11 06:10:42.000000000 -0500
@@ -97,6 +97,7 @@
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/config.h>
+#include <linux/accessibility.h>
 #include <linux/workqueue.h>
 #include <linux/bootmem.h>
 #include <linux/pm.h>
@@ -263,6 +264,10 @@
 		nr =3D b - t - 1;
 	if (b > video_num_lines || t >=3D b || nr < 1)
 		return;
+#ifdef CONFIG_ACCESSIBILITY
+	if(accops && accops->scroll)
+		accops->scroll(accdev, currcons+1, t, b, nr);
+#endif
 	if (IS_VISIBLE && sw->con_scroll(vc_cons[currcons].d, t, b, SM_UP, =
nr))
 		return;
 	d =3D (unsigned short *) (origin+video_size_row*t);
@@ -281,6 +286,10 @@
 		nr =3D b - t - 1;
 	if (b > video_num_lines || t >=3D b || nr < 1)
 		return;
+#ifdef CONFIG_ACCESSIBILITY
+	if(accops && accops->scroll)
+		accops->scroll(accdev, currcons+1, t, b, -nr);
+#endif
 	if (IS_VISIBLE && sw->con_scroll(vc_cons[currcons].d, t, b, SM_DOWN, =
nr))
 		return;
 	s =3D (unsigned short *) (origin+video_size_row*t);
@@ -545,8 +554,15 @@
=20
 static void set_cursor(int currcons)
 {
-    if (!IS_FG || console_blanked || vcmode =3D=3D KD_GRAPHICS)
+    if (console_blanked || vcmode =3D=3D KD_GRAPHICS)
 	return;
+#ifdef CONFIG_ACCESSIBILITY
+	/* Background console adapters may still want to track the cursor,
+	 * so this code comes before the is_fg test. */
+	if(accops && accops->cursorloc)
+		accops->cursorloc(accdev, currcons+1, x, y);
+#endif
+	if(! IS_FG) return;
     if (deccm) {
 	if (currcons =3D=3D sel_cons)
 		clear_selection();
@@ -3038,10 +3054,85 @@
 	return 0;
 }
=20
+#ifdef CONFIG_ACCESSIBILITY
+
+int vc_screenItem(int minor, int xx, int yy)
+{
+	int currcons =3D minor - 1;
+	short nlines, ncols;
+	unsigned short *org;
+
+	if(!vc_cons_allocated(currcons)) return -ENODEV;
+
+	nlines =3D video_num_lines;
+	ncols =3D video_num_columns;
+	if(xx < 0 || xx >=3D nlines || yy < 0 || yy >=3D ncols) return =
-EFAULT;
+	org =3D screen_pos(currcons, xx*ncols, 0);
+	org +=3D yy;
+	return vcs_scr_readw(currcons, org);
+} /* vc_screenItem */
+
+/* Grab a copy of screen memory. */
+int vc_screenImage(int minor, short *dest, int destsize)
+{
+	int currcons =3D minor - 1;
+	short nlines, ncols;
+	long p;
+	int row, col;
+	unsigned short *org;
+
+	if(!vc_cons_allocated(currcons)) return -ENODEV;
+	if(!dest) return 0;
+
+	nlines =3D video_num_lines;
+	ncols =3D video_num_columns;
+if(nlines*ncols > destsize) return -ENOMEM;
+
+	p =3D 0;
+	for(row=3D0; row<nlines; ++row) {
+		org =3D screen_pos(currcons, row*ncols, 0);
+		for(col=3D0; col<ncols; ++col) {
+			dest[p++] =3D vcs_scr_readw(currcons, org++);
+		} /* loop over columns */
+	} /* loop over rows */
+
+	return 0;
+} /* vc_screenImage */
+
+/* get the screen parameters */
+int vc_screenParams(int minor,
+short *nlines_p, short *ncols_p, short *x_p, short *y_p)
+{
+	int currcons =3D minor - 1;
+	short nlines, ncols;
+	char xy[2];
+
+	if(!vc_cons_allocated(currcons)) return -ENODEV;
+
+	nlines =3D video_num_lines;
+	ncols =3D video_num_columns;
+	*nlines_p =3D nlines;
+	*ncols_p =3D ncols;
+
+	getconsxy(currcons, xy);
+	*x_p =3D xy[0];
+	*y_p =3D xy[1];
+
+	return 0;
+} /* vc_screenParams */
+
+#endif
+
+
 /*
  *	Visible symbols for modules
  */
=20
+#ifdef CONFIG_ACCESSIBILITY
+EXPORT_SYMBOL(vc_screenImage);
+EXPORT_SYMBOL(vc_screenItem);
+EXPORT_SYMBOL(vc_screenParams);
+#endif
 EXPORT_SYMBOL(color_table);
 EXPORT_SYMBOL(default_red);
 EXPORT_SYMBOL(default_grn);
--- fs/proc/root.c	2004-01-11 06:10:42.000000000 -0500
+++ fs/proc/root.c.new	2004-01-11 06:10:42.000000000 -0500
@@ -19,6 +19,7 @@
 #include <linux/smp_lock.h>
=20
 struct proc_dir_entry *proc_net, *proc_bus, *proc_root_fs, =
*proc_root_driver;
+struct proc_dir_entry *proc_accessibility;
=20
 #ifdef CONFIG_SYSCTL
 struct proc_dir_entry *proc_sys_root;
@@ -53,6 +54,7 @@
 	}
 	proc_misc_init();
 	proc_net =3D proc_mkdir("net", 0);
+	proc_accessibility =3D proc_mkdir("accessibility", 0);
 #ifdef CONFIG_SYSVIPC
 	proc_mkdir("sysvipc", 0);
 #endif
@@ -160,5 +162,6 @@
 EXPORT_SYMBOL(proc_root);
 EXPORT_SYMBOL(proc_root_fs);
 EXPORT_SYMBOL(proc_net);
+EXPORT_SYMBOL(proc_accessibility);
 EXPORT_SYMBOL(proc_bus);
 EXPORT_SYMBOL(proc_root_driver);
--- drivers/accessibility/Makefile	2004-01-10 09:36:53.000000000 -0500
+++ drivers/accessibility/Makefile.new	2004-01-10 09:36:53.000000000 =
-0500
@@ -0,0 +1,6 @@
+#
+# Makefile for the Linux adaptive modules
+#
+# 15 Jan 2004, Karl Dahlke <karl@eklhad.net>
+#
+
--- drivers/accessibility/Kconfig	2004-01-10 09:36:53.000000000 -0500
+++ drivers/accessibility/Kconfig.new	2004-01-10 09:36:53.000000000 =
-0500
@@ -0,0 +1,7 @@
+#
+#  Accessibility adapters
+#
+
+menu "Accessibility Adapters"
+
+endmenu

--nextpart-eb-163871--
