Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130518AbRCDV2H>; Sun, 4 Mar 2001 16:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130519AbRCDV15>; Sun, 4 Mar 2001 16:27:57 -0500
Received: from smtp3.xs4all.nl ([194.109.127.132]:20237 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S130518AbRCDV1o>;
	Sun, 4 Mar 2001 16:27:44 -0500
Path: Home.Lunix!not-for-mail
Subject: Re: Another rsync over ssh hang (repeatable, with 2.4.1 on both ends)
Date: Sun, 4 Mar 2001 21:28:45 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <Pine.LNX.4.33.0103011607540.17365-100000@laird.ocp.internap.com>
    <20010302101236.A21799@flint.arm.linux.org.uk>
    <20010302114541.C1438@kochanski.internal.splhi.com>
NNTP-Posting-Host: kali.eth
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 983741325 8812 10.253.0.3 (4 Mar 2001 21:28:45 GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Sun, 4 Mar 2001 21:28:45 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:78796
X-Mailer: Perl5 Mail::Internet v1.32
Message-Id: <97uc2d$8jc$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Notice also that by default ssh opens stdin/stdout blocking, and can
relatively easily deadlock if the pipes it talks over really want to do
a write before a read or the other way round. 

You can try compile the following file, put it in the same directory
as ssh, and then run rsync over this instead of plain ssh (I use it in
fact in all places where I connect to ssh over pipes).

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#ifndef HAVE_NO_UNISTD_H
# include <unistd.h>
#endif /* HAVE_NO_UNISTD_H */
#include <fcntl.h>

static char ssh[] = "ssh";

int unblock(FILE *fp) {
    int fd, rc, flags;

    fd = fileno(fp);
    if (isatty(fd)) return 0;

    flags = fcntl(fd, F_GETFL, 0);
    if (flags < 0) {
        fprintf(stderr, "Could not query fd %d: %s\n", fd, strerror(errno));
        return 1;
    }
    rc = fcntl(fd, F_SETFL, flags | O_NONBLOCK);
    if (rc < 0) {
        fprintf(stderr, "Could not unblock fd %d: %s\n", fd, strerror(errno));
        return 1;
    }
    return 0;
}

int main(int argc, char **argv) {
    int rc;
    char *ptr, *work;

    if (unblock(stdin))  return 1;
    if (unblock(stdout)) return 1;
    if (unblock(stderr)) return 1;
    
    ptr = strrchr(argv[0], '/');
    if (ptr == NULL) ptr = argv[0];
    else ptr++;
    work = malloc(ptr-argv[0]+sizeof(ssh));
    if (!work) {
        fprintf(stderr, "Out of memory. Buy more ?\n");
        return 1;
    }
    memcpy(work, argv[0], ptr-argv[0]);
    memcpy(work+(ptr-argv[0]), ssh, sizeof(ssh));
    argv[0] = work;
    rc = execvp(work, argv);
    fprintf(stderr, "Could not exec %.300s: %s\n", work, strerror(errno));
    return rc;
}
