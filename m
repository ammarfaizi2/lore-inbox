Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129338AbQKGJYN>; Tue, 7 Nov 2000 04:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129493AbQKGJYD>; Tue, 7 Nov 2000 04:24:03 -0500
Received: from vega.services.brown.edu ([128.148.19.202]:18144 "EHLO
	vega.brown.edu") by vger.kernel.org with ESMTP id <S129338AbQKGJXz>;
	Tue, 7 Nov 2000 04:23:55 -0500
Message-Id: <4.3.2.7.2.20001107040409.00add3e0@postoffice.brown.edu>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 07 Nov 2000 04:26:43 -0500
To: linux-kernel@vger.kernel.org
From: David Feuer <David_Feuer@brown.edu>
Subject: RE: malloc (1/0) ??
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As long as you don't try to do any more mm once you've allocated with 
malloc(0), and as long as you haven't done any previous allocations with 
malloc, you should be able to scribble all over malloc.  In fact, if you 
want, I think you can scribble all over your own stack without causing 
Linux any trouble.

I'm guessing (and this is only an educated guess), that you could do some 
really strange things like

void scribble(void)
{
int x[50];
do_scribble(x);
}
void do_scribble(int *x)
{
char y[50];
x[70]=54;
x[71]=32;
x[50]=3;x[51]=12;  /* watch out */
}
void main(void)
{
scribble();
}


Depending how the storage structure works for your C compiler (sorry, I 
don't remember), this COULD scribble integers onto your character 
array.  The line marked "watch out" COULD severely scribble the return 
pointer and make the program crash in really ugly ways. Alternatively, it 
might not.  Depends how you stack it.


As a less severe example, if you want, you can do something really funky like

x=(char *)malloc(100);
x=(char *)realloc (x,50);
y=x+50;  /*could be a fencepost error: not worth my time to check*/


Writing to y will scribble on malloc's territory, but as long as you don't 
call malloc again, you should be fine.  This way you can get any amount of 
scribble space.  Of course, this only works on normal versions of malloc 
that don't try to return memory to the OS, etc.
--
This message has been brought to you by the letter alpha and the number pi.
David Feuer
David_Feuer@brown.edu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
