Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030773AbWJKDXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030773AbWJKDXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 23:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030774AbWJKDXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 23:23:48 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:24280 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030773AbWJKDXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 23:23:47 -0400
Subject: Re: Proof of concept:  Logdev with "almost-non" intrusive markers.
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Martin Bligh <mbligh@google.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <20061010134014.GD6200@Krystal>
References: <20060921232024.GA16155@Krystal>
	 <1160189237.21768.47.camel@localhost.localdomain>
	 <20061010134014.GD6200@Krystal>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 23:23:38 -0400
Message-Id: <1160537018.13097.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 09:40 -0400, Mathieu Desnoyers wrote:
> Hi Steven,
> 
> Those are great ideas! Kernel compile-time type checking is interesting, but has
> the following disadvantages (compared to Linux Kernel Markers 0.20
>   http://sources.redhat.com/ml/systemtap/2006-q3/msg00794.html) :
> 
> - It requires to keep a system-wide header file with all the marker functions
>   prototypes around. When a change is done in the code, the header must match.
>   My goal being to provide a self-describing, one liner marker, such system-wide
>   header file makes me uncomfortable.

But it doesn't compile if you screw up :)

It is more of a tedious burden, than a maintenance one.  The prototypes
would just sit in a include/linux file.  If someone needs to change a
prototype, they had better change it where it's used!  With the tracing
I do, I like to take some pointer and dereference it.  So it had better
match my prototype.  the printf syntax doesn't cut it for me.  But
that's for my logdev, which is for debugging, and the last thing I need
is to be debugging logdev when I'm debugging something else.

BTW, I looked at the link you showed me, and I think you need a
__mark_check_format in linux/asm-generic/marker.h:

+#define MARK(name, format, args...) \
+	do { \
+		static marker_probe_func *__mark_call_##name = \
+					__mark_empty_function; \
+		volatile static char __marker_enable_##name = 0; \
+		static const struct __mark_marker_c __mark_c_##name \
+			__attribute__((section(".markers.c"))) = \
+			{ #name, &__mark_call_##name, format } ; \
+		static const struct __mark_marker __mark_##name \
+			__attribute__((section(".markers"), unused)) = \
+			{ &__mark_c_##name, &__marker_enable_##name } ; \
+		if (unlikely(__marker_enable_##name)) { \
+			preempt_disable(); \
+			(*__mark_call_##name)(format, ## args); \
+			preempt_enable_no_resched(); \
+		} \
+	} while(0)
+


It seems to be missing.


> - Knowing the number of parameters (LD_MARK[1-4]) instead of using variable
>   arguments (MARK) adds the ability to use typeof() on the parameters, which is
>   clearly great. On the downside, it multiplies the number of macros and limits
>   the number of parameters that can be passed (I guess we will never do an
>   LD_MARK10). 

Ah, passing more than 4 is probably a waste.  Especially if you can grab
other variables outside of the parameters.

Soon I'll post a new logdev, that doesn't duplicate the macros so bad.
Here's an excerpt:

 #define LD_MARK_PROLOG(label)						\
	"1:"								\
	".section .__logdev_strings,\"a\"\n"				\
	"__logdev_str_" #label ": .string \"" #label "\"\n"		\
	".previous\n"							\
	".section .__logdev_markers,\"a\"\n"				\
	".long 1b, __logdev_caller__" #label "\n"			\
	".long __logdev_str_" #label "\n"

#define LD_MARK(label)						\
	{							\
		extern void __logdev_caller__ ## label(void);	\
		asm(						\
		    LD_MARK_PROLOG(label)			\
		    ".long 0\n"					\
		    ".previous"					\
		    : :	);					\
	}

#define LD_MARK1(label, arg1)						\
	{								\
		extern void __logdev_caller__ ## label(typeof(arg1));	\
		asm(							\
		    LD_MARK_PROLOG(label)				\
		    ".long 1\n"						\
		    "xorl %0, %0\n"					\
		    ".short 0\n"					\
		    ".previous"						\
		    : :							\
		    "r"(arg1));						\
	}

#define LD_MARK2(label, arg1, arg2)					\
	{								\
		extern void __logdev_caller__ ## label(typeof(arg1),	\
						       typeof(arg2));	\
		asm(							\
		    LD_MARK_PROLOG(label)				\
		    ".long 2\n"						\
		    "xorl %0, %0\n"					\
		    ".short 0\n"					\
		    "xorl %1, %1\n"					\
		    ".short 0\n"					\
		    ".previous"						\
		    : :							\
		    "r"(arg1), "r"(arg2));				\
	}

#define LD_MARK3(label, arg1, arg2, arg3)				\
	{								\
		extern void __logdev_caller__ ## label(typeof(arg1),	\
						       typeof(arg2),	\
						       typeof(arg3));	\
		asm(							\
		    LD_MARK_PROLOG(label)				\
		    ".long 3\n"						\
		    "xorl %0, %0\n"					\
		    ".short 0\n"					\
		    "xorl %1, %1\n"					\
		    ".short 0\n"					\
		    "xorl %2, %2\n"					\
		    ".short 0\n"					\
		    ".previous"						\
		    : :							\
		    "r"(arg1), "r"(arg2), "r"(arg3));			\
	}

#define LD_MARK4(label, arg1, arg2, arg3, arg4)				\
	{								\
		extern void __logdev_caller__ ## label(typeof(arg1),	\
						       typeof(arg2),	\
						       typeof(arg3),	\
						       typeof(arg4));	\
		asm(							\
		    LD_MARK_PROLOG(label)				\
		    "xorl %0, %0\n"					\
		    ".short 0\n"					\
		    "xorl %1, %1\n"					\
		    ".short 0\n"					\
		    "xorl %2, %2\n"					\
		    ".short 0\n"					\
		    "xorl %3, %3\n"					\
		    ".short 0\n"					\
		    ".previous"						\
		    : :							\
		    "r"(arg1), "r"(arg2), "r"(arg3), "r"(arg4));	\
	}


The prolog helps with this.  With x86_64, I added a SPACER macro to
handle the spacing (.short here).


> Wether
>     MARK4(label, args1, arg2, arg3, arg4)
>   or
>     MARK(label, format, arg1, arg2, arg3, arg4)
>   is better is a matter of visual impact and level of self-description of the
>   probe. While I personally prefer the format string because of its
>   flexibility, it could be useful to have other insight about which is the
>   less visually hurting approach.

:)

I don't care for the numbering of the parameters, but it helps with the
type checking that printf can fail with.  But if the printf format is
enough for others, I'm not complaining.  My logdev will be around as
long as I am!

-- Steve


