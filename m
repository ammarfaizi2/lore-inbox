Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318067AbSHHWV1>; Thu, 8 Aug 2002 18:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318071AbSHHWV1>; Thu, 8 Aug 2002 18:21:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18703 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318067AbSHHWV0>; Thu, 8 Aug 2002 18:21:26 -0400
Date: Thu, 8 Aug 2002 15:26:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hubertus Franke <frankeh@us.ibm.com>
cc: Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       Andrew Morton <akpm@zip.com.au>, <andrea@suse.de>, <davej@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, Paul Larson <plars@austin.ibm.com>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
In-Reply-To: <Pine.LNX.4.44.0208081500550.9114-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208081519010.1661236-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Aug 2002, Linus Torvalds wrote:
> 
> So let's just try Andries approach, suggested patch as follows..

"ps" seems to do ok from a visual standpoint at least up to 99 million. 
Maybe it won't look that good after that, I'm too lazy to test.

The following trivial program is useful for efficiently allocating pid
numbers without blowing chunks on the VM subsystem and spending all the
time on page table updates - for people who want to test (look out: I've
got dual 2.4GHz CPU's with HT, so getting up to 10+ million was easy, your
milage may wary and at some point you should just compile a kernel that
starts higher ;).

		Linus

---
#include <sys/types.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

int main()
{
        int i;
        for (i = 1; i < 250000; i++) {
                if (!vfork())
                        exit(1);
                if (waitpid(-1, NULL, WNOHANG) < 0)
                        perror("waitpid");
        }
        return 0;
}


