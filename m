Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262711AbRE3Kaq>; Wed, 30 May 2001 06:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262715AbRE3Kag>; Wed, 30 May 2001 06:30:36 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:11270 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262711AbRE3KaY>;
	Wed, 30 May 2001 06:30:24 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: hps@intermeta.de
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net #9 
In-Reply-To: Your message of "Wed, 30 May 2001 09:32:39 GMT."
             <9f2enn$jbr$1@forge.intermeta.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 May 2001 20:30:18 +1000
Message-ID: <18468.991218618@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001 09:32:39 +0000 (UTC), 
"Henning P. Schmiedehausen" <mailgate@hometree.net> wrote:
>Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl> writes:
>
>>-static char	name[4][IFNAMSIZ] = { "", "", "", "" };
>
>>+static char	name[4][IFNAMSIZ];
>
>Ugh. Sure about that one? the variables have been pointers to zero,
>now they're zero...

Bzzt.  Arrays and pointers are not always equivalent.  This code
defines an area of 4*IFNAMSIZ chars.  The old code then initialised
each IFNAMSIZ chars to the empty string (an array starting with '\0'),
not a pointer to an empty string.  Test file x.c.

#define IFNAMSIZ 7
static char name[4][IFNAMSIZ];
int main(void) { return(0); }

# gcc -g x.c -o x
# gdb x
(gdb) ptype name
type = char [4][7]
(gdb) x name[0]
0x80494f4 <name>:       0x00000000
(gdb) x name[1]
0x80494fb <name+7>:     0x00000000
(gdb) x name[2]
0x8049502 <name+14>:    0x00000000
(gdb) x name[3]
0x8049509 <name+21>:    0x00000000

Zero initialisation via bss works fine.  Try it with 
  static char name[4][IFNAMSIZ] = {"", "", "", ""};
and you get exactly the same results, at the expense of more disk space
and time to load.  Not much extra I know, but it all adds up.

