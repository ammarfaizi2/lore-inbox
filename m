Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273918AbRJQCUy>; Tue, 16 Oct 2001 22:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274062AbRJQCUo>; Tue, 16 Oct 2001 22:20:44 -0400
Received: from intranet.resilience.com ([209.245.157.33]:33948 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S273918AbRJQCUk>; Tue, 16 Oct 2001 22:20:40 -0400
Message-ID: <3BCCEA19.8080809@usa.net>
Date: Tue, 16 Oct 2001 19:16:57 -0700
From: Eric <ebrower@usa.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010802
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Q] pivot_root and initrd
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been doing some work to boot a 2.4.x linux system from onboard 
flash and then change_root to an attached disk.

As the kernel documentation admonishes us to use pivot_root instead of 
relying on the change_root facility (Documentation/initrd.txt: "Current 
kernels still support it, but you should _not_ rely on its continued 
availability") I have given it a shot with less than stellar results-- 
perhaps someone (Warner?) could enlighten me on a few points:

1) What is the current status of pivot_root from an initrd?  Is anyone 
using it for this purpose, and is it being deprecated by the "union 
mounts" mentioned in the bootinglinux-current document by Warner?

2) The initrd.txt and pivot_root manpages seem incorrect on how to 
execute /sbin/init on the pivot-root'ed filesystem.  In general, the 
examples suggest the following should work, but it will not:

   pivot_root . old_root
   exec chroot . sh -c 'umount /old_root; exec /sbin/init' \
     <dev/console >dev/console 2>&1

The standard util-linux /sbin/init program will not allow itself to be 
executed without command-line args unless its PID is 1, or it is invoked 
as "sh" or "init.new."  As we are exec'ing init from userspace instead 
of from the kernel, we fail these tests.  Perhaps we can update these 
examples with something (admitedly hokey) like:

   pivot_root . old_root
   exec chroot . sh -c 'umount /old_root; exec -a init.new /sbin/init' \
     <dev/console >dev/console 2>&1

... or am I misunderstanding a finer point of the standard linux init 
process?  Note, if we substitute in the above "exec -a sh /sbin/init" we 
get a truncated process name in the resulting 'ps' listing as 'in' (bug?).

3) The kernel does not understand pivot_root in the context of an 
initrd.  As I understand the process, an initd-aware kernel will spawn a 
thread to handle the /linuxrc process in the initrd.  Once it completes, 
the kernel double-checks the real_root_dev against the initrd major and 
minor and invokes change_root when the /linuxrc thread exits:

  #ifdef CONFIG_BLK_DEV_INITRD
  [ ... ]
    pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
    if (pid>0)
            while (pid != wait(&i));
    if (MAJOR(real_root_dev) != RAMDISK_MAJOR
         || MINOR(real_root_dev) != 0) {
            error = change_root(real_root_dev,"/initrd");
  [ ... ]
  #endif

This poses a problem--  I load an initrd, perform a pivot_root and exec 
the real /sbin/init on the new root filesystem.  I am happily running; 
now I do 'shutdown -r now' and the init process is terminated.  Once the 
init process goes away the kernel decides it is time to change_root and 
exec "the real /sbin/init."

I would expect to see some sort of fall-through mechanism to prevent the 
change_root once a pivot_root is done during an initrd run.  The only 
method that seems (un)plausible is that I am responsible for setting the 
real_root_dev via sysctl to the major/minor of the initrd device after a 
successful pivot_root.  For those of us without sysctl, we have precious 
little to do but accept a restart of init.

What say ye with a better view of the landscape?
I do not subscribe, so cc's to me would be appreciated...

E





