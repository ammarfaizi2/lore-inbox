Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbUKHOG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbUKHOG5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUKHOG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:06:57 -0500
Received: from [61.48.53.221] ([61.48.53.221]:27630 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261839AbUKHODe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:03:34 -0500
Date: Mon, 8 Nov 2004 21:57:58 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200411090557.iA95vwA02432@freya.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] please test: small devfs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Here is a single patch against 2.6.10-rc1-bk17 for
both the small devfs implementation and the "lookup trap"
feature in tmpfs that it uses.  If you're running devfs, you
should be able to apply just this patch, run "make oldconfig" and
say "y" to the new configuration option CONFIG_TMPFS_LOOKUP_TRAPS,
rebuild, reboot, and be running the new code.

	If you want devfsd-like functionality according to
your /etc/devfsd.conf, you should download devfs_helper from
ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/devfs_helper/devfs_helper-0.2.tar.gz .
This kernel version generates LOOKUP and {,UN}REGISTER events

	Note that the {,UN}REGISTER events were not included in
previously posted versions of these patches.  In the future, it is
likely that {,UN}REGISTER events will be moved to a user level
inspector program that notices changes in /dev, but I've put
{,UN}REGISTER events in tmpfs for the time being so I don't have
to ask users also to reconfigure modprobe right now.

	This implementation does not use the files include/fs/devfs_fs.h
and fs/devfs/base.c, but including all those line deletions in the patch
would make the patch too big to be carried on linux-kernel, so you
can delete those two files yourself (or leave them there).  With
those files deleted, the total code deletion is about 1800 lines.

	You can also read more about the lookup trapping facility
in the new file Documentation/filesystems/lookup-trap.txt.  It
is quite an easy facility to use, and has some interesting
applications that you can set up with just shell scripts.

	Please try it out!  Thanks in advance.

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l

--- linux-2.6.10-rc1-bk17/Documentation/filesystems/lookup-trap.txt	1969-12-31 16:00:00.000000000 -0800
+++ linux/Documentation/filesystems/lookup-trap.txt	2004-11-08 21:24:23.000000000 -0800
@@ -0,0 +1,440 @@
+User's Guide To Trapping Directory Lookup Operations in Tmpfs
+Version 0.2
+
+
+1. INSTRUCTIONS FOR THE IMPATIENT
+
+	% modprobe tmpfs
+	% mount -t tmpfs -o helper=/path/to/helper/program whatever /mnt
+	% ls /mnt/foo
+	# Notice that "/path/to/helper/program LOOKUP foo" was executed.
+
+
+2. OVERVIEW (from the Kconfig help)
+
+	Tmpfs now allows user level programs to implement file systems
+that are filled in on demand.  This feature works by invoking a
+configurable helper program on attempts to open() or stat() a
+nonexistent file.  The access waits until the helper finishes, so the
+helper can install the missing file if desired.
+
+	Using this facility, a shell script or small C program can
+implement a file system that automatically mounts remote file systems
+or creates device files on demand, similar to autofs or devfs,
+respectively.  Tmpfs is, however, daemonless and, perhaps
+consequently, smaller than either of these, and may avoid some
+recursion problems.
+
+	Tmpfs might also be useful for debugging programs where you
+want to trap the first access a particular file or perhaps in
+automatic installation of missing command or libraries by specifying a
+tmpfs file system in certain search paths.
+
+	This access trapping facility is designed to be easily ported
+to other file systems.  Kernel developers should examine the following
+source files for more information:
+
+	include/linux/fsuserhelper
+	include/linux/lookuptrap.h
+	fs/lookuptrap.c
+	fs/userhelper.c
+	mm/shmem.c (for an example of tmpfs using trapping_lookup)
+
+
+3. GETTING STARTED
+
+3.1 MOUNTING THE FILE SYSTEM
+
+	First, build and boot a kernel with tmpfs either compiled in
+or built as a module.  If you compile tmpfs as a module, you may have
+to load it, although, since the module name ("tmpfs.ko") and the file
+system name ("tmpfs") match, that may be unnecessary if you've
+configured modprobe automatically.
+
+	% modprobe tmpfs
+
+	Now let's mount a tmpfs file system on /mnt.
+
+	% mount -t tmpfs blah /mnt
+
+	The file system will behave exactly like a ramfs file system.
+In fact, tmpfs is derived from ramfs.  You can create files,
+directories, symbolic links and device nodes in it, and they will
+exist only in the computer's main memory.  The contents of the file
+system will disappear as soon as you unmount it.
+
+	If you mount multiple instances of tmpfs, you will get
+separate file systems.
+
+
+3.2. THE HELPER PROGRAM
+
+	What distinguishes tmpfs from ramfs is that it can invoke a
+user level helper program when an attempt is made to open or stat a
+nonexistent file for the first time (if the name is not already in the
+dcache).  The user level program is set with the "helper" mount
+option.  It is possible to set, clear or change the helper command at
+any time, so let's go back to our example and put a helper command on
+the tmpfs file system that we mounted on /mnt:
+
+	% mount -o remount,helper=/tmp/helper /mnt
+
+	If you use the file system in /mnt now, nothing appears to have
+changed.  Now let's put a simple shell script in /tmp/helper:
+
+	% cat > /tmp/helper
+	#!/bin/sh
+	echo "$*" > /dev/console
+	^D
+	% chmod a+x /tmp/helper
+
+	Now you should see console messages like "LOOKUP foo" when you
+try to access the file /mnt/foo for the first time.
+
+	You can also pass arguments to the helper program by using
+spaces in the helper mount option, like so:
+
+	% mount -o remount,helper='/tmp/helper my_argument' /mnt
+
+	If you do this, your console messages will start to look
+something like "my_argument LOOKUP foo".  The arguments that
+you specify come before "LOOKUP foo" to facilitate the use of
+command interpreters, like, say, helper='/usr/bin/perl handler.pl'.
+Arguments also make it easy to pass things like the mount point or
+configuration files, which should make it easier to write facilities
+that work on multiple mount points.
+
+	You can also deactivate the helper at any time, like so:
+
+	mount -o remount,helper='' /mnt
+
+4. PRACTICAL EXAMPLES
+
+4.1 AN NFS AUTOMOUNTER
+
+	% cat > /usr/sbin/tmpfs-automount
+	#!/bin/sh
+	if [ "$2" != LOOKUP ] ; then exit ; fi
+	topdir=$1
+	host=${3%/*}
+	dir=$topdir/$host
+	mkdir $dir
+	mount -t nfs $host:/ $dir
+	^D
+	% chmod a+x /usr/sbin/tmpfs-automount
+	% mkdir /auto
+	% mount -t tmpfs -o helper="/usr/sbin/tmpfs-automount /auto" x /auto
+
+	Notice how we pass the additional argument "/auto" to the
+tmpfs-automount command.
+
+	If you want automatic unmount after a timeout, you'll probably
+want to do something a little more elaborate, perhaps with a script that
+runs from cron.
+
+
+4.2 DEMAND LOADING OF DEVICE DRIVERS
+
+	A version of devfs that uses tmpfs is under development and
+running on the system I am using to write this document, but I am
+still cleaning it up.  Here is how it should work, although I have
+not yet actually tried devfs_helper on it.
+
+	The devfs_helper program was originally written for a stripped down
+rewrite of devfs, from which tmpfs is derived.  It can read your
+/etc/devfs.conf file (the file previously used to configured
+devfsd) and load modules specified by "LOOKUP" commands.  Other
+devfs.conf command are ignored.
+
+	% ftp ftp.yggdrasil.com
+	login: anonymous
+	password; guest
+	ftp> cd /pub/dist/device_control/devfs
+	ftp> get devfs_helper-0.2.tar.gz
+	.....
+	ftp> quit
+	% tar xfpvz devfs_helper-0.2.tar.gz
+	% cd devfs_helper-0.2
+	% make
+	% make install
+	% mkdir /tmp/tmpdev
+	% mount -t devfs /tmp/tmpdev
+	% cp -apRx /dev/* /tmpdev/
+	% mount -t devfs -o helper=/sbin/devfs_helper blah /dev
+	% mount -t msods /dev/floppy/0 /mnt
+
+	The above example should load the floppy.ko kernel module
+if you have a a line in your /etc/devfs.conf file like this:
+
+	LOOKUP	floppy		EXECUTE modprobe floppy
+
+
+	You should also be able to use execfs in this fashion to get
+automatic loading of kernel modules on non-devfs systems, although
+you'll need something like udev the larger udev to create the
+device files once the device drivers are registered.
+
+
+4.3 DEBUGGING A PROGRAM TRYING TO ACCESS A FILE
+
+	% cat > /tmp/call-sleep
+	#!/bin/sh
+	sleep 30
+	^D
+	% mount -t tmpfs -o helper=/tmp/call-sleep foo /mnt
+	% mv .bashrc .bashrc-
+	% ln -s /mnt/whatever .bashrc
+	% gdb /bin/sh
+	GNU gdb 5.2
+	[blah blah blah]
+	(gdb) run
+	[program eventually hangs.  Switch to another terminal session.  You
+         cannot control-C out of it, a tmpfs bug from call_usermodehelper.]
+	% ps axf
+	[Find the process under gdb.  Let say it's pid 1152.]
+	% kill -SEGV 1152
+	% ps auxww | grep sleep
+	[Find the sleeping tmpfs helper.  Let's say it's pid 1120.]
+	% kill -9 1120
+	[Now back at the first session, running gdb on /bin/sh.]
+	Program received signal SIGSEGV, Segmentation fault.
+	0xb7f303d4 in __libc_open () at __libc_open:-1
+	-1      __libc_open: No such file or directory.
+        	in __libc_open
+		(gdb) where
+	#0  0xb7f303d4 in __libc_open () at __libc_open:-1
+	#1  0xb7f8b4c0 in __DTOR_END__ () from /lib/libc.so.6
+	#2  0x080921ef in _evalfile (filename=0x80dc788 "/tmp/junk/.bashrc", flags=9)
+	    at evalfile.c:85
+	#3  0x08092635 in maybe_execute_file (
+	    fname=0xfffffffe <Address 0xfffffffe out of bounds>, 
+	    force_noninteractive=1) at evalfile.c:218
+	#4  0x08059fe8 in run_startup_files () at shell.c:1019
+	#5  0x08059849 in main (argc=1, argv=0xbfffebc4, env=0xbfffebcc) at shell.c:581
+	#6  0xb7e88e02 in __libc_start_main (main=0x8059380 <main>, argc=1, 
+	    ubp_av=0xbfffebc4, init=0x805897c <_init>, 
+	    fini=0xb80005ac <_dl_debug_mask>, rtld_fini=0x8000, stack_end=0x0)
+	    at ../sysdeps/generic/libc-start.c:129
+
+
+4.4 AUTOMATIC LOADING OF MISSING PROGRAMS
+
+	% cat > /usr/sbin/missing-program
+	#!/bin/sh
+	if [ "$2" != LOOKUP ] ; then exit ; fi
+	my-automatic-network-downloader $2
+	^D
+	% chmod a+x /usr/sbin/missing-program
+	% mount -t tmpfs -o helper=/usr/sbin/my-automatic-installer /mnt
+	% PATH=$PATH:/mnt:$PATH
+	# We include $PATH a second time so that the program can be
+	# found after it is installed.
+	% kdevelop		# Or some other program you don't have...
+
+	...or maybe something like this...
+
+	% cat > /usr/sbin/missing-program
+	#!/bin/sh
+	if [ "$2" != LOOKUP ] ; then exit ; fi
+	export DISPLAY=:0
+	konqueror http://www.google.com/search?q="download+$2" &
+	^D
+	% chmod a+x /usr/sbin/missing-program
+	% mount -t tmpfs -o helper=/usr/sbin/missing-program glorp /mnt
+	% xhost localhost
+	% PATH=$PATH:/mnt
+	% kdevelop
+
+4.4.1 AUTOMATIC LOADING OF MISSING LIBRARIES
+
+	Same as above, but with this line:
+	% LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt:$LD_LIBRARY_PATH
+
+4.5  ADVANCED EXAMPLE: Generating plain files
+
+	Doing automatic generation of plain files (as opposed to
+directories, device files and symbolic links) requires more care,
+because the helper program's attempt to open a file for writing
+will itself invoke another instance of the user level handler.
+
+	One approach, perhaps the only one, is to define some temporary
+file name pattern that your user handler knows to ignore, create the
+file with a temporary name that matches that pattern, and then
+rename the temporary file to the real file name, since rename
+operations are not trapped (and if renames ever are trapped in future,
+releases you could filter out renames where the source matched the
+tempary file pattern).
+
+	[FIXME. This example is untested!  --Adam Richter, 2004.11.03]
+
+
+	% cat > /usr/sbin/my-decrypter
+	#!/bin/sh
+	if [ "$5" != LOOKUP ] ; then exit ; fi
+	encrypted_dir=$2
+	decrypted_dir=$3
+	key=$4
+	# $5 is "LOOKUP"
+	filename=$6
+
+	case $target in ( tmp/* ) ; exit ;; esac
+	tmpfile=$decrypted_dir/$$
+	decrypt --key $key < $encrypted_dir/$filename > $tmpfile
+	mv $tmpfile $decrypted_dir/$filename
+	^D
+	% chmod a+x /usr/sbin/my-decrypter
+	% mount -t tmpfs -o \
+	   helper='/usr/sbin/my-decrypter /cryptdir /mnt key' x /mnt
+	% cat /mnt/my-secret-file
+	....
+
+	If you want to make the temporary directory completely
+inaccessible from the public directory, you can create two mount
+points, where the public directory for the file system is actually
+a subdirectory of a larger hidden directory, like so:
+
+	% mount -t tmpfs /some/place/hidden
+	% chmod go-rwx /someplace/hidden
+	% mkdir /some/place/hidden/mirror
+	% mount --bind /some/place/hidden/mirror /public
+
+	Now you can set up a helper program that operates in some
+other directory of /some/place/hidden, and then renames the
+resultant files into /some/place/hidden/mirror.
+
+
+4.5.1 A WARNING ABOUT SYMBOLIC LINKS AND THE GNU "ln -s" COMMAND
+
+	If your helper program invoke the shell command "ln" to create
+symbolic links, you may need to use "filter and rename" technique that
+was described above for plain files, or one of several other
+workarounds listed below.  If you helper program just uses the
+symlink() system call directly, you don't have to worry about this.
+
+	What is the problem, exactly?  The problem is that although
+symlink system calls are not trapped, the "ln" command from version
+5.2.1 of the GNU coreutils package (latest version as of this writing)
+does a stat system call on the target before doing the symlink,
+because it is specified to behave differently if the destination path
+exists and is a directory.  stat, unlink symlink, is trapped, in order
+to support automatic creation of files in case a program stats a file
+before deciding whether to open it, and for things like "ls
+/auto/fileserver1.mycompany.com/".  Consequently, a user level helper
+shell script that simply does "ln -s whatever $target_file_name" will
+deadlock (which can be broken by interrupting the child helper
+program).
+
+	There are several possible solutions to this problem.
+
+	1. You can use a simpler symlink program, such as ssln,
+	   instead of "ln -s".
+
+	2. If the final path element of the symlink's contents is
+	   the same as the final path element of the symlink's name,
+	   then you can just specify the directory name as the second
+	   argument to "ln -s".  In other words, change
+
+			ln -s foo/bar /the/target/bar
+			...to...
+			ln -s foo/bar /the/target
+
+	3. You can use the same filtering techniques for symlink
+	   as discussed for plain files in the previous section
+	   (create them with speical temporary names that your helper
+	   program knows to ignore and then rename them into place).
+
+	4. Invoke perl to do the symlink, if you know you have it available:
+
+			perl -e 'symlink("contents", "target");'
+
+	5. You can port shell script to C or perl or some other
+	   language that gives you direct access to the symlink()
+	   system call.
+
+
+	Perhaps, in the future, the GNU ln command could be changed so
+that, when it is called with exactly two file names, it would try to
+do the symlink() and then check if the target is a directory only if
+the symlink attempt failed.
+
+
+4.6. OTHER USES?
+
+     I would be interested in hearing about any other uses that you up
+with for tmpfs, especially if I can include them in this document.
+
+5. SERIALIZATION
+
+	Note that many instances of the user level helper program
+can potentially be running at the same time.  It is up to "you",
+the implementor of the helper program to determine what sort of
+serialization you need and implement it.  A simple solution to
+enforce complete serialization would be to have every instance
+of the helper program take an exclusive flock on some common
+file.
+
+6. KERNEL DEVELOPER ANSWERS ABOUT IMPLEMENTATION DECISIONS
+
+6.1 Q:  Why doesn't tmpfs provide REGISTER and UNREGISTER events when
+        new nodes are created or deleted from the file system, as the
+	mini-devfs implementation from which is derived did?
+
+    A:  {,UN}REGISTER in Richard Gooch's implementation of devfs enabled
+        things like automatically setting permissions and sound settings
+	on your sound device when the driver was loaded, even if
+	the loading of the driver had not been caused by devfs.
+	For tmpfs-based devfs, I expect to implement that in
+	a more complex way by shadowing the real devfs file system
+	and creating {,UN}REGISTER events as updates are propagated
+	from the real devfs to /dev.  The advantages of this would be
+	that module initialization would not be blockable by a user
+	level program, and events like a device quickly appearing and
+	disappearing could be coalesced (i.e., ignored in this case).
+
+	I'm not convinced that {,UN}REGISTER has to go, but I haven't
+	seen any compelling uses for it, and I know it's politically
+	easier to add a feature than to remove one, especially if anyone
+	has developed a dependence on it and does not want to port.  So,
+	I'm starting out with tmpfs not providing {,UN}REGISTER events.
+
+6.2 Q:	Why isn't this facility implemented as an overlay file system?  I'd
+	like to be able to apply it to, say, /dev, without having
+	to start out with /dev being a devfs file system.  I could
+	also demand load certain facilities based on accesses to /proc.
+
+    A:	There are about two dozen routines in inode_operations and
+	file_operations that would require pass-through versions, and
+	they are not as trivial as you might think because of
+	locking issues involved in going through the vfs layer again.
+	Also, currently, tmpfs, like ramfs and sysfs, use a struct
+	inode and a struct dentry in kernel low memory for every
+	existing node in the file system, about half a kilobyte
+	per entry.  So, tmpfs would need to be converted to allow
+	inode structures to be released if it were to overlay
+	potentially large directory trees.  Also there are issues
+	related to the underlying file system changing "out from
+	under" tmpfs.  Perhaps in the future this an be implemented.
+
+
+6.3. Q: Why isn't tmpfs a built-in kernel facility that can be
+	applied to any file, like dnotify?  That would also have
+	the above advantages and could eliminate the mount complexity
+	of overlays.
+
+     A:	I thought about defining a separating inode->directory_operations
+	from inode->inode_operations. Since all of those operations that
+	I want to intercept are called with inode->i_sem held, it
+	follows that it would be SMP-safe to change an inode->dir_ops
+	pointer dynamically, which would allow stacking of inode
+	operations.  This approach could be used to remove the special
+	case code that is used to implement dnotify.  But what happens
+	when the inode is freed?  It would be necessary to intercept
+	the victim superblock's superblock_operations.drop_inode
+	routine, which could get pretty messy, especially, if, for
+	example, more than one trap was being used on the same file
+	system.  Perhaps if drop_inode were moved to struct
+	inode_operations this would be easier.
+
+
+Adam J. Richter (adam@yggdrasil.com)
+2004.11.02
--- linux-2.6.10-rc1-bk17/arch/um/drivers/line.c	2004-11-08 11:33:09.000000000 -0800
+++ linux/arch/um/drivers/line.c	2004-11-02 21:13:08.000000000 -0800
@@ -438,7 +438,7 @@
 
 	from = line_driver->symlink_from;
 	to = line_driver->symlink_to;
-	err = devfs_mk_symlink(from, to);
+	err = devfs_mk_symlink(to, from);
 	if(err) printk("Symlink creation from /dev/%s to /dev/%s "
 		       "returned %d\n", from, to, err);
 
--- linux-2.6.10-rc1-bk17/arch/um/drivers/mmapper_kern.c	2004-10-23 13:56:12.000000000 -0700
+++ linux/arch/um/drivers/mmapper_kern.c	2004-11-02 21:13:08.000000000 -0800
@@ -128,7 +128,7 @@
 	p_buf = __pa(v_buf);
 
 	devfs_mk_cdev(MKDEV(30, 0), S_IFCHR|S_IRUGO|S_IWUGO, "mmapper");
-	devfs_mk_symlink("mmapper0", "mmapper");
+	devfs_mk_symlink("mmapper", "mmapper0");
 	return(0);
 }
 
--- linux-2.6.10-rc1-bk17/arch/um/drivers/ubd_kern.c	2004-10-18 14:54:08.000000000 -0700
+++ linux/arch/um/drivers/ubd_kern.c	2004-11-02 21:13:08.000000000 -0800
@@ -559,7 +559,7 @@
 			
 {
 	struct gendisk *disk;
-	char from[sizeof("ubd/nnnnn\0")], to[sizeof("discnnnnn/disc\0")];
+	char to[sizeof("discnnnnn/disc\0")];
 	int err;
 
 	disk = alloc_disk(1 << UBD_SHIFT);
@@ -573,9 +573,8 @@
 	if(major == MAJOR_NR){
 		sprintf(disk->disk_name, "ubd%c", 'a' + unit);
 		sprintf(disk->devfs_name, "ubd/disc%d", unit);
-		sprintf(from, "ubd/%d", unit);
 		sprintf(to, "disc%d/disc", unit);
-		err = devfs_mk_symlink(from, to);
+		err = devfs_mk_symlink(to, "ubd/%d", unit);
 		if(err)
 			printk("ubd_new_disk failed to make link from %s to "
 			       "%s, error = %d\n", from, to, err);
--- linux-2.6.10-rc1-bk17/fs/Kconfig	2004-11-08 11:33:11.000000000 -0800
+++ linux/fs/Kconfig	2004-11-06 01:34:09.000000000 -0800
@@ -846,56 +846,6 @@
 
 	Designers of embedded systems may wish to say N here to conserve space.
 
-config DEVFS_FS
-	bool "/dev file system support (OBSOLETE)"
-	depends on EXPERIMENTAL
-	help
-	  This is support for devfs, a virtual file system (like /proc) which
-	  provides the file system interface to device drivers, normally found
-	  in /dev. Devfs does not depend on major and minor number
-	  allocations. Device drivers register entries in /dev which then
-	  appear automatically, which means that the system administrator does
-	  not have to create character and block special device files in the
-	  /dev directory using the mknod command (or MAKEDEV script) anymore.
-
-	  This is work in progress. If you want to use this, you *must* read
-	  the material in <file:Documentation/filesystems/devfs/>, especially
-	  the file README there.
-
-	  Note that devfs no longer manages /dev/pts!  If you are using UNIX98
-	  ptys, you will also need to mount the /dev/pts filesystem (devpts).
-
-	  Note that devfs has been obsoleted by udev,
-	  <http://www.kernel.org/pub/linux/utils/kernel/hotplug/>.
-	  It has been stripped down to a bare minimum and is only provided for
-	  legacy installations that use its naming scheme which is
-	  unfortunately different from the names normal Linux installations
-	  use.
-
-	  If unsure, say N.
-
-config DEVFS_MOUNT
-	bool "Automatically mount at boot"
-	depends on DEVFS_FS
-	help
-	  This option appears if you have CONFIG_DEVFS_FS enabled. Setting
-	  this to 'Y' will make the kernel automatically mount devfs onto /dev
-	  when the system is booted, before the init thread is started.
-	  You can override this with the "devfs=nomount" boot option.
-
-	  If unsure, say N.
-
-config DEVFS_DEBUG
-	bool "Debug devfs"
-	depends on DEVFS_FS
-	help
-	  If you say Y here, then the /dev file system code will generate
-	  debugging messages. See the file
-	  <file:Documentation/filesystems/devfs/boot-options> for more
-	  details.
-
-	  If unsure, say N.
-
 config DEVPTS_FS_XATTR
 	bool "/dev/pts Extended Attributes"
 	depends on UNIX98_PTYS
@@ -930,6 +880,9 @@
 
 	  See <file:Documentation/filesystems/tmpfs.txt> for details.
 
+	  devfs now requires tmpfs.  You must say "Y" here to tmpfs if
+	  you want to be able to use devfs.
+
 config TMPFS_XATTR
 	bool "tmpfs Extended Attributes"
 	depends on TMPFS
@@ -951,6 +904,107 @@
 	  If you are not using a security module that requires using
 	  extended attributes for file security labels, say N.
 
+config TMPFS_LOOKUP_TRAPS
+	bool "tmpfs lookup trapping"
+	depends on TMPFS
+	help
+	  This facility allows you to configure a tmpfs file system to
+	  invoke a user level helper program whenever an attempt is made
+	  to access a nonexistent file, enabling these helper programs
+	  to define file systems are filled in on demand.  There
+	  is a version of devfs that requires it, and it can be
+	  used to implement certain types of automatic mounting
+	  of other file systems.  It is a daemonless and, perhaps
+	  consequently, smaller (under 2kB object on x86) alternative
+	  to autofs for certain uses, although it cannot be used as a
+	  replacement in all cases, and it is not available as a loadable
+	  module (because tmpfs isn't).  For examples and more information,
+	  please see <file:Documentations/filesystems/lookup-trap.txt>.
+
+	  devfs now uses tmpfs lookup traps to implement configuration
+	  of devices on demand.  If you want this feature of devfs to
+	  be available, you must say "Y" here to TMPFS_LOOKUP_TRAPS.
+
+config DEVFS_FS
+	bool "/dev file system support"
+	depends on TMPFS
+	help
+	  This is support for devfs, a virtual file system (like /proc) which
+	  provides the file system interface to device drivers, normally found
+	  in /dev. Device drivers register entries in /dev which then
+	  appear automatically, which means that the system administrator does
+	  not have to create character and block special device files in the
+	  /dev directory using the mknod command (or MAKEDEV script) anymore.
+
+	  Note that devfs no longer manages /dev/pts!  If you are using UNIX98
+	  ptys, you will also need to mount the /dev/pts filesystem (devpts).
+
+	  You many want to read the material in
+	  <file:Documentation/filesystems/devfs/>, which currently
+	  documents the previous implementation.
+
+	  People interested in devfs may also be interested in udev
+	  <http://www.kernel.org/pub/linux/utils/kernel/hotplug/>, a
+	  system which creates device files in /dev in response to
+	  hot plug events.  Previously, someone put a note in this
+	  help message claiming that udev had obseleted devfs, so
+	  here is a quick summary of why that is probably not true.
+
+	  udev by itself does not currently do anything to support demand
+	  loading of drivers (some of which do not correspond to any
+	  hardware event) or give device drivers the ability to register
+	  descriptive minor device names (/dev/sound/mixer, /dev/sound/dsp),
+	  although non-devfs systems can, of course be preconfigured to
+	  "know" these things for specific devices, either by creating
+	  fixed files in /dev or sysfs-to-dev configuration files, which
+	  leads one to want automatic generation of such information from
+	  new modules, devfs does when the module is loaded, although it
+	  would be helpful to evolve devfs to also make some of this
+	  information extractable from the module, as hardware device ID
+	  information now is.  Also, mechanisms to pass such string
+	  information to udev via sysfs look to require more kernel code
+	  and consume more kernel memory than devfs.  However, having
+	  a user level utility mediate the creation of nodes in /dev
+	  has advantages in customizability, and having /dev reflect
+	  what device drivers are available rather than what drivers
+	  are loaded is informative to the user.
+
+	  With about half of the code that implements the functionality
+	  previously handled by devfs now part of the tmpfs lookup
+	  trapping facility which many udev systems are likely use,
+	  and with the move to dynamic device numbers requiring some sort
+	  of string-based device identification mechanism, there is
+	  question to what set of functionality one means by "devfs"
+	  if one claims that devfs is obseleted.
+
+	  Perhaps in the future, the kernel will not directly create
+	  device nodes in a virtual file system, but it is quite likely
+	  the some variant of the current devfs driver registration
+	  calls, perhaps via more user level software, will indirectly
+	  cause /dev to names appear about the same way it does today.
+
+config DEVFS_MOUNT
+	bool "Automatically mount at boot"
+	depends on DEVFS_FS
+	help
+	  This option appears if you have CONFIG_DEVFS_FS enabled. Setting
+	  this to 'Y' will make the kernel automatically mount devfs onto /dev
+	  when the system is booted, before the init thread is started.
+	  You can override this with the "devfs=nomount" boot option.
+
+	  If unsure, say N.
+
+config DEVFS_DEBUG
+	bool "Debug devfs"
+	depends on DEVFS_FS
+	help
+	  If you say Y here, then the /dev file system code will generate
+	  debugging messages. See the file
+	  <file:Documentation/filesystems/devfs/boot-options> for more
+	  details.
+
+	  If unsure, say N.
+
 config HUGETLBFS
 	bool "HugeTLB file system support"
 	depends X86 || IA64 || PPC64 || SPARC64 || SUPERH || X86_64 || BROKEN
--- linux-2.6.10-rc1-bk17/fs/Makefile	2004-11-08 11:33:11.000000000 -0800
+++ linux/fs/Makefile	2004-11-05 23:25:48.000000000 -0800
@@ -44,6 +44,10 @@
 obj-y				+= devpts/
 
 obj-$(CONFIG_PROFILING)		+= dcookies.o
+
+ifdef CONFIG_TMPFS_LOOKUP_TRAPS
+  obj-$(CONFIG_TMPFS)		+= lookuptrap.o userhelper.o
+endif
  
 # Do not add any filesystems before this line
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
--- linux-2.6.10-rc1-bk17/fs/compat_ioctl.c	2004-10-23 13:56:30.000000000 -0700
+++ linux/fs/compat_ioctl.c	2004-10-23 14:27:02.000000000 -0700
@@ -412,7 +412,7 @@
 	return err;
 }
 
-#ifdef CONFIG_NET
+#if defined(CONFIG_NET) || defined(CONFIG_NET_MODULE)
 static int do_siocgstamp(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	struct compat_timeval __user *up = compat_ptr(arg);
@@ -3166,7 +3166,7 @@
 #ifdef DECLARES
 HANDLE_IOCTL(MEMREADOOB32, mtd_rw_oob)
 HANDLE_IOCTL(MEMWRITEOOB32, mtd_rw_oob)
-#ifdef CONFIG_NET
+#if defined(CONFIG_NET) || defined(CONFIG_NET_MODULE)
 HANDLE_IOCTL(SIOCGIFNAME, dev_ifname32)
 HANDLE_IOCTL(SIOCGIFCONF, dev_ifconf)
 HANDLE_IOCTL(SIOCGIFFLAGS, dev_ifsioc)
--- linux-2.6.10-rc1-bk17/fs/devfs/Makefile	2004-10-18 14:53:10.000000000 -0700
+++ linux/fs/devfs/Makefile	2004-11-02 21:13:33.000000000 -0800
@@ -4,5 +4,4 @@
 
 obj-$(CONFIG_DEVFS_FS) += devfs.o
 
-devfs-objs := base.o util.o
-
+devfs-objs := fs.o interface.o util.o
--- linux-2.6.10-rc1-bk17/fs/devfs/fs.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/fs/devfs/fs.c	2004-11-02 21:13:33.000000000 -0800
@@ -0,0 +1,117 @@
+/*
+  Device File System implementation as an instance of trapfs.
+ 
+  Written by Adam J. Richter.  Copyright 2004 Yggdrasil Computing, Inc.
+
+  This file is free software; you can redistribute it and/or
+  modify it under the terms of the GNU General Public License as
+  published by the Free Software Foundation; either version 2 of the
+  License, or (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+  General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+  02111-1307 USA
+*/
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/shmem_fs.h>
+
+extern int __init trapfs_init(void);
+
+char devfs_slave_fs[40] = "tmpfs";
+module_param_string(devfs_slave_fs, devfs_slave_fs, sizeof(devfs_slave_fs),
+		    0444);
+
+static struct super_block *devfs_sb;
+static struct file_system_type *slavefs;
+static DECLARE_MUTEX(devfs_sb_sem);
+
+
+static struct super_block *devfs_get_sb(struct file_system_type *fs_type,
+					int flags,
+					const char *dev_name,
+					void *data)
+{
+	down(&devfs_sb_sem);
+
+	if (!devfs_sb) {
+		if (!slavefs)
+			slavefs = get_fs_type(devfs_slave_fs);
+
+		if (!slavefs)
+			printk (KERN_ERR "devfs_get_sb: unable to find %s.\n",
+				devfs_slave_fs);
+		else {
+			devfs_sb = (slavefs->get_sb)(fs_type, flags, dev_name,
+						     data);
+			if (!devfs_sb)
+				printk (KERN_ERR "devfs_get_sb: "
+					"slavefs_get_sb failed.\n");
+		}
+
+	}
+
+	if (devfs_sb)
+		atomic_inc(&devfs_sb->s_active);
+
+	up(&devfs_sb_sem);
+
+	return devfs_sb;
+}
+
+static void devfs_kill_super(struct super_block *sb)
+{
+	BUG_ON(sb != devfs_sb);
+	atomic_dec(&sb->s_active);
+}
+
+
+static struct file_system_type devfs_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "devfs",
+	.get_sb		= devfs_get_sb,
+	.kill_sb	= devfs_kill_super,
+};
+
+/* Not static, because it can also be called from init_devfs_fs. */
+int __init devfs_init(void)
+{
+	static int initialized;	/* = 0 */
+	int err;
+
+	init_tmpfs();
+
+	if (initialized)
+		err = 0;
+	else {
+		err = register_filesystem(&devfs_fs_type);
+		if (!err)
+			initialized = 1;
+	}
+
+	return err;
+}
+
+
+static void __exit devfs_exit(void)
+{
+	unregister_filesystem(&devfs_fs_type);
+	if (slavefs) {
+		if (devfs_sb)
+			(*slavefs->kill_sb)(devfs_sb);
+
+		module_put(slavefs->owner);
+	}
+}
+
+module_init(devfs_init)
+module_exit(devfs_exit)
+
+MODULE_LICENSE("GPL");
--- linux-2.6.10-rc1-bk17/fs/devfs/interface.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/fs/devfs/interface.c	2004-11-02 21:13:08.000000000 -0800
@@ -0,0 +1,334 @@
+/*
+    Device File System (devfs) - device interface routines
+
+    This file is a reimplementation by Adam J. Richter of part of a
+    design and implementation originally written by Richard Gooch.
+
+
+
+    Copyright 2002-2003  Yggdrasil Computing, Inc.
+
+    This library is free software; you can redistribute it and/or
+    modify it under the terms of the GNU Library General Public
+    License as published by the Free Software Foundation; either
+    version 2 of the License, or (at your option) any later version.
+
+    This library is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+    Library General Public License for more details.
+
+    You should have received a copy of the GNU Library General Public
+    License along with this library; if not, write to the Free
+    Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+/* Change log:
+	2003.02.24 - Maneesh Soni <maneesh@in.ibm.com> made it work with
+	read-copy-update, which is also apparently needed for linux-2.5.62-bk7
+	(presumably rcu has been merged into 2.5.62-bk7).
+
+	2003.02.24 - Override discretionary access controls (CAP_DAC_OVERRIDE)
+	in case devfs_{register,mk_sym_link} is called from a non-super-user.
+
+	2003.02.25 - Restore devfs=nomount boot option for now when
+	CONFIG_DEVFS_MOUNT is specified.
+
+	2003.03.21 - Implement suggestions by Christoph Hellwig:
+	rename to interface.c, raise CAP_DAC_OVERRIDE in devfs_mk_dir
+	(to match devfs_regsiter and devfs_mk_symlink), eliminate call
+	to devfs_dealloc_devnum, put unlikely() around devfs_vfsmount
+	test.  Also raise CAP_DAC_OVERRIDE in devfs_unregsiter.
+
+	2003.03.24 - 2.5.65-bk5 simplified devfs_mk_dir and devfs_mk_symlink.
+*/
+	
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/namei.h>
+#include <linux/mount.h>
+#include <linux/namespace.h>
+
+#include "internal.h"
+
+static char *devfs_mountpoint = "/dev";
+static char *dev_fs_type = "devfs";
+
+static struct dentry *devfs_root;
+
+/*
+   walk_parents expects to be called with parent->d_inode->i_sem
+   NOT held (this is against the convention of VFS lookup routines, but
+   no callers in this file currently want to do anything with i_sem
+   held before calling walk_parents, so we consolidate the
+   down() call here.
+
+   On the other hand, if the routine succeeds, it returns a dentry
+   with ->d_inode->i_sem HELD.  This is to avoid any races between
+   the last lookup done in walk_parents and whatever vfs
+   operation the caller is going to do.  (On failure, this routine
+   does release parent_inode->i_sem, since the routine will not
+   return a pointer that would allow the caller to determine the
+   parent inode).
+ */
+static struct dentry *
+walk_parents(const char *fmt, va_list args, int mkdirs)
+{
+	int len;
+	char path_buf[64];
+	char *path;
+	char *slash;
+	int err;
+	struct inode *parent_inode;
+	struct dentry *child;
+	struct dentry *parent;
+
+	len = vsnprintf(path_buf, sizeof(path_buf), fmt, args);
+	if (len >= sizeof(path_buf))
+		return ERR_PTR(-ENAMETOOLONG);
+
+	parent = devfs_root;
+
+	/*
+	  FUTURE: parent can be null if the kernel has devfs support
+	  compiled in, but the user has disabled it at boot.
+
+	  FUTURE: parent->d_inode can be null if the devfs_root is
+	  not a mount point and the user does "rm -rf /dev"
+	*/
+	if(!parent || !parent->d_inode)
+		return ERR_PTR(-ENOENT);
+
+	path = path_buf;
+	dget(parent);
+	for(;;) {
+		while (*path == '/')
+			path++;
+
+		/* paths passed to devfs_mk_* must not end in "/".
+		   It's too much of a pain to deal with, so we just
+		   declare that to be a bug in the calling device driver. */
+		BUG_ON(*path == '\0');
+
+
+		slash = strchr(path, '/');
+
+		parent_inode = parent->d_inode;
+		down(&parent_inode->i_sem);
+
+		if (slash == NULL) {
+			child = lookup_one_len(path, parent, strlen(path));
+			break;
+		}
+
+		child = lookup_one_len(path, parent, slash - path);
+		if (IS_ERR(child))
+			break;
+
+		if (!child->d_inode) {
+			err = mkdirs ?
+				vfs_mkdir(parent_inode, child, 0755) : -ENOENT;
+
+			if (err) {
+				dput(child);
+				child = ERR_PTR(err);
+				break;
+			}
+		}
+
+		up(&parent_inode->i_sem);
+		dput(parent);
+		parent = child;
+		path = slash + 1;
+	}
+
+	if (IS_ERR(child))
+		up(&parent_inode->i_sem);
+
+	dput(parent);
+	return child;
+}
+
+int devfs_mk_bdev(dev_t dev, umode_t mode, const char *fmt, ...)
+{
+	va_list args;
+	struct dentry *dentry;
+	int err;
+	struct inode *parent_inode;
+	kernel_cap_t oldcap = current->cap_effective;
+
+	current->cap_effective |=
+		CAP_TO_MASK(CAP_MKNOD) | CAP_TO_MASK(CAP_DAC_OVERRIDE);
+
+	va_start(args, fmt);
+	dentry = walk_parents(fmt, args, 1);
+	va_end(args);
+
+	if (IS_ERR(dentry))
+		err = PTR_ERR(dentry);
+	else {
+		parent_inode = dentry->d_parent->d_inode;
+
+		err = vfs_mknod(parent_inode, dentry, mode, dev);
+		up(&parent_inode->i_sem);
+		dput(dentry);
+	}
+
+	current->cap_effective = oldcap;
+	return err;
+}
+EXPORT_SYMBOL(devfs_mk_bdev);
+
+int devfs_mk_symlink (const char *link_contents, const char *fmt, ...)
+{
+	va_list args;
+	struct dentry *dentry;
+	int err;
+	struct inode *parent_inode;
+	kernel_cap_t oldcap = current->cap_effective;
+
+	cap_raise(current->cap_effective, CAP_DAC_OVERRIDE);
+
+	va_start(args, fmt);
+	dentry = walk_parents(fmt, args, 1);
+	va_end(args);
+
+	if (IS_ERR(dentry))
+		err = PTR_ERR(dentry);
+	else {
+		parent_inode = dentry->d_parent->d_inode;
+		err = vfs_symlink(parent_inode, dentry, link_contents,
+				  S_IALLUGO);
+		up(&parent_inode->i_sem);
+		dput(dentry);
+	}
+
+	current->cap_effective = oldcap;
+	return err;
+}
+EXPORT_SYMBOL(devfs_mk_symlink);
+
+int devfs_mk_dir(const char *fmt, ...)
+{
+	struct inode *parent_inode;
+	struct dentry *dentry;
+	int err;
+	va_list args;
+	kernel_cap_t oldcap = current->cap_effective;
+
+	cap_raise(current->cap_effective, CAP_DAC_OVERRIDE);
+
+	va_start(args, fmt);
+	dentry = walk_parents(fmt, args, 1);
+	va_end(args);
+
+	if (IS_ERR(dentry))
+		err = PTR_ERR(dentry);
+	else {
+		parent_inode = dentry->d_parent->d_inode;
+		err = vfs_mkdir(parent_inode, dentry, 0755);
+		up(&parent_inode->i_sem);
+		dput(dentry);
+	}
+
+	current->cap_effective = oldcap;
+	return err;
+}
+EXPORT_SYMBOL(devfs_mk_dir);
+
+/* From fs/devfs/base.c: */
+void devfs_remove(const char *fmt, ...)
+{
+	va_list args;
+	kernel_cap_t oldcap;
+	struct inode *parent_inode;
+	struct dentry *dentry;
+
+	va_start(args, fmt);
+	dentry = walk_parents(fmt, args, 0);
+	va_end(args);
+
+	if (IS_ERR(dentry))
+		return;
+
+	parent_inode = dentry->d_parent->d_inode;
+
+	oldcap = current->cap_effective;
+	cap_raise(current->cap_effective, CAP_DAC_OVERRIDE);
+
+	if (S_ISDIR(dentry->d_inode->i_mode))
+		vfs_rmdir(parent_inode, dentry);
+	else
+		vfs_unlink(parent_inode, dentry);
+
+	current->cap_effective = oldcap;
+
+	up(&parent_inode->i_sem);
+	dput(dentry);
+}
+EXPORT_SYMBOL(devfs_remove);
+
+#ifdef CONFIG_DEVFS_MOUNT
+static int devfs_do_mount = 1;
+
+static int devfs_param_set(const char *buffer, struct kernel_param *unused)
+{
+	if (strcmp(buffer, "mount") == 0)
+		devfs_do_mount = 1;
+	else if (strcmp(buffer, "nomount") == 0)
+		devfs_do_mount = 0;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int devfs_param_get(char *buffer, struct kernel_param *unused)
+{
+	return sprintf(buffer, "%smount", devfs_do_mount ? "" : "no");
+}
+
+__module_param_call("", devfs, devfs_param_set, devfs_param_get, NULL, 0444);
+
+int __init init_devfs_fs(void)
+{
+	struct vfsmount *vfsmount;
+
+	if (devfs_root != NULL)	/* FIXME? Can this happen? */
+		return 0;
+
+	devfs_init();		/* Safe to call repeatedly if devfs
+				   is compiled into the kernel. */
+
+	vfsmount = do_kern_mount(dev_fs_type, 0, dev_fs_type, NULL);
+
+	if (IS_ERR(vfsmount))
+		return PTR_ERR(vfsmount);
+	else {
+		devfs_root = vfsmount->mnt_root;
+		return 0;
+	}
+}
+
+void __init mount_devfs_fs (void)
+{
+	if (devfs_do_mount) {
+		int err = do_mount ("none", devfs_mountpoint, dev_fs_type, 0, "");
+
+		if (err == 0)
+			printk (KERN_INFO "Mounted devfs on /dev\n");
+		else
+			printk ("(): unable to mount devfs, err: %d\n", err);
+	}
+}   /*  End Function mount_devfs_fs  */
+
+#else 
+
+void __init mount_devfs_fs (void)
+{
+}
+
+#endif /* CONFIG_DEVFS_MOUNT */
+
--- linux-2.6.10-rc1-bk17/fs/devfs/internal.h	1969-12-31 16:00:00.000000000 -0800
+++ linux/fs/devfs/internal.h	2004-11-02 20:23:23.000000000 -0800
@@ -0,0 +1,6 @@
+#ifndef DEVFS_INTERNAL_H
+#define DEVFS_INTERNAL_H
+
+extern int __init devfs_init(void);
+
+#endif /* DEVFS_INTERNAL_H */
--- linux-2.6.10-rc1-bk17/fs/devfs/util.c	2004-10-23 13:56:30.000000000 -0700
+++ linux/fs/devfs/util.c	2004-11-02 21:13:08.000000000 -0800
@@ -75,13 +75,12 @@
 
 int devfs_register_tape(const char *name)
 {
-	char tname[32], dest[64];
+	char dest[64];
 	static unsigned int tape_counter;
 	unsigned int n = tape_counter++;
 
 	sprintf(dest, "../%s", name);
-	sprintf(tname, "tapes/tape%u", n);
-	devfs_mk_symlink(tname, dest);
+	devfs_mk_symlink(dest, "tapes/tape%u", n);
 
 	return n;
 }
--- linux-2.6.10-rc1-bk17/fs/lookuptrap.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/fs/lookuptrap.c	2004-11-05 23:15:06.000000000 -0800
@@ -0,0 +1,190 @@
+/*
+  struct dentry *trapping_lookup(struct inode *dir,
+				 struct dentry *dentry,
+				 struct nameidata *nd,
+				 char **shell_command_ptr)
+
+  trapping_lookup() is an alternative to simple_lookup() (from libfs.c),
+  that adds the ability to invoke a user level helper program when
+  an attempt is made to access a nonexistant file.  It invokes the
+  command via call_fs_helper() from fs/helper.c.
+
+  trapping_lookup takes one parameter in addition to the parameters
+  that an inode_operations->lookup method requires.  This paratmer,
+  shell_command_ptr is the address of a pointer to a string containing
+  the command to be executed trapping_lookup will always take a
+  read lock on superblock->s_umount, so it is multiprocessor-safe for your
+  file system's superblock mount and remount routines to modify that
+  address, since mount and remount will take a write lock on
+  superblock->s_umount.
+
+  See tmpfs in mm/shmem.c for an example of use of trapping_lookup.
+
+  trapping_lookup() is the only symbol exported from this file.
+
+
+  Written by Adam J. Richter
+  Copyright (C) 2004 Yggdrasil Computing, Inc.
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/dcache.h>
+#include <linux/wait.h>
+#include <linux/fsuserhelper.h>
+
+static inline int want_to_trap(struct nameidata *nd)
+{
+	return (nd != NULL);
+}
+
+
+/*
+ * Retaining negative dentries for an in-memory filesystem just wastes
+ * memory and lookup time: arrange for them to be deleted immediately.
+ */
+static int always_delete_dentry(struct dentry *dentry)
+{
+	return 1;
+}
+
+/* Force revalidation of all negative dentries.  Note that this routine
+   only gets called when some other routine has a reference to the dentry
+   or the dentry has an inode.  Otherwise, unused negative dentries
+   are immediately dropped, because of always_delete_dentry.  Apparently,
+   the only time blocking_dentry_valid ends up being called with an empty
+   inode is when a trapped reference is blocking on the user level helper.
+*/
+static int blocking_dentry_valid(struct dentry *dentry,
+				 struct nameidata *nd)
+{
+	struct wait_queue_head *queue_head;
+	struct semaphore *parent_inode_sem;
+	DEFINE_WAIT(my_wait);
+
+	if (dentry->d_inode != NULL)
+		return 1;
+
+	if (!want_to_trap(nd))
+		return 0;
+
+	/* FIXME? I think there is no need to use dget_parent or
+	   to take dcache_lock here, because dentry->d_parent never
+	   changes and the dentry holds a reference to its parent,
+	   and dentry->d_parent holds a reference to
+	   dentry->d_d_parent->d_inode. Right??? -AJR 2004.11.05 */
+	parent_inode_sem = &dentry->d_parent->d_inode->i_sem;
+
+	down(parent_inode_sem);
+
+	queue_head = dentry->d_fsdata;
+	if (!queue_head) {
+		up(parent_inode_sem);
+		return (dentry->d_inode != NULL);
+	}
+
+	prepare_to_wait(queue_head, &my_wait, TASK_INTERRUPTIBLE);
+	up(parent_inode_sem);
+	schedule();
+	finish_wait(queue_head, &my_wait);
+
+	/* At this point, maybe the queue was woken up or maybe we got a
+	   signal.  There is no need to check, because we just return
+	   in either case. */
+
+	return (dentry->d_inode != NULL);
+	
+}
+
+
+static struct dentry_operations trapping_dentry_ops = {
+	.d_delete =	always_delete_dentry,
+	.d_revalidate =	blocking_dentry_valid,
+};
+
+struct dentry *
+trapping_lookup(struct inode *dir,
+		struct dentry *dentry,
+		struct nameidata *nd,
+		char **shell_command_ptr)
+{
+	/*
+	  We must do d_add before call_fs_helper to prevent
+	  a duplicate dentry from being created if the helper
+	  program attempts to access the same file name in /dev.
+	  If simple_lookup returns non-NULL, then that is to an error
+	  like a malformed file name, so we do not invoke trapfs_event.
+	  If the file is not found but there was no other error,
+	  simple_lookup returns NULL, and that is the only case
+	  in which we want to generate a notification.
+
+	  We also filter out the final path element of mknod, mkdir
+	  and symlink, because invoking the helper for mknod and mkdir
+	  could lead to deadlock when trapfs loads a device driver
+	  kernel module than.  One would think that the way to filter
+	  would be to look at nd->flags to check that LOOKUP_CREATE
+	  is set and LOOKUP_OPEN is clear, but instead, the vfs
+	  layers passed nd==NULL in these cases via a routine
+	  called lookup_create (without any leading underscores),
+	  so we filter out the case where nd == NULL.
+
+	  Filtering out nd==NULL has the unintented side-effect of
+	  filtering out the final path component of arguments to
+	  rmdir, unlink and rename (both source and destination).
+	  For rmdir, unlink, and the source arguement to rename,
+	  that's fine, since nobody cares about attempts to remove
+	  nonexistant files.  We're probably also OK skipping the
+	  notifications with regard to the destination argument to
+	  rename, although that is less clear.
+	*/
+
+	struct dentry		*result;
+	wait_queue_head_t	queue_head;
+	struct dentry		*new;
+
+	if (!want_to_trap(nd))
+		return simple_lookup(dir, dentry, nd);
+
+	if (dentry->d_name.len > NAME_MAX)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	init_waitqueue_head(&queue_head);
+
+	dentry->d_fsdata = &queue_head;
+	dentry->d_op = &trapping_dentry_ops;
+
+	d_add(dentry, NULL);
+
+	call_fs_helper(shell_command_ptr, &dir->i_sb->s_umount, "LOOKUP",
+		       dentry);
+
+	new = d_lookup(dentry->d_parent, &dentry->d_name);
+
+	if (new != dentry) /* also handles new==NULL */
+		result = new;
+	else {
+		dput(new);
+		result = NULL;
+	}
+
+	wake_up(&queue_head);
+	dentry->d_fsdata = NULL; /* Yes, we really can call wake_up() first.*/
+
+	return result;
+}
+
+EXPORT_SYMBOL_GPL(trapping_lookup);
--- linux-2.6.10-rc1-bk17/fs/partitions/devfs.c	2004-10-23 13:56:31.000000000 -0700
+++ linux/fs/partitions/devfs.c	2004-11-02 21:13:08.000000000 -0800
@@ -79,7 +79,7 @@
 
 void devfs_add_partitioned(struct gendisk *disk)
 {
-	char dirname[64], symlink[16];
+	char dirname[64];
 
 	devfs_mk_dir(disk->devfs_name);
 	devfs_mk_bdev(MKDEV(disk->major, disk->first_minor),
@@ -88,10 +88,8 @@
 
 	disk->number = alloc_unique_number(&disc_numspace);
 
-	sprintf(symlink, "discs/disc%d", disk->number);
 	sprintf(dirname, "../%s", disk->devfs_name);
-	devfs_mk_symlink(symlink, dirname);
-
+	devfs_mk_symlink(dirname, "discs/disc%d", disk->number);
 }
 
 void devfs_add_disk(struct gendisk *disk)
@@ -103,13 +101,12 @@
 			"%s", disk->devfs_name);
 
 	if (disk->flags & GENHD_FL_CD) {
-		char dirname[64], symlink[16];
+		char dirname[64];
 
 		disk->number = alloc_unique_number(&cdrom_numspace);
 
-		sprintf(symlink, "cdroms/cdrom%d", disk->number);
 		sprintf(dirname, "../%s", disk->devfs_name);
-		devfs_mk_symlink(symlink, dirname);
+		devfs_mk_symlink(dirname, "cdroms/cdrom%d", disk->number);
 	}
 }
 
--- linux-2.6.10-rc1-bk17/fs/userhelper.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/fs/userhelper.c	2004-11-05 23:25:48.000000000 -0800
@@ -0,0 +1,190 @@
+/*
+  helper.c -- Invoke user level helper command for a struct dentry.
+
+  Written by Adam J. Richter
+  Copyright (C) 2004 Yggdrasil Computing, Inc.
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/ctype.h>
+#include <linux/fsuserhelper.h>
+
+static int path_len (struct dentry *de, struct dentry *root)
+{
+	int len = 0;
+	while (de != root) {
+		len += de->d_name.len + 1;	/* count the '/' */
+		de = de->d_parent;
+	}
+	return len;		/* -1 because we omit the leading '/',
+				   +1 because we include trailing '\0' */
+}
+
+static int write_path_from_mnt (struct dentry *de, char *path, int buflen)
+{
+	struct dentry *mnt_root = de->d_parent->d_inode->i_sb->s_root;
+	int len;
+	char *path_orig = path;
+
+	if (de == NULL || de == mnt_root)
+		return -EINVAL;
+
+	spin_lock(&dcache_lock);
+	len = path_len(de, mnt_root);
+	if (len > buflen) {
+		spin_unlock(&dcache_lock);
+		return -ENAMETOOLONG;
+	}
+
+	path += len - 1;
+	*path = '\0';
+
+	for (;;) {
+		path -= de->d_name.len;
+		memcpy(path, de->d_name.name, de->d_name.len);
+		de = de->d_parent;
+		if (de == mnt_root)
+			break;
+		*(--path) = '/';
+	}
+		
+	spin_unlock(&dcache_lock);
+
+	BUG_ON(path != path_orig);
+
+	return 0;
+}
+
+static inline int
+calc_argc(const char *str_in, int *str_len)
+{
+	const char *str = str_in;
+	int argc = 0;
+	while (*str) {
+		while (*str == ' ' || *str == '\t')
+			str++;
+		argc++;
+		while (*str != ' ' && *str != '\t' && *str)
+			str++;
+	}
+	*str_len = str - str_in;
+	return argc;
+}
+
+static char **
+gen_argv(char *str_in, int argc_extra, int *argc_out)
+{
+	int argc;
+	char **argv;
+	char *str_out;
+	int str_len;
+
+	if (!str_in)
+		return NULL;
+
+	while (*str_in == ' ' || *str_in == '\t')
+		str_in++;
+
+	if (*str_in == '\0')
+		return NULL;
+
+	argc = calc_argc(str_in, &str_len);
+
+	argv = kmalloc(((argc + argc_extra) * sizeof(char*)) + str_len + 1,
+		       GFP_KERNEL);
+	if (!argv)
+		return NULL;
+
+	str_out = (char*) (argv + argc + argc_extra);
+
+	argc = 0;
+	while (*str_in) {
+		argv[argc++] = str_out;
+
+		while (*str_in != ' ' && *str_in != '\t' && *str_in)
+			*(str_out++) = *(str_in++);
+
+		*(str_out++) = '\0';
+
+		while (*str_in == ' ' || *str_in == '\t')
+			str_in++;
+	}
+	*argc_out = argc;
+	return argv;
+}
+
+/*
+  Warning: dentry_usermodehelper releases and retakes
+  dentry->d_parent->d_inode->i_sem.  It must be called with this
+  semaphore already held.
+
+  command_p is a pointer to a single string.  It is *not* in argv format.
+  Instead, elements are separated by spaces.
+*/
+void call_fs_helper(char **command_ptr,
+		    struct rw_semaphore *command_rwsem,
+		    const char *event,
+		    struct dentry *dentry)
+{
+	char path[64];
+	int argc;
+	char **argv;
+	struct semaphore *parent_inode_sem = &dentry->d_parent->d_inode->i_sem;
+
+	if (write_path_from_mnt(dentry, path, sizeof(path)) == 0) {
+
+		/*
+		  FIXME.  We would not need the extra memory allocation,
+		  string copying, error branch and lines of source code
+		  due to err_strdup(), and we could put gen_argv
+		  into the set_fs_helper, if call_usermodehelper
+		  and execve had a callback to inform us when
+		  execve was done copying argv and envp.  With
+		  such a facility, we could just hold helper->rw_sem
+		  up to that point, without having to make a copy of the
+		  argument (which we currently do) or hold the semaphore
+		  until the helper process exits (which would cause a
+		  deadlock if a helper process ever tried to change
+		  the helper string of a file system, especially since
+		  there is not such a thing as rw_down_read_interruptible
+		  that would make the deadlock breakable).
+		*/
+
+		up(parent_inode_sem);
+
+		down_read(command_rwsem);
+		argv = gen_argv(*command_ptr, 3, &argc);
+		up_read(command_rwsem);
+
+		if (argv != NULL) {
+			static char *envp[] =
+				{"PATH=/bin:/sbin:/usr/bin:/usr/sbin",
+				 "HOME=/", NULL };
+
+			argv[argc++] = (char*) event;
+			argv[argc++] = path;
+			argv[argc] = NULL;
+
+			call_usermodehelper(argv[0], argv, envp, 1);
+			kfree(argv);
+		}
+
+		down(parent_inode_sem);
+	}
+}
+EXPORT_SYMBOL_GPL(call_fs_helper);
--- linux-2.6.10-rc1-bk17/include/linux/devfs_fs_kernel.h	2004-10-18 14:54:40.000000000 -0700
+++ linux/include/linux/devfs_fs_kernel.h	2004-11-02 21:13:08.000000000 -0800
@@ -8,14 +8,13 @@
 
 #include <asm/semaphore.h>
 
-#define DEVFS_SUPER_MAGIC                0x1373
-
 #ifdef CONFIG_DEVFS_FS
 extern int devfs_mk_bdev(dev_t dev, umode_t mode, const char *fmt, ...)
     __attribute__ ((format(printf, 3, 4)));
-extern int devfs_mk_cdev(dev_t dev, umode_t mode, const char *fmt, ...)
-    __attribute__ ((format(printf, 3, 4)));
-extern int devfs_mk_symlink(const char *name, const char *link);
+
+#define devfs_mk_cdev(dev, mode, fmt...)	devfs_mk_bdev(dev,mode,fmt)
+
+extern int devfs_mk_symlink (const char *link_contents, const char *fmt, ...);
 extern int devfs_mk_dir(const char *fmt, ...)
     __attribute__ ((format(printf, 1, 2)));
 extern void devfs_remove(const char *fmt, ...)
@@ -32,7 +31,8 @@
 {
 	return 0;
 }
-static inline int devfs_mk_symlink(const char *name, const char *link)
+static inline int
+devfs_mk_symlink (const char *link_contents, const char *fmt, ...)
 {
 	return 0;
 }
--- linux-2.6.10-rc1-bk17/include/linux/fsuserhelper.h	1969-12-31 16:00:00.000000000 -0800
+++ linux/include/linux/fsuserhelper.h	2004-11-04 16:11:42.000000000 -0800
@@ -0,0 +1,15 @@
+#ifndef _LINUX_FS_HELPER
+#define _LINUX_FS_HELPER
+
+#include <linux/dcache.h>
+#include <linux/rwsem.h>
+
+/*
+  Note: call_fs_helper releases and retakes dentry->d_parent->d_inode->i_sem.
+*/
+extern void call_fs_helper(char **comand_str_ptr,
+			   struct rw_semaphore *command_rwsem,
+			   const char *event,
+			   struct dentry *dentry);
+
+#endif /* _LINUX_FS_HELPER */
--- linux-2.6.10-rc1-bk17/include/linux/lookuptrap.h	1969-12-31 16:00:00.000000000 -0800
+++ linux/include/linux/lookuptrap.h	2004-11-05 12:03:19.000000000 -0800
@@ -0,0 +1,12 @@
+#ifndef _LINUX_LOOKUPTRAP_H
+#define _LINUX_LOOKUPTRAP_H
+
+#include <linux/fs.h>
+#include <linux/dcache.h>
+
+extern struct dentry *trapping_lookup(struct inode *dir,
+				      struct dentry *dentry,
+				      struct nameidata *nd,
+				      char **shell_command_ptr);
+
+#endif /* _LINUX_LOOKUPTRAP_H */
--- linux-2.6.10-rc1-bk17/include/linux/shmem_fs.h	2004-10-18 14:54:55.000000000 -0700
+++ linux/include/linux/shmem_fs.h	2004-11-05 23:25:48.000000000 -0800
@@ -1,8 +1,10 @@
 #ifndef __SHMEM_FS_H
 #define __SHMEM_FS_H
 
+#include <linux/config.h>
 #include <linux/swap.h>
 #include <linux/mempolicy.h>
+#include <linux/fsuserhelper.h>
 
 /* inode in-kernel data */
 
@@ -22,11 +24,15 @@
 };
 
 struct shmem_sb_info {
+	int limited;		/* 0 = ignore max_blocks and max_inodes */
 	unsigned long max_blocks;   /* How many blocks are allowed */
 	unsigned long free_blocks;  /* How many are left for allocation */
 	unsigned long max_inodes;   /* How many inodes are allowed */
 	unsigned long free_inodes;  /* How many are left for allocation */
 	spinlock_t    stat_lock;
+#ifdef CONFIG_TMPFS_LOOKUP_TRAPS
+	char *helper_shell_command;
+#endif
 };
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
@@ -34,4 +40,6 @@
 	return container_of(inode, struct shmem_inode_info, vfs_inode);
 }
 
+extern int __init init_tmpfs(void); /* early initialization for devfs */
+
 #endif
--- linux-2.6.10-rc1-bk17/mm/shmem.c	2004-11-08 11:33:15.000000000 -0800
+++ linux/mm/shmem.c	2004-11-08 21:14:04.000000000 -0800
@@ -14,6 +14,9 @@
  * Copyright (c) 2004, Luke Kenneth Casson Leighton <lkcl@lkcl.net>
  * Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *
+ * User level helper for directory lookups:
+ * Copyright (C) 2004 Adam J. Richter, Yggdrasil Computing, Inc.
+ *
  * This file is released under the GPL.
  */
 
@@ -46,6 +49,9 @@
 #include <linux/mempolicy.h>
 #include <linux/namei.h>
 #include <linux/xattr.h>
+#include <linux/fsuserhelper.h>
+#include <linux/lookuptrap.h>
+#include <linux/parser.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 #include <asm/pgtable.h>
@@ -135,7 +141,20 @@
 
 static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
 {
+#ifdef CONFIG_TMPFS
 	return sb->s_fs_info;
+#else
+	return NULL;		/* compiler optimization */
+#endif
+}
+
+static inline int shmem_have_quotas(struct shmem_sb_info *sb_info)
+{
+#ifdef CONFIG_TMPFS
+	return sb_info->limited;
+#else
+	return 0;		/* sb_info will be NULL. */
+#endif
 }
 
 /*
@@ -194,7 +213,8 @@
 static void shmem_free_blocks(struct inode *inode, long pages)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
-	if (sbinfo) {
+
+	if (shmem_have_quotas(sbinfo)) {
 		spin_lock(&sbinfo->stat_lock);
 		sbinfo->free_blocks += pages;
 		inode->i_blocks -= pages*BLOCKS_PER_PAGE;
@@ -357,7 +377,7 @@
 		 * page (and perhaps indirect index pages) yet to allocate:
 		 * a waste to allocate index if we cannot allocate data.
 		 */
-		if (sbinfo) {
+		if (shmem_have_quotas(sbinfo)) {
 			spin_lock(&sbinfo->stat_lock);
 			if (sbinfo->free_blocks <= 1) {
 				spin_unlock(&sbinfo->stat_lock);
@@ -678,7 +698,7 @@
 			spin_unlock(&shmem_swaplist_lock);
 		}
 	}
-	if (sbinfo) {
+	if (shmem_have_quotas(sbinfo)) {
 		BUG_ON(inode->i_blocks);
 		spin_lock(&sbinfo->stat_lock);
 		sbinfo->free_inodes++;
@@ -1081,7 +1101,7 @@
 	} else {
 		shmem_swp_unmap(entry);
 		sbinfo = SHMEM_SB(inode->i_sb);
-		if (sbinfo) {
+		if (shmem_have_quotas(sbinfo)) {
 			spin_lock(&sbinfo->stat_lock);
 			if (sbinfo->free_blocks == 0 ||
 			    shmem_acct_block(info->flags)) {
@@ -1269,7 +1289,7 @@
 	struct shmem_inode_info *info;
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
-	if (sbinfo) {
+	if (shmem_have_quotas(sbinfo)) {
 		spin_lock(&sbinfo->stat_lock);
 		if (!sbinfo->free_inodes) {
 			spin_unlock(&sbinfo->stat_lock);
@@ -1598,7 +1618,7 @@
 	buf->f_type = TMPFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
 	buf->f_namelen = NAME_MAX;
-	if (sbinfo) {
+	if (shmem_have_quotas(sbinfo)) {
 		spin_lock(&sbinfo->stat_lock);
 		buf->f_blocks = sbinfo->max_blocks;
 		buf->f_bavail = buf->f_bfree = sbinfo->free_blocks;
@@ -1614,7 +1634,8 @@
  * File creation. Allocate an inode, and we're done..
  */
 static int
-shmem_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
+shmem_mknod_no_register(struct inode *dir, struct dentry *dentry,
+			int mode, dev_t dev)
 {
 	struct inode *inode = shmem_get_inode(dir->i_sb, mode, dev);
 	int error = -ENOSPC;
@@ -1634,13 +1655,43 @@
 	return error;
 }
 
+#ifdef CONFIG_TMPFS_LOOKUP_TRAPS
+static void
+shmem_call_fs_helper(const char *event, struct dentry *dentry)
+{
+	struct super_block *sb = dentry->d_inode->i_sb;
+	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+
+	call_fs_helper(&sbinfo->helper_shell_command, &sb->s_umount,
+		       event, dentry);
+}
+#else
+static inline void
+shmem_call_fs_helper(const char *event, struct dentry *dentry)
+{
+}
+#endif 
+
+static int
+shmem_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
+{
+	int error = shmem_mknod_no_register(dir, dentry, mode, dev);
+	if (!error)
+		shmem_call_fs_helper("REGISTER", dentry);
+
+	return error;
+}
+
 static int shmem_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	int error;
 
-	if ((error = shmem_mknod(dir, dentry, mode | S_IFDIR, 0)))
+	if ((error = shmem_mknod_no_register(dir, dentry, mode | S_IFDIR, 0)))
 		return error;
 	dir->i_nlink++;
+
+	shmem_call_fs_helper("REGISTER", dentry);
+
 	return 0;
 }
 
@@ -1650,6 +1701,19 @@
 	return shmem_mknod(dir, dentry, mode | S_IFREG, 0);
 }
 
+#ifdef CONFIG_TMPFS_LOOKUP_TRAPS
+static struct dentry * shmem_lookup(struct inode *dir,
+				    struct dentry *dentry,
+				    struct nameidata *nd)
+{
+	struct shmem_sb_info *sbinfo = SHMEM_SB(dir->i_sb);
+
+	return trapping_lookup(dir, dentry, nd, &sbinfo->helper_shell_command);
+}
+#else
+# define shmem_lookup simple_lookup
+#endif
+
 /*
  * Link a file..
  */
@@ -1663,7 +1727,7 @@
 	 * but each new link needs a new dentry, pinning lowmem, and
 	 * tmpfs dentries cannot be pruned until they are unlinked.
 	 */
-	if (sbinfo) {
+	if (shmem_have_quotas(sbinfo)) {
 		spin_lock(&sbinfo->stat_lock);
 		if (!sbinfo->free_inodes) {
 			spin_unlock(&sbinfo->stat_lock);
@@ -1686,9 +1750,11 @@
 {
 	struct inode *inode = dentry->d_inode;
 
+	shmem_call_fs_helper("UNREGISTER", dentry);
+		
 	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode)) {
 		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
-		if (sbinfo) {
+		if (shmem_have_quotas(sbinfo)) {
 			spin_lock(&sbinfo->stat_lock);
 			sbinfo->free_inodes++;
 			spin_unlock(&sbinfo->stat_lock);
@@ -1784,6 +1850,7 @@
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	d_instantiate(dentry, inode);
 	dget(dentry);
+	shmem_call_fs_helper("REGISTER", dentry);
 	return 0;
 }
 
@@ -1840,7 +1907,7 @@
 #endif
 };
 
-static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long *blocks, unsigned long *inodes)
+static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long *blocks, unsigned long *inodes, substring_t *helper)
 {
 	char *this_char, *value, *rest;
 
@@ -1894,6 +1961,9 @@
 			*gid = simple_strtoul(value,&rest,0);
 			if (*rest)
 				goto bad_val;
+		} else if (!strcmp(this_char,"helper")) {
+			helper->from = value;
+			helper->to = value + strlen(value);
 		} else {
 			printk(KERN_ERR "tmpfs: Bad mount option %s\n",
 			       this_char);
@@ -1909,32 +1979,73 @@
 
 }
 
+#ifdef CONFIG_TMPFS_LOOKUP_TRAPS
+static int
+maybe_replace_from_substr(char **target, substring_t *substr)
+{
+	char *str;
+
+	if (substr->from == NULL)
+		return 0;
+
+	if (substr->from == substr->to)
+		str = NULL;
+	else {
+		str = match_strdup(substr);
+		if (!str)
+			return -ENOMEM;
+	}
+	kfree(*target);
+	*target = str;
+	return 0;
+}
+#endif /* CONFIG_TMPFS_LOOKUP_TRAPS */
+
 static int shmem_remount_fs(struct super_block *sb, int *flags, char *data)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 	unsigned long max_blocks = 0;
 	unsigned long max_inodes = 0;
+	substring_t helper_str;
 
-	if (sbinfo) {
+	if (shmem_have_quotas(sbinfo)) {
 		max_blocks = sbinfo->max_blocks;
 		max_inodes = sbinfo->max_inodes;
 	}
-	if (shmem_parse_options(data, NULL, NULL, NULL, &max_blocks, &max_inodes))
+	helper_str.from = NULL;
+	if (shmem_parse_options(data, NULL, NULL, NULL, &max_blocks, &max_inodes, &helper_str))
 		return -EINVAL;
+
+#ifdef CONFIG_TMPFS_LOOKUP_TRAPS
+	if (maybe_replace_from_substr(&sbinfo->helper_shell_command,
+				      &helper_str) != 0)
+		return -ENOMEM;
+#endif
+
 	/* Keep it simple: disallow limited <-> unlimited remount */
-	if ((max_blocks || max_inodes) == !sbinfo)
+	if ((max_blocks || max_inodes) != shmem_have_quotas(sbinfo))
 		return -EINVAL;
+
 	/* But allow the pointless unlimited -> unlimited remount */
-	if (!sbinfo)
+	if (!max_blocks && !max_inodes)
 		return 0;
+
 	return shmem_set_size(sbinfo, max_blocks, max_inodes);
 }
-#endif
+#endif /* CONFIG_TMPFS */
 
 static void shmem_put_super(struct super_block *sb)
 {
-	kfree(sb->s_fs_info);
-	sb->s_fs_info = NULL;
+#ifdef CONFIG_TMPFS
+	struct shmem_sb_info *sb_info = SHMEM_SB(sb);
+
+# ifdef CONFIG_TMPFS_LOOKUP_TRAPS	
+	kfree(sb_info->helper_shell_command);
+# endif
+	kfree(sb_info);
+#endif
+
+	sb->s_fs_info = NULL;	/* FIXME.  Is this line necessary? */
 }
 
 #ifdef CONFIG_TMPFS_XATTR
@@ -1954,14 +2065,17 @@
 	int err = -ENOMEM;
 
 #ifdef CONFIG_TMPFS
+	substring_t helper_str;
 	unsigned long blocks = 0;
 	unsigned long inodes = 0;
+	struct shmem_sb_info *sbinfo;
 
 	/*
 	 * Per default we only allow half of the physical ram per
 	 * tmpfs instance, limiting inodes to one per page of lowmem;
 	 * but the internal instance is left unlimited.
 	 */
+	helper_str.from = NULL;
 	if (!(sb->s_flags & MS_NOUSER)) {
 		blocks = totalram_pages / 2;
 		inodes = totalram_pages - totalhigh_pages;
@@ -1969,24 +2083,32 @@
 			inodes = blocks;
 
 		if (shmem_parse_options(data, &mode,
-					&uid, &gid, &blocks, &inodes))
+					&uid, &gid, &blocks, &inodes,
+					&helper_str))
 			return -EINVAL;
 	}
 
-	if (blocks || inodes) {
-		struct shmem_sb_info *sbinfo;
-		sbinfo = kmalloc(sizeof(struct shmem_sb_info), GFP_KERNEL);
-		if (!sbinfo)
-			return -ENOMEM;
-		sb->s_fs_info = sbinfo;
-		spin_lock_init(&sbinfo->stat_lock);
-		sbinfo->max_blocks = blocks;
-		sbinfo->free_blocks = blocks;
-		sbinfo->max_inodes = inodes;
-		sbinfo->free_inodes = inodes;
-	}
+	sbinfo = kmalloc(sizeof(struct shmem_sb_info), GFP_KERNEL);
+	if (!sbinfo)
+		return -ENOMEM;
+
+	sbinfo->limited = (blocks || inodes);
+	sb->s_fs_info = sbinfo;
+	spin_lock_init(&sbinfo->stat_lock);
+	sbinfo->max_blocks = blocks;
+	sbinfo->free_blocks = blocks;
+	sbinfo->max_inodes = inodes;
+	sbinfo->free_inodes = inodes;
+
+# ifdef CONFIG_TMPFS_LOOKUP_TRAPS
+	sbinfo->helper_shell_command = NULL;
+	if (maybe_replace_from_substr(&sbinfo->helper_shell_command,
+				      &helper_str) != 0)
+		return -ENOMEM;
+# endif
+
 	sb->s_xattr = shmem_xattr_handlers;
-#endif
+#endif /* CONFIG_TMPFS */
 
 	sb->s_maxbytes = SHMEM_MAX_BYTES;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
@@ -2088,7 +2210,7 @@
 static struct inode_operations shmem_dir_inode_operations = {
 #ifdef CONFIG_TMPFS
 	.create		= shmem_create,
-	.lookup		= simple_lookup,
+	.lookup		= shmem_lookup,
 	.link		= shmem_link,
 	.unlink		= shmem_unlink,
 	.symlink	= shmem_symlink,
@@ -2192,9 +2314,15 @@
 };
 static struct vfsmount *shm_mnt;
 
-static int __init init_tmpfs(void)
+/* init_tmpfs is exported so that devfs can get an earlier initialization
+   if necessary. */
+int __init init_tmpfs(void)
 {
 	int error;
+	static int initialized;	/* = 0 */
+
+	if (initialized)
+		return 0;
 
 	error = init_inodecache();
 	if (error)
@@ -2215,6 +2343,7 @@
 		printk(KERN_ERR "Could not kern_mount tmpfs\n");
 		goto out1;
 	}
+	initialized = 1;
 	return 0;
 
 out1:
@@ -2310,3 +2439,5 @@
 	vma->vm_ops = &shmem_vm_ops;
 	return 0;
 }
+EXPORT_SYMBOL(shmem_lock);
+EXPORT_SYMBOL(shmem_nopage);
