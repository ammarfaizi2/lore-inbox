Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbRFJSx4>; Sun, 10 Jun 2001 14:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbRFJSxq>; Sun, 10 Jun 2001 14:53:46 -0400
Received: from SMTP-OUT003.ONEMAIN.COM ([63.208.208.73]:1854 "HELO
	smtp07.mail.onemain.com") by vger.kernel.org with SMTP
	id <S261535AbRFJSxg>; Sun, 10 Jun 2001 14:53:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Scott Long <smlong@teleport.com>
To: linux-kernel@vger.kernel.org
Subject: Threads and the LDT (Intel-specific)?
Date: Sun, 10 Jun 2001 11:53:29 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01061011532900.01126@abacus>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to do something a bit unorthodox: I want to share the 
address space between threads, but I want a certain region of the 
address space to be writeable only for a particular thread -- for all 
other threads this region is read-only.

I've considered several approaches. I'll only go over the one I think 
is the best solution. I would appreciate any comments folks might have:

When linking the userspace program, I instruct the linker to avoid the 
region from VMA 0 to VMA 0x400000. Then, in the userspace code, I 
duplicate the GDT entries for CS, DS, ES, SS into the LDT, except that 
the new segments begin at 0x400000, instead of 0. I load the segment 
registers with these LDT entries. In the "write-allowed" thread I 
create an LDT entry to address VMA 0 through VMA 0x400000, in 
read-write mode. In all the other threads I create an LDT entry to 
address the same area in read-only mode. This gives me a 4M region at 
the bottom of memory that is accessible in different ways to different 
threads.

I can also use the LDT to point to thread-specific segments. IMHO this 
is much better than the stack trick used by linuxthreads. The problem 
is, I don't fully understand how to use modify_ldt(). Is anyone 
knowledgeable about this?

If anyone has any other suggestions, please let me know. If you are 
confused as to why I would ever want to do this in the first place, I'd 
be willing to go over it off the list.

Thanks,
Scott
