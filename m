Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317892AbSGKUHn>; Thu, 11 Jul 2002 16:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317893AbSGKUHn>; Thu, 11 Jul 2002 16:07:43 -0400
Received: from chaos.analogic.com ([204.178.40.224]:24714 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317892AbSGKUHl>; Thu, 11 Jul 2002 16:07:41 -0400
Date: Thu, 11 Jul 2002 16:13:41 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Shipman, Jeffrey E" <jeshipm@sandia.gov>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: ioctl between user/kernel space
In-Reply-To: <03781128C7B74B4DBC27C55859C9D73809840658@es06snlnt>
Message-ID: <Pine.LNX.3.95.1020711155541.10054A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

