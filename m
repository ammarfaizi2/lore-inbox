Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161219AbVIPSCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbVIPSCt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbVIPSCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:02:49 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:54668 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1161219AbVIPSCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:02:48 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [Patch] Support UTF-8 scripts
To: "H. Peter Anvin" <hpa@zytor.com>,
       Martin =?ISO-8859-1?Q?v=2E_L=F6wis?= <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 16 Sep 2005 20:02:36 +0200
References: <4N6EL-4Hq-3@gated-at.bofh.it> <4N6EL-4Hq-5@gated-at.bofh.it> <4N6EK-4Hq-1@gated-at.bofh.it> <4N6EX-4Hq-27@gated-at.bofh.it> <4N6Ox-4Ts-33@gated-at.bofh.it> <4N7AS-67L-3@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EGKXl-0001Sn-GA@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch <bernd@firmix.at> wrote:
> On Thu, 2005-09-15 at 20:39 +0200, "Martin v. Löwis" wrote:
>> H. Peter Anvin wrote:

>> > In Unix, it's a hideously bad idea.  The reason is that Unix inherently
>> > assumes that text streams can be merged, split, and modified.  In other
>> > words, unless you can guarantee that EVERY program can handle BOM
>> > EVERYWHERE, it's broken.

You can't sort /bin/ls into /tmp/ls and expect /tmp/ls to be meaningfull,
but /bin/ls works as expected. You can't usurally concat perl scripts and
shell scripts either, but both kinds of script run quite well.

And if you do "cat /bin/cat /bin/cp > /bin/catcp", what's "catcp foo bar"
supposed to do? First output foo and bar to stdout, then copy foo to bar?
Is execve() broken if it doesn't do what I described? Is the ELF header
broken because it's not recogmized EVERYWHERE? I don't think so.

>> This argument is bogus. We are talking about scripts here, which cannot
>> be merged, split, and modified. You don't cat(1) or sort(1) them - it's
> 
> Sure they can since they are plain text files.
> How do you think one merges scripts?
> Just `cat`ing them all into one new file and edit that new file is much
> faster and simpler than to open an empty new file with your editor, then
> you open all the other scripts in your editor and copy them by hand.

What's supposed to happen if you concatenate a script from your french
user and from your russian user, both using localized text, into one file?
Unless you can guarantee every editor to correctly handle this case, all
usage of 8-bit-characters should be disabled - NOT!

If you concatenate two plain text files, you will use cat.
If you concatenate two pnm image files, you will use pnmcat.
If you concatenate two utf-8 files, you will use utf8cat.
If you concatenate two binaries, you will shoot your feet.
That's easy, isn't it?

BTW: I think decent utf-8 capable programs SHOULD ignore extra BOM markers.

> And you (or at least I) do `grep`/`egrep`/`fgrep`, `wc` them.

You can *grep utf-8 scripts, but you can't *grep binaries. Shouldn't
this be fixed by implementing an in-kernel ASCII assembler and convert
all binaries to assembler text?

> And
> probably with several other tools too - think of `find <dir> -type f
> -print0 | xargs -0r <cmd>`.

utf-8 filenames will work correctly (unless used as an extended BASIC
script with non-ASCII variable names, but that would be insane).

>> just pointless to do that. You create them with text editors, and those
>> can handle the UTF-8 signature.
> 
> It is not uncommon to create scripts and the like with other programs,
> other scripts, what-else.

It's not uncommon to create binaries using other programs. So what?

> Apart from the fact the a "script" is merely a plain text file with the
> eXecutable bit set.

And an utf-8 script is a utf-8 encoded text file with it's executable bit
set.

> And that is the only difference, so you have to at
> least (all instances of) `chmod` to insert and remove the BOM.
[...]

In order to make it harder for the interpreter to correctly detect utf-8?
You can have DOS executables run in dosboxes, windows applications run
in windows, java archives run in java, but utf-8 scripts should be
mangled in order to work "correctly", and mangled back in order to be
editable? *That*'s insane!

Just make execve ignore the BOM marker before "#!" as the patch does, and
you're done. The rest is somebody else's not-a-problem.



BTW2: However, I don't like the patch.

I'd first check for a utf-8 signature, and if it's found, adjust the
buffer offset by 3. Then I'd run the old code checking for the sh_bang.
OTOH, I just read the patch and not the .c file, maybe (unlikely) my idea
wouldn't work correctly.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
