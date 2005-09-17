Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVIQRRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVIQRRA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 13:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVIQRRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 13:17:00 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:40427 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751165AbVIQRQ7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 13:16:59 -0400
Date: Sat, 17 Sep 2005 19:16:51 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: "D. Hazelton" <dhazelton@enter.net>
cc: 7eggert@gmx.de, "H. Peter Anvin" <hpa@zytor.com>,
       "Martin v.=?iso-8859-1?q?L=F6wis?=" <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
In-Reply-To: <200509170028.59973.dhazelton@enter.net>
Message-ID: <Pine.LNX.4.58.0509171538200.2713@be1.lrz>
References: <4N6EL-4Hq-3@gated-at.bofh.it> <4N7AS-67L-3@gated-at.bofh.it>
 <E1EGKXl-0001Sn-GA@be1.lrz> <200509170028.59973.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Sep 2005, D. Hazelton wrote:
> On Friday 16 September 2005 18:02, Bodo Eggert wrote:
> > Bernd Petrovitsch <bernd@firmix.at> wrote:
> > > On Thu, 2005-09-15 at 20:39 +0200, "Martin v. Löwis" wrote:
> > >> H. Peter Anvin wrote:

> > >> > In Unix, it's a hideously bad
> > >> > idea.  The reason is that Unix inherently assumes that text
> > >> > streams can be merged, split, and modified.  In other words,
> > >> > unless you can guarantee that EVERY program can handle BOM
> > >> > EVERYWHERE, it's broken.
> >
> > You can't sort /bin/ls into /tmp/ls and expect /tmp/ls to be
> > meaningfull, but /bin/ls works as expected. You can't usurally
> > concat perl scripts and shell scripts either, but both kinds of
> > script run quite well.
> >
> > And if you do "cat /bin/cat /bin/cp > /bin/catcp", what's "catcp
> > foo bar" supposed to do? First output foo and bar to stdout, then
> > copy foo to bar? Is execve() broken if it doesn't do what I
> > described? Is the ELF header broken because it's not recogmized
> > EVERYWHERE? I don't think so.
> 
> This is a bogus argument. You're comparing the way a _binary_ 
> executable works to the way an interpreted _text_ script works.

You can live with binaries, therefore the features not provided by 
binaries aren't vital for each and every executable.

> execve(), at least on my system, isn't capable of running a script - 
> if I want to do that from a program I have to tell execve() that it's 
> running /bin/sh and the script file is in the parameter list. 

Fix your system, it's broken.

> While I appreciate that the kernel is capable of performing complex 
> actions when execve runs into a file that is not an a.out or elf 
> binary I have yet to see a "binfmt script" option in the kernel 
> config files ever.

Your wish ... but you won't be happy.

--- ../t/linux-2.6.12/fs/Makefile	2005-06-17 21:48:29.000000000 +0200
+++ ./fs/Makefile	2005-09-17 18:02:36.000000000 +0200
@@ -20,9 +20,7 @@ obj-y				+= $(nfsd-y) $(nfsd-m)
 obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
 obj-$(CONFIG_BINFMT_EM86)	+= binfmt_em86.o
 obj-$(CONFIG_BINFMT_MISC)	+= binfmt_misc.o
-
-# binfmt_script is always there
-obj-y				+= binfmt_script.o
+obj-$(CONFIG_BINFMT_SCRIPT)	+= binfmt_script.o
 
 obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
 obj-$(CONFIG_BINFMT_ELF_FDPIC)	+= binfmt_elf_fdpic.o
--- ../t/linux-2.6.12/fs/Kconfig.binfmt	2005-06-17 21:48:29.000000000 +0200
+++ ./fs/Kconfig.binfmt	2005-09-17 17:59:39.000000000 +0200
@@ -42,6 +42,12 @@ config BINFMT_FLAT
 	help
 	  Support uClinux FLAT format binaries.
 
+config BINFMT_SCRIPT
+       bool "Kernel support for script files"
+       default y
+       help
+         Support script files starting with a '#!' marker.
+
 config BINFMT_ZFLAT
 	bool "Enable ZFLAT support"
 	depends on BINFMT_FLAT

> On the other hand, there is the "binfmt_misc" option, which does the 
> work that you seem to be looking for and can, AFAIK, be set to handle 
> both ASCII and UTF-8 scripts. Why add the complexity to the kernel 
> when it's not needed?

Skipping 3 bytes vs. handling tons of binary formats? I bet the memory
required to hold the utf8 binfmt_misc entry alone will be bigger than the
code added by this patch.

> > BTW: I think decent utf-8 capable programs SHOULD ignore extra BOM
> > markers.
> 
> All well and good if you use UTF-8. I, personally, am happy with ASCII 
> and have found no need for the extensive UTF character set (in fact, 
> I despise it when people insist on using UTF-8 in mediums in which 
> the character set is defined in the standards to be ASCII or a subset 
> of ASCII)

I'm not using it, because nobody else is using it, and evrybody else does 
the same for exactly the same reasons. That's why just using utf-8 does 
not work out.

However, if there were means of using both transparently, people could 
migrate. The editor part is simple, but if you can't use your favorite 
editor to generate shell scripts, it's a showstopper.

> Since I am quite happy with the small subset of ASCII that I use on a 
> regular basis, and since I am always seeking ways to optimize my code 
> and my scripts I don't want the editor I'm using adding extra 
> characters behind my back. 

ACK. But you should be able to edit international text without tons of
helper scripts, so a BOM will be usefull to mark utf-8.

> > > And you (or at least I) do `grep`/`egrep`/`fgrep`, `wc` them.
> >
> > You can *grep utf-8 scripts, but you can't *grep binaries.
> > Shouldn't this be fixed by implementing an in-kernel ASCII
> > assembler and convert all binaries to assembler text?
> 
> Bogus argument. Every shell I've ever used has expected the command 
> line to contain only ASCII characters. With that restriction in mind 
> it's clear that it'd be hard to put a UTF8 string as the argument to 
> grep. Although I doubt wc would be buggered by UTF8 input... 

If your shell isn't 8-bit-clean, it should have been replaced in the last 
millenium. Handling combined characters will be the problem.

> > > And
> > > probably with several other tools too - think of `find <dir>
> > > -type f -print0 | xargs -0r <cmd>`.
> >
> > utf-8 filenames will work correctly (unless used as an extended
> > BASIC script with non-ASCII variable names, but that would be
> > insane).
> 
> This is the truth. As I previously mentioned I have yet to find a 
> shell that accepted UTF8 on the command line without choking. And 
> allowing UTF8 for filenames would, I believe, require any number of 
> changes to the kernel,  not the least of which would be changes to 
> the various filesystems to allow for UTF8 and to any number of system 
> calls that would be taking a filename for an argument.

It's not a task of allowing utf-8 filenames, but a task of disallowing
non-canonialized and non-utf8 filenames if files might be created. Systems
doing that won't be a strictly POSIX conformant, but as long as there is a
mounted FAT partition, it can't be anyway.

> > >> just pointless to do that. You create them with text editors,
> > >> and those can handle the UTF-8 signature.
> > >
> > > It is not uncommon to create scripts and the like with other
> > > programs, other scripts, what-else.
> >
> > It's not uncommon to create binaries using other programs. So what?
> 
> Bullsh*t. The case of one binary creating another doesn't apply - 
> because you either enter the data for the binary by hand (tedious and 
> difficult) or you use a binary that takes input and produces the 
> binary you need. And if the binary is missing the proper headers, 
> it's pretty much useless.

And you can live with binaries being non-editable, non-generatable without 
propper tools.

> When a script creates another script it is 
> just creating a text file, putting the data in the file as it reaches 
> those parts and has no way to know that it should be inserting the 
> BOM.

If scripts are just text files, why doesn't sort<script|sh usurally do
the right thing?

Scripts are _not_ random text, they have specific structures. They consist 
of well-formed data, and you should better know what kind of script you're 
creating, therefore you should also know wether to write sh_bang or 
BOM_sh_bang. If you don't, don't generate the script!

> > > Apart from the fact the a "script" is merely a plain text file with
> > > the eXecutable bit set.
> >
> > And an utf-8 script is a utf-8 encoded text file with it's
> > executable bit set.
> 
> And the kernel should have no more code in it to execute them than is 
> already present in the binfmt_misc code. No need for special kernel 
> code when you can simply hand a chunk of parameters regarding the 
> various executable formats to the kernel using a clean, simple and 
> proven interface. And even then I feel it should be limited to 
> binaries - a script is, by definition, interpreted. As such, it 
> belongs in the same place as the interpreter - in userland. (And I 
> fail to see why this is even brought up other than some people being 
> lazy and not wanting to do things _correctly_)

So the binfmt_sh code should be completely abandoned in favor of binfmt_misc?

> > > And that is the only difference, so you have to at
> > > least (all instances of) `chmod` to insert and remove the BOM.
> >
> > [...]
> >
> > In order to make it harder for the interpreter to correctly detect
> > utf-8? You can have DOS executables run in dosboxes, windows
> > applications run in windows, java archives run in java, but utf-8
> > scripts should be mangled in order to work "correctly", and mangled
> > back in order to be editable? *That*'s insane!
> >
> > Just make execve ignore the BOM marker before "#!" as the patch
> > does, and you're done. The rest is somebody else's not-a-problem.
> 
> GCC allows for non-ascii input as a formality. The specifications of 
> both C and C++ clearly define the input character set to be limited 
> to an extremely limited subset of ASCII, as do the specifications of 
> most other language.

This is a userspace problem.

> (Perl 6 is the first language I've ever heard of 
> that directly includes non-ascii characters in the accepted character 
> set)

The MS-DOS 3.3 shell accepted international characters in program names.

> AFAIK, the most common shells don't accept UTF-8 in the command set - 
> they instead see the non-ascii UTF-8 characters as a series of bytes, 
> and if one of them happens to be NULL, you're pretty much screwed.

There is no '\0' in utf-8-encoded data.

> > BTW2: However, I don't like the patch.
> 
> Neither do I. such a thing doesn't belong in the kernel.

It's better than 

- using a legacy wrapper script for each script.

- mangeling each utf8 file before and after editing it

- forcing the world to convert to utf-8 within two weeks

- using a wrapper script around each and every utf-8 script which would
  unnescensarily throw out pages and wastes CPU cycles while requiring
  each user to add several KB of kernel code for binfmt_misc and to
  have the interpreter for the wrapper script installed

I actually created a wrapper script for binfmt_misc and called it a 
hundres times, here is the result:

$ time for((i=0;i<100;i++));do ./foo > /dev/null;done # with wrapper

real    0m2.350s
user    0m1.808s
sys     0m0.476s
$ time for((i=0;i<100;i++));do ./bar > /dev/null;done # without wrapper

real    0m0.461s
user    0m0.232s
sys     0m0.216s

And I'm sure this script has a bug to exploit.

(foo and bar will ust print "test\n" to stdout)

-- 

"Our parents, worse than our grandparents, gave birth to us who are worse than
they, and we shall in our turn bear offspring still more evil."
	-- Horace (BC 65-8)
