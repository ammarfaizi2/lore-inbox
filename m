Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271578AbRHXOYp>; Fri, 24 Aug 2001 10:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271853AbRHXOYf>; Fri, 24 Aug 2001 10:24:35 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:16300 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S271578AbRHXOYT>; Fri, 24 Aug 2001 10:24:19 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: macro conflict
In-Reply-To: <6208.998658929@ocs3.ocs-net> <16800.998659058@redhat.com>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 24 Aug 2001 10:20:00 -0400
In-Reply-To: David Woodhouse's message of "Fri, 24 Aug 2001 14:17:38 +0100"
Message-ID: <m2k7ztwne7.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> kaos@ocs.com.au said:

 >> Did you try that?  Firstly typeof() is only defined in declaration
 >> context, it gets an error when used in an expression.  Secondly
 >> typeof() is not expanded by cpp so the stringify tricks do not
 >> work.  typeof(x) is handled by cc, not cpp.

>>>>> "David" == David Woodhouse <dwmw2@infradead.org> writes:

 David> No. It's far too silly for me to have actually tried it :)

David, you wild and crazy guy!  How crazy is this,

#define real_min(x,y) ({ typeof((x)) _x = (x); typeof((y)) _y = (y); (_x>_y)?_y:_x; })
#define min(x,y) ({extern void BUG(void); typeof(x) _x = 0; typeof(y) _y = 0;  \
        if (sizeof(typeof(x)) != sizeof(typeof(y)) ||   \
            (_x-1 > 0 && _y-1 < 0) || (_x-1<0 && _y-1>0)) \
                            BUG();                      \
        real_min(x,y); }) 

int main(int argc, char *argv[])
{
    int ix,iy;
    unsigned int ux,uy;
    long lx,ly;
    unsigned long Ux,Uy;

    ux = min(ix,uy);
    return 0;
}

sh> gcc -Wall test.c -O2 test

This is a little slimmy as the sizeof will evaluate the to same thing
on some architectures for long/int or short/int.  Even worse, it won't
handle pointers.  The macro is `physically correct' if a short/int are
the same.  Actually, you would probably want to cast up to which ever
is the bigger of the types to fully handle the precision.  Maybe the
sizeof() test isn't even needed due to promotion.  Just the signs are
important (afaik) and a test for pointer and integral mixing which I
cann't think of.  Maybe some clever use of arrays or "+ *x" or
something.

fwiw,
Bill Pringlemeir.




