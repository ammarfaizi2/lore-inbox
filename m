Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbQJ3MAr>; Mon, 30 Oct 2000 07:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbQJ3MAh>; Mon, 30 Oct 2000 07:00:37 -0500
Received: from jalon.able.es ([212.97.163.2]:41963 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129053AbQJ3MA2>;
	Mon, 30 Oct 2000 07:00:28 -0500
Date: Mon, 30 Oct 2000 13:00:06 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel Developer <linux_developer@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need info on the use of certain datastructures and the first C++ keyword patch for 2.2.17
Message-ID: <20001030130006.B1555@werewolf.cps.unizar.es>
In-Reply-To: <OE58erOc0Ne0PaLI9mK000004a6@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <OE58erOc0Ne0PaLI9mK000004a6@hotmail.com>; from linux_developer@hotmail.com on Mon, Oct 30, 2000 at 12:09:49 +0100
X-Mailer: Balsa 1.0.pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2000 12:09:49 Linux Kernel Developer wrote:
> The goal of this project is to clean up the kernel headers so as they are
> useable/compatible with those who wish to program their kernel modules in
> C++.  It is not my goal to rewrite the kernel in C++ or anything like that,

Fist of all, there is even one other goal, to MAKE PEOPLE PROGRAMMING IN C++
TO BE ABLE TO USE KERNEL HEADERS; it is more likely that someone programs
something in C++ that accesses kernel info that anyone programming a C++
module.

The generated patch has to be usable by someone that has only kernel headers
and kernel binaries, no kernel source tree (situation 1). 
You get the standard kernel
headers, apply the patch and make them C++-friendly. There is a similar
workaround done in X, that I will comment below.

> updated.  A couple of C files had to be updated as well due to parameters,
> defined in the header files, being called "new".  All of these were
> straightforward fixes and should be correct, testing is welcome.
..
>     Ok now on to the questions I have.  In include/linux/joystick.h,
> include/linux/raid5.h, and include/linux/adfs_fs.h I've found members of
> structures and a union which were called "new".  The datastructures in
> question are union adfs_dirtail::new, struct stripe_head::new, struct
> js_dev::new.  My questions are basically this.  If I update these data
> structure members' names along with the references to them in various C
> files in the kernel will all be happy in Linuxland.  Can any external

Why do you need to touch any existing kernel .c source file ? If you make
that patch, this breaks "situation 1" above.
AFAIK, ANSI C does not require that prototype (declaration) parameter names and 
definition parameter names match, only types. So, this snippet is correct:

int f(int onename);

int f(int othername)
{
}

and compiled both under egcs-1.1.2 and gcc-2.95.2. So you don't have to touch
kernel .c source files, only change headers to make them not break C++.

And what about struct fields ? It is the same. If you change the name of a field
permanently, you have to modify the C source that uses it. But names are not
important for binary compatability, so you can make things like:
struct data {
	int field1;
#ifndef __cplusplus
	double 	new;
	int	class;
#else
	double	dnew;
	int	klass;
#endif
};

The "klass" example is directly taken from XFree header files, look at
vi +239 /usr/X11R6/include/X11/Xlib.h
vi +898 /usr/X11R6/include/X11/Xlib.h

So the core X internals, written in C, use the "class" field, but anyone using 
X in C++ programs has to use the field as "klass" or "c_class".

I think X is a good example to provide C++ friendlyness with the minimal
internal
change. Perhaps this is a way to make kernel programmers-mantainers to accept
the 
headers patch, they can continue working the same...

-- 
Juan Antonio Magallon Lacarta                          mailto:jamagallon@able.es

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
