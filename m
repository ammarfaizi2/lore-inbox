Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWHGWxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWHGWxL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWHGWxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:53:11 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:36741 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S932328AbWHGWxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:53:10 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Date: Mon, 7 Aug 2006 22:52:59 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <eb8g8b$837$1@taverner.cs.berkeley.edu>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI> <20060807101745.61f21826.froese@gmx.de> <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com> <20060807224144.3bb64ac4.froese@gmx.de>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1154991179 8295 128.32.168.222 (7 Aug 2006 22:52:59 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Mon, 7 Aug 2006 22:52:59 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Toernig  wrote:
>Your implementation is much cruder - it simply takes the fd
>away from the app; any future use gives EBADF.  As a bonus,
>it works for regular files and even goes as far as destroying
>all mappings of the file from all processes (even root processes).
>IMVHO this is a disaster from a security and reliability point
>of view.

I'm still trying to understand the semantics of this proposed
frevoke() implementation.  Can an attacker use this to forcibly
close some other processes' file descriptor?  Suppose the target
process has fd 0 open and the attacker revokes the file corresponding
to fd 0; what is the state of fd 0 in the target process?  Is it
closed?  If the target process then open()s another file, does it
get bound to fd 0?  (Recall that open() always binds to the lowest
unused fd.)  If the answers are "yes", then the security consequences
seem very scary.

For example, suppose that the attacker opens some file onto fd 2,
forks and execs /bin/login (say), and revokes that fd while /bin/login
is in the middle of executing.  Can this cause horrible catastrophes?
Note that, to defend against stderr attacks, some setuid programs will
forcibly open /dev/zero three times to make sure that fds 0, 1, and
2 are open, so that opening some later file (e.g., /etc/passwd)
doesn't inadvertently get attached to fd 2.  If some other process
can forcibly close /bin/login's fd 2, then that's very bad.

Can something like the following happen?

    Attacker                /bin/login
    --------                ----------
    open("foo") -> 2
    fork()
    exec("/bin/login")
                            open("/dev/zero") -> 3
                            open("/dev/zero") -> 4
                            open("/dev/zero") -> 5
    frevoke(2)
                            open("/etc/passwd") -> 2
                            ...
                            perror("wrong password")   # Corrupts /etc/passwd!


/* A hypothetical implementation of /bin/login: */
int main() {
    // Protect ourselves from stderr attacks
    int ignore;
    ignore = open("/dev/zero");
    ignore = open("/dev/zero");
    ignore = open("/dev/zero");

    int pwfd;
    pwfd = open("/etc/passwd", O_RDWR);
    ...
    if (!correctpassword(uname, pass)) {
        perror("wrong password");
        exit(1);
    }
    ...
}
