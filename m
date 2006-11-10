Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946746AbWKJW5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946746AbWKJW5m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 17:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946782AbWKJW5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 17:57:41 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:50866 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1946746AbWKJW5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 17:57:41 -0500
Date: Fri, 10 Nov 2006 23:57:39 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: O_ASYNC question
Message-ID: <Pine.LNX.4.64.0611102339570.12180@artax.karlin.mff.cuni.cz>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Does anyone know what should O_ASYNC do? The manual page says that it 
sends SIGIO to the process when input or output is possible, however it is 
very vaguely defined.

Should the signal be level-triggered (being sent constantly while IO is 
possible) or edge-triggered (being sent only when state changes)?

Should the signal be sent on read or write availability or any of them or 
the one selected with O_RDONLY/O_WRONLY/O_RDRW?

I did some test and it looks almost unusable, see this program, it behaves 
very strangely:

1. when you press some key and not yet ENTER, SIGIO is sent although there 
are no characters to read because ENTER was not pressed.

2. there is no way to stop the flood of SIGIOs, once triggered, they are 
coming over and over again. When all terminal characters are read, SIGIOs 
is still signaled, even when I drop and set O_ASYNC flag sith fcntl, it 
doesn't help.

On the other hand, FreeBSD and Solaris don't send any signal.

Mikulas

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>

int h;

void async(int s)
{
         char c;
         int x = 0;
         printf("signal\n"); fflush(stdout);
         while (read(h, &c, 1) == 1) x++;
         printf("read: %d\n", x); fflush(stdout);
         if (fcntl(h, F_SETFL, O_NONBLOCK) < 0) perror("fcntl"), exit(1);
         if (fcntl(h, F_SETFL, O_ASYNC | O_NONBLOCK) < 0) perror("fcntl"), exit(1);
         sleep(1);
}

int main(void)
{
         h = open("/dev/tty", O_RDONLY | O_NONBLOCK);
         if (h < 0) perror("open"), exit(1);
         signal(SIGIO, async);
         if (fcntl(h, F_SETFL, O_ASYNC | O_NONBLOCK) < 0) perror("fcntl"), exit(1);
         while (1) sleep(1);
}

