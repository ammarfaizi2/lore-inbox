Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129303AbRBDDSE>; Sat, 3 Feb 2001 22:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129103AbRBDDRy>; Sat, 3 Feb 2001 22:17:54 -0500
Received: from otter.mbay.net ([206.40.79.2]:18692 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S129303AbRBDDRs> convert rfc822-to-8bit;
	Sat, 3 Feb 2001 22:17:48 -0500
From: jalvo@mbay.net (John Alvord)
To: David Ford <david@linux.com>
Cc: reiserfs-list@namesys.com, <reiser@namesys.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink  related)
Date: Sun, 04 Feb 2001 03:24:00 GMT
Message-ID: <3a7dc9fb.47468112@mail.mbay.net>
In-Reply-To: <E14OoD8-0007GI-00@the-village.bc.nu> <3A7BC808.E9BF5B44@linux.com>
In-Reply-To: <3A7BC808.E9BF5B44@linux.com>
X-Mailer: Forte Agent 1.5/32.451
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Feb 2001 00:57:45 -0800, David Ford <david@linux.com>
wrote:

>How about a simple patch to the top level makefile that checks the gcc
>version then prints a distinct message ..'this compiler hasn't been approved
>for compiling the kernel', sleeping for one second, then continuing on.  This
>solution doesn't stop compiling and makes a visible indicator without forcing
>anything.

A while ago I worked up a nasty bit of make logic which prompted the
user for yes or no... and then did one thing or the other. You could
ask the user if he REALLY wants to continue and wait for a response.
Following is the model code...
John Alvord
=================

_ECHO=@

all:  t0 t1 t2 t3 t4 t5 t6

# prompt for input, must be in a separate rule to unbuffer terminal
# output.
t0:
     $(_ECHO)echo Enter Y or N: \\c

# capture a line of terminal input, copy to a file, tell user
t1:
     $(_ECHO)echo $(shell read ans; echo ans) > ans
     $(_ECHO)echo The answer is \\c
     $(_ECHO)cat ans

# take first character of answer, upper case, store in another file
# then create two files, one for yes and one for no
# the || exit 0 is to mask the potential grep error, which
# would result in an error message even a - was used to ignore error
# and continue. The result is two files, which may be zero byte
t2:
     $(_ECHO)cat ans | cut -c 1-1 | tr 'a-z' 'A-Z' >ans1
     $(_ECHO)rm -f ansy
     $(_ECHO)rm -f ansn
     $(_ECHO)grep Y ans1 > ansy || exit 0
     $(_ECHO)grep N ans1 > ansn || exit 0

# Check for case where neither answer file is > 0 bytes
t3:
     $(_ECHO)test -s ansy || test -s ansn && exit 0; \
 echo Answer [$(shell cat ans)] is neither Y or N! && exit 1

# handle Yes case. Exit if Y answer file is 0 bytes or missing
t4:
     $(_ECHO)test ! -s ansy  && exit 0; \
     echo in YES processing

# handle No case
t5:
     $(_ECHO)test ! -s ansn  && exit 0; \
     echo in NO processing


# remove files used during processing
t6:
     $(_ECHO)rm -f ans
     $(_ECHO)rm -f ans1
     $(_ECHO)rm -f ansn
     $(_ECHO)rm -f ansy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
