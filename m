Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262323AbSJNVQs>; Mon, 14 Oct 2002 17:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262336AbSJNVQs>; Mon, 14 Oct 2002 17:16:48 -0400
Received: from inrete-46-20.inrete.it ([81.92.46.20]:52871 "EHLO
	pdamail1-pdamail.inrete.it") by vger.kernel.org with ESMTP
	id <S262323AbSJNVQp>; Mon, 14 Oct 2002 17:16:45 -0400
Message-ID: <3DAB3592.E19150C6@inrete.it>
Date: Mon, 14 Oct 2002 23:22:26 +0200
From: Daniele Lugli <genlogic@inrete.it>
Organization: General Logic srl
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rthal5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
References: <Pine.LNX.3.95.1021014162539.16867B-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Mon, 14 Oct 2002, Daniele Lugli wrote:
> 
> > I recently wrote a kernel module which gave me some mysterious problems.
> > After too many days spent in blood, sweat and tears, I found the cause:
> >
> > *** one of my data structures has a field named 'current'. ***
> >
> > Pretty common word, isn't it? Would you think it can cause such a
> > trouble? But in some of my files I happen to indirectly include
> > <asm/current.h> (kernel 2.4.18 for i386), containing the following line:
> >
> > #define current get_current()
> >
> > so that my structure becomes the owner of a function it has never asked
> > for, while it looses a data member. gcc has nothing to complain about
> > that.
> >
> 
> This cannot be the reason for your problem. The name of a structure
> member has no connection whatsoever with the name of any function or
> definition.
> 
> The following code will correctly write "Hello world!" to the screen
> even though the text initializes a member of a structure called "current"
> while "current" has been defined to be a function called puts.
> 
> #include <stdio.h>
> #define current puts
> struct foo {
>     char *current;
>     int foo;
>     } bar;
> main()
> {
>     bar.current = "Hello world!";
>     current(bar.current);
>     return 0;
> }
> 
> For your code to get "confused", you really have something else
> wrong. That said, some name-space polution may make it difficult
> to find the problem. For instance, a structure member is expected
> to have a ";" after it. It's possible for some previous definition
> to make a syntax error invisible.
> 
> Cheers,
> Dick Johnson

Try the following instead:

// file shade1.cpp

// excerpt from common.h

#define current get_current()

// my stuff

struct {
  int any;
  int current[1000];
} mine;


// file shade2.cpp

#include <stdio.h>

// my stuff

extern struct {
  int any;
  int current[1000];
} mine;

int main () {
  mine.current[999] = 1;
  printf ("%d\n", mine.current[999]);
}

g++ shade1.cpp shade2.cpp

./a.out => segmentation fault

Regards, Daniele
