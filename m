Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264068AbTDNWfZ (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264081AbTDNWfZ (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:35:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3471 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264068AbTDNWfQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 18:35:16 -0400
Subject: Re: readprofile ; Meaning of "Length of procedure"
From: Andy Pfiffer <andyp@osdl.org>
To: Shesha@asu.edu
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <Pine.GSO.4.21.0304141517040.3054-100000@general2.asu.edu>
References: <Pine.GSO.4.21.0304141517040.3054-100000@general2.asu.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1050360396.1192.20.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 Apr 2003 15:46:37 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 15:17, Shesha@asu.edu wrote:
>  Hello Linux ppl,
>  
>  I have copuple of questions, I request you to share the information if you
> know ....

I have a partial answer.

> --
> 1
> --
>  In the readprofile man page load=(# of clk ticks) / (length of the procedure)
>  
>  What does "length of procedure" means.

My understanding after a quick read of the source is that "length of the
procedure" means the length, in bytes, of the function.  For most
architectures, there is not a correlation between lines of code in
assembler and number of executable bytes.

On ARM all instructions are 4 bytes long (not counting "Thumb" style
instruction encoding), but that does not mean 1 line of assembler source
code is equal to 4 bytes worth of instructions.

As far as I can tell, the "length of the procedure" is determined by the
difference between sucessive symbols found in System.map:

        .
        .
        .
        c0109414 T sys_fork
        c010943c T sys_clone
        c0109474 T sys_vfork
        c01094a0 T sys_execve
        .
        .
        .

sys_clone(), on my system, is 56 bytes long, including any alignment
padding (0xc0109474-0xc010943c = 56).



> Does that mean the # of ASM lines of
>  the procedure code? What is the units of the load. It cannot be %. because 
> -----------------------------------------------------------
>  152495 default_idle                             3176.9792 
> -----------------------------------------------------------
>  the above line indicates,  more than 100% of times CPU is idle. This cannot
> happen.

It is not a percentage.  The value is computed by:

	"load" = ticks_attributed_to_the_proc / length_of_proc

>From your example above:

	3176.9792 = 152495 / length_of_proc

therefore length_of_proc = 48 bytes.  48 looks reasonable when cross
checked with my x86 system (default_idle() is 52 bytes long on my
system).


>  What value of the procedure load is considered to be a potential CPU
> intensive procedure/ high load procedure.

There is no magic number.  However, from the readprofile man page, some
likely "high load" candidates could be found by:

	readprofile | sort -nr +2 | head -20


Regards,
Andy

