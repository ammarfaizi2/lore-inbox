Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbTDJUaB (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 16:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTDJUaB (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 16:30:01 -0400
Received: from mail.casabyte.com ([209.63.254.226]:30479 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S264154AbTDJU35 (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 16:29:57 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Ruth Ivimey-Cook'" <Ruth.Ivimey-Cook@ivimey.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: kernel support for non-english user messages
Date: Thu, 10 Apr 2003 13:41:29 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGMEPICGAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780BEBA768@orsmsx116.jf.intel.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is tautologically true that every printk starts with a format string, and
that "really" the kernel has no business "switching languages" on the fly.
That is, like selecting the chipset, the language the kernel should express
it self ought to be selected at compile time.

In essence, the translations have to be done earlier in the process instead
of later.  Having or needing a tool to read the log won't help someone
trying to diagnose a problem where a tool isn't in place and the storage
requirements for after-the-fact to see and use the output become
unreasonable.  (It's just not telnet/shell friendly.)

(being innocent of intent, for a moment, i.e. this isn't a recommendation at
this time, just a though experiment...)

Consider a tool that scans any source file and collects up the literal
strings of every printk encountered and tosses them into a static array,
"CHAR_TYPE * KernelMessage[] = { "whatever", "whatever"...};" then replaces
"printk("whatever",...);" with "printk(KernelMessage[0],...);"

subsequent runs of this theoretical tool will take any new prink(s) found
and add them to the list.

For completeness, any KernelMessage subscripts never used (cause the printk
was removed) would get burped out of the sequence at re-expression time.

Once that was done to any/every module, source, etc. the person wishing
translate a fragment needs only go into that file, and a branching define,
and translate the array of messages into the language of their intent.

Now the kernel "naturally" speaks the target language.

The Flaws however:

1) Needs this magic tool.
2) Needs each developer to support the tool.
3) Removes the comment-like value of the messages in the text because you
would have to cross-reference the KernelMessage subscript during development
to see what the program would try to output.
4) Each language would need a maintainer.  (i.e. want a French and a Spanish
kernel you need the French language manager and a Spanish language manager)
5) It's not patch friendly.  (Two people separately add a prink and run the
tool, now two different texts are intended for say KernelMessage[140] in
exit.c) which means un-official patches need to be not-language-enabled
which in turn means that the tool needs to be kept under guard to prevent
misuse etc.
6) Header Problems.  (printk's in headers would force each such header to
have it's own dedicated non-static  message array in a separate source file.

(and so on)

=====

Given that the above is actually the "logically most direct" solution set,
and every step you take further away from modifying the source and compiling
up a single-desired-target-language kernel induces non-trivial loss of
information/clarity at substantial analysis-time expense, I suspect that the
whole problem of "really" making the kernel multi-lingual is NP Complete.

=====

Now consider that any "regular expression or whatever" post processing that
someone might want to put into klogd is a fixed cost expense at runtime, but
in theory most runtime events are successes, one can conclude that that cost
really should only be paid only when someone is actually looking at the
messages.

That naturally infers that the translation shouldn't happen in klogd, but
instead much later at evaluation time.

If you push the evaluation-time (human reading etc) hypothesis to its
conclusion, and fold in the need to manage the per-language effort
coherently, you are led almost inexorably to an external "kernel message
translator" project.

This project would have a generic base and a per-language specialization.

The translator would have two phases, a harvester phase that would literally
collect up all the likely output strings from the entire kernel tree and
drop them into a data file.  Some sort of hashing should be done to find new
and old strings so as to preserve prior runs etc.  The file should also be
able to reasonably find/define the substitution engine for any given message
because it will have the in-place substitution markers (e.g. "%s");

The expressor would take that file and a companion file that listed target
translations, and then do the translation.  The expressor would only be run
when a person was interested in the output.  It would, of course, be fed the
contents of /var/log/messages or wherever the klogd is sending things.  For
people who MUST HAVE the translations real-time, klogd would/could be wired
up to pipe its output through the translator when necessary.

Untranslated lines would pass through unchanged.

A optional third part would be an editor that brought up the two files (the
source hash and the current translation for a language, and let someone who
could translate the strings, enter the well formed desired output with value
markers from the substitution engine.  (e.g. "foo:<value1>" would set
$1=value1 in the extraction engine and then substitute it into the constant
target "blah blah $1 blah", where blah is a real useful text in the target
language. 8-)

In short, The task really requires a heinous post processor, a language
maintainer per target language, and such a project should *NOT* be part of
the kernel tree or it will be trashed over time.

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Perez-Gonzalez,
Inaky
Sent: Thursday, April 10, 2003 12:22 PM
To: 'Ruth Ivimey-Cook'; 'linux-kernel@vger.kernel.org'
Subject: RE: kernel support for non-english user messages




> From: Ruth Ivimey-Cook [mailto:Ruth.Ivimey-Cook@ivimey.org]
>
> >This is _not_ like any i18n support.  The problem is that normal
>
> Agreed. How about changing the way printk works, so that instead of
> combining the format string, it just "prints" its args:
>
> printk("%s: name %p is %d\n", name, ptr, val);
>
> results in the following in the kernel buffer:
>
> "%s: name %p is %d\n", "stringval", 0x4790243, 44

Debugging a non-klogd enabled kernel would be a pain - alas, having some
preprocessing tool, this can be done without that modification. If you
know the format string (from the sources), given a printed message, a
regexp could extract the parts that need translation.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

