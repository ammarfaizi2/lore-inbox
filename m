Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbTLGVIi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264556AbTLGVHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 16:07:14 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:44485 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S264562AbTLGVDK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 16:03:10 -0500
Date: Sun, 7 Dec 2003 22:03:05 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11 - fork, dup, dup2 oddities
Message-ID: <20031207210305.GE13201@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have 2.6.0-test11 kernel. I try to run pppd with pppd call gprs. In gprs
I have device /dev/ttyUSB0. It fails. I've found that it happened ONLY if I use
detach option. 

I have tried /dev/ircomm0 as well with the same result. However with /dev/ttySL0
(that is symlink to pty created by modem driver) it works ok with or withoud
detach option.

I've tried to debug pppd and discovered failing code:

    /* make sure fds 0, 1, 2 are occupied */
    while ((fd = dup(in)) >= 0) {
        if (fd > 2) {
            close(fd);
            break;
        }
    }

    /* dup in and out to fds > 2 */
    {
        int fd1 = in, fd2 = out, fd3 = log_to_fd;

        in = dup(in);
        out = dup(out);
        if (log_to_fd >= 0) {
            errfd = dup(log_to_fd);
        } else {
            errfd = open(_PATH_CONNERRS, O_WRONLY | O_APPEND | O_CREAT, 0600);
        }
        close(fd1);
        close(fd2);
        close(fd3);
    }

    /* close fds 0 - 2 and any others we can think of */
    close(0);
    close(1);
    close(2);
    if (the_channel->close)
        (*the_channel->close)();
    closelog();
    close(fd_devnull);

    /* dup the in, out, err fds to 0, 1, 2 */
    dup2(in, 0);
    close(in);
    dup2(out, 1);
    close(out);
    if (errfd >= 0) {
        dup2(errfd, 2);
        close(errfd);
    }

    setuid(uid);
    if (getuid() != uid) {
        error("setuid failed");
        exit(1);
    }
    setgid(getgid());
    execl("/bin/sh", "sh", "-c", program, (char *)0);
    error("could not exec /bin/sh: %m");
    exit(99);

execl exit with code 02. 

program is equal to:
/usr/sbin/chat -V -s '' ATZ OK 'AT+CGDCONT=1,\"IP\",\"ointernet\"' OK 'ATD*99***1#' CONNECT

in=10, out=10 (it is opened /dev/ttyUSB0)

It works OK with 2.4.22 or if do not use previous fork.

-- 
Luká¹ Hejtmánek
