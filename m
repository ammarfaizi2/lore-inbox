Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271916AbRIDJKX>; Tue, 4 Sep 2001 05:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271917AbRIDJKN>; Tue, 4 Sep 2001 05:10:13 -0400
Received: from [195.66.192.167] ([195.66.192.167]:54279 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271916AbRIDJKA>; Tue, 4 Sep 2001 05:10:00 -0400
Date: Tue, 4 Sep 2001 12:09:34 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <6412704327.20010904120934@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A test program.
min2 performs a very strict checking.
min3 gives you full control, but checks for too small target type.
Do anybody see any flaws? Any improvements?
For compiler folks: Why GCC compiles ...f(1);f(1);f(1)... to
...
        pushl $1
        call f
        addl $32,%esp  <-- My grandma optimizes better
        addl $-12,%esp <-- ?
        pushl $1
        call f
        addl $16,%esp  <-- ?
        addl $-12,%esp <-- ?
...
--------------------------------------------------------------------
#include <stdio.h>

#define min2(a,b) ({ \
    typeof(a) __a = (a); \
    typeof(b) __b = (b); \
    if( sizeof(a) != sizeof(b) ) BUG(); \
    if( ~(typeof(a))0 > 0 && ~(typeof(b))0 < 0) BUG(); \
    if( ~(typeof(a))0 < 0 && ~(typeof(b))0 > 0) BUG(); \
    (__a < __b) ? __a : __b; \
    })

#define min3(type,a,b) ({ \
    type __a = (a); \
    type __b = (b); \
    if( sizeof(a) > sizeof(type) ) BUG(); \
    if( sizeof(b) > sizeof(type) ) BUG(); \
    (__a < __b) ? __a : __b; \
    })

#define BUG() printf("BUG at %i\n",__LINE__)
#define llong long long

// Uncomment {} for compile, comment for gcc -S -O2 optimizer test
void f(int v);
// void f(int v) {}

int main() {
    signed char  sc=1; unsigned char  uc=1;
    signed short ss=1; unsigned short us=1;
    signed int   si=1; unsigned int   ui=1;
    signed long  sl=1; unsigned long  ul=1;
    signed llong su=1; unsigned llong uu=1;

    f(min2(sc,sc)); // not a BUG
    f(min2(sc,uc)); // not a BUG: (typeof(x))0 first expanded to signed int
    f(1); // optimizer test: all the mins must be optimized to 
    f(1); // f(1) so do gcc -S -O2 and inspect .s file
    f(min2(ss,ss)); // not a BUG
    f(min2(ss,us)); // not a BUG: (typeof(x))0 first expanded to signed int
    f(min2(si,si)); // not a BUG
    f(min2(si,ui)); // BUG: signedness mismatch
    f(min2(sl,sl)); // not a BUG
    f(min2(sl,ul)); // BUG: signedness mismatch
    f(min2(su,su)); // not a BUG
    f(min2(su,uu)); // BUG: signedness mismatch
    f(min2(sc,ss)); // BUG: size mismatch
    f(min3(unsigned char, sc,uc)); // not a BUG
    f(min3(int,           sc,ss)); // not a BUG
    f(min3(unsigned llong,ss,uu)); // not a BUG
    f(min3(unsigned long, ss,uu)); // BUG: target type is too small
    
    return 0;
}
-------------------------------------------------------------
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


