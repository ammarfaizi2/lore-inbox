Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971376-3797>; Wed, 29 Jul 1998 09:48:16 -0400
Received: from loki.appliedtheory.com ([204.168.18.19]:1612 "EHLO loki.appliedtheory.com" ident: "root") by vger.rutgers.edu with ESMTP id <971340-3797>; Wed, 29 Jul 1998 09:47:55 -0400
Date: Wed, 29 Jul 1998 11:31:41 -0400 (EDT)
From: Benjamin Saller Bender <case@AppliedTheory.com>
To: Eric PAIRE <e.paire@opengroup.org>
cc: torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.rutgers.edu>
Subject: Re: 2.1.111 fix for debugger ptrace(PTRACE_ATTACH, ...) side-effects
In-Reply-To: <199807291434.QAA00194@gr.opengroup.org>
Message-ID: <Pine.LNX.4.02.9807291125580.5889-100000@loki.appliedtheory.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Wed, 29 Jul 1998, Eric PAIRE wrote:
> The summary of the bugs, the SMP-safe fix explanation and the patch file
> are all available at http://www.gr.opengroup.org/java/jdk/linux/kernel1.htm

	I have seen additional problems which may or may not be related. I
think that the debug registers are not being cleared during context
switching, or at all for that matter? (I haven't looked into the
kernel code yet)

	The following is a reproducable example of what I am talking
about. This is on  linux-2.1.111 SMP 

-----------------------------

[//loki/src/registry2] gdb test_parser                          
GNU gdb 4.17
This GDB was configured as "i386-redhat-linux"...

(gdb) b registry_parse_object 
Breakpoint 1 at 0x804a5a6: file registry_parser.c, line 118.
(gdb) r
Starting program: /loki/seg_components/src/registry2/test_parser 

Breakpoint 1, registry_parse_object (lex=0x804ea28, input=0x804ea60)
    at registry_parser.c:118
118       char *name = 0;
(gdb) rwatch lex->tok
Hardware read watchpoint 2: lex->tok
(gdb) c
Continuing.
warning: Hardware watchpoint 2: Could not insert watchpoint

Hardware read watchpoint 2: lex->tok

Value = 0
registry_lex_token (lex=0x804ea28, input=0x804ea60) at registry_lex.c:531
531               return NAME;
(gdb) c
Continuing.
warning: Hardware watchpoint 2: Could not insert watchpoint

Hardware read watchpoint 2: lex->tok

Value = 0
0x804a5c4 in registry_parse_object (lex=0x804ea28, input=0x804ea60)
    at registry_parser.c:121
121       if(lex->tok != NAME)
(gdb) q
The program is running.  Exit anyway? (y or n) y
[//loki/src/registry2] ./test_parser                            11:21AM Wed 29 
zsh: 5877 trace trap  ./test_parser
[//loki/src/registry2] ./test_parser                            11:21AM Wed 29 
test: line    2 pos   3: Unexpected 'semicolon', should be a basic type
zsh: 5882 trace trap  ./test_parser



Could this extend to other processes as well? I am not really all that
well aware of how hardware breakpoints work on x86 and in the kernel, but
it seems that if the address is marked with a breakpoint and another
process got that address on the next pass? *Shurg*


Benjamin Saller Bender 			<case@AppliedTheory.com>
AppliedTheory Communications		Software Engineering Group


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
