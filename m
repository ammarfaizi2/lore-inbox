Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291007AbSAaKm0>; Thu, 31 Jan 2002 05:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290596AbSAaKmM>; Thu, 31 Jan 2002 05:42:12 -0500
Received: from turing.cs.hmc.edu ([134.173.42.99]:1473 "EHLO turing.cs.hmc.edu")
	by vger.kernel.org with ESMTP id <S290521AbSAaKl6>;
	Thu, 31 Jan 2002 05:41:58 -0500
Date: Thu, 31 Jan 2002 02:43:00 -0800 (PST)
From: Nathan Field <nathan@cs.hmc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: BUG: PTRACE_POKETEXT modifies memory in related processes
Message-ID: <Pine.GSO.4.32.0201310055030.23602-100000@turing.cs.hmc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe I have found a bug in recent 2.4 linux kernels (at least 2.4.17)
running on x86 related to using ptrace to modify a processes memory. From
a quick scan of the 2.4.17 code it looks like ptrace.c:access_process_vm
is not checking to see if the page of memory it is writing to has write
permission, so it is not properly copy-on-write'ing. This means that if I
have a simple program like this:

main() {
  int pid = fork();
  while(1) {
    printf("pid is: %d\n", pid);
    sleep(1);
  }
}

and I set a breakpoint on the printf() line in the parent both the parent
and the child will hit that breakpoint.

This bug was not present in any 2.2 kernel that I've tested or in 2.4.2 or
2.4.7 (RH stock kernels for 7.1 and 7.2). Looking at the code for 2.4.14 I
noticed that access_one_page, which is called through access_process_vm,
does a lot more work to make sure that page faults are handled correctly.
I haven't tested 2.4.14 though, so I can't say that it does the correct
thing. I'm not familiar with kernel source, but it looks to me like
get_user_pages is supposed to handle the fault, and it is being passed a
len of 1 rather than the len passed into access_process_vm. Not that I
think that's the bug, just an observation.

I'm more than willing to test out patches, provide more information, or
just have a fireside chat. Please CC replies to my address as I'm on the
daily digest list.

	nathan

------------
Nathan Field  Root is not something to be shared with strangers.

"It is commonly the case with technologies that you can get the best
 insight about how they work by watching them fail."
        -- Neal Stephenson

