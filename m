Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319000AbSHFGKk>; Tue, 6 Aug 2002 02:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319002AbSHFGKk>; Tue, 6 Aug 2002 02:10:40 -0400
Received: from pc132.utati.net ([216.143.22.132]:48525 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S319000AbSHFGKj>; Tue, 6 Aug 2002 02:10:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Greg KH <greg@kroah.com>
Subject: Policy vs API (was Re: [PATCH] integrate driverfs and devfs (2.5.28))
Date: Mon, 5 Aug 2002 19:51:21 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207291431381.22697-100000@cherise.pdx.osdl.net> <200208051225.g75CP4v316564@pimout4-ext.prodigy.net> <20020805231914.GF29396@kroah.com>
In-Reply-To: <20020805231914.GF29396@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020806055922.26D48644@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 August 2002 07:19 pm, Greg KH wrote:

> > By the way, why doesn't imposing consistent predefined major/minor
> > numbers (0x0301 instead of "hda1") count as "policy"?   I'm honestly
> > curious...
>
> It does.  I want to get rid of it too :)  But that's still a ways away...

The user needs some kind of API.  Some way for a program to say "Could I 
please talk to the slave drive on the second IDE controller".  What I'm 
wondering is where's the line between "policy" and "API"?  You can't have a 
standard API without SOME level of "policy".

Major/minor device numbers suck because the namespace is too small (for 
historical reasons), it's randomly organized (again for historical reasons), 
it's almost exhausted (due to the first two), making it bigger will just help 
the clutter breed, and it's almost impossible to recycle old numbers as long 
as three people out there are still using the floppy tape controller or 
whatever.  Plus humans really do think in words (or at least text strings), 
hence the phone book and DNS to access numbers via strings.  (And the /dev 
directory.)

There already ARE standardized text based APIs, and internationalization 
people object to them for political correctness reasons and that's just 
stupid.  If somebody is REALLY stupid enough to translate the standard C 
library function names into chinese unicode, and then try to actually link a 
program against it, they deserve what they get.  Same with the standard unix 
commands: awk, grep, and sed aren't english.  (They're posix.  :)
Internationalizing the data going through an API is one thing, trying to 
internationalize the API itself is just silly.  Might as well encourage 
non-english posts on linux-kernel...

I've noticed a bias against actually using strings to interface the kernel 
with userspace (the module autoloader being one relatively obvious example), 
but it's still done in a bunch of places anyway ("/sbin/init", "linuxrc", 
"hotplug", "modprobe", the text command line for kernel booting with "init=", 
"root=", "initrd="...).  The kernel talks to other parts of the kernel by 
exporting text symbols, userspace talks to userspace with strings, why is 
kernel to userspace fundamentally different?  The problem with the horror 
that is /proc is that it's not ORGANIZED, not that it's text.  People put so 
much stuff into /proc because they WANT a text API, and for a long time that 
was their only real outlet.

The problems with devfs are, well, numerous, but the fundamental idea of 
automatically mounting a /dev directory with the available devices into it 
rather than a MAKEDEV script to create 8 zillion nodes for devices you might 
conceivably want to borrow from a museum someday...  Implementation issues 
aside, what was wrong with the idea itself?  The rebellion against using the 
existing names there makes devfs a lot less interesting to me, I know that 
much.  It doesn't provide the same API the /dev directory does, and half the 
software I use won't compile against it without a chainsaw and a bullwhip, or 
the daemon kludge.  Code quality aside, the new devfs api never struck me as 
an improvement over the old one.  (I STILL don't know why a change of 
implementation mandated a change of API.)

I'm under the vague impression that devicefs may somehow become the new 
driver API at some point after Buck Rogers returns from his frozen orbit.  
The whole POINT of devicefs seems to be to expose new data through a fresh 
API that's designed to grow without getting disorganized.  This implies (to 
me) a move towards a device API defined in the context of a text namespace.

If there's some move underway to avoid doing so (because any standard API is 
"policy"), what exactly is the better alternative?

Rob
