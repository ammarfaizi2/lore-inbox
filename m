Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289093AbSAJAUT>; Wed, 9 Jan 2002 19:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289094AbSAJAUA>; Wed, 9 Jan 2002 19:20:00 -0500
Received: from motgate2.mot.com ([136.182.1.10]:30397 "EHLO motgate2.mot.com")
	by vger.kernel.org with ESMTP id <S289093AbSAJATl>;
	Wed, 9 Jan 2002 19:19:41 -0500
Date: Wed, 9 Jan 2002 19:19:24 -0500
Message-Id: <200201100019.g0A0JOM32110@hyper.wm.sps.mot.com>
From: Peter Barada <pbarada@mail.wm.sps.mot.com>
To: jamagallon@able.es
CC: groudier@free.fr, jtv@xs4all.nl, tim@hollebeek.com,
        Dautrevaux@microprocess.com, dewar@gnat.com, paulus@samba.org,
        gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        trini@kernel.crashing.org, velco@fadata.bg
In-Reply-To: <20020110004952.A11641@werewolf.able.es> (jamagallon@able.es)
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020108012734.E23665@werewolf.able.es> <20020109204043.T1027-100000@gerard> <20020110004952.A11641@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Even
>
>int	b;
>volatile const int a = 5;
>b = a - a;
>
>can not be optimized to 
>
>b = 0;

Until you define the scope of the variables, you can't make that
assertion.  If the code is:

int b;
volatile const a=5;
void stuff()
{
  b = a - a;
}

I can see how a can change in the midst of the execution since
some other code has access to a since its global scope.

If the code is:

int b;
void stuff()
{
  volatile const a=5;

  b = a - a;
}

Then the code can be optimized to 'b = 0;' since nowhere in the scope
of 'a' does anyone take its address(which would allow it to be changed).
Of course if 'a' is external then another function can access its
address.

>And a CAN change between the two pushes. It is not resposibility of the
>compiler to try to be clever than the programmer, if the volatile is there
>is for a reason (it can be a hardware mapped register like a DAC,
>or who knows).
>In the (in)famous example above the compiler should not convert to a += 13.
>If it is expected to do it, then the (in)famous is the programmer who
>put a volatile in a local variable. Usually a mapped register would
>be a 'volatile extern int my_reg'.

I don't think that anyone is arguing about that case *if so stated*.
What they are arguing about is the following code(and literally!):

void foo()
{
  int a=3;
  {
    volatile int b=10;

    a += b;
  }
  bar(a);
}


can *by inspection* be modified into:

void foo()
{
  bar(13);
}


Since:
1) a and b's scope are limited to the function, so they will reside on
   the stack.
2) No one takes the address of b, so there is no way for any external
   hardware/thread to modify b.

For the above code, I see no reason for not optimizing out 'b'(and for
that case 'a').  If others want to argue about volatile variables,
generate a *realistic* testcase where the possibility for modification
can be inferred, and then pitch your case.

-- 
Peter Barada                                   Peter.Barada@motorola.com
Wizard                                         781-852-2768 (direct)
WaveMark Solutions(wholly owned by Motorola)   781-270-0193 (fax)
