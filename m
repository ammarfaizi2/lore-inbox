Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKQXgn>; Fri, 17 Nov 2000 18:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129145AbQKQXgc>; Fri, 17 Nov 2000 18:36:32 -0500
Received: from mx01.uni-tuebingen.de ([134.2.3.11]:51982 "EHLO
	mx01.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S129136AbQKQXgM> convert rfc822-to-8bit; Fri, 17 Nov 2000 18:36:12 -0500
Date: Fri, 17 Nov 2000 23:55:15 +0100
From: Harald Koenig <koenig@tat.physik.uni-tuebingen.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Harald Koenig <koenig@tat.physik.uni-tuebingen.de>, Andries.Brouwer@cwi.nl,
        aeb@veritas.com, emoenke@gwdg.de, eric@andante.org,
        kobras@tat.physik.uni-tuebingen.de, linux-kernel@vger.kernel.org
Subject: Re: BUG: isofs broken (2.2 and 2.4)
Message-ID: <20001117235515.A1522@turtle.tat.physik.uni-tuebingen.de>
In-Reply-To: <20001117222056.A1187@turtle.tat.physik.uni-tuebingen.de> <Pine.LNX.4.10.10011171426240.2581-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10011171426240.2581-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Nov 17, 2000 at 02:29:25PM -0800
X-fingerprint: 3B CD 5A A9 73 44 DD 04  A0 4E A0 34 20 7B 1E 38
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 17, Linus Torvalds wrote:

> 
> 
> On Fri, 17 Nov 2000, Harald Koenig wrote:
> > 
> > this seems to make things much worse:  starting with ~90M free memory
> > "du" again started leaking (or maybe just using memory?) down to ~80M free
> > memory when the system suddently locked up completely, no console switch
> > was possible anymore (but Sysrq-B did reboot).
> 
> How about this version (full patch against test10 - it includes a
> slightly corrected version of my earlier dir.c patch)?
> 
> It's entirely untested, but it looks good and compiles. Ship it!

it looks slightly better performacewise with cold cache when compared
with Andries' patch:

Linus:		0.380u 76.850s 1:19.12 97.6%    0+0k 0+0io 113pf+0w
Andries:	0.470u 97.220s 1:40.29 97.4%    0+0k 0+0io 112pf+0w


BUT: there are some obvious bugs in the output of "du" and "find".
some samples (all file names (should) match the format "xe%03d/xe%03d.%c%c"
with both %03d being the _same_ number and both %c are in [a-z0-9]).

from "find" output:

...
/mnt/xe001/xe001.hg
find: /mnt/xe001/xe001.h: No such file or directory
/mnt/xe001/xe001.hi
...
/mnt/xe001/xe001.ib
find: /mnt/xe001/xe001.h: No such file or directory
/mnt/xe001/xe001.id
...
find: /mnt/xe003/xe002.rg: No such file or directory
...
find: /mnt/xe004/xe003.rg: No such file or directory
...
find: /mnt/xe005/xe004.rg: No such file or directory


"find" from hot cache even shows some binary garbage:

...
/mnt/xe001/xe001.0k
find: /mnt/xe001/¶^¶ ¶¶p¶$¶^¶¶^¶^¶ ¶¶¶{}: No such file or directory
/mnt/xe001/xe001.0m
...
/mnt/xe001/xe001.gl
find: /mnt/xe001/xe105/xe105.p1
/mnt/xe105/xe105.p2
/mnt/xe105/x: No such file or directory
/mnt/xe001/xe001.gn
...



and from "du":
...
du: /mnt/xe001/xe001.k: No such file or directory
du: /mnt/xe001/xe001.k: No such file or directory
du: /mnt/xe001/xe001.k: No such file or directory
du: /mnt/xe001/xe001.m: No such file or directory
du: /mnt/xe001/xe001.m: No such file or directory
du: /mnt/xe001/xe001.m: No such file or directory
du: /mnt/xe001/xe001.o: No such file or directory
du: /mnt/xe001/xe001.o: No such file or directory
du: /mnt/xe001/xe001.o: No such file or directory
du: /mnt/xe001/xe001.p: No such file or directory
du: /mnt/xe001/xe001.p: No such file or directory
du: /mnt/xe001/xe001.p: No such file or directory
du: /mnt/xe001/xe001.r: No such file or directory
3378    /mnt/xe001
du: /mnt/xe002/xe001.og: No such file or directory
du: /mnt/xe002/xe001.og: No such file or directory
du: /mnt/xe002/xe001.og: No such file or directory
4587    /mnt/xe002
du: /mnt/xe003/xe002.rg: No such file or directory
du: /mnt/xe003/xe002.rg: No such file or directory
du: /mnt/xe003/xe002.rg: No such file or directory
3669    /mnt/xe003
4451    /mnt/xe004
du: /mnt/xe005/xe004.rg: No such file or directory
du: /mnt/xe005/xe004.rg: No such file or directory
du: /mnt/xe005/xe004.rg: No such file or directory
3728    /mnt/xe005
...
du: /mnt/xe010/

# note: this file is far from being complete: No such file or directory
du: /mnt/xe010/

# note: this file is far from being complete: No such file or directory
du: /mnt/xe010/

# note: this file is far from being complete: No such file or directory
4263    /mnt/xe010






Harald
-- 
All SCSI disks will from now on                     ___       _____
be required to send an email notice                0--,|    /OOOOOOO\
24 hours prior to complete hardware failure!      <_/  /  /OOOOOOOOOOO\
                                                    \  \/OOOOOOOOOOOOOOO\
                                                      \ OOOOOOOOOOOOOOOOO|//
Harald Koenig,                                         \/\/\/\/\/\/\/\/\/
Inst.f.Theoret.Astrophysik                              //  /     \\  \
koenig@tat.physik.uni-tuebingen.de                     ^^^^^       ^^^^^
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
