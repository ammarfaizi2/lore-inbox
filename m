Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314069AbSEVOK4>; Wed, 22 May 2002 10:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSEVOK4>; Wed, 22 May 2002 10:10:56 -0400
Received: from users.ccur.com ([208.248.32.211]:45154 "HELO amber2.ccur.com")
	by vger.kernel.org with SMTP id <S314069AbSEVOKy>;
	Wed, 22 May 2002 10:10:54 -0400
Date: Wed, 22 May 2002 14:10:45 GMT
Message-Id: <200205221410.OAA14969@amber2.ccur.com>
From: Tom Horsley <Tom.Horsley@mail.ccur.com>
To: linux-kernel@vger.kernel.org
Subject: Bug: Once ptrace() modifies a page, the child program can too!
Reply-to: Tom.Horsley@mail.ccur.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Platform: Redhat 7.1 on intel. Also happens with our local variation of the
2.4.18 kernel.

Here is a simple program which should obviously segfault (and does if you
don't debug it and set breakpoints):

  #include <stdio.h>

  int
  main(int argc, char ** argv) {
     int * mainprog = ((int *)(void *)&main);
     printf("Main program starts at %#x\n", mainprog);
     printf("First word looks like 0x%08x\n", *mainprog);
     printf("About to try writing on it...\n");
     fflush(stdout);
     *mainprog = 0xdeadbeef;
     printf("First word now looks like 0x%08x\n", *mainprog);
     fflush(stdout);
     return 0;
  }

But, run this under gdb like so:

gdb ./bug
(gdb) b *&main
Breakpoint 1 at 0x80484c0: file nomapbug.c, line 4.
(gdb) r
Starting program: /tt/neon/tom/./bug

Breakpoint 1, main (argc=134513856, argv=0x1) at bug.c:4
4       main(int argc, char ** argv) {
(gdb) c
Continuing.
Main program starts at 0x80484c0
First word looks like 0x83e589cc
About to try writing on it...
First word now looks like 0xdeadbeef

Program exited normally.
(gdb) q

Yikes! The program was able to modify a page that should be strictly
read/execute. I don't think debuggers are intended to have that
kind of impact on the behavior of the child process :-).

If you look at the /proc address map info after setting the breakpoint,
it claims the page is still just read/execute, but that is obviously
not the case.

A co-worker who knows more about linux innards than me (John Blackwood), had
this to say after poking around a bit:

  I don't know about where to log this 'bug', and I'm not a VM expert, but
  both the /proc and ptrace PTRACE_POKEDATA/TEXT calls end up calling the

  access_process_vm()

  routine, which calls the 

  get_user_pages() 

  routine, with the 'force' flag set.

  This routine calls

  handle_mm_fault() 

  to get a hold of the target page.  It will be made write-able at this
  point, if it is not already writeable.

  Once made writeable, there is no code to make it write-protected again.

  Looks like this is also true for text pages.

  Not being a VM expert, I don't know how easy or hard it would be to try
  and make this page write-protected again, but due to the layering of the
  above calls, it doesn't look trivial to me....

I tried searching the mailing list for ptrace() related issues, but wasn't
able to find anything that seemed to describe this problem (however as much
stuff as there is in the archives, I could easily have missed it :-).
