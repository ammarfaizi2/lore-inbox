Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbTEKSX4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 14:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTEKSX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 14:23:56 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:4612 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S261839AbTEKSXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 14:23:54 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Jamie Lokier <jamie@shareable.org>, Jos Hulzink <josh@stack.nl>,
       Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
References: <Pine.LNX.4.44.0305102043320.28287-100000@home.transmeta.com>
	<200305111137.29743.josh@stack.nl>
	<20030511140144.GA5602@mail.jlokier.co.uk>
	<Pine.LNX.4.50.0305111033590.7563-100000@blue1.dev.mcafeelabs.com>
	<m1fznl74f9.fsf@frodo.biederman.org>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 11 May 2003 20:43:26 +0200
In-Reply-To: <m1fznl74f9.fsf@frodo.biederman.org>
Message-ID: <m3wugxz5m9.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Davide Libenzi <davidel@xmailserver.org> writes:
> Now if someone could tell me how to do a jump to 0xffff0000:0xfff0 in real
> mode I would find that very interesting.

Well, it should be possible to use a trick similar to the BIG REAL or
UNREAL mode.  Just load CS with a segment that has a base of
0xffff0000 in protected mode and then jump back to real mode.
Something like this, completely untested of course, should do it:

        .align  4
reset_gdt:
        .word   reset_gdt_end - reset_gdt -1
        .long   reset_gdt
        .word   0

/* 16 bit code segment starting at 0xffff0000 */
        .word   0xffff, 0x0000
        .byte   0xff, 0x9b, 0x00, 0xff
#endif

reset_gdt_end:

        lgdt    %cs:reset_gdt
        ljmp    $ROM_CODE_SEG, 0xfff0

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
