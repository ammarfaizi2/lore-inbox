Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288299AbSACUbq>; Thu, 3 Jan 2002 15:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288300AbSACUbg>; Thu, 3 Jan 2002 15:31:36 -0500
Received: from [195.66.192.167] ([195.66.192.167]:4623 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S288299AbSACUbZ>; Thu, 3 Jan 2002 15:31:25 -0500
Message-Id: <200201032028.g03KSsE29484@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: "vda@port.imtp.ilyichevsk.odessa.ua" 
	<vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "H.J.Lu" <hjl@lucon.org>, Momchil Velikov <velco@fadata.bg>,
        Oliver Xymoron <oxymoron@waste.org>,
        Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@zip.com.au>
Subject: Re: Extern variables in *.c files (maintainers pls read this)
Date: Thu, 3 Jan 2002 22:28:55 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <02010216180403.01928@manta> <3C340EA9.FE084B4C@zip.com.au> <20020103095742.A11443@flint.arm.linux.org.uk>
In-Reply-To: <20020103095742.A11443@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, you have a choice:
> 1. Enable -fno-common
>    - detect variables that should be marked static which aren't
>    - don't detect size differences
> 2. Disable -fno-common
>    - don't detect variables that should be marked static
>    - detect size differences as long as the variables aren't marked extern
>
> As soon as someone has int foo in one file, and extern char foo in another,
> you've lost no matter which option you take.
>
> The header file approach is the most reliable (and imho correct) method to
> solve this problem.

And this method is traditional for C. We have struct declarations and fn 
propotypes in *.h, we should place extern vars there too. Always.

If you are a kernel subsystem or driver maintainer, you may wish to check 
whether *your* part of kernel has any extern variable defs. Just run this
hunter script in top dir of kernel source:
-----------------------
#!/bin/sh

function do_grep() {
    pattern="$1"
    dir="$2"
    shift;shift
    
    for i in $dir/$*; do
        if ! test -d "$i"; then
            if test -e "$i"; then
		grep -E "$pattern" "$i" /dev/null
	    fi
        fi
    done
    for i in $dir/*; do
        if test -d "$i"; then
	    do_grep "$pattern" "$i" $*
	fi
    done
}

do_grep 'extern [^()]*;' . "*.c" 2>&1 | tee ../extern.log
---------------------------------

Output is not attached here, it's too big: ~100 KB, ~1500 lines for 2.5.1-pre8
--
vda
