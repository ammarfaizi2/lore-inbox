Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLRTZ6>; Mon, 18 Dec 2000 14:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbQLRTZr>; Mon, 18 Dec 2000 14:25:47 -0500
Received: from chaos.analogic.com ([204.178.40.224]:13698 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129436AbQLRTZk>; Mon, 18 Dec 2000 14:25:40 -0500
Date: Mon, 18 Dec 2000 13:54:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: VM performance problem
Message-ID: <Pine.LNX.3.95.1001218135307.5234A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have some memory-checker software. I will put it on my
server if anybody is interested.

I have discovered a VM performance problem that somebody should
look into.

The code:

1/	Allocates PAGE_SIZE buffers (using ordinary malloc()) until
	the swap file starts being used (reading /proc --slow).
	These buffers are in a linked-list.
2/	Writes all these buffers to a known pattern.
3/	Does lots of XOR operations, etc., on the buffers.
4/	Reads all the buffers to see if any bits are bad.
5/	Reports any bad stuff. If anything is bad, executes
	an ioctl() to a dummy driver to get the physical address.
6/	Deallocates all the buffers by running down the linked-list.
7/	Continues <forever> to (1) above.

Here is the performance problem observed. If I ^C out of the program,
killing it outright, with the kernel freeing all the allocated data,
everything is fine. There is little or no swap activity as a result
of this.

If the program deallocates all the buffers, as in (6) above, it will
take even up to 1 whole minute!! At this time, there is an enormous
amount of swap-file activity going on.

Since many programs allocate/deallocate data by setting the break address
via malloc(), this represents a severe performance penalty. Deallocating
pages should not result in any swap-file activity! This activity should
occur only when whatever got swapped out, needs to get swapped back in
and nothing needs to get swapped back in during a deallocation!

Since user's pages are not reordered (or should not be), there should
be no swap activity during page deallocation.

This problem is observed on 2.2.17, 2.4.0-test9, and 2.4.0-test12.
Could a VM guru please comment?


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
