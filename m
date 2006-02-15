Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030596AbWBOCad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030596AbWBOCad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 21:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030600AbWBOCad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 21:30:33 -0500
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:8637 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030596AbWBOCac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 21:30:32 -0500
Message-ID: <43F29245.7070902@bigpond.net.au>
Date: Wed, 15 Feb 2006 13:30:29 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] rmkernel.py v0.2 -- a simple tool for deleting Linux kernels
Content-Type: multipart/mixed;
 boundary="------------060504090200010704060308"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 15 Feb 2006 02:30:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060504090200010704060308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

As Steven Rostedt pointed out when announcing his clean-boot.pl tool, 
one can end up with quite a large number of installed kernels if 
building and installing from a GIT playground.  Attached is a Python 
script that eases the burden of managing this problem by providing a 
convenient mechanism for deleting kernels.

Usage: rmkernel.py [-i] [-v] <kernel> ....
        rmkernel.py -l [<kernel> ...]
        rmkernel.py -g

where <kernel> can be a glob expression (n.b. lists of expressions 
accepted) describing which kernels to delete, the -i option selects 
interactive mode where confirmation is requested for each deletion and 
-v lists each kernel that has been deleted.  This script uses grubby to 
update grub (or lilo etc.) for the removal of the kernel.  Additionally, 
the script checks to see if the kernel was installed via rpm and if it 
was uses rpm to do the removal.  It will not delete the currently 
running kernel and will silently skip it if it is in the list of kernels 
to be deleted.

The -l option lists installed kernels that match the <kernel> glob 
expression(s) or all installed kernels if no globs are provided.  The 
currently running kernel will be marked with "******" after its name.

The -g selects "GUI mode" (using PyGTK) and presents a list of installed 
kernels which can be selected and deleted with the provided buttons. 
The currently running kernel is not included in the list but is 
displayed  at the top of the window for information only.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------060504090200010704060308
Content-Type: text/x-python;
 name="rmkernel.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rmkernel.py"

#!/usr/bin/env python

### Copyright (C) 2005 Peter Williams <pwil3058@bigpond.net.au>

### This program is free software; you can redistribute it and/or modify
### it under the terms of the GNU General Public License as published by
### the Free Software Foundation; version 2 of the License only.

### This program is distributed in the hope that it will be useful,
### but WITHOUT ANY WARRANTY; without even the implied warranty of
### MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
### GNU General Public License for more details.

### A copy of the GNU General Public License is available at
### <http://www.gnu.org/licenses/gpl.txt>; if not, write to the Free Software
### Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

## Version 0.2

import os, os.path, signal, popen2, fcntl, select, re, pygtk, gtk

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

_kernel_re = re.compile("^(\d+)\.(\d+)\.(\d+)(.*)$")

def cmp_kernels(k1, k2):
    m1 = _kernel_re.match(k1)
    m2 = _kernel_re.match(k2)
    for i in range(3):
        res = cmp(int(m1.group(i+1)), int(m2.group(i+1)))
        if res != 0:
            return res
    if len(m1.groups()) == 4:
        if len(m2.groups()) == 4:
            return cmp(m1.group(4), m2.group(4))
        else:
            return -1
    elif len(m2.groups()) == 4:
        return 1
    return 0

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
    if run_cmd("/sbin/grubby --info=" + kfile)[0] == 0:
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

def get_current_kernel():
    res, so, se = run_cmd("uname -r")
    return so.strip()

class gui(gtk.Window):
    def __init__(self):
        gtk.Window.__init__(self, gtk.WINDOW_TOPLEVEL)
        self.connect("destroy", self._quit)
        self.set_title("rmkernel")
        self.tooltips = gtk.Tooltips()
        self.window = self.get_root_window()
        vbox = gtk.VBox()
        self.add(vbox)
        self.current_kernel = get_current_kernel()
        ck_label = gtk.Label(self.current_kernel + " :Current Kernel")
        ck_label.set_padding(0, 0)
        vbox.pack_start(ck_label, False, False, 0)
        self.store = gtk.ListStore(str)
        self.view = gtk.TreeView(self.store)
        text_cell = gtk.CellRendererText()
        tvcolumn = gtk.TreeViewColumn("Installed Kernels")
        tvcolumn.pack_start(text_cell)
        tvcolumn.set_attributes(text_cell, text=0)
        self.view.append_column(tvcolumn)
        sw = gtk.ScrolledWindow()
        sw.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
        sw.add(self.view)
        vbox.add(sw)
        self.selection = self.view.get_selection()
        self.selection.set_mode(gtk.SELECTION_MULTIPLE)
        self.update_kernels()
        bbox = gtk.HButtonBox()
        vbox.pack_start(bbox, False, False, 0)
        qbutton = gtk.Button("Quit", gtk.STOCK_QUIT)
        bbox.add(qbutton)
        qbutton.connect("clicked", self._quit)
        self.tooltips.set_tip(qbutton, "Quit this application")
        rbutton = gtk.Button("Refresh", gtk.STOCK_REFRESH)
        bbox.add(rbutton)
        rbutton.connect("clicked", self.update_kernels)
        self.tooltips.set_tip(rbutton, "Refresh the list of installed kernels")
        dbutton = gtk.Button("Delete", gtk.STOCK_DELETE)
        bbox.add(dbutton)
        dbutton.connect("clicked", self.delete_selection)
        self.tooltips.set_tip(dbutton, "Delete/uninstall the selected kernels")
        self.selection.unselect_all()
        self.show_all()
        self.show()
    def _show_busy(self):
        self.window.set_cursor(gtk.gdk.Cursor(gtk.gdk.WATCH))
        while gtk.events_pending():
            gtk.main_iteration()
    def _unshow_busy(self):
        self.window.set_cursor(gtk.gdk.Cursor(gtk.gdk.LEFT_PTR))
    def update_kernels(self, data=None):
        self._show_busy()
        kernels = find_kernels()
        kernels.sort(cmp_kernels)
        self.store.clear()
        for k in kernels:
            if k != self.current_kernel:
                self.store.append([k])
        self._unshow_busy()
    def _get_selected_kernels_cb(self, store, path, iter, list):
        list.append(store.get_value(iter, 0))
    def delete_selection(self, data=None):
        self._show_busy()
        res = []
        self.selection.selected_foreach(self._get_selected_kernels_cb, res)
        for k in res:
            try:
                remove_kernel(k)
            except OSError, msg:
                dialog = gtk.Dialog("rmkernel", self, gtk.DIALOG_MODAL,
                    (gtk.STOCK_OK, gtk.RESPONSE_ACCEPT))
                dialog.vbox.add(gtk.Label("Error: " + str(msg)))
                dialog.show_all()
                dialog.run()
                dialog.destroy()
                break
        self._unshow_busy()
        self.update_kernels()
    def _quit(self, widget):
        gtk.main_quit()

if __name__ == "__main__":
    def print_usage_and_exit(ev):
        print "Usage: rmkernel.py [-i] [-v] <kernel> ..."
        print "       rmkernel.py -l [<kernel> ...]"
        print "       rmkernel.py -g"
        sys.exit(ev)
    import getopt, sys, fnmatch
    syntax_error = False
    interactive = False
    verbose = False
    list = False
    use_gui = False
    opts_ok = True
    args_ok = True
    try:
        optlist, args = getopt.getopt(sys.argv[1:], "ivlg")
    except getopt.GetoptError:
        syntax_error = True
    if syntax_error:
        print_usage_and_exit(1)
    for o, a in optlist:
        if o == "-i":
            interactive = True
            opts_ok = opts_ok and not (list or use_gui)
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
            opts_ok = opts_ok and not (list or use_gui)
            verbose = True
        if o == "-l":
            opts_ok = opts_ok and not (verbose or interactive or use_gui)
            list = True
        if o == "-g":
            opts_ok = opts_ok and not (verbose or interactive or list)
            args_ok = len(args) == 0
            use_gui = True
    args_ok = args_ok and ((list or use_gui) or len(args) > 0)
    if not (args_ok and opts_ok):
        print_usage_and_exit(2)
    kernels = find_kernels()
    current_kernel = get_current_kernel()
    if list:
        if len(args) == 0:
            klist = kernels
            klist.sort(cmp_kernels)
        else:
            klist = []
            for g in args:
                sublist = fnmatch.filter(kernels, g)
                sublist.sort(cmp_kernels)
                klist += sublist
        for k in klist:
            if k == current_kernel:
                print k, "******"
            else:
                print k
    elif use_gui:
        app = gui()
        gtk.main()
    else:
        for g in args:
            klist = fnmatch.filter(kernels, g)
            klist.sort(cmp_kernels)
            for k in klist:
                if k == current_kernel:
                    continue
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

--------------060504090200010704060308--
