Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317896AbSGKUgx>; Thu, 11 Jul 2002 16:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317902AbSGKUgw>; Thu, 11 Jul 2002 16:36:52 -0400
Received: from mm02snlnto.sandia.gov ([132.175.109.21]:8723 "HELO
	mm02snlnto.sandia.gov") by vger.kernel.org with SMTP
	id <S317896AbSGKUgr>; Thu, 11 Jul 2002 16:36:47 -0400
X-Server-Uuid: 95b8ca9b-fe4b-44f7-8977-a6cb2d3025ff
Message-ID: <03781128C7B74B4DBC27C55859C9D73809840659@es06snlnt>
From: "Shipman, Jeffrey E" <jeshipm@sandia.gov>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: ioctl between user/kernel space
Date: Thu, 11 Jul 2002 14:39:31 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-Filter-Version: 1.8 (sass2426)
X-WSS-ID: 113333EB3611437-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your answers. I do have a couple more questions,
however:

1) I'm not dealing with any hardware. Is it still ok to
call some sort of register_xxxdev() function? If so, where can
I find the definitions of these register functions and which
one would you think be appropriate for a module which simply
does packet manipulation via Netfilter?

2) What if my module is not in the kernel? Does ioctl()
just return an error code?

Thanks again.

Jeff Shipman - CCD
Sandia National Laboratories
(505) 844-1158 / MS-1372


-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com]
Sent: Thursday, July 11, 2002 2:14 PM
To: Shipman, Jeffrey E
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: ioctl between user/kernel space


On Thu, 11 Jul 2002, Shipman, Jeffrey E wrote:

> I'm not sure if this is the right place to ask this, but
> I have a question about ioctl(). I have a situation where
> I need to parse a file and build a hash table out of the
> information in user space. Then, I must pass that hash
> table into my module that's in kernel space. My question 
> is: is ioctl() the way to go about this? I really don't
> know much about the function, but some people have mentioned
> it to me as the way to pass information between user and
> kernel space.
> 
> If anyone has advice on if this is the way to go about it
> or how we could go about doing this would be greatly
> appreciated. Also, if anyone knows of any websites which
> may be helpful in this area, we'd appreciate that as
> well.
> 
> Thanks.
> 
> Jeff Shipman - CCD
> Sandia National Laboratories
> (505) 844-1158 / MS-1372

That's what ioctl() is/was designed for. In user-space, you have

            int ioctl(fd, FUNCTION_NR, parameter);

... where fd is your open file-handle, FUNCTION_NR is whatever you want
to define a specific control for your device, and parameter is usually
a pointer to some parameters (like a buffer).

In the module, you have.
  
 int any_name(struct inode *ip, struct file *fp, unsigned int command,
unsigned long arg);

    'ip' and 'fp' will probably be ignored in your module.
    'command' is your FUNCTION_NR, and 'arg' is your parameter.
    You cast 'arg' to a pointer of your choice if the user-mode
    code supplies a pointer.

    The address (pointer) of your function goes into the
   'struct file_operations' (7th member) that you pass a pointer
   to when you initialize your device (register_xxxdev()).

   The normal return code is 0. You return a -ERRNO if any errors
   are encountered in your function.

   Typically, you do:

   switch(command)
   {
   case FIRST_FUNCTION:
   ....
   break;
   default:
       return -ESPIPE; // Invalid stuff, lets you still test with
                       // standard text tools (od, hexdump, etc).
   }

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.


