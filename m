Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbSK0Wfl>; Wed, 27 Nov 2002 17:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbSK0Wfl>; Wed, 27 Nov 2002 17:35:41 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:31749 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264883AbSK0Wfk>;
	Wed, 27 Nov 2002 17:35:40 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Modules with list 
In-reply-to: Your message of "Wed, 27 Nov 2002 10:19:02 -0800."
             <200211271819.KAA24041@adam.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Nov 2002 09:42:46 +1100
Message-ID: <18750.1038436966@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2002 10:19:02 -0800, 
"Adam J. Richter" <adam@yggdrasil.com> wrote:
>	Hmm.  We could certainly have a binary editing tool to remove
>what was the .exit{,func} sections after the link...
>	In this scenario, the .exit{,func} section would be linked
>in and then discarded by the module loader, by the process of the
>kernel releasing its .init{,data} areas, or, if you wanted to build
>a bzImage without CONFIG_HOTPLUG, by using a binary editing tool or
>perhaps an ld script as I mentioned earlier in this response.
>
>	The point of the .devexit_p_refs section would just be to
>set those references to NULL if that was useful.  The kernel module
>load code would do something like:

You have it back to front.  The real problem is open code that calls
functions in sections that have been discarded, that code is an oops
just waiting to happen.  When binutils was changed to detect such
dangling references, it found a lot of bad code on rarely tested error
paths.  Your method would stop binutils finding the dangling references
and open the kernel up to bad code again.

__devexit_p tells the build "these functions are known to be omitted at
link time, do not reference them at build time".  IOW, we tell the
kernel that these references are safe, allowing binutils to find all
the other references to discarded code - the bad ones.

Removing the check from binutils is not an option.  The problem was
originally detected on ia64 and mips which use program counter relative
calls with a small number of bits for the offset from current PC.  The
dangling references to functions in discarded sections resulted in
calls to address 0 or to small addresses (actually the offset of the
target function from the start of the discarded section).  Trying to
convert that into PC relative format resulted in an offset which would
not fit in the number of available bits and the linker/insmod flagged a
relocation error.

Bottom line - unsafe references to discarded sections must be detected
by ld/insmod.  Kernel developers have to flag safe references to
discarded sections via __devexit_p().

