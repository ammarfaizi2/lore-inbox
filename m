Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbQL2BVJ>; Thu, 28 Dec 2000 20:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbQL2BU7>; Thu, 28 Dec 2000 20:20:59 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:30702 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S129563AbQL2BUq>;
	Thu, 28 Dec 2000 20:20:46 -0500
Date: Fri, 29 Dec 2000 01:49:18 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
Message-ID: <20001229014918.A10171@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <20001229002527.C25388@gruyere.muc.suse.de> <Pine.LNX.4.10.10012281536510.1123-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012281536510.1123-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 28, 2000 at 03:37:51PM -0800
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-test10-fijiji2 (i686)
X-APM: 100% 200 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 03:37:51PM -0800, Linus Torvalds wrote:

> Too bad. Maybe somebody should tell gcc maintainers about programmers that
> know more than the compiler again.

I know that {p,}gcc-2.95.2{,.1} are not officially supported.

Did you know that it's impossible to compile nfsv4 because of
register allocation problems with long long since (long long) month ?

The following does not hurt, it's just a fix for a broken
compiler:

--- linux/fs/lockd/xdr4.c.orig  Fri Dec 29 01:35:32 2000
+++ linux/fs/lockd/xdr4.c       Fri Dec 29 01:36:36 2000
@@ -156,7 +156,7 @@
 nlm4_encode_lock(u32 *p, struct nlm_lock *lock)
 {
        struct file_lock        *fl = &lock->fl;
-       __s64                   start, len;
+       volatile __s64                  start, len;
                
        if (!(p = xdr_encode_string(p, lock->caller))
         || !(p = nlm4_encode_fh(p, &lock->fh))


Here is an example without this patch (pgcc-2.95.2.1 this time which
is bug-compatible to gcc-2.95.2.1).

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o xdr4.o xdr4.c
xdr4.c: In function `nlm4_encode_lock':
xdr4.c:181: internal error--insn does not satisfy its constraints:
(insn/i 313 585 315 (set (reg:SI 1 %edx)
        (subreg:SI (lshiftrt:DI (reg:DI 0 %eax)
                (const_int 32 [0x20])) 0)) 323 {lshrdi3_const_int_subreg} (nil)
    (nil))
gcc: Internal compiler error: program cpp got fatal signal 13
make[2]: *** [xdr4.o] Error 1
make[2]: Leaving directory `/.localvol000/usr/src/linux-2.4.0-test13pre5/fs/lockd'
make[1]: *** [_modsubdir_lockd] Error 2
make[1]: Leaving directory `/.localvol000/usr/src/linux-2.4.0-test13pre5/fs'
make: *** [_mod_fs] Error 2

The question is: Is it worth to apply ?

-- 

  ciao - 
    Stefan

"                export PS1="((((((((((((rms))))))))))))# "              "

Stefan Traby                Linux/ia32               fax:  +43-3133-6107-9
Mitterlasznitzstr. 13       Linux/alpha            phone:  +43-3133-6107-2
8302 Nestelbach             Linux/sparc       http://www.hello-penguin.com
Austria                                    mailto://st.traby@opengroup.org
Europe                                   mailto://stefan@hello-penguin.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
