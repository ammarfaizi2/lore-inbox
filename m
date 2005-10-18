Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbVJREoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVJREoL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 00:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVJREoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 00:44:11 -0400
Received: from koto.vergenet.net ([210.128.90.7]:52649 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751229AbVJREoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 00:44:10 -0400
Date: Tue, 18 Oct 2005 13:41:48 +0900
From: Horms <horms@verge.net.au>
To: linux-kernel@vger.kernel.org
Cc: Rudolf Polzer <debian-ne@durchnull.de>, 334113@bugs.debian.org,
       Alastair McKinstry <mckinstry@debian.org>, security@kernel.org,
       team@security.debian.org, secure-testing-team@lists.alioth.debian.org
Subject: kernel allows loadkeys to be used by any user, allowing for local root compromise
Message-ID: <20051018044146.GF23462@verge.net.au>
References: <E1EQofT-0001WP-00@master.debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EQofT-0001WP-00@master.debian.org>
X-Cluestick: seven
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2005 at 06:03:31PM +0200, Rudolf Polzer wrote:
> Package: linux-image-2.6.12-1-powerpc
> Version: 2.6.12-10
> Severity: critical
> Tags: security
> Justification: root security hole
> 
> 
> The non-suid command "loadkeys" can be used by any local user having
> console access. It does not just apply to the current virtual console
> but to all virtual consoles and its effect persists even after logout.
> 
> A proof of concept would be (^V, ^C etc. refer to key presses on the
> console):
> 
> loadkeys
> keycode 15 = F23
> string F23 = "^V^C^V^Mecho hello world^V^M"
> ^D
> 
> Then log out and let root login (in a computer pool, you can usually get
> an admin to log on as root on a console somehow). The next time he'll
> press TAB to complete a file name, he instead will run the shell
> command.
> 
> Of course, the shell command could be more evil, e.g. add a line to
> /etc/passwd, clear the screen to make it less obvious, sync and write
> stuff to /dev/mem to cause a kernel crash so that most people would not
> suspect anything but a hardware fault. A demo exploit adding a line to
> the password file, clearing the screen and logging out exists in form of
> a shell script.
> 
> As a solution, I propose that the loadkeys command (or more exactly, the
> kernel interface it uses) should be restricted to root and instead one
> could add a suid wrapper for loadkeys that only allows the system-wide
> keymaps to be loaded. The old behaviour could still be made selectable
> using a procfs file.
> 
> If the last modification time of the manual page of loadkeys is true,
> this bug exists in the Linux kernel at least since 1997. However, the
> BUGS section of the manpage does not hint that the loadkeys command
> can even be used as a root compromise and not just for stuff like
> unbinding all keys.
> 
> Plus, it might be good to have a way to disable chvt for non-root users.
> Using chvt, a malicious user could do the same thing in an X session:
> remap Backspace to another key, handle Ctrl-Alt-Backspace by chvt 1;
> chvt 7 (so the video mode switches) and showing a fake login manager on
> the X display. If chvt were not possible for mere mortals, the admin
> would be able to disable all possible video mode switching caused by X
> applications (like xrandr, xvidmode, dpms) in the xorg.conf file so that
> he finally knows: if Ctrl-Alt-Backspace caused video mode switching, the
> resulting login screen is genuine.
> 
> Another solution would be a keymap-invariant non-remappable "zap" key
> combination with the functionality of Alt-SysRq-K - but on an X screen,
> it should tell the X server to exit instead of kill -9ing it so that the
> video mode gets restored. And it should be able to make a kernel support
> it without adding all of the other "Magic SysRq Key" features. Of
> course, it should lock the keymap until the user tells the system to
> unlock it again.
> 
> Or, even better: a "root login key". That is, something unremappable
> that causes a new VT to be created with a login prompt for root - and
> while this VT is active, the keymap should be locked to the system-wide
> standard keymap. Ideally, that "root login key" should also work from X
> and maybe even when the X server has crashed.

Hi,

I recently received the following message through the debian Bug tracker.

http://bugs.debian.org/334113

In a nuthsell it raises concernes about the effects of giving
users access to VT ioctls and outlines a potential attack 
using loadkeys to execute commands as root.

I took a very brief look over it, and the concern does seem valid to me.
Most of the VT ioctls are only garded by the following permissions,
the ioctl in question, which I believe is KDSKBSENT, is no exception:

drivers/char/vt_ioctl.c: vt_ioctl(): line 377

        /*
         * To have permissions to do most of the vt ioctls, we either
         * have
         * to be the owner of the tty, or have CAP_SYS_TTY_CONFIG.
         */
        perm = 0;
        if (current->signal->tty == tty || capable(CAP_SYS_TTY_CONFIG))
                perm = 1;


A simple fix for this might be just checking for capable(CAP_SYS_TTY_CONFIG)
in do_kdgkb_ioctl(), which effects KDSKBSENT. This more restrictive
approach is probably appropriate for many of the other ioctls that set
VT parameters.

However, the changes will still affect all consoles and be persistant
after the user logs out of the console. It would seem more logical to
have the state apply only to the current console, and only for the
duration of the session. The latter could be handled in user-space if
the ioctls were privelaged. But I suspect adding the former might be
somewhat difficult.

The same kind of issue also seems to be relevant to many of the other VT
ioctls.

I'm not really familiar enough with the code to comment more, though I
am happy to code-up ideas if people can point me in the right direction.

-- 
Horms
