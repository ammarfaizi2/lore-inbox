Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbVHLLTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbVHLLTl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 07:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbVHLLTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 07:19:41 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:41378 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750983AbVHLLTk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 07:19:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KJk6yZZMIV9gSsdyCIw4f/ZfVJq1QJLrsSzQubDzxO3DVX99Z1CpMmp1QsW41YwESTA9xoGISeVkEAxDcy9/nMGUZffXx45PTd+uvDFYBln5ASgJOtix8JOTiNon7w9RnZ60r8O6yyZ+vrjTrz729UU76nolvzqkZr6P6A2t38U=
Message-ID: <396556a20508120419238abca6@mail.gmail.com>
Date: Fri, 12 Aug 2005 12:19:39 +0100
From: Adam Langley <alangley@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Edge triggered epoll with pts devices acts as level triggered
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please cc me on replies)

Waiting for edge triggered events (with EPOLLET) on pseudo terminal
devices appears to act as if it were level triggered; when data is
ready the fd is always returned by epoll_wait.

You can test this with the code below. Compile, run and press return.
If edge triggering is working correctly a single event will be
generated, otherwise a never ending stream will start.

This works *correctly* at a real terminal, but fails for pseudo
terminals (specifically an xterm). As far as I can test with other
terminals and ssh this is a general problem with pseudo terminals.

% uname -a
Linux ice 2.6.12 #4 SMP Sun Jul 31 11:42:15 BST 2005 i686 Pentium II
(Deschutes) GenuineIntel GNU/Linux
(vanilla kernel sources)

% cat et2.c
#include <sys/epoll.h>
#include <unistd.h>
#include <string.h>

int
main(int argc, char **argv) {
        const int epoll_fd = epoll_create(4);
        struct epoll_event ev;
        struct epoll_event events[4];

        memset(&ev, 0, sizeof(ev));
        ev.events = EPOLLIN | EPOLLET;

        epoll_ctl(epoll_fd, EPOLL_CTL_ADD, 0, &ev);

        for (;;) {
                epoll_wait(epoll_fd, events, 4, -1);
                write(1, ".", 1);
        }
}


Thanks


AGL

-- 
Adam Langley                                      agl@imperialviolet.org
http://www.imperialviolet.org                       (+44) (0)7906 332512
PGP: 9113   256A   CC0F   71A6   4C84   5087   CDA5   52DF   2CB6   3D60
