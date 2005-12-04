Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVLDAaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVLDAaf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 19:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVLDAaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 19:30:35 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:13456 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932186AbVLDAae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 19:30:34 -0500
Message-ID: <439238A7.2030905@bigpond.net.au>
Date: Sun, 04 Dec 2005 11:30:31 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] clean-boot.pl version 0.1 - Simple utility to clean
 up	/boot and /lib/modules
References: <1133573415.32583.108.camel@localhost.localdomain>
In-Reply-To: <1133573415.32583.108.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------020304040701060108050603"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 4 Dec 2005 00:30:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020304040701060108050603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Steven Rostedt wrote:
> I'm not sure if this has been done already or not (let me know if it
> has), but I've just noticed that after playing with several
> developmental kernels I had about 30 to 40 different versions of
> vmlinuz, initrd.img, config, and System.maps in my /boot directory, not
> to mention all the modules loaded in /lib/modules.
> 
> So I wrote this perl script that let me pick and choose what I wanted to
> clean up.  Be careful, this must be run as root, and although the
> default is to do nothing, if you hit a "y" in the wrong place, you can
> lose that kernel.
> 
> The script is here:
> 
> http://www.kihontech.com/code/clean-boot.pl
> 
> Here's the usage:
> 
> # ./clean-boot.pl -h
> 
> usage: clean-boot.pl [-b boot_dir] [-m module_dir]
>   (version 0.1)
>    default boot_dir = /boot
>    default module_dir = /lib/modules
> 
> It's run like the following:
> 
> ---
> #./clean-boot.pl
> List of versions found:
>   2.6.12-1-386              2.6.14                    2.6.14-2-386
>   2.6.14-2-k7-smp           2.6.14-kthrt2             2.6.14-rt13
>   2.6.14-rt13-logdev1       2.6.14-rt15               2.6.14-rt20
>   2.6.15-rc3
> Remove files for version 2.6.12-1-386 [y/N/l/q/?]:  ?
>   y - remove files from boot and modules
>   n [default] - skip this version
>   l - list the found versions again
>   q - quit
>   ? - display this message
> Remove files for version 2.6.12-1-386 [y/N/l/q/?]:  q
> ---
> 
> If you hit "y" (or yes or ye, case is ignored), it will then remove any
> of the vmlinuz, initrd.img, config and System.map files for version
> 2.6.12-1-386 in /boot and the directory /lib/modules/2.6.12-1-386.
> 
> This is under just a public license, no warranty, so just be careful not
> to delete too much.
> 
> Also remember to update lilo or grub, since this doesn't handle that.
> 
> Comments?

I also had this problem and created the attached Python script to handle 
the problem.  Usage is:

Usage: rmkernel.py [-i] [-v] <kernel> ....

where <kernel> can be a glob expression (n.b. lists of expressions 
accepted) describing which kernels to delete, the -i option selects 
interactive mode where confirmation is requested for each deletion and 
-v lists each kernel that has been deleted.  This script is slightly 
smarter than yours in that it uses grubby to update grub (or lilo etc.) 
for the removal of the kernel.  Additionally, the script checks to see 
if the kernel was installed via rpm and if it was uses rpm to do the 
removal.

If it was thought desirable a GUI version of this program would be 
fairly easy to write using rmkernel.py as a library module.

Cheers,
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------020304040701060108050603
Content-Type: text/x-python;
 name="rmkernel.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rmkernel.py"

#!/usr/bin/env python

import os, os.path, signal, popen2, fcntl, select, re

def make_non_blocking(fd):
    fl = fcntl.fcntl(fd, fcntl.F_GETFL)
    try:
        fcntl.fcntl(fd, fcntl.F_SETFL, fl | os.O_NDELAY)
    except AttributeError:
        fcntl.fcntl(fd, fcntl.F_SETFL, fl | os.FNDELAY)

# Take advice from "Python Cookbook" on avoiding potential dead locks
# reading stdout and stderr from sub process
def run_cmd(cmd, input=None):
    savedsh = signal.getsignal(signal.SIGPIPE)
    signal.signal(signal.SIGPIPE, signal.SIG_DFL)
    sub = popen2.Popen3(cmd, True)
    if not input is None:
        sub.tochild.write(input)
    sub.tochild.close()
    outfd = sub.fromchild.fileno()
    errfd = sub.childerr.fileno()
    make_non_blocking(outfd)
    make_non_blocking(errfd)
    outd, errd = [], []
    outeof = erreof = False
    while True:
        to_check = [outfd] * (not outeof) + [errfd] * (not erreof)
        ready = select.select(to_check, [], [])
        if outfd in ready[0]:
            outchunk = sub.fromchild.read()
            if outchunk == '':
                outeof = True
            else:
                outd.append(outchunk)
        if errfd in ready[0]:
            outchunk = sub.childerr.read()
            if outchunk == '':
                erreof = True
            else:
                errd.append(outchunk)
        if outeof and erreof:
            break
        try:
            select.select([], [], [], 0.05)
        except select.error, data:
            if data[0] is errno.EINTR:
                pass
            else:
                return [ data[0], "", data[1] ]
    res = sub.wait()
    signal.signal(signal.SIGPIPE, savedsh)
    return [ res, ''.join(outd), ''.join(errd) ]

def file_is_known_to_rpm(file):
    res, so, se = run_cmd("rpm -qf " + file)
    return res == 0

def remove_rpm_kernel(kernel):
    kfile = kernel_file(kernel)
    run_cmd("rpm -e --nodeps `rpm -qf " + kfile + "`")

def modules_dir(kernel):
    return "/lib/modules/" + kernel

def kernel_file(kernel):
    return "/boot/vmlinuz-" + kernel

def system_map_file(kernel):
    return "/boot/System.map-" + kernel

def initrd_file(kernel):
    return "/boot/initrd-" + kernel + ".img"

def remove_kernel_modules(kernel):
    kmdir = modules_dir(kernel)
    if os.path.isdir(kmdir):
        os.system("/bin/rm -r " + kmdir)

def _remove_files(file):
    if os.path.exists(file):
        os.remove(file)
    if os.path.exists(file + ".old"):
        os.remove(file + ".old")

def remove_kernel_file(kernel):
    _remove_files(kernel_file(kernel))

def remove_system_map_file(kernel):
    _remove_files(system_map_file(kernel))

def remove_initrd_file(kernel):
    _remove_files(initrd_file(kernel))

def remove_kernel_from_grub(kernel):
    kfile = kernel_file(kernel)
    if run_cmd("sudo /sbin/grubby --info=" + kfile)[0] == 0:
        run_cmd("/sbin/grubby --remove-kernel=" + kfile)

def remove_kernel(kernel, verbose=False):
    if verbose:
        print "Removing", kernel,
    if file_is_known_to_rpm(kernel_file(kernel)):
        remove_rpm_kernel(kernel)
        if verbose:
            print "done via rpm."
    else:
        remove_kernel_file(kernel)
        remove_system_map_file(kernel)
        remove_initrd_file(kernel)
        remove_kernel_modules(kernel)
        remove_kernel_from_grub(kernel)
        if verbose:
            print "done."

def find_kernels():
    kernels = os.listdir("/lib/modules")
    kre = re.compile("^vmlinuz-(.*?)(.old)?$")
    for f in os.listdir("/boot"):
        m = kre.match(f)
        if m:
            k = m.group(1)
            if k not in kernels:
                kernels.append(m.group(1))
    return kernels

if __name__ == "__main__":
    import getopt, sys, fnmatch
    syntax_error = False
    interactive = False
    verbose = False
    try:
        optlist, args = getopt.getopt(sys.argv[1:], "iv")
    except getopt.GetoptError:
        syntax_error = True
    if syntax_error or len(args) == 0:
        print "Usage: rmkernel.py [-i] [-v] <kernel> ..."
        sys.exit(1)
    for o, a in optlist:
        if o == "-i":
            interactive = True
            import tty, termios
            def getch():
                fd = sys.stdin.fileno()
                old_settings = termios.tcgetattr(fd)
                try:
                    tty.setraw(fd)
                    ch = sys.stdin.read(1)
                finally:
                    termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
                return ch
        if o == "-v":
            verbose = True
    kernels = find_kernels()
    for g in args:
        klist = fnmatch.filter(kernels, g)
        for k in klist:
            if not interactive:
                remove_kernel(k, verbose)
            else:
                print "Delete", k, "?"
                while True:
                    response = getch()
                    print response
                    if response in ["y", "n"]:
                        break
                    else:
                        beep()
                if response == "y":
                    remove_kernel(k, verbose)
            del kernels[kernels.index(k)]

--------------020304040701060108050603--
