Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278732AbRKDQbg>; Sun, 4 Nov 2001 11:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279994AbRKDQb1>; Sun, 4 Nov 2001 11:31:27 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:21135 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S278732AbRKDQbS>; Sun, 4 Nov 2001 11:31:18 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jakob =?iso-8859-1?q?=D8stergaard?= <jakob@unthought.net>,
        linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Sun, 4 Nov 2001 17:31:50 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
        Tim Jansen <tim@tjansen.de>
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160Nyq-2ACgt6C@fmrl07.sul.t-online.com> <20011104163354.C14001@unthought.net>
In-Reply-To: <20011104163354.C14001@unthought.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011104163110Z16629-26012+114@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 4, 2001 04:33 pm, Jakob Østergaard wrote:
> Here's my stab at the problems - please comment,
> 
> We want to avoid these problems:
>  1)  It is hard to parse (some) /proc files from userspace
>  2)  As /proc files change, parsers must be changed in userspace
> 
> Still, we want to keep on offering
>  3)  Human readable /proc files with some amount of pretty-printing
>  4)  A /proc fs that can be changed as the kernel needs those changes
> 
> 
> Taking care of (3) and (4):
> 
> Maintaining the current /proc files is very simple, and it offers the system
> administrator a lot of functionality that isn't reasonable to take away 
now. 
> 
>        * They should stay in a form close to the current one *
> 
> 
> Taking care of (1) and (2):
> 
> For each file "f" in /proc, there will be a ".f" file which is a
> machine-readable version of "f", with the difference that it may contain 
extra
> information that one may not want to present to the user in "f".
> 
> The dot-proc file is basically a binary encoding of Lisp (or XML), e.g. it 
is a
> list of elements, wherein an element can itself be a list (or a character 
string,
> or a host-native numeric type.  Thus, (key,value) pairs and lists thereof 
are
> possible, as well as tree structures etc.
> 
> All data types are stored in the architecture-native format, and a simple
> library should be sufficient to parse any dot-proc file.
> 
> 
> So, we need a small change in procfs that does not in any way break
> compatibility - and we need a few lines of C under LGPL to interface with 
it.
> 
> Tell me what you think - It is possible that I could do this (or something
> close) in the near future, unless someone shows me the problem with the
> approach.
> 
> Thank you,

While the basic idea is attractive for a number of reasons, there are more 
than a few questions to answer.  Take a look at a typical proc function, 
meminfo_read_proc for example.  Its active ingredient is basically a sprintf 
function:

        len += sprintf(page+len,
                "MemTotal:     %8lu kB\n"
                "MemFree:      %8lu kB\n"
                "MemShared:    %8lu kB\n"
		...,
                K(i.totalram),
                K(i.freeram),
                K(i.sharedram),
		...);

What does the equivalent look like under your scheme?   Does it remain 
localized in one proc routine, or does it get spread out over a few 
locations, possibibly with a part of the specification outside the 
kernel?  Do the titles end up in your dotfile?  How do you specify whatever 
formatting is necessary to transform a dotfile into normal /proc output?  Is 
this transformation handled in user space or the kernel?  How much library 
support is needed?

--
Daniel
