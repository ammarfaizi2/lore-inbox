Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265972AbSKBNoq>; Sat, 2 Nov 2002 08:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265973AbSKBNoq>; Sat, 2 Nov 2002 08:44:46 -0500
Received: from codepoet.org ([166.70.99.138]:47278 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S265972AbSKBNop>;
	Sat, 2 Nov 2002 08:44:45 -0500
Date: Sat, 2 Nov 2002 06:51:09 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where's the documentation for Kconfig?
Message-ID: <20021102135109.GA6321@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
References: <20021031134308.I27461@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0210311452531.13258-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210311452531.13258-100000@serv>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Oct 31, 2002 at 03:43:26PM +0100, Roman Zippel wrote:
> kconfig:
> config /symbol/
> 	bool /prompt/
> 	default /word/

Suppose at some time we wished to move things like architecture
specific CFLAGS into Kconfig.  It would be implemented as a
"string" object and would look something like:

config CPU_CFLAGS
        string
        default "-march=i386" if M386
        default "-march=i486" if M486
        default "-march=i586" if M586
        default "-march=i686 -malign-functions=4" if MK7

This is terribly simplified, but I think you get the idea.
Suppose someone selects MK7.  The resulting .config file
would then have:

    CONFIG_CPU_CFLAGS="-march=i686 -malign-functions=4"

Since this file is sourced into the Makefile, we could then
append CONFIG_CPU_CFLAGS onto the CFLAGS.  This would also
be kindof cool, since we could add in Makefile macros into the
strings and they would actually be evaluated...

So for the K7 case, we could expand it to something much more
sneaky later on, something like:
    default "$(call check_gcc,-march=athlon,-march=i686 -malign-functions=4)" if MK7
and the check_gcc macro could be correctly evaluated by make.
Neat stuff.  (Such a check_gcc macro does not yet exist in the 
kernel Makefiles, but surely will sometime).

Ok, everything looks fine so far.  But now we see a problem...

String objects always contain quotes (") around them.  So when
included into a Makefile, we would end up with something like:

    gcc -Wall "-march=i686 -malign-functions=4" foo.c -o bar

or similar being run.  Because the entire string object value is
quoted, gcc will try to set arch="i686 -malign-functions=4" and
will blow up.  Not what we want at all...  Dropping the quotes
from the .config file would work, but would probably screw up
other things that need the quotes to work properly.  Creating a
new "unquoted_string" data type would work nicely.  

Any interest in adding an "unquoted_string" data type ?  I dunno
if such a data type is anything you care about, but I can imagine
cool things being done with it, such as the above.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
