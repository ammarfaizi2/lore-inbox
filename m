Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312529AbSDEMxM>; Fri, 5 Apr 2002 07:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSDEMxC>; Fri, 5 Apr 2002 07:53:02 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:43537 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312529AbSDEMwz>;
	Fri, 5 Apr 2002 07:52:55 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available 
In-Reply-To: Your message of "05 Apr 2002 14:01:13 +0200."
             <p73k7rms6ba.fsf@oldwotan.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Apr 2002 22:52:43 +1000
Message-ID: <7853.1018011163@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Apr 2002 14:01:13 +0200, 
Andi Kleen <ak@suse.de> wrote:
>Keith Owens <kaos@ocs.com.au> writes:
>
>> 
>> More accurate kernel build, easier to write and understand Makefiles,
>> 30% faster than kbuild 2.4.  Now the nay-sayers will have to find
>> something else to complain about!
>
>I assume with kbuild 2.4 you mean the current makefiles. How does it
>compare at a single threaded build without -j ? 

On a smaller config (full config takes too long when single threaded).

kbuild 2.4:
	make oldconfig dep bzImage modules	6:25
	make bzImage modules (no changes)	0:22

kbuild 2.5:
	make oldconfig installable		4:45
	make installable (no changes)		0:16

>You seem to have written an awful lot of code just to build something.
>Perhaps it would have been easier to just replace make completely with a 
>custom builder @)

Would not have helped.  Apart from all the people who complain about
needing extra tools to build the kernel (remember the Python wars for
CML2?), the kernel build has some really nasty requirements :-

* Most dependencies are not listed.  kbuild has to work out which
  sources depend on which headers, sometimes sources include other
  sources.

* 2,200+ config options, each of which can affect as little as one file
  or as much as the entire kernel.  kbuild has to work out what each
  config option affects.

* Changing a config option must only rebuild the affected targets, not
  the entire kernel.

* Changing a command must rebuild only the affected targets, not the
  entire kernel.

* You can change a command from the makefile, from the command line or
  as a side effect of changing a config option.

* After applying a patch, kbuild must work out what has changed and
  only rebuild the affected targets.  Even if the patch changes the
  dependencies or commands!

Most of the work of kbuild 2.5 is tracking all the special cases, as is
a lot of the code in kbuild 2.4 Rules.make.  Any custom builder would
have to do the same amount of work and tracking, so replacing make by
another tool would not save anything.  I looked at the various make
replacements like scons, but none of them were ready for the
complexities of kbuild.

