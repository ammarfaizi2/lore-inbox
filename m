Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263947AbTDODcn (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 23:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263967AbTDODcn (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 23:32:43 -0400
Received: from mail.casabyte.com ([209.63.254.226]:8208 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S263947AbTDODck (for <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 23:32:40 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Riley Williams" <Riley@Williams.Name>,
       "Linux Kernel List" <Linux-Kernel@vger.kernel.org>
Subject: RE: kernel support for non-English user messages
Date: Mon, 14 Apr 2003 20:44:29 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGKEIFCHAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <BKEGKPICNAKILKJKMHCAGEEBCGAA.Riley@Williams.Name>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Message codes would be *VERY BAD* anyway.  As soon as you start that, then
you need a numbering authority and all that nonsense.

However, it should be "reasonably easy" to preprocess (in the gcc -E sense)
all the files in a kernel directory and the gather up nearly all the
prototype strings.  (you would still have the occasional person who wrote
"char Message[] = "INode: %d invalid"; printk(Message,number);" instead of
having the string in place as just "printk("INode: %d invalid",number);" and
the later is easier to collect up 8-)

The thing is "INode: %d invalid", as a string is easy to decompose into a
regular expression because it is mostly-constant and the non-constant parts
are represented with constant markers.  There are a small number of
degenerate cases [e.g. printk("Filename %s invalid: %s","Filename","invalid:
whitespace character")] that might need to be tweaked but nothing is
perfect.

So "the magic tool" collects these imprint strings and builds a list of all
the strings (for the translator), a recognizer-table (perhaps hashes against
the constant leader word of each message and a regex for the message) that
points to the also-built hash/key into the table of all of the known
strings.

The human translator comes along to prepare the table for the target
language, and populates a replacement-string table with the translations
with suitable $1, $2, etc. style markers for all the messages he can
translate.

At runtime, the translator takes the recognizer-table and does the hash on
the leader word, then tries the string against the regexes with the same
leader hash.  Every match (there should usually be only one) will net the
key hash which in turn leads to the human-supplied replacement line.  $1
style replacement takes place, and the line is emitted in the "new"
language.  IF there is no match, the unchanged line is produced.

It's cute in that in-elegant sort of way, but it *IS* deterministic and
extensible (if the unique hash/key algo can be worked out.)

In fact, such a system could be pointed at, say, the kernel archive, and
produce a translation of all the kernel messages (for a given kernel etc)
and leave the bulk of the message text untouched.

Rob.

-----Original Message-----
From: Riley Williams [mailto:Riley@Williams.Name]
Sent: Friday, April 11, 2003 3:53 PM
To: Robert White; Linux Kernel List
Subject: RE: kernel support for non-English user messages


Hi Robert.

 > Actually, my final point had been that doing it inside the kernel
 > itself, or indeed inside klogd, was probably a very bad idea. If
 > the translation always happens after-the-fact based on properly
 > harvested message semantics then any segment of messages
 > distributed into this mailing list (among other uses) would be
 >
 > A)  Still in English.
 > B)  Translatable after the fact there too.
 >
 > Also after-the-fact translation makes the language translations a
 > scalar problem instead of a matrix one. That is, if you always
 > pass the message stream around in English (treat it like n opaque
 > source file) and then translate it as necessary, it will "always
 > work".
 >
 > If you try to do the translations at message generation time, then
 > the translation must be any-language-to-any-language capable during
 > post-even discussions. Not good.

I can see the points you're making, and that is precisely why I believe
that message codes would be required to implement this idea. As Linus
has vetoed the idea of having message codes in the kernel, I can't see
it ever coming to fruition.

 > Also, you will always have leakage as people add new strings to the
 > set.

That's the easiest aspect of dealing with it - the tool that generates
the language set to use just grabs the "English" language version for
any message codes not in the selected translation.

 > As for the #define issues, when you process the source tree to build the
 > source matrix you just "gcc -E file.c | collector" and now the printk
 > case you mention is handled. Any module designer who does uglier things
 > can make a dead-code procedure that expresses his possible output strings
 > for collection (if he cares.)

 > {Satire}

 > Speaking as an arrogant (U.S. of) American who knows that God(TradeMark,
 > all rights reserved) decreed that he never had to learn any language but
 > his own, I can honestly state, that it is nearly certain that you will
 > get no real support for the multi-language kernel out of a us
USAmericans.
 > We can't even get ourselves to write decent comments, and on the average,
 > we all secretly believe that if we just speak slowly enough everybody
 > really knows English. After all, that's how our condescending "wouldn't
 > want to fail Johnny, it would be bad for his self-image" public schools
 > taught us in the first place.... 8-)

Speaking as an amused (U.S. of) American, I long ago learned how to tell
when
somebody is speaking "God's Language"(tm) - that's simple to work out. After
all, the most likely people to speak "God's Language"(tm) are those that
have
just left His presence - the new born babies - so if we want to listen to
His
language, we just listen to them speak it. What could be simpler???

However, I understand "God's Language"(tm) is not currently understood well
enough by the kernel developers for any of them to translate the kernel
messages into it...

 > {/Satire}

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.471 / Virus Database: 269 - Release Date: 10-Apr-2003

