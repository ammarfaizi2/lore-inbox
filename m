Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313128AbSDIK4V>; Tue, 9 Apr 2002 06:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313130AbSDIK4U>; Tue, 9 Apr 2002 06:56:20 -0400
Received: from [195.63.194.11] ([195.63.194.11]:47886 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313128AbSDIK4S>; Tue, 9 Apr 2002 06:56:18 -0400
Message-ID: <3CB2BA4C.80200@evision-ventures.com>
Date: Tue, 09 Apr 2002 11:54:20 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "T. A." <tkhoadfdsaf@hotmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: C++ and the kernel
In-Reply-To: <OE379mspgEOI7vDcPp200002a4c@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

T. A. wrote:
> Hi all,
> 
>     I am in the initial stages of writing some C++ wrapper classes for the
> kernel.  
> 
>     So far my overloading of "new" works if I compile the module without
> exceptions (-fno-exceptions).  This is fine for myself as I prefer checking
> for a NULL on a memory allocation error over handling an exception, plus the
> resulting code appears to be much more efficient without exceptions by a
> large order of magnitude.  However I would like my C++ kernel support to
> include exception support if possible so those whom may want to use it,

This will turn out to be nearly impossible. Please note that
the exception mechanisms in C++ are basically a second function
return path and are therefore not desirable at all for the following reasons:

1. It's silly becouse we have already a return path and page fault based
    exception mechanisms in kernel, which is far better suited for the purposes
    of the kernel then the C++ semantics. (Remarkable the KDE people recognize
    that C++ exceptions are not a good thing...)

2. It's changing the stack layout for the kernel functions, and there
    are few of them which rely on a particular stack layout (namely the
    scheduler and some *.S files - look out for the asmlinkage attribute...)


> besides which it may yet prove itself useful.  However allowing exceptions
> in (if used apparently, via so far my overloading of "new") appears to put
> an undefined reference to throw and (I think) terminate into the resulting
> object file.  Does someone know how I can resolve this?

Yes I know - PLEASE JUST FORGET ABOUT IT.

>     I would like to add the ability for the wrapper classes' users to use
> static member functions as the module initiation and cleanup functions.  For
> example:
> 
> class my_module
> {
>     public:
>         static int load();
>         static void unload();
> };
> 
>     And use my_module::load() as the init_module function and
> my_module::unload() as the cleanup_module function.  The provided macros
> module_init and module_exit should do this for me however I've encountered a
> limitation in how gcc's "alias" feature is used.  Apparently for C++ one
> must pass the mangled name of the function in question.  Is there a gcc
> macro or function of some kind to do something like this:
> 
> int init_module() __attribute__((alias(mangle_name("load__9my_module"))));
> int cleanup_module()
> __attribute__((alias(mangle_name("unload__9my_module"))));

I guess the above wouldn't work due to the games which the linkage scripts
play already on the init_module and cleanup_module function.
Maybe you would rather wan't to have a look at those scripts themself
and adjust them accordingly? (Possibly having a mangling tool at hand...)

>     I need a function or macro like mangle_name above.
> 
>     Another issue that I currently have is that I haven't been able to
> figure out a way to get the module to properly initiate global objects.
> Like so:
> 
> my_module mod1;

Well the "hidden C++" initializations you should propably forget
about - they are not desirable inside the kernel, becouse this
C++ mechanism is annihilating the expliciticity of the programm controll
flow of C.

> On a side note:
> 
>     So far C++'s use of the kernel headers has found a couple of areas in
> which possible bugs exists.  In one header file the typedef ssize_t is used
> despite its definition not appearing in the source file or any of the
> included header files.  I've also encountered negative numbers being
> assigned to unsigned numbers without a cast.  And I've found completely
> unnecessary use of the C++ keyword "new" as variable names in some inlined
> functions.
> 
>     Would patches be welcomed for one or more of these issues?

Personally I would just like to have the ability to compile the
kernel with C++ just for the following two reaons:

1. C++ is a bit tighter on type checking, which would give better regreesions.

2. Modern GCC versions generate generally better code for C if compiled as C++
    files, since the language gives tighter semantics to some constructs.

However I wouldn't for certainly like to see the kernel beeing transformed
in to C++. Expierence has shown over time that the chances for abuse of this
programming language are just too high. Language design idiocies like the
following come immediately in to mind:

1. Templates.

2. Runtime Type Information.

3. Operator overloading. This makes the language morphable which is killing
nearly the ability to understand code by reading it.

4. Syntactically hidden code paths
(exceptions, constructors with side effects, destructors which you never know
when they tis you...) make the readability even worser...

5. Instability of compiler implementations (ever wondered how many libstdc++ you
have on your linux system?)

