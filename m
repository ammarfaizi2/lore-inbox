Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVF2NNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVF2NNG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 09:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVF2NNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 09:13:05 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:13269 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262112AbVF2NMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 09:12:46 -0400
Message-Id: <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>
To: Hubert Chan <hubert@uhoreg.ca>
cc: Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from Hubert Chan <hubert@uhoreg.ca> 
   of "Tue, 28 Jun 2005 21:40:41 -0400." <874qbiey92.fsf@evinrude.uhoreg.ca> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Wed, 29 Jun 2005 01:09:05 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 29 Jun 2005 09:08:37 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Chan <hubert@uhoreg.ca> wrote:

[...]

> Of course.  With file-as-dir, you can "cd /usr/games/tetris/..." and
> mess with the game files, or you can run "/usr/games/tetris" and get on
> with ... stacking blocks.

And doing "tar cf /dev/tape /usr/games/tetris" gives you a nice tangle of
undecipherable junk.

>                            The advantage of doing it in the kernel is
> that you don't need extra support from the applications (or GnomeVFS or
> KDE).

I don't see any advantage here... it has to be implemented, and doing it
in-kernel for one filesystem is /much/ harder than doing it in userland,
where it'll probably work whatever the underlying filesystem is.

Besides, why should the Tetris scores (or icon, or whatever) reside inside
the executable, when said executable is perhaps shared by a bunch of
machines on the network, each of which would like to keep its own? Or
perhaps the sysadmin is terminally paranoid, and mounts /usr read-only
(Hey, the FHS people defined what goes in there with /exactly/ that in mind
too!). 

>        So typing "/usr/games/tetris" from the command prompt does the
> same thing as double-clicking it in the file manager.

Right. And what should happen if I run the (logically equivalent) directory
/home? Or /etc? What if I want to shove a directory into the tetris
executable? Symlinks? Hard links to files inside? Outside? Symlinks from
the outside in? Hardlinks? And if you now move that to another filesystem,
or ship it to another machine? No, the answer "All that will be forbidden"
is /not/ allowed, you want this stuff working "normally". "Unpack" the
contents into real files and directories how? "Pack" a directory into one
of those structured objects? What would be the /practical/ difference
between the packed and unpacked forms? (If none, why do it in the first
place? If the packed version has significant restrictions, why use it? If
the packed version does have significant extra capabilities, why not just
give those to regular objects?)

Yet again, what somebody (I forget who) called the "Zero - one - infinity
principle" (I think it was in the area of programming languages; which
arguably are very complex user interfaces, just like what an operating
system provides): It only makes sense giving zero, exactly one, or how many
you wish for of some item/nesting. Here: Either files got /no/ strange
things inside, or /exactly one/ (and then it becomes questionable, as there
is no space for regular data anymore...), or whatever complex
(sub)structure you want. But in the last case, there is /no/ difference
between a file and a directory... and the whole setup is just mess for mess
sake, nothing else.

>                                                        Of course, this
> change does require file managers to understand default actions when
> it's ambiguous what to do on a double-click -- but MacOS X has that too,
> in the form of the "Open as Folder" option (or whatever it's called).

Right. For the sake of a filesystem among many on a minority operating
system /all/ GUI programs have to be rewritten. And all command-line
stuff. Just because.


Please /do/ think the above through, giving reasonable answers for /all/ of
the operations mentioned. Tell what the advantage of all this would be on a
multiuser operating system, when files are shared via the net, when files
are being handled from read-only media (or filesystems). When different
users want different metadata (I'm interested in the names of members of
the band playing a song, you might want a high-resolution image of the
album cover, the next guy wants the song's lyrics translated into swahili,
all for the MP3s on the shared server or on the CD each of us bought
separately). Consider the scenario where all this works only on /a very
few/ machines (no Sun or *BSD box will have this for a very long time, and
to get a significant fraction of just Linux systems will take some time),
for only a limited selection of tools (existing tools will have to be
rewritten or at least adapted, that doesn't happen overnight). Factor in
space and processing requirements for several, even hundreds, of concurrent
users (or versions of metadata at least). How do you account for that? The
1 byte file with GiB of metadata where everybody and their pet iguana store
their junk is handled how by quota systems? What should happen if I email
such a file with several versions of metadata to someone? Do they get just
my metadata, or everybody's? If I copy it to, say, a CD for safekeeping for
myself? For system backup purposes? What if I copy such a file (with only
my, or everybody's) metadata back from a backup? Or try to merge it with
the version I took with my notebook on a trip, changing my parts while the
otghers change theirs? I'd assume all of those will requiere special tools,
or at least flags selecting the right operation or some other unspecified
magic, and the "simple to use" just went out for lunch.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
