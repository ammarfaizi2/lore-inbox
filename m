Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSHAQmE>; Thu, 1 Aug 2002 12:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSHAQmE>; Thu, 1 Aug 2002 12:42:04 -0400
Received: from khms.westfalen.de ([62.153.201.243]:15255 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S315758AbSHAQmB>; Thu, 1 Aug 2002 12:42:01 -0400
Date: 01 Aug 2002 14:31:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8U0hkQ6Hw-B@khms.westfalen.de>
In-Reply-To: <3D490894.9030506@evision.ag>
Subject: Re: 2.5.28 and partitions
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.GSO.4.21.0207311832270.8505-100000@weyl.math.psu.edu> <3D490894.9030506@evision.ag>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dalecki@evision.ag (Marcin Dalecki)  wrote on 01.08.02 in <3D490894.9030506@evision.ag>:

> Alexander Viro wrote:
> >
> > On Thu, 1 Aug 2002, Peter Chubb wrote:
> >
> >
> >>Maybe we need to roll our own?  I suggest something like:
> >>      struct linux_volume_header {
> >>	     char  volname[16];
> >>	     __u32 nparts;
> >>	     __u32 blocksize;
> >>	     struct linux_partition {
> >>		    char partname[16]
> >>		    __u64  start;
> >>		    __u64  len;
> >>		    __u32  usage;
> >>		    __u32  flags;
> >>	    } parts[]
> >>    }
> >
> >
> > Oh, ferchrissake!  WHY???  People, we'd seen a lot of demonstrations
> > of the reasons why binary structures are *bad* for such stuff.
> >
> > What the bleedin' hell is wrong with <name> <start> <len>\n - all in
> > ASCII? Terminated by \0.  No need for flags, no need for endianness crap,
> > no need to worry about field becoming too narrow...
> >
> > What, parsing that would be too slow?  Right.  Sure.  How many times do
> > we parse partition table?  How many times do we end up reading it from
> > disk?  How does IO time compare to the "overhead" of trivial sscanf loop?
> >
> > Furrfu...  "ASCII is tough, let's go shopping"...
>
> Whats wrong with ASCII processing? Easy to tell:
>
> 1. Look at bagtraq. (www.securityfocus.com)

I can't see how that can possibly apply to this case. Getting a parser for  
*this* format wrong enough to allow for an attack needs incredible  
stupidity.

And remember, this is not something for generic applications to parse:  
possibly the bootloader (unless it's LILO), the kernel, and fdisk. That's  
it.

> 2. It's making data *not agnostic* against i18n issues. This is
> something most people forgett about. /proc is LANG=en_US. ISO8859-1 - I
> do not like this language.

I18n in partition names? Because that's certainly the only part in there  
that seems to even be possible. Just define that text in partition names  
is supposed to be UTF-8, and if there's ever anything that needs to be  
understood by programs (as opposed to just handed straight through between  
user and disk), make that be ASCII.

(However, I'd put the name as the _last_ field, possibly with a different  
separator [in case we ever want more fields], so I'd not need to think  
about any special characters in there.)

Oh, and don't forget some kind of magic string at the beginning. And  
possibly add some (optional) uuid. Helps with partitions moving around if  
the filesystem hasn't one.

> 3. For some as of jet undiscovered reason actual application programmers
> hate processing it.

Very few of them need to.

> 4. Answer 1. should be actually sufficient.

Not even remotely.


Ok, that makes a format proposal as follows:

#*Partition table*#
512 156258637 547af-d65e78-8978af =My Volume Label\n
0 3 ptable\n
4 7868 6562-adfea-898809aa =Bootloader\n
7872 150000000 a6f5-c9ba-6532 =Linux root
150007872 6250765\n
\0

That would be a 512-bytes-per block volume of around 80 GB (assuming I  
didn't miscalculate), with two data partitions and some free space at the  
end, and with both uuid and name fields being optional, except that an  
uuid of "ptable" marks the partition table partition.

Every line after the magic parses as /^\s*\d+\s+\d+\s*(\s\w+\s*)(=.*)$/  
(in Perl notation). It's free space if it only has the first two fields;  
the first line describes the whole volume and uses the first field for the  
block size. (Obviously, if you need boot code at the beginning of the  
disk, the partition table will need to start at some later sector. So that  
field has actual meaning.)

As for finding where to boot from - either have the bootloader define a  
partition name it wants to see, or put the relevant name into the boot  
loader config. No need to define that in the partition format. That's  
trivial: even MS-DOS did that (finding IO.SYS and MSDOS.SYS from the boot  
loader)! And neither scanning for '=' and '\n' nor comparing one string  
nor converting one number from decimal is any kind of hardship. Maybe half  
a screen of assembler, tops.

MfG Kai
