Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUIMMwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUIMMwI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 08:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266657AbUIMMwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 08:52:08 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:14348 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266650AbUIMMwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 08:52:01 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Unwritable device nodes on ro nfs
Date: Mon, 13 Sep 2004 15:51:29 +0300
User-Agent: KMail/1.5.4
Cc: Greg KH <greg@kroah.com>, Trond Myklebust <trond.myklebust@fys.uio.no>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200409131551.30187.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am moving away from devfs. I have a problem
booting with ro nfs root fs.

I initialize network and mount nfs using an
initrd, then pivot_root into nfs mountpoint:

...
mount -n -t devfs none /new_root/dev
cd /new_root
# making sure we dont keep /dev busy
exec <dev/console >dev/console 2>&1
pivot_root . old_root
...
exec \
chroot . \
sh -c \
'umount -n /old_root; exec /bin/env - $INIT'

I removed "mount -n -t devfs" line and
now "exec >dev/console" fails because
/new_root is ro-mounted nfs. ro-mounted
local fs (reiser3) works fine.

Shall I jump thru the hoops, mount a ramfs
on top of new_root/dev, populate it with
device nodes, etc?

I don't want to do this, I want to hand a
'clean' state to secondary $INIT.

I can close all descriptors (exec <&- >&- 2>&-)
before I exec $INIT, and have $INIT deal with
that. This avoid the problem of >/dev/console.

But I lose the ability to boot with INIT=/bin/sh then.
sh doesn't expect to have stdio closed at startup.
Not good.

What is a 'right thing' to do in this situation?
--
vda

