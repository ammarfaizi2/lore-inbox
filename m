Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311365AbSCMUuD>; Wed, 13 Mar 2002 15:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311360AbSCMUty>; Wed, 13 Mar 2002 15:49:54 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59011 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S311362AbSCMUtp> convert rfc822-to-8bit; Wed, 13 Mar 2002 15:49:45 -0500
Date: Wed, 13 Mar 2002 15:49:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: =?ISO-8859-1?Q?Romain_Li=E9vin?= <rlievin@free.fr>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <1016051318.3c8fb67699ae8@imp.free.fr>
Message-ID: <Pine.LNX.3.95.1020313153432.30430A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, [ISO-8859-1] Romain Liévin wrote:
I'm going to comment on a few points:

[SNIPPED most...]

> +
> +/* D-bus protocol:
> +                    1                 0                      0
> +       _______        ______|______    __________|________    __________
> +Red  :        ________      |      ____          |        ____
> +       _        ____________|________      ______|__________       _____
> +White:  ________            |        ______      |          _______
> +*/
> +
> +/* Try to transmit a byte on the specified port (-1 if error). */
> +static int put_ti_parallel(int minor, unsigned char data)
> +{
> +       int bit, i;
> +       unsigned long max;
> +  
> +       for (bit=0; bit<8; bit++) {
> +               if (data & 1) {
> +                       outbyte(2, minor);
> +                       START(max); 
> +                       do {
> +                               WAIT(max);
> +                       } while (inbyte(minor) & 0x10);

             This may never happen. You end up waiting forever!
             If the port doesn't exist or is broken, it may return 0xff
             forever! You need to time-out and get out.


> +                       
> +                       outbyte(3, minor);
> +                       START(max);
> +                       do {
> +                               WAIT(max);
> +                       } while (!(inbyte(minor) & 0x10));

                     This may never happen. You end up awiting forever!
                     You need to time-out and get out.


> +               } else {
> +                       outbyte(1, minor);
> +                       START(max);
> +                       do {
> +                               WAIT(max);
> +                       } while (inbyte(minor) & 0x20);
> +                       
                       This also may never happen!
                       Same applies, time-out and get out.
                     
> +                       outbyte(3, minor);
> +                       START(max);
> +                       do {
> +                               WAIT(max);
> +                       } while (!(inbyte(minor) & 0x20));

                      This also may never happen!
                      Same applives, time-out and get out.

> +               }
> +               data >>= 1;
> +               for(i=0; i < delay; i++) {
> +                       inbyte(minor);
> +               }

> +               schedule();

                  This will just spin without setting
                  current->policy |= SCHED_YIELD;
                  (you really should use sys_sched_yield())


> +       }
> +       
> +       return 0;
> +}
> +
> +/* Receive a byte on the specified port or -1 if error. */
> +static int get_ti_parallel(int minor)
> +{
> +       int bit,i;
> +       unsigned char v, data=0;
> +       unsigned long max;
> +
> +       for (bit=0; bit<8; bit++) {
> +               START(max); 
> +               do {
> +                       WAIT(max);
> +               } while ((v=inbyte(minor) & 0x30) == 0x30);
> +      
                  More wait-forever above...

> +               if (v == 0x10) { 
> +                       data=(data>>1) | 0x80;
> +                       outbyte(1, minor);
> +                       START(max);
> +                       do {
> +                               WAIT(max);
> +                       } while (!(inbyte(minor) & 0x20));

                      More wait-forever above.


> +                       outbyte(3, minor);
> +               } else {
> +                       data=data>>1;
> +                       outbyte(2, minor);
> +                       START(max);
> +                       do {
> +                               WAIT(max);
> +                       } while (!(inbyte(minor) & 0x10));
> +                       outbyte(3, minor);
                      More wait-forever!

> +               }
> +               for(i=0; i<delay; i++) {
> +                       inbyte(minor);
> +               }
> +               schedule();
                  No current->policy

> +       }
> +       return (int)data;
> +}
> +

[SNIPPED rest]


Basically, this code performs a needed function. I have been waiting
for someone to write this! However, it's not yet ready for prime-time.
Never assume that hardware is going to produce what you expect. Don't
wait forever for something that was supposed to happen. You'll hang
the machine.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

