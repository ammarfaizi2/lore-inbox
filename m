Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278511AbRJPD0n>; Mon, 15 Oct 2001 23:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278076AbRJPDZb>; Mon, 15 Oct 2001 23:25:31 -0400
Received: from cti06.citenet.net ([206.123.38.70]:43789 "EHLO
	cti06.citenet.net") by vger.kernel.org with ESMTP
	id <S278077AbRJPDZK>; Mon, 15 Oct 2001 23:25:10 -0400
From: Jacques Gelinas <jack@solucorp.qc.ca>
Date: Mon, 15 Oct 2001 21:49:57 -0500
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: re: re: Re: Announce: many virtual servers on a single box
X-mailer: tlmpmail 0.1
Message-ID: <20011015214957.8286ad1406bb@remtk.solucorp.qc.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001 08:55:51 -0500, David Lang wrote
> you mention problems with interaction if the main sandbox has a service
> listening on 0.0.0.0, what happens if a vserver does this (does it only
> see it's own IP addresses or does it interfere with other servers?)

The vserver can't bind 0.0.0.0. The new set_ipv4root system call (named
after the chroot one) is setting one IP number in the current task_struct.
the system call accept only a transition from 0 to some IP. So like chroot()
once you do it in a process you are trapped.

The system calls affects both the bind() syscall and the connect() one (when
it lookup the route). Once an ipv4 root is set to x.y.z.w, the process (and children) can
do

	bind (0.0.0.0) and it gets bind(x.y.z.w)
	connect() without binding and they get coonect + bind(x.y.z.w)
	bind (x.y.z.w) and it gets bind(x.y.z.w)
	bind(another_ip) and it gets an error
	connect + bind(another_IP) and it gets an error.

The ability to bind multiple time on a port has always been there. So using
this call, we limit the vserver to a single IP. The nice part is that this is
completly transparent to the vserver services. Services like apache, sshd, xinetd
sybase are running without any special configuration.

Btw, the v_xxx service (v_httpd, v_sshd) are simple wrapper to run service
in the main server without having to change their configuration so they
do not interfere. What they do is simply

	#!/bin/sh
	/usr/sbin/chbind --ip eth0 /etc/rc.d/init.d/httpd $*

Also you can do the following

	/usr/sbin/chbind --ip 1.2.3.4 some_command

and this effectivly prevent the "some_command" to do any IP network activity.
The set_ipv4root() syscall is not privileged at all. Its a one shot thing though :-)

--

For now, I have not tried to hide completly the fact that a vserver is a vserver.
The only feature it has is that a vserver can have its own host and domain name.
This was done because many service use this to setup some defaults and I wanted
vservers to be as natural as possible configuration wise.

I could have added a couple featurism such as

	private uptime
	hide the network device and fake a single one
	what else.

We will see as the need arise.

I also added the /sbin/vreboot command which talks with a socket /dev/reboot
established by the rebootmgr service in the root server (one socket per
vserver). This way a vserver can test its ability to properly shutdown and start.
The reboot manager simply does

	/usr/sbin/vserver the-vserver restart

this simply chroot to the vserver, selec the same security context, sets
the ipv4root and then exec

	/etc/rc.d/rc 6

Then it kills the remaining processes. To start it, it executes

	/etc/rc.d/rc 3

In general, you reboot a vserver in 3 seconds :-)

---------------------------------------------------------
Jacques Gelinas <jack@solucorp.qc.ca>
vserver: run general purpose virtual servers on one box, full speed!
http://www.solucorp.qc.ca/miscprj/s_context.hc
