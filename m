Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbTJAWYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 18:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTJAWYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 18:24:18 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:25799 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S262600AbTJAWYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 18:24:11 -0400
To: linux-kernel@vger.kernel.org
Subject: CLONE_NEWNS & chroot(2) behavior
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Date: Thu, 02 Oct 2003 00:24:05 +0200
Message-ID: <87oex0vbp6.fsf@kosh.ultra.csn.tu-chemnitz.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Score: -5.7 () BAYES_00,USER_AGENT_GNUS_UA
X-Spam-Score: 0.0 (/)
X-Spam-Report: --- Start der SpamAssassin 2.60 Textanalyse (0.0 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: e4b5076b308c977cae8cdcac8588cacb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have problems to understand the CLONE_NEWNS semantic because I see
some strange behavior in combination with chroot(2).

E.g. look at the program at

                 http://www.tu-chemnitz.de/~ensc/nst.c



There, the umount(2) in 'child()' fails when the chroot is outside
/dev/root. E.g. when /var/tmp is on a separate partition, I get


    # mkdir -p /var/tmp/foo/bar && strace -f ./nst /var/tmp/foo bar
    | mount("none", "/var/tmp/foo/bar", "proc", , 0) = 0
    | chroot("/var/tmp/foo")                  = 0
    | chdir("/")                              = 0
    | clone(Process 28706 attached
    | child_stack=0xbffff7bc, flags=CLONE_NEWNS|SIGCHLD) = 28706
    | [pid 28706] --- SIGSTOP (Stopped (signal)) @ 0 (0) ---
    | [pid 28706] oldumount("bar")            = -1 EINVAL (Invalid argument)


The umount(2) can be replaced with anything which accesses files in
"bar"---it would fail too, since "bar" is not mounted in the new
namespace.

But when doing the same in /, things are ok:

    # mkdir -p /foo/bar && strace -f ./nst /foo bar
    | mount("none", "/foo/bar", "proc", , 0)  = 0
    | chroot("/foo")                          = 0
    | chdir("/")                              = 0
    | clone(Process 28733 attached
    | child_stack=0xbffff7cc, flags=CLONE_NEWNS|SIGCHLD) = 28733
    | [pid 28733] --- SIGSTOP (Stopped (signal)) @ 0 (0) ---
    | [pid 28733] oldumount("bar")            = 0



When this behavior is wanted, what is the formal description of the
CLONE_NEWNS behavior?




Enrico
