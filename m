Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWD0N4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWD0N4H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 09:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWD0N4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 09:56:07 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:8676 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S965051AbWD0N4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 09:56:05 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Avi Kivity <avi@argo.co.il>
Subject: Re: C++ pushback
Date: Thu, 27 Apr 2006 16:55:48 +0300
User-Agent: KMail/1.8.2
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       Roman Kononov <kononov195-far@yahoo.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <4EE8AD21-55B6-4653-AFE9-562AE9958213@mac.com> <44507BB9.7070603@argo.co.il>
In-Reply-To: <44507BB9.7070603@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604271655.48757.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 11:07, Avi Kivity wrote:
> C++ compilation isn't slower because the compiler has to recognize more 
> keywords. It's slower because it is doing more for you: checking types 
> (C++ code is usually free of void *'s except for raw data) and expanding 

Today's C is much better at typechecking than ancient K&R C.

> those 4-line function to their 14-line goto-heavy equivalents.

Where do you see goto-heavy code in kernel?

> > Ok, help me understand here:  Instead of helping using one sensible 
> > data structure and generating optimized code for that, the language 
> > actively _encourages_ you to duplicate classes and interfaces, 
> > providing even _more_ work for the compiler, making the code harder to 
> > debug, and probably introducing inefficiencies as well.  If C++ 
> > doesn't work properly for a simple and clean example like struct 
> > list_head, why should we assume that it's going to work any better for 
> > more complicated examples in the rest of the kernel?  Whether or not 
> > some arbitrary function is inlined should be totally orthogonal to 
> > adding type-checking.
> 
> C++ works excellently for things like list_head. The generated code is 
> as efficient or better that the C equivalent,

"or better" part is pure BS, because there is no magic C++ compiler
can possibly do which is not implementable in C.

"as efficient", hmmm, let me see... gcc 3.4.3, presumably an contemporary
C++ compiler, i.e. which is "rather good".

Random example. gcc-3.4.3/include/g++-v3/bitset:

  template<size_t _Nw>
    struct _Base_bitset
    {
      typedef unsigned long _WordT;

      /// 0 is the least significant word.
      _WordT            _M_w[_Nw];

      _Base_bitset() { _M_do_reset(); }
...
      void
      _M_do_set()
      {
        for (size_t __i = 0; __i < _Nw; __i++)
          _M_w[__i] = ~static_cast<_WordT>(0);
      }
      void
      _M_do_reset() { memset(_M_w, 0, _Nw * sizeof(_WordT)); }
...

A global or static variable of _Base_bitset or derived type
would need an init function?! Why not just preset sequence of
zeroes in data section?
[this disproves that C++ is very efficient]

Why _M_do_set() doesn't use memset()?
Why _M_do_reset() is not inlined?
[this disproves that today's C++ libs are well-written]?

> and the API is *much*  
> cleaner. You can iterate over a list without knowing the name of the 
> field which contains your list_head (and possibly getting it wrong if 
> there is more than one).

But kernel folks tend to *want to know* everything, including
names of the fields.

> > How could that possibly work in C++ given what you've said?  Anything 
> > that breaks code that simple is an automatic nonstarter for the 
> > kernel.  Also remember that spinlocks are defined preinitialized at 
> > the very earliest stages of init.  Of course I probably don't have to 
> > say that anything that tries to run a function to iterate over all 
> > statically-allocated spinlocks during init would be rejected out of hand.
> 
> Why would it be rejected?
> 
> A static constructor is just like a module init function. Why are 
> modules not rejected out of hand?

Because we do not like init functions which can be eliminated.
That's bloat.
--
vda
