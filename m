Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266657AbUBLWWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 17:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266659AbUBLWWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 17:22:17 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:50162 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S266657AbUBLWWM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 17:22:12 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bogus __KERNEL_SYSCALLS__ usage
Date: Thu, 12 Feb 2004 23:16:22 +0100
User-Agent: KMail/1.5.4
Cc: Dave Jones <davej@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200402122316.26610.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 12 February 2004, Dave Jones wrote:
> I just did a mini-audit of users of __KERNEL_SYSCALLS and turned
> up a bunch of uglies. The patch below is the easy ones
> (nothing to fix, they were defining it and including unistd.h for no
> reason). The remainders will need more work.

Incidentally, I've recently done the same and come to almost the some
conclusions. Comparing my list with yours, I have found two differences:

> 	arch/ia64/kernel/process.c:#define __KERNEL_SYSCALLS__
I just saw davidm reply on this, nevermind.

./arch/sparc64/kernel/power.c:90:       if (execve("/sbin/shutdown", argv, envp) < 0) {
This appears to be missing from your list. Can probably be changed to
call_usermodehelper() if needed.

I also did the reverse search and found that some architectures have 
definitions for __KERNEL_SYSCALLS__ that are never used. In particular,
delete_module, exit, idle, pause, stat, sync, wait and wait4 are never
used as a kernel syscall, potentially also clone and _exit, when they are
removed from ia64 process.c.

Below is my list of which calls are actually done, in case someone wants to
know exactly. I'm not sure about what to do with execve(), but the other
legitimate uses of system call handlers in init/*.c are probably easy to
convert to their sys_* counterparts, once we have Randy's new syscalls.h.

	Arnd <><

*** _exit ***
./arch/ia64/kernel/process.c:597:               _exit(result);
*** clone ***
./arch/ia64/kernel/process.c:585:       tid = clone(flags | CLONE_VM | CLONE_UNTRACED, 0);
*** close ***
./init/do_mounts.c:73:  close(fd);
./init/do_mounts.c:103: close(fd);
./init/do_mounts.c:330:         close(fd);
./init/do_mounts.c:341:         close(fd);
./init/do_mounts_devfs.c:64:                    close(fd);
./init/do_mounts_devfs.c:74:    close(fd);
./init/do_mounts_initrd.c:31:   close(old_fd);close(root_fd);
./init/do_mounts_initrd.c:32:   close(0);close(1);close(2);
./init/do_mounts_initrd.c:70:   close(old_fd);
./init/do_mounts_initrd.c:71:   close(root_fd);
./init/do_mounts_initrd.c:96:                   close(fd);
./init/do_mounts_md.c:166:                      close(fd);
./init/do_mounts_md.c:212:              close(fd);
./init/do_mounts_md.c:249:                      close(fd);
./init/do_mounts_rd.c:208:                      if (close(in_fd)) {
./init/do_mounts_rd.c:234:      close(in_fd);
./init/do_mounts_rd.c:236:      close(out_fd);
./sound/isa/wavefront/wavefront_synth.c:2008:   close (fd);
./sound/isa/wavefront/wavefront_synth.c:2013:   close (fd);
./sound/oss/wavfront.c:2584:    close (fd);
./sound/oss/wavfront.c:2589:    close (fd);
*** delete_module ***
*** dup ***
./init/do_mounts_initrd.c:35:   (void) dup(0);
./init/do_mounts_initrd.c:36:   (void) dup(0);
./init/main.c:599:      (void) dup(0);
./init/main.c:600:      (void) dup(0);
*** execve ***
./init/do_mounts_initrd.c:37:   return execve(shell, argv, envp_init);
./arch/sparc64/kernel/power.c:90:       if (execve("/sbin/shutdown", argv, envp) < 0) {
./drivers/sbus/char/bbc_envctrl.c:201:  if (execve("/sbin/shutdown", argv, envp) < 0)
./drivers/sbus/char/envctrl.c:1007:     if (0 > execve("/sbin/shutdown", argv, envp)) {
./init/main.c:559:      execve(init_filename, argv_init, envp_init);
./kernel/kmod.c:173:            retval = execve(sub_info->path, sub_info->argv,sub_info->envp);
*** exit ***
*** idle ***
*** lseek ***
./init/do_mounts_devfs.c:31:    lseek(fd, 0, 0);
./init/do_mounts_rd.c:68:       lseek(fd, start_block * BLOCK_SIZE, 0);
./init/do_mounts_rd.c:95:       lseek(fd, (start_block+1) * BLOCK_SIZE, 0);
./init/do_mounts_rd.c:122:      lseek(fd, start_block * BLOCK_SIZE, 0);
./drivers/media/dvb/frontends/alps_tdlb7.c:158: filesize = lseek(fd, 0L, 2);
./drivers/media/dvb/frontends/alps_tdlb7.c:172: lseek(fd, SP8870_FIRMWARE_OFFSET, 0);
./drivers/media/dvb/frontends/sp887x.c:219:     filesize = lseek(fd, 0L, 2);
./drivers/media/dvb/frontends/sp887x.c:241:     lseek(fd, 10, 0);
./drivers/media/dvb/frontends/tda1004x.c:297:   filesize = lseek(fd, 0L, 2);
./drivers/media/dvb/frontends/tda1004x.c:327:   lseek(fd, tda10045h_fwinfo[fwinfo_idx].fw_offset, 0);
*** open ***
./init/do_mounts.c:69:  fd = open(path, 0, 0);
./init/do_mounts.c:99:  fd = open(path, 0, 0);
./init/do_mounts.c:327: fd = open("/dev/root", O_RDWR | O_NDELAY, 0);
./init/do_mounts.c:333: fd = open("/dev/console", O_RDWR, 0);
./init/do_mounts_devfs.c:51:    int fd = open(path, 0, 0);
./init/do_mounts_initrd.c:34:   (void) open("/dev/console",O_RDWR,0);
./init/do_mounts_initrd.c:50:   root_fd = open("/", 0, 0);
./init/do_mounts_initrd.c:51:   old_fd = open("/old", 0, 0);
./init/do_mounts_initrd.c:87:           int fd = open("/dev/root.old", O_RDWR, 0);
./init/do_mounts_md.c:157:              fd = open(name, 0, 0);
./init/do_mounts_md.c:246:              int fd = open("/dev/md0", 0, 0);
./init/do_mounts_rd.c:139:      out_fd = open("/dev/ram", O_RDWR, 0);
./init/do_mounts_rd.c:143:      in_fd = open(from, O_RDONLY, 0);
./init/do_mounts_rd.c:213:                      in_fd = open(from, O_RDONLY, 0);
./drivers/media/dvb/frontends/alps_tdlb7.c:152: fd = open(fn, 0, 0);
./drivers/media/dvb/frontends/sp887x.c:213:     fd = open(sp887x_firmware, 0, 0);
./drivers/media/dvb/frontends/tda1004x.c:291:   fd = open(tda1004x_firmware, 0, 0);
./init/main.c:596:      if (open("/dev/console", O_RDWR, 0) < 0)
./sound/isa/wavefront/wavefront_synth.c:1950:   if ((fd = open (path, 0, 0)) < 0) {
./sound/oss/wavfront.c:2526:    if ((fd = open (path, 0, 0)) < 0) {
*** pause ***
*** read ***
./init/do_mounts.c:72:  len = read(fd, buf, 32);
./init/do_mounts.c:102: len = read(fd, buf, 32);
./init/do_mounts.c:338:         read(fd, &c, 1);
./init/do_mounts_rd.c:69:       read(fd, buf, size);
./init/do_mounts_rd.c:96:       read(fd, buf, size);
./init/do_mounts_rd.c:220:              read(in_fd, buf, BLOCK_SIZE);
./init/do_mounts_rd.c:333:      insize = read(crd_infd, inbuf, INBUFSIZ);
./drivers/media/dvb/frontends/alps_tdlb7.c:173: if (read(fd, dp, SP8870_FIRMWARE_SIZE) != SP8870_FIRMWARE_SIZE) {
./drivers/media/dvb/frontends/sp887x.c:242:     if (read(fd, firmware, fw_size) != fw_size) {
./drivers/media/dvb/frontends/tda1004x.c:328:   if (read(fd, firmware, fw_size) != fw_size) {
./sound/isa/wavefront/wavefront_synth.c:1959:           if ((x = read (fd, &section_length, sizeof (section_length))) !=
./sound/isa/wavefront/wavefront_synth.c:1969:           if (read (fd, section, section_length) != section_length) {
./sound/oss/wavfront.c:2535:            if ((x = read (fd, &section_length, sizeof (section_length))) !=
./sound/oss/wavfront.c:2545:            if (read (fd, section, section_length) != section_length) {
*** setsid ***
./init/do_mounts_initrd.c:33:   setsid();
*** stat ***
*** sync ***
*** wait ***
*** wait4 ***
*** waitpid ***
./init/do_mounts_initrd.c:60:           while (pid != waitpid(-1, &i, 0))
./net/ipv4/ipvs/ip_vs_sync.c:867:       if ((waitpid_result = waitpid(pid, NULL, __WCLONE)) != pid) {
*** write ***
./init/do_mounts_rd.c:221:              write(out_fd, buf, BLOCK_SIZE);
./init/do_mounts_rd.c:354:    written = write(crd_outfd, window, outcnt);
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAK/s25t5GS2LDRf4RAhY/AJ9z+bZzEb3fRp2X+rR0sQRAC1PAQACfR0mo
K80EOirEjf1dHfNDvfynnKk=
=yPuM
-----END PGP SIGNATURE-----

